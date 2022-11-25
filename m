Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362A0C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Nov 2022 21:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKYVGq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Nov 2022 16:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYVGp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Nov 2022 16:06:45 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031D6442C5
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Nov 2022 13:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDoCzJtxCPP22oUEXb7OKmxWHLF3NiBQ2lPqZ+Ku1vw=;
 b=g7EDp/wcDQOZ+2HZCYjftP9FTkOilZj1je/jwiMVyaI47pHg1enrP57AP5Ig9Q61NNXGtCQutqKbcyRkXsPpNrV2+37hK/XQFiAI7s5rmT9vV6CsLi+AE6ojytEnP5WgyHO/RFEUOloEPnHZmEN6c1Fo3iB+1zbXC2B9laY7m+A=
Received: from FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e::12)
 by DB9PR08MB6553.eurprd08.prod.outlook.com (2603:10a6:10:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.5; Fri, 25 Nov
 2022 21:06:31 +0000
Received: from VI1EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:1e:cafe::e0) by FR0P281CA0087.outlook.office365.com
 (2603:10a6:d10:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20 via Frontend
 Transport; Fri, 25 Nov 2022 21:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT040.mail.protection.outlook.com (100.127.145.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.19 via Frontend Transport; Fri, 25 Nov 2022 21:06:30 +0000
Received: ("Tessian outbound aeae1c7b66fd:v130"); Fri, 25 Nov 2022 21:06:30 +0000
X-CR-MTA-TID: 64aa7808
Received: from 985098e73ee8.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 66F258F7-7138-4CEF-9550-375FC1322507.1;
        Fri, 25 Nov 2022 21:06:19 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 985098e73ee8.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 25 Nov 2022 21:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADWnuEKRIfBlZUIuYhdW+Nn+T+jbXZJqfes6aHEHnY/KnSZvpngnudofUzYBB2x6LZxGB+XTYkXEiJ4/ADQpBFlXl2CHtoSdJZ2deqzK/cgIXaFbKcaNTwfmDEH9Ls1UTMAvQ1to2QL2cDZFIN/EXVjjr8gNf1uqMmcxf4n3lb5hrG45HeGblW5qZkLWNOv2WXQFCHSXhRM6gSp0GjOrMyXutCbx8hoNZoDNEuZrj3UyLwxG0iC7uMQ4Nr7VBcC2SulDtTQnyM6+siYeyL1Pkd4exQu28fTU4pUZ/0X3rPOQNOSZ1YP367/IVk0Bt5eYYXogsgD3NId+KlbmcMeT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDoCzJtxCPP22oUEXb7OKmxWHLF3NiBQ2lPqZ+Ku1vw=;
 b=Nxc5lKiCRSbKRTT20gBNSwOK3rXJEQ/6YFQRyOE5rRxdL30RV7bH9Yy9p8oxRedCyiSdYCMSb8bfLuDzDy0UaLsGSD1fXj3YWusGULA9C/vrtWrUwDk4aFyghyEXdNeJBCxAGIRla3Mw3xrEaduA86oIqyU/Vlo3/jFuYO0gTJRzIAsl2R9/7ijw4z00neaCl0D02vmWn6QJAvLTh8p1MP4MAPqmKt9THCzR24RGmgcOEx78CPwqeNMTSK324cZ9yEEa82JIcbQLuTQbSxdV0Y3K7Pfju0BEcXsfbrBo5GI4h++M+mFTq66n3FZ8s0Jov5z1tidmcRpVL+9EXgSBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDoCzJtxCPP22oUEXb7OKmxWHLF3NiBQ2lPqZ+Ku1vw=;
 b=g7EDp/wcDQOZ+2HZCYjftP9FTkOilZj1je/jwiMVyaI47pHg1enrP57AP5Ig9Q61NNXGtCQutqKbcyRkXsPpNrV2+37hK/XQFiAI7s5rmT9vV6CsLi+AE6ojytEnP5WgyHO/RFEUOloEPnHZmEN6c1Fo3iB+1zbXC2B9laY7m+A=
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com (2603:10a6:10:303::14)
 by GV1PR08MB8081.eurprd08.prod.outlook.com (2603:10a6:150:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.5; Fri, 25 Nov
 2022 21:06:11 +0000
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::2eca:d44c:1dbe:9459]) by DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::2eca:d44c:1dbe:9459%7]) with mapi id 15.20.5880.005; Fri, 25 Nov 2022
 21:06:10 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     "leo.yan@linaro.org" <leo.yan@linaro.org>,
        Marc Jorda <marc.jorda@bsc.es>,
        James Clark <James.Clark@arm.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: Available Arm CPUs with SPE
Thread-Topic: Available Arm CPUs with SPE
Thread-Index: AQHZAMktbmOLdI1sGEaSdNU0bIGKna5PmYcg
Date:   Fri, 25 Nov 2022 21:06:09 +0000
Message-ID: <DB9PR08MB75125CC4EBA5F21EE3B5D33D860E9@DB9PR08MB7512.eurprd08.prod.outlook.com>
References: <2695ecbe-816e-eab7-8da2-30e0f62ae926@bsc.es>
 <Y4C0RkbpGP4KX36C@leoy-yangtze.lan>
In-Reply-To: <Y4C0RkbpGP4KX36C@leoy-yangtze.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 006D27B9C43D944FA457637045AD7C5A.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DB9PR08MB7512:EE_|GV1PR08MB8081:EE_|VI1EUR03FT040:EE_|DB9PR08MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: f70ef5fc-7b41-48ea-6959-08dacf28ed1b
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MzNPP1BJ5Tw6EsfNUPQuoBU46+HCiR+uPwqSuIrrLbv56bHksUFMqLx3tDpGU4iUS9wppRNmTj3pSkkJ6Vk6FMFDNnQq0msDpWkMy0zN1osyhNNQgs+SBvJsm92UElli8W7S0Reu9MK8kGzcbK3eEDWS9C9aQ+yXYjnc87TwhmnX/EjeCAS4C0VUssLE5bICAeQ892vp+CtsJp4SeRP8PdriVyprxRoBFew4ZqDAEx19Pr+mn/4tBSpe64tqk2KPFBEFoNwatZAWUpXT94M4d3uxEnJsAZ/0Vv++UODznYbkNoKJcZ6giyfTWAZAwrXFcY13V9fqfeppIVy38sQIjRBvfngY/Q0B0o5AyYeprbngWPDxVmkQQrvuO3/OvAnEFMN8vFVWu/VAQiJ1i0Xq9VtPCYUwESJuxR3JuTvCH3KsDiIA8iGkIFFKs3GCRm3QtE5WSIYaXJxjWJPXa5orpCqnykL6ib5so5oGXHcg4UviRsxaLA7aY8r6HCTtn7I5jf94qXLklAGHv4ovgRpXMoWpxcP29LeUF9bIy3EocDoAVydg7dq5UHm44nIfhU1Hm5yuVm4elthPdgLsb6lUvBILZQbTAduMOezQc+0IcnYFOLy4ZQvNzULubQU8Whm0wDGrJah4OoaBhmh4zc+q9X1sl0eQJJ5rccrjdfeXT4+mpXRh/Ieqqe5aaPpG2ndmZRX7Y666penYPA8fuDN0gw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7512.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(83380400001)(38070700005)(122000001)(38100700002)(2906002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(52536014)(55016003)(71200400001)(26005)(9686003)(7696005)(6506007)(478600001)(186003)(6636002)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(966005)(110136005)(86362001)(33656002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8081
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 337d4778-b36b-40b7-cbd8-08dacf28e093
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmt/EALix9g+zRFf6f907XSC2VJTRtNkTNFQw/MZguCHoj6mxFAZec5yDNPxHKnuE7V6NlIEMbFmq/0fEbSUodmxfUYW+iIAHu/rkbP9LsQ7Qow4/ftQnmVot8dOnZqh1WCGrP7YDkG6RK0yrXPCyJL/DNr1oxNvvghQ0V/NplphvsDmzvMCsk0GqNB1Ax6XzP/o5BiVPtvF9bDrxK4SAbMJITa4pLDOICJApS37lJ151iw+JhUNfY6wsPCChKUSb0rbGSy9N+r4Bbxnr+eSya8VuayEFALJtFfi7hEu0iWbWoGtc7pb+N3GlfudTKq6q1S/xYoc/hIzG4mfd61i0d9d5jzFsGPgmG2lu5VfI++LQUbRFmZs33P/mMvuVSVbaufSOPj7fd2Q6/EzUpDqq+yMMPs6B5AU84NsqCLEWmWo9Hhozw7xGLzPD6Eiy12WwiaoSg5wmFqJOZ982SAdObKjJCIIdO+i4Bssv9xGWMBBr0I6SXM/sFxGG25F69GrZ3YWt7ZUxcsmqfKIc4G2OiNbi8ihb1Q7aDEs0YaDx7PTzoEtI4/v/YlHM5ni2O0Vu/d+W89FYDOp6v0CEyBCPWrJyhFe2hHrz0maABFswFdsZsCivGfaCsEiVwUqmrPA5jJ9f0Bn5GiMVb8Qe4Iel6x2FZuikO05sMJUCR0nyv/tkAs9IUlKdMGfI6yUII7a5hZ1sDrmEg5897TZ09mIBg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39850400004)(451199015)(40470700004)(36840700001)(46966006)(110136005)(6636002)(356005)(81166007)(316002)(7696005)(6506007)(82740400003)(41300700001)(82310400005)(52536014)(8936002)(336012)(5660300002)(47076005)(86362001)(186003)(26005)(40460700003)(9686003)(8676002)(40480700001)(4326008)(70586007)(83380400001)(70206006)(55016003)(2906002)(478600001)(36860700001)(33656002)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 21:06:30.8734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70ef5fc-7b41-48ea-6959-08dacf28ed1b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6553
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Leo Yan wrote:
> On Fri, Nov 25, 2022 at 12:17:18PM +0100, Marc Jorda wrote:
> > Hello,
> >
> > I am trying to know which currently available Arm CPUs implement the
> > Statistical Profiling Extension (SPE), does anyone know where can I
> > find such information?
>
> I don't know we have such kind of info, usually the most safe way is to c=
heck
> SoC vendor's spec and confirm if Arm SPE is supported or not.
>
> > As far as I know, it is an optional extension in Armv8.2, but I don't
> > know if it is mandatory for newer versions. Is it correct to assume
> > that all Arm Neoverse CPUs have this extension?
>
> Yes, since SPE is an optional extension, my understanding is we cannot 10=
0% say
> SPE is implemented in Armv8.2 and upwards CPUs (though it's unlikely not =
to
> implement SPE in Arm standard CPUs).
>
> To avoid to mislead you, I would like loop in James and Al for more relia=
ble
> answer.

Generally SPE has gone into the server cores but not the mobile cores,
partly for power/area reasons. Neoverse N1 has SPE, but Cortex-A76,
which is the same v8.2 architecture and a similar microarchitecture but
optimized for mobile, does not have SPE. It's not entirely a Neoverse
vs. Cortex thing though. You can use the PMU event repo to get a list,
since all CPUs with SPE, and only those, will implement SAMPLE_POP:

$ git clone https://ARM-software/data
$ grep SAMPLE_POP data/pmu/*
data/pmu/common_armv8.json:            "name": "SAMPLE_POP",
data/pmu/common_armv9.json:            "name": "SAMPLE_POP",
data/pmu/cortex-a715.json:            "name": "SAMPLE_POP",
data/pmu/cortex-x3.json:            "name": "SAMPLE_POP",
data/pmu/neoverse-n1.json:            "name": "SAMPLE_POP",
data/pmu/neoverse-n2.json:            "name": "SAMPLE_POP",
data/pmu/neoverse-v1.json:            "name": "SAMPLE_POP",
data/pmu/neoverse-v2.json:            "name": "SAMPLE_POP",

That is believed to be up to date and correct, but to be absolutely sure
you would need to check the documentation for each core. Third-party
implementations may also feature SPE, again you would need to check
documentation. (We'd be happy to include additional PMU event JSON in
the repo.)

Also, keep in mind that even if SPE is on the CPU, some action is needed
from firmware, hypervisor OS etc. to make it available to the end user.
It might or might not be available to a guest OS for example.

Al



>
> Thanks,
> Leo
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
