Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8681EC433B4
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 08:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E806115B
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 08:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhDPIT5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:19:57 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:39406
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229706AbhDPIT4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Apr 2021 04:19:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDvrVxg2VbxXbQc2NsMMRLUKFvkL1F86Dbtl8PHxKpLYtFlEareTLKVWNzNhQ+bHN7NJ9xmY0JE5x6qtRqFiTR581duGN/MA1+u2v6HNac+SetKprHyzUsIdyWMOmPGBSi/a82OmxKC+BG0kj7KFS7oLsuRzRJoE3GdOSH+9uau9WP0rkaMJ9lr1z46aEXEuXcgGA/dfKThtK8vUlo3NKZCIwvhoAR2bAV+lwl0x/eIA8DRdPUBm9wJZeZtCEBMef0m2w/F0MRRlE7zbJV+bnYTtIaoHApORVFn/K5AVLIq+HDRO5dyTMXA+Ez51/ykoVb9LY1yFvgF6CRXtTKQk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEmwfRMN7Z5Vvtl3j6GWTkV2ZVuHIiqUZkISeAFjLDo=;
 b=OLciDWqO2e00t98far5x4SnJf6+eBvfOXmQBGdrQM+lDoez15Yn01Nkq9EZkAUfgg6hEjmeH1dFEJoLGeLyq1nASqACA37yuOuYHEYE94qH+X+1k+AAnIwldXuN+I52mw338kgagsBVy+CDYmfzyxS0pVKg8hbppPoOJdAxlD1RDTg8wylbOFOr5KSOtFLEJj8brqA6mbh8cfOTAEOtchMZz4S2MvGDiVQDHEr5Ra456pUETsX91b303lWTJ2KUpOAdUqQX/Gn4nmFIqsMzBka69l2w/kDXWAhEWQZb748fpVpbGv4Wk9o9Nvdms1eHe4Yk9NG3FJo8a/bUJR6HGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEmwfRMN7Z5Vvtl3j6GWTkV2ZVuHIiqUZkISeAFjLDo=;
 b=PIJeVV0Y2ZWFBxILYdb7P34FzMnO82osNZBETmd0lPRYe8vrZWifOy3eUiiKfuH/NbD5oiKmxLHkeDRPJhrAZY+aIlAbuMNPcc1PZ9aYS4mUR9IkjrRjHxV4nAgap3peI3xOjWNW/qS2ycCYKmbsqI0LsbVIRzJPpKZt6db4kuM=
Received: from DU2PR04CA0318.eurprd04.prod.outlook.com (2603:10a6:10:2b5::23)
 by AM7PR10MB3809.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:173::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 08:19:30 +0000
Received: from DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::af) by DU2PR04CA0318.outlook.office365.com
 (2603:10a6:10:2b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 08:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=de.bosch.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 DB5EUR03FT024.mail.protection.outlook.com (10.152.20.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 08:19:30 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.2; Fri, 16 Apr
 2021 10:19:09 +0200
Received: from SI-MBX2070.de.bosch.com (10.3.230.175) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.2; Fri, 16 Apr 2021 10:19:09 +0200
Received: from SI-MBX2071.de.bosch.com (10.3.230.176) by
 SI-MBX2070.de.bosch.com (10.3.230.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.2; Fri, 16 Apr 2021 10:19:08 +0200
Received: from SI-MBX2071.de.bosch.com ([fe80::f414:70fb:ddd0:ec15]) by
 SI-MBX2071.de.bosch.com ([fe80::f414:70fb:ddd0:ec15%4]) with mapi id
 15.01.2176.009; Fri, 16 Apr 2021 10:19:08 +0200
From:   "Fontius Sebastian (XC-DA/ESV9)" <Sebastian.Fontius@de.bosch.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: RE: Perf call graphs on ARM
Thread-Topic: Perf call graphs on ARM
Thread-Index: AdcxML9pspPNbggzT5KWFDKe/60W3///49+A//0TrlA=
Date:   Fri, 16 Apr 2021 08:19:08 +0000
Message-ID: <483117050be94fe89841a5cb74b66150@de.bosch.com>
References: <e083221298cc4bd09c4d77a85a33c2a1@de.bosch.com>
 <YHbwU1mCp+Mslx6a@kernel.org>
In-Reply-To: <YHbwU1mCp+Mslx6a@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.157.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07fb703b-44be-48af-fffb-08d900b05bf1
X-MS-TrafficTypeDiagnostic: AM7PR10MB3809:
X-Microsoft-Antispam-PRVS: <AM7PR10MB38096B66B2F6A7599D27C513C94C9@AM7PR10MB3809.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQVTe7W8WvFucwAsRelBo/jRDWouF9qvvgPIqFz3wEMSxASllIsg83eCEey/O6p1mBpshK7HMhw5iXpCO2nffCrghG/R93O9ZdxqDV8qcZWPmly5Y7mkYuT6necFo3+Zcy2gQGAxT3w6/LAGhnrrlLFUrCP2/I8GrI/CeHwJgdQ6PX/1jmBMdILIRh2SaEsb9ChMaI7cEObffYhPs5H0E4AOf+pEMcVhvAvk10LjtwZ+Kv8LzSKYKiqz/3MS81oOiMdDwCrb692X94GpzKD602CtRcBOQWFfvfoNur2aADawcdFG6NIJ7ZjonsrAqkQDKSb0W1IE9zzjCDPakDcEEI34CyNeGVU3yh+p6TMO1vftjfQ+odFfM4U7GAYrHlN0c0KPhAAnh4JCQ1L6iKhQJe1Ih27g/wm9M3vGLRn9PhqozfhAYf5rTrMhAB9Y/soyXdvqOPQ5NP5A9CcB+BznivZRAIRPpgEtHzqoG8KUbc/DSVA16YJHIRBtzG5cGP7Rw34JY+N9x1G3sX+CbKtWENY24InjnyOCLAb5O8WueFY/WarjwHbN/ndERsXU889an3x8F177mN5ZD7t8qnyY5cYAQdaLYWnJPIq8niWHFYi0ZsC8J0Ks8HgTfWpGGWQR66bvbD1ViGuZ/be6LDY2VF+NeQJAbgXnnAmE/zU642JGRmKZnNY6/DKdi7glESxp4pxJpe+YexbBCDRV0eVitfCB48K9rcgatzPxD+gihbrDQcjMinSy8lqHu6ilKEzg+7vthRVKWlQtmHuZAfVB4A==
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(26005)(426003)(2616005)(8936002)(966005)(5660300002)(478600001)(336012)(186003)(82310400003)(316002)(2906002)(8676002)(81166007)(82740400003)(6916009)(7696005)(70586007)(4326008)(86362001)(24736004)(70206006)(47076005)(36860700001)(108616005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 08:19:30.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fb703b-44be-48af-fffb-08d900b05bf1
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3809
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

RW0gV2VkLCBBcHIgMTQsIDIwMjEgYXQgMDE6MjI6MzJQTSArMDAwMCwgRm9udGl1cyBTZWJhc3Rp
YW4gKFhDLURBL0VTVjkpIGVzY3JldmV1Og0KPiA+IHdlIGFyZSBoYXZpbmcgdHJvdWJsZSB0byBn
ZXQgcGVyZiB0byBvdXRwdXQgYSBjYWxsIGdyYXBoIHVzaW5nIGZyYW1lDQo+ID4gcG9pbnRlcnMg
b24gYSBSYXNwYmVycnkgUGkgMiBNb2RlbCBCIFJldmlzaW9uIDEuMSAoQVJNIENvcnRleC1BNykN
Cj4gPiBydW5uaW5nIFJhc3BiaWFuIG9uIGl0cyBvZmZpY2lhbCBLZXJuZWwgdmVyc2lvbnMgNC45
IGFuZCA1LjEwLg0KPiA+IA0KPiA+IExldCBtZSBpbGx1c3RyYXRlIHRoZSBwcm9ibGVtIHdlJ3Jl
IGhhdmluZyB1c2luZyBhIHNtYWxsIHRlc3QgcHJvZ3JhbQ0KPiA+IHdlIHdpbGwgY2FsbCBhYWEu
Y3BwOg0KDQo+IEZpcnN0IHF1ZXN0aW9uIGlzIHdoYXQgcGVyZiB2ZXJzaW9uIGFyZSB5b3UgdXNp
bmc/IFRoZSBvbmUgdGhhdCBjb21lcw0KPiB3aXRoIHRoZSBkaXN0cm8geW91J3JlIHVzaW5nPw0K
DQpXZSB0cmllZCB0aGUgZm9sbG93aW5nIGNvbWJpbmF0aW9uczoNCg0KKiBLZXJuZWwgNC45ICh0
aGUgY3VycmVudCB2ZXJzaW9uIHdoZW4gd2Ugd2VyZSBpbnN0YWxsaW5nIFJhc3BiaWFuKSB3aXRo
DQogIHRoZSBwZXJmIGJpbmFyeSBhcyBzdXBwbGllZCBieSB0aGUgJ2xpbnV4LXBlcmYtNC45JyBS
YXNwYmlhbiBwYWNrYWdlLg0KDQoqIEtlcm5lbCA1LjEwIHdpdGggaXRzIGFjY29tcGFueWluZyBw
ZXJmIHZlcnNpb24gY29tcGlsZWQgZnJvbSBzb3VyY2Ugb24NCiAgdGhlIFJhc3BiZXJyeSBQaSAy
IGRpcmVjdGx5Lg0KDQo+IElmIHNvIGNhbiB5b3UgcGxlYXNlIHRyeSBmb2xsb3dpbmcgdGhlIGlu
c3RydWN0aW9ucyBhdDoNCj4NCj4gaHR0cHM6Ly9taXJyb3JzLmVkZ2Uua2VybmVsLm9yZy9wdWIv
bGludXgva2VybmVsL3Rvb2xzL3BlcmYvSE9XVE8uYnVpbGQucGVyZg0KPg0KPiBBbmQgdHJ5IHdp
dGggdGhlIGxhdGVzdCByZWxlYXNlZCBwZXJmLCBpLmUuOg0KPg0KPiBodHRwczovL21pcnJvcnMu
ZWRnZS5rZXJuZWwub3JnL3B1Yi9saW51eC9rZXJuZWwvdG9vbHMvcGVyZi92NS4xLjAvcGVyZi01
LjEuMC50YXIueHoNCg0KSSBjb21waWxlZCB0aGlzIHZlcnNpb24gYXMgcGVyIHlvdXIgc3VnZ2Vz
dGlvbi4gIFRoZSByZXN1bHRzIHdlcmUgZXhhY3RseQ0KdGhlIHNhbWUgYXMgd2l0aCB0aGUgdmVy
c2lvbnMgbWVudGlvbmVkIGFib3ZlLg0KDQo+IExlbW1lIHRyeSB0aGlzIG9uIGEgeDg2XzY0LCB1
c2luZyB0aGUgLS1uby1jaGlsZHJlbiBvcHRpb246DQoNCk9uIHg4Nl82NCB3ZSBhbHNvIGRvIG5v
dCBoYXZlIGFueSBwcm9ibGVtcy4gIFRoZSBwcm9ibGVtcyB3ZSBmYWNlIGFyZQ0Kc29sZWx5IG9u
IEFSTSwgYW5kIHRoZXJlIG9ubHkgb24gdGhlIFJhc3BiZXJyeSBQaSAyIE1vZGVsIEIgcmV2aXNp
b24gMS4xDQphbmQgMS4yLiAgV2UgaGF2ZSB0cmllZCB0aGUgc2FtZSB0aGluZyBvbiBhIGRldmlj
ZSBmcm9tIGEgZGlmZmVyZW50DQp2ZW5kb3Igd2hpY2ggZmVhdHVyZXMgYW4gQVJNIEE1MyBwcm9j
ZXNzb3IgbGlrZSB0aGUgUGkyQiByMS4yLCBidXQgbm90IGENCkJyb2FkY29tIFNvQy4gIFRoZSBP
UyBvbiB0aGUgb3RoZXIgZGV2aWNlIGlzIGEgWW9jdG8tYmFzZWQgT1MgZmVhdHVyaW5nDQprZXJu
ZWwgNC4xNCBidWlsdCBzcGVjaWZpY2FsbHkgZm9yIHRoaXMgZGV2aWNlLCBpbiBjYXNlIHRoYXQg
bWF0dGVycy4NCg0KPiBbYWNtZUBmaXZlIGMrK10kIHBlcmYgcmVwb3J0IC0tbm8tY2hpbGRyZW4g
LS1zdGRpbw0KPg0KPiBbLi4uXQ0KDQpBcyBmYXIgYXMgd2UgY2FuIHRlbGwgdGhlIHBlcmYgcmVj
b3JkIG9wdGlvbiB1c2luZyBmcmFtZSBwb2ludGVycyBhbHJlYWR5DQpkb2VzIHByb2R1Y2UgaW5j
b21wbGV0ZSBvdXRwdXQsIHdoaWNoIGNhbm5vdCBiZSB1c2VkIHRvIGNyZWF0ZSBjYWxsDQpncmFw
aHMuICBBbGwgdGhlIHBlcmYgcmVwb3J0IG9wdGlvbnMgd2UgdHJpZWQgZGlkIG5vdCBtYWtlIGFu
eQ0KZGlmZmVyZW5jZSBXUlQgY2FsbCBncmFwaHMuDQoNCj4gVGhhdCBmaXJzdCAweDQ5NTY0MTAw
MDAyYWViM2QgcmVtYWlucyBhIG1pc3RlcnksIGJ1dCBJIHJhbiBvdXQgb2YgdGltZSwNCj4gaGF2
ZSB0byBnbyBkcml2ZSB0byBwaWNrIHVwIG15IDV5byBraWQgOi0pDQoNClRoYW5rcyBmb3IgeW91
ciBpbnB1dCA6KS4NCg0KUmVnYXJkcywNCg0KU2ViYXN0aWFuDQo=
