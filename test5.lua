if not game:IsLoaded()then game.Loaded:Wait()end
local a=game:GetService("CoreGui")
local b=a:FindFirstChild("FluentRenewed_Prospecting!")if b then b:Destroy()end
local c=game:GetService("GuiService")
local d=game:GetService("Players")
local e=game:GetService("TeleportService")
local f=d.LocalPlayer
local g=false
local h=3
local function i(j)if g or not f then return end;g=true;task.wait(h);local k,l=pcall(function()e:Teleport(game.PlaceId,f)end)if not k then g=false end end
c.ErrorMessageChanged:Connect(function(m)if m and m~=""then i(m)end end)
local n=getinfo or debug.getinfo
local o=false
local p={}
local q,r
setthreadidentity(2)
for s,t in getgc(true)do if typeof(t)=="table"then local u=rawget(t,"Detected")local v=rawget(t,"Kill")if typeof(u)=="function"and not q then q=u;local w;w=hookfunction(q,function(x,y,z)if x~="_"then if o then end end;return true end)table.insert(p,q)end;if rawget(t,"Variables")and rawget(t,"Process")and typeof(v)=="function"and not r then r=v;local w;w=hookfunction(r,function(y)if o then end end)table.insert(p,r)end end end
local w;w=hookfunction(getrenv().debug.info,newcclosure(function(...)local x,y=...;if q and x==q then if o then end;return coroutine.yield(coroutine.running())end;return w(...)end))
setthreadidentity(7)
local aa=loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local ab=loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local ac=loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local ad=game:GetService("VirtualInputManager")
local ae=game:GetService("ReplicatedStorage")
local af=game:GetService("Workspace")
local ag=game:GetService("RunService")
local ah=game:GetService("PathfindingService")
local ai=game:GetService("Players") 
local aj=ai.LocalPlayer
local ak=aa:CreateWindow{Title="Prospecting!",SubTitle=" | by DOIT",TabWidth=160,Size=UDim2.fromOffset(830,525),Resize=false,MinSize=Vector2.new(470,380),Acrylic=false,Theme="Dark",MinimizeKey=Enum.KeyCode.RightControl}
local al={Main=ak:CreateTab{Title="Main",Icon="shovel"},Favourite=ak:CreateTab{Title="Favourite",Icon="heart"},Shop=ak:CreateTab{Title="Shop",Icon="shopping-cart"},Settings=ak:CreateTab{Title="Settings",Icon="settings"}}
local am=aa.Options
local an=nil
local ao=""
local ap=""
local function aq(ar)
    local as=aj.Character
    if not as then return end
    local at=as:FindFirstChildOfClass("Humanoid")
    local au=as:FindFirstChild("HumanoidRootPart")
    if not(at and au and at.Health>0)then return end
    local av=at.WalkSpeed
    local aw=45
    at.WalkSpeed=aw
    local ax=ah:CreatePath{AgentRadius=2,AgentHeight=6,AgentCanJump=true,AgentJumpHeight=8,AgentMaxSlope=45}
    while(au.Position-ar).Magnitude>5 and at.Health>0 and am.ToggleFarm.Value do
        local ay,az=pcall(function()ax:ComputeAsync(au.Position,ar)end)
        if ay and ax.Status==Enum.PathStatus.Success then
            local ba=ax:GetWaypoints()
            for bb,bc in ipairs(ba)do
                if bb>1 then
                    if not am.ToggleFarm.Value or at.Health<=0 then break end
                    at:MoveTo(bc.Position)
                    local bd=false
                    local be=at.MoveToFinished:Connect(function(bf)bd=bf end)
                    local bg=3.6+math.random(-22,24)/100
                    local bh=0
                    while not bd and bh<bg and at.Health>0 and am.ToggleFarm.Value do
                        bh=bh+task.wait()
                        if(au.Position-ar).Magnitude<5 then break end
                    end
                    be:Disconnect()
                    if not bd then at.Jump=true;task.wait(0.2)break end
                    at:MoveTo(au.Position)
                    task.wait(math.random(1,3)/100)
                    if(au.Position-ar).Magnitude<5 then break end
                end
            end
        else
            at:MoveTo(ar)
            task.wait(8)
            break
        end
        task.wait()
    end
    at.WalkSpeed=av
end
local function bi(bj,bk)
    if not(bj and bj.Parent and bj.Parent:FindFirstChild("HumanoidRootPart"))then return end
    if am.FarmMethod.Value=="Teleport"then
        bj.Parent.HumanoidRootPart.CFrame=bk
        task.wait(0.1)
    else aq(bk.Position)end
end
local function bl(bm)
    if not bm then return end
    local bn=bm.AbsolutePosition.X+(bm.AbsoluteSize.X/2)
    local bo=bm.AbsolutePosition.Y+(bm.AbsoluteSize.Y/2)
    ad:SendMouseButtonEvent(bn,bo,0,true,bm,1)
end
local function bp(bq)
    if not bq then return end
    local br=bq.AbsolutePosition.X+(bq.AbsoluteSize.X/2)
    local bs=bq.AbsolutePosition.Y+(bq.AbsoluteSize.Y/2)
    ad:SendMouseButtonEvent(br,bs,0,false,bq,1)
end
local function bt(bu)
    if not bu then return end
    bl(bu)
    task.wait(0.05)
    bp(bu)
end
local function bv(bw)
    if bw==""then return"Not set"end
    local bx=string.split(bw,",")
    if #bx>=3 then
        return string.format("X: %.3f, Y: %.3f, Z: %.3f",tonumber(bx[1]),tonumber(bx[2]),tonumber(bx[3]))
    end
    return"Invalid data"
end
local function by()
    local bz=aj.PlayerGui.BackpackGui.Backpack.Inventory.TopButtons.Unaffected:FindFirstChild("InventorySize")
    if not bz then return nil end
    local ca=bz.Text
    local cb,_=string.match(ca,"(%d+)/(%d+)")
    if not cb then return nil end
    local cc=tonumber(cb)
    local cd=tonumber(am.AutoSellSlider.Value)or 0
    if cc<cd then return nil end
    local ce=aj.Character
    if not ce then return nil end
    local cf=ce:FindFirstChild("HumanoidRootPart")
    local cg=ae.Remotes.Shop:FindFirstChild("SellAll")
    if not(cf and cg)then return nil end
    local ch={{"NPCs","StarterTown","Merchant"},{"NPCs","RiverTown","Merchant"},{"NPCs","Delta","Shady Merchant"}}
    local ci=nil
    local cj=math.huge
    for _,ck in ipairs(ch)do
        local cl=af
        for _,cm in ipairs(ck)do cl=cl:FindFirstChild(cm)if not cl then break end end
        if cl and cl.PrimaryPart then
            local cn=(cf.Position-cl.PrimaryPart.Position).Magnitude
            if cn<cj then cj=cn;ci=cl end
        end
    end
    if not ci then return nil end
    local co=ci.PrimaryPart
    if cj>45 then
        local cp
        if ci:GetFullName()=="Workspace.NPCs.RiverTown.Merchant"then
            cp=(co.CFrame*CFrame.new(0,0,-45)).Position
        else
            local cq=(cf.Position-co.Position).Unit
            cp=co.Position+cq*45
        end
        aq(cp)
    end
    cg:InvokeServer()
    task.wait(0.1)
    cg:InvokeServer()
    task.wait(0.1)
    return ci
end
local function cr()
    if an then task.cancel(an)an=nil end
    an=task.spawn(function()
        if ao==""or ap==""then aa:Notify({Title="Error",Content="Please set both water and sand spots",Duration=5})am.ToggleFarm:SetValue(false)return end
        local cs=CFrame.new(table.unpack(string.split(ao,",")))
        local ct=CFrame.new(table.unpack(string.split(ap,",")))
        local function cu()
            local cv=aj.Character
            if not cv then return nil end
            for _,cw in ipairs(aj.Backpack:GetChildren())do
                if cw:IsA("Tool")and(cw.Name:match("Pan")or cw.Name=="Worldshaker"or cw.Name=="Earthbreaker")then return cw end
            end
            for _,cx in ipairs(cv:GetChildren())do
                if cx:IsA("Tool")and(cx.Name:match("Pan")or cx.Name=="Worldshaker"or cx.Name=="Earthbreaker")then return cx end
            end
            return nil
        end
        while am.ToggleFarm.Value do
            local cy=aj.Character
            local cz=cy and cy:FindFirstChildOfClass("Humanoid")
            local da=cu()
            if cy and cz and cz.Health>0 and da then
                if da.Parent==aj.Backpack then
                    cz:EquipTool(da)
                    task.wait(0.1)
                else
                    local db=cy:FindFirstChild(da.Name)
                    local dc=aj.PlayerGui:FindFirstChild("ToolUI",true)and aj.PlayerGui.ToolUI:FindFirstChild("FillingPan",true)and aj.PlayerGui.ToolUI.FillingPan:FindFirstChild("Bar")
                    if db and dc then
                        if dc.Size.X.Scale<0.99 then
                            if(cy.HumanoidRootPart.Position-ct.Position).Magnitude>3 then
                                bi(cz,ct)
                                task.wait(0.1)
                            end
                            local dd=aj.PlayerGui:FindFirstChild("ToolUI",true)and aj.PlayerGui.ToolUI:FindFirstChild("DigBar",true)
                            if dd then
                                if dc.Size.X.Scale<0.99 then
                                    bl(dd)
                                    local de
                                    local df
                                    local dg=tick()
                                    local dh=false
                                    while(tick()-dg)<1.5 and not(de and de.Visible and df and df.Visible)do
                                        if dc.Size.X.Scale>=0.99 then dh=true;break end
                                        de=dd:FindFirstChild("Line")
                                        if not df then
                                            for _,di in ipairs(dd:GetChildren())do
                                                if di:IsA("Frame")and di.BackgroundColor3.G>0.5 and di.BackgroundColor3.R<0.3 and di.BackgroundColor3.B<0.3 then
                                                    df=di
                                                    break
                                                end
                                            end
                                        end
                                        task.wait()
                                    end
                                    if not dh and de and de.Visible and df and df.Visible then
                                        local dj=df.Position.Y.Scale
                                        local dk=dj+df.Size.Y.Scale
                                        local dl=tick()
                                        while(tick()-dl)<2 and am.ToggleFarm.Value do
                                            if dc.Size.X.Scale>=0.99 then dh=true;break end
                                            if not(de and de.Visible)then break end
                                            if de.Position.Y.Scale>=dj and de.Position.Y.Scale<=dk then break end
                                            task.wait()
                                        end
                                    end
                                    bp(dd)
                                end
                            else task.wait(0.1)end
                        else
                            if(cy.HumanoidRootPart.Position-cs.Position).Magnitude>3 then
                                bi(cz,cs)
                                task.wait(0.1)
                            end
                            local dm=db:FindFirstChild("Scripts")
                            if dm then
                                local dn=dm:FindFirstChild("Pan")
                                local do_=dm:FindFirstChild("Shake")
                                if dn and do_ then
                                    dn:InvokeServer()
                                    task.wait(0.1)
                                    while dc.Size.X.Scale>0 and am.ToggleFarm.Value do
                                        do_:FireServer()
                                        task.wait(0.1)
                                    end
                                    if am.AutoSellToggle and am.AutoSellToggle.Value then
                                        local dp=by()
                                        if dp then
                                            if dp:GetFullName()=="Workspace.NPCs.RiverTown.Merchant"then
                                                local dq=af.Map.RiverTown.Details:FindFirstChild("LampPost")
                                                local dr={}
                                                if dq then
                                                    for _,ds in ipairs(dq:GetDescendants())do
                                                        if ds:IsA("BasePart")then
                                                            dr[ds]={CanCollide=ds.CanCollide,CanQuery=ds.CanQuery}
                                                            ds.CanCollide=false
                                                            ds.CanQuery=false
                                                        end
                                                    end
                                                end
                                                aq(ct.Position)
                                                if dq then
                                                    for dt,du in pairs(dr)do
                                                        if dt and du then
                                                            dt.CanCollide=du.CanCollide
                                                            dt.CanQuery=du.CanQuery
                                                        end
                                                    end
                                                end
                                            else
                                                aq(ct.Position)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else task.wait(0.1)end
                end
            else
                task.wait()
            end
            task.wait()
        end
    end)
end
al.Main:CreateToggle("ToggleFarm",{Title="Auto Farm",Description="Auto Farm All",Default=false,Callback=function(dv)if dv then cr()else if an then task.cancel(an)an=nil end end end,})
al.Main:CreateToggle("AutoSellToggle",{Title="Auto Sell",Description="Enable auto selling when inventory is full enough",Default=false})
local dw=500
local dx=50
pcall(function()local dy=aj.PlayerGui:WaitForChild("BackpackGui"):WaitForChild("Backpack"):WaitForChild("Inventory"):WaitForChild("TopButtons"):WaitForChild("Unaffected"):WaitForChild("InventorySize")local _,dz=string.match(dy.Text,"(%d+)/(%d+)")if dz then dw=tonumber(dz)dx=math.floor(dw*0.3)end end)
al.Main:CreateInput("AutoSellSlider",{Title="Auto Sell Threshold",Placeholder="Set item count to trigger auto-sell",Default=tostring(dx),Numeric=true,Finished=false,Callback=function()end})
al.Main:CreateDropdown("FarmMethod",{Title="Selected method",Description="Choose how to move",Values={"Teleport","Walk"},Default="Teleport",Multi=false,})
local ea=al.Main:CreateParagraph("PanPos",{Title="Water CFrame",Content=bv(ao)})
al.Main:CreateButton({Title="Set Water CFrame",Description="Save current CFrame",Callback=function()local eb=aj.Character;if eb and eb.HumanoidRootPart then local ec=eb.HumanoidRootPart.CFrame;ao=table.concat({ec:GetComponents()},",")ea:SetContent(bv(ao))aa:Notify({Title="Success",Content="Water CFrame saved",Duration=4})end end})
local ed=al.Main:CreateParagraph("ColPos",{Title="Sand CFrame",Content=bv(ap)})
al.Main:CreateButton({Title="Set Sand CFrame",Description="Save current CFrame.",Callback=function()local ee=aj.Character;if ee and ee.HumanoidRootPart then local ef=ee.HumanoidRootPart.CFrame;ap=table.concat({ef:GetComponents()},",")ed:SetContent(bv(ap))aa:Notify({Title="Success",Content="Sand CFrame saved",Duration=4})end end})
local eg={}
local function eh()local ei=ae:FindFirstChild("Items")and ae.Items:FindFirstChild("Valuables")if not ei then return end;for _,ej in ipairs(ei:GetChildren())do if ej:IsA("Tool")then local ek=ej:GetAttribute("Rarity")if type(ek)=="string"and ek~=""then eg[ej.Name]=ek end end end end
eh()
local el={}
for _,em in pairs(eg)do el[em]=true end
local en={}
for eo in pairs(el)do table.insert(en,eo)end
table.sort(en)
local ep=al.Favourite:CreateDropdown("RaritySelection",{Title="Select Rarity",Description="Pick one or more rarities to favourite",Values=en,Multi=true,Default={},})
local eq=al.Favourite:CreateToggle("AutoLockItems",{Title="Auto Favourite by Rarity",Description="Auto favourite selected rarity",Default=false,})
al.Favourite:CreateButton({Title="Remove Favourite by Rarity",Description="Remove favourite by rarity",Callback=function()local er=aj.Backpack;local es=am.RaritySelection.Value;local et=game:GetService("ReplicatedStorage").Remotes.Inventory.ToggleLock;if not et then return end;local eu=0;for _,ev in ipairs(er:GetChildren())do if ev:IsA("Tool")then local ew=eg[ev.Name];if ew and es[ew]and ev:GetAttribute("Locked")then et:FireServer(ev)eu=eu+1 end end end end})
al.Favourite:CreateParagraph("Aligned Paragraph",{Title="Weight",Content="Auto Favourite Weight",TitleAlignment="Middle",ContentAlignment=Enum.TextXAlignment.Center})
local ex=al.Favourite:CreateInput("WeightInput",{Title="Minimum Weight",Default="0.5",Placeholder="e.g., 0.5",Numeric=true,Finished=false,})
local ey=al.Favourite:CreateToggle("AutoLockByWeight",{Title="Auto Favourite Weight",Description="Auto favourite at or above the weight",Default=false,})
al.Favourite:CreateParagraph("Aligned Paragraph",{Title="Ore",Content="Auto Favourite Ore",TitleAlignment="Middle",ContentAlignment=Enum.TextXAlignment.Center})
local ez={}
for fa,_ in pairs(eg)do table.insert(ez,fa)end
table.sort(ez)
local fb=al.Favourite:CreateDropdown("ItemNameSelection",{Title="Select Item by Name",Description="Pick one or more ore to favourite",Values=ez,Multi=true,Default={},})
local fc=al.Favourite:CreateToggle("AutoLockByName",{Title="Auto Favourite Ore",Description="Auto favourite ore",Default=false,})
local fd,fe=nil,nil
local function ff()task.wait()if am.AutoLockItems.Value then local fg=aj.Backpack;local fh=am.RaritySelection.Value;local fi=game:GetService("ReplicatedStorage").Remotes.Inventory.ToggleLock;for _,fj in ipairs(fg:GetChildren())do if fj:IsA("Tool")then local fk=eg[fj.Name];if fk and fh[fk]and not fj:GetAttribute("Locked")then fi:FireServer(fj)end end end end;if am.AutoLockByWeight.Value then local fl=aj.Backpack;local fm=tonumber(am.WeightInput.Value)if not fm then return end;local fn=game:GetService("ReplicatedStorage").Remotes.Inventory.ToggleLock;for _,fo in ipairs(fl:GetChildren())do if fo:IsA("Tool")then local fp=fo:FindFirstChild("Stats")if fp and fp:GetAttribute("BaseWeight")then if fp:GetAttribute("BaseWeight")>=fm and not fo:GetAttribute("Locked")then fn:FireServer(fo)end end end end end;if am.AutoLockByName.Value then local fq=aj.Backpack;local fr=am.ItemNameSelection.Value;if not next(fr)then return end;local fs=game:GetService("ReplicatedStorage").Remotes.Inventory.ToggleLock;for _,ft in ipairs(fq:GetChildren())do if ft:IsA("Tool")then if fr[ft.Name]and not ft:GetAttribute("Locked")then fs:FireServer(ft)end end end end end
local function fu()if fd then task.cancel(fd)fd=nil end;if fe then fe:Disconnect()fe=nil end;if am.AutoLockItems.Value or am.AutoLockByWeight.Value or am.AutoLockByName.Value then ff()fd=task.spawn(function()while am.AutoLockItems.Value or am.AutoLockByWeight.Value or am.AutoLockByName.Value do ff()task.wait()end end)fe=aj.Backpack.ChildAdded:Connect(function(fv)if fv:IsA("Tool")then ff()end end)end end
local function fw(fx)local fy=tostring(math.floor(fx))fy=fy:reverse():gsub("(%d%d%d)","%1,")return fy:reverse():gsub("^,","")end
local fz,ga,gb,gc={}, {}, {}, {}
local gd={}
local ge={}
local gf={}
local gg={}
local gh=af:FindFirstChild("Purchasable")
if gh then
    for _,gi in ipairs(gh:GetChildren())do
        if gi:IsA("Folder")then
            for _,gj in ipairs(gi:GetChildren())do
                local gk=gj.Name
                local gl=gj:FindFirstChild("ShopItem")
                if gl then
                    local gm=gl:GetAttribute("Price")
                    local gn=gl:GetAttribute("ShardPrice")
                    if gm and type(gm)=="number"then
                        local go={Town=gi.Name,ItemName=gk,Price=gm,Currency="Standard"}
                        if(string.sub(gk,-3)=="Pan"or gk=="Earthbreaker"or gk=="Worldshaker"or(gj:IsA("Model")and gj.PrimaryPart and gj.PrimaryPart.Name=="Pan"))then
                            table.insert(fz,go)
                        elseif(string.sub(gk,-6)=="Shovel"or(gj:IsA("Model")and gj.PrimaryPart and gj.PrimaryPart.Name=="ShovelHandle"))then
                            table.insert(ga,go)
                        elseif(string.sub(gk,-6)=="Potion"or(gj:IsA("Model")and gj.PrimaryPart and gj.PrimaryPart.Name=="Glass Bottom"))then
                            table.insert(gb,go)
                        end
                    elseif gn and type(gn)=="number"then
                        local gp={Town=gi.Name,ItemName=gk,Price=gn,Currency="Shards"}
                        table.insert(gc,gp)
                    end
                end
            end
        end
    end
end
if #fz>0 then
    for _,gq in ipairs(fz)do
        table.insert(ge,string.format("%s - %s ($%s)",gq.Town,gq.ItemName,fw(gq.Price)))
    end
else
    table.insert(ge,"No pans found")
end
if #ga>0 then
    for _,gr in ipairs(ga)do
        table.insert(gf,string.format("%s - %s ($%s)",gr.Town,gr.ItemName,fw(gr.Price)))
    end
else
    table.insert(gf,"No shovels found")
end
if #gb>0 then
    for _,gs in ipairs(gb)do
        table.insert(gg,string.format("%s - %s ($%s)",gs.Town,gs.ItemName,fw(gs.Price)))
    end
else
    table.insert(gg,"No potions found")
end
if #gc>0 then
    for _,gt in ipairs(gc)do
        table.insert(gd,string.format("%s - %s (%sS)",gt.Town,gt.ItemName,fw(gt.Price)))
    end
else
    table.insert(gd,"No shard items found")
end
local function gu(gv)
    return function()
        if #gv.data==0 then return end
        local gw=aa.Options[gv.selectorName].Value
        local gx=nil
        for _,gy in ipairs(gv.data)do
            local gz=gv.formatString
            if string.format(gz,gy.Town,gy.ItemName,fw(gy.Price))==gw then
                gx=gy
                break
            end
        end
        if gx then
            local ha=af.Purchasable[gx.Town][gx.ItemName].ShopItem
            ae.Remotes.Shop.BuyItem:InvokeServer(ha)
            aa:Notify{Title="Purchase Successful",Content="You have purchased the "..gx.ItemName..".",Duration=3}
        else
            aa:Notify{Title="Purchase Error",Content="Could not find the selected item",Duration=3}
        end
    end
end
al.Shop:CreateDropdown("PanSelector",{Title="Select Pan",Values=ge,Multi=false,Default=ge[1]})
al.Shop:CreateButton{Title="Buy Selected Pan",Callback=gu{data=fz,selectorName="PanSelector",formatString="%s - %s ($%s)"}}
al.Shop:CreateDropdown("ShovelSelector",{Title="Select Shovel",Values=gf,Multi=false,Default=gf[1]})
al.Shop:CreateButton{Title="Buy Selected Shovel",Callback=gu{data=ga,selectorName="ShovelSelector",formatString="%s - %s ($%s)"}}
al.Shop:CreateDropdown("PotionSelector",{Title="Select Potion",Values=gg,Multi=false,Default=gg[1]})
al.Shop:CreateButton{Title="Buy Selected Potion",Callback=gu{data=gb,selectorName="PotionSelector",formatString="%s - %s ($%s)"}}
al.Shop:CreateDropdown("ShardItemSelector",{Title="Select Shard Item",Values=gd,Multi=false,Default=gd[1]})
al.Shop:CreateButton{Title="Buy Selected Shard Item",Callback=gu{data=gc,selectorName="ShardItemSelector",formatString="%s - %s (%sS)"}}
ep:OnChanged(ff)
ex:OnChanged(ff)
eq:OnChanged(fu)
ey:OnChanged(fu)
fb:OnChanged(ff)
fc:OnChanged(fu)
fu()
ab:SetLibrary(aa)
ac:SetLibrary(aa)
aa:SetTheme("Dark")
ab:IgnoreThemeSettings()
ab:SetIgnoreIndexes({})
ac:SetFolder("DOITV.1")
ab:SetFolder("DOITV.1/Pros")
ac:BuildInterfaceSection(al.Settings)
ab:BuildConfigSection(al.Settings)
ak:SelectTab(1)
ab:LoadAutoloadConfig()
print("DoitV.1 loadded")
