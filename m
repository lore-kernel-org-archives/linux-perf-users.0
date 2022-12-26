Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD0C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Dec 2022 16:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLZQMl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Dec 2022 11:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLZQMk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Dec 2022 11:12:40 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9B610D7
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Dec 2022 08:12:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu8dRHCowf6ymZBVlIANfBrScDqXcXQfAug/YBSnBt5IJxlk4xvhPkFdR9/ZoDc5iC8f08ssiqRojQZphkAfAAPldfKk5VbiHdoA6IzUTVDeVcfmER1sftVj9my9Yc7TPYVQpzab0d0XztzNJ9Fm+pFTBOrlpbCIEDsP4Ey4cYoGrZo9khQA8BJvszqv2LqlZXtY191MFG0OZq/BLg9CGWesdIQosrPzq1FtdR0hwJd3F6eqAF/ny/frASKwzn4KGb423aG83REiW0UiV7gAMshBZnD1TK4TICaB+etG/KxSmz5mYSIZXfiz0Va8/b/lRJEgX1usdkRb03HOsDRnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUtCBzQXg/NyOyR7f6vzoZb6sOH443ZImURv8I/2UUI=;
 b=Z7IL9fZPcsTcfRfqDeiL+GxQy/x4psFOH7SZTttrJIKN4nm79ycbeR+mN3JZ/VmuUSrnPGGn892tdt/gfeXuT5qnbMFZMaYzAAaKIlRGj0XMXMsnW6cJipGpkGf4/dp4LGIlTHXBMB47Oxr9PS5u1PbHA24kd/vPyAhcmSrgTkEOwKi31oqxoHfgmrlO+I3U72Gw5mpr5eewp8AXvhBDQTliayoXns/Rnnis/REdj3jfd+xfq9fHag6LqhEp5YpCCt3+JFMkUwufnJ4EauCxkZ4qUe3+PFI8auRd2IsIV9ABIryOpBO5gxDm2KbOwrU/dF1vCqWGiHkhxPdYg11h6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUtCBzQXg/NyOyR7f6vzoZb6sOH443ZImURv8I/2UUI=;
 b=w0sQ12Z/QlrnVQaSc2h9Ewxh2zlf0TuVHW0WRqgz908i4v6lxS/HmoRBFzJwAJDYjFgO9ofJtZinm8bFu+k+3iT7zxr04sj7efuwXWumU1JP3Y7PSvSDPg49d8HdwXXfzi0/ndssrd24HyUruThQqHYYGqy9gMTQOnBGo+HTBasLgIuflfCfRyRnnQF4PZFtKBTGSnwO+7/ttqgIj0FCIfHhAUuc1Lx29HZv8fj6Up20xE6rd5G0kPwXHJs9xfRSE8JK2WZ2yjdPPEbESx9gAeXesHR6cQBggQLeZyp7JDx5/CV93FWjInzkEz3CS98uksiiLMPfV9aI2KE2sOOFNA==
Received: from GV3P280CA0113.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::13) by
 AS4PR10MB5573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.15; Mon, 26 Dec
 2022 16:12:34 +0000
Received: from HE1EUR01FT039.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::27) by GV3P280CA0113.outlook.office365.com
 (2603:10a6:150:8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Mon, 26 Dec 2022 16:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT039.mail.protection.outlook.com (10.152.0.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16 via Frontend Transport; Mon, 26 Dec 2022 16:12:32 +0000
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.20; Mon, 26 Dec 2022 17:12:31 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 27 Dec 2022 00:12:29 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.016; Tue, 27 Dec 2022 00:12:29 +0800
From:   "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "irogers@google.com" <irogers@google.com>
CC:     "ben@decadent.org.uk" <ben@decadent.org.uk>,
        "debian-kernel@lists.debian.org" <debian-kernel@lists.debian.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "waldi@debian.org" <waldi@debian.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
Thread-Topic: Getting the latest and greatest Linux perf features on every
 Debian kernel
Thread-Index: AQHZFnAE2KafCifzNka8ZEqO5o/ybK5+iEKzgAFOboA=
Date:   Mon, 26 Dec 2022 16:12:28 +0000
Message-ID: <fcfc3f28f7d67099f19cba2f5b4bf2ef528917b0.camel@siemens.com>
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
         <YY58idSor+lJ84KF@kernel.org>
         <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
         <f59da80e6b4d053246fec4ef263ae4ca7aa1277f.camel@decadent.org.uk>
         <Ydx+mtl1c7L/bbGJ@kernel.org>
         <CAP-5=fUzHV765DqcTZpqCKC1Ve1H91tUfoxQE7Z2KcK5yq021A@mail.gmail.com>
         <874jtjem5q.fsf@linux.intel.com>
In-Reply-To: <874jtjem5q.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [139.24.236.126]
Content-Type: text/plain; charset="utf-8"
Content-ID: <86AECF30914B654EB69785A33D7E88FB@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT039:EE_|AS4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: a1abee48-de2d-4138-dcfa-08dae75bfeb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dF5eQEmFjaQ+Czu7me6UyETE2NiEsp5Z7Qi6EdflZRjrkYOj29vmZ9BUxr2dmzcOpfNwZrMcAj3c156/Fy/JEsvAsHcN1zJVaIOCExdz8VxCKnnPPUkyjVybEPE1t/nMh/PjzHIJ5owdko4NRwRwBeSxSHeshkmiEoHBcN42mR81YWQwBdWND43p0kmnINKuuuCevW7mFYjCpk169VqbKtuL8fXnCeJQx8dIw9KV0S0kr9ZArysDJPDbUr8Fz/NPHZ93B+zdILPwbD0q7X80UYF3WT0FfxHPuSyuFqPD1GgBAy0NN+KphK4Ll+ak/m/pNq7yVDRKuhJiIbd6cLGf54ZZssHPlw4faGVYXpVMYqpU1KkNjT2N4ylpbzcWYJpqtf/G0Jw7j2P2+51DDl+uIftE1ozgzoZtl6SY5SMpydoEhG5vYfRcVi8O+Ynmk1QZLOv9bFrmTnEYCOfecojmyiskoekh3yn8RXxTHgclGsEUXK/D4tlYLoOfzSHSAkPNsCzw6eB3Qb4RWNfqoCYnVHNn4+samQ/CCxgOTvEekLQ8neOTjCkYFKbNl5HmgJoQ/Y8PsPMt6JzvxrnPlAqmPAxK/KSiwNsNiGqQ8PMTuutSlA0hPxpkGj7EZ+tIbE6GFe0pS+5UJOeRVTvkJJCkTfKPPLa5wzJjPCoMQB1l9yBco09qvs/0wOpdABAapOX2ZFo+m73Vzv12seL/b/8rw7s4rMbT6T68sjljXyjPX+Q=
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(2616005)(36860700001)(956004)(70586007)(316002)(70206006)(82960400001)(7596003)(82740400003)(356005)(4001150100001)(7636003)(82310400005)(36756003)(40460700003)(478600001)(8936002)(83380400001)(47076005)(5660300002)(2906002)(8676002)(4326008)(54906003)(966005)(110136005)(336012)(86362001)(4744005)(26005)(186003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 16:12:32.6719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1abee48-de2d-4138-dcfa-08dae75bfeb5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT039.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5573
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

T24gU3VuLCAyMDIyLTEyLTI1IGF0IDAzOjUxIC0wODAwLCBBbmRpIEtsZWVuIHdyb3RlOg0KPiBJ
YW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+IHdyaXRlczoNCj4gDQo+ID4gU28gSSB3YW50
ZWQgdG8gc2F5IGEgQklHIHRoYW5rcyB0byBCZW4gYXMgSSBzZWUgaW4gdGhlIDUuMTYNCj4gPiBj
aGFuZ2Vsb2cNCj4gPiB0aGF0IHRoZSBwZXJmIHdyYXBwZXIgc2NyaXB0IGZvciBEZWJpYW4gaXMg
bm93IGdvbmUhDQoNCkFzIGFscmVhZHkgc2FpZDogVGhhbmsgeW91IEJlbiENCg0KPiA+ICANCj4g
PiBodHRwczovL21ldGFkYXRhLmZ0cC1tYXN0ZXIuZGViaWFuLm9yZy9jaGFuZ2Vsb2dzLy9tYWlu
L2wvbGludXgvbGludXhfNi4xfnJjOC0xfmV4cDFfY2hhbmdlbG9nDQo+IA0KPiBIYWxsZWx1amEh
IFRoaXMgd3JhcHBlciBsaXRlcmFsbHkgaXMgdGhlIHNpbmdsZXN0IGJpZ2dlc3QgdXNhYmlsaXR5
DQo+IHByb2JsZW0gd2l0aA0KPiBwZXJmIHdpdGggcmVhbCB1c2Vycy4gSG9wZWZ1bGx5IHRoYXQg
Y2hhbmdlIGdldHMgcGlja2VkIHVwIGV2ZXJ5d2hlcmUNCj4gYXMNCj4gc29vbiBwb3NzaWJsZS4N
Cg0KT25lIGltcG9ydGFudCB0aGluZyB0byBub3RpY2U6IHdoZW4gdXNpbmcgdGhlIGJ1bGxzZXll
IGJhY2twb3J0cw0Ka2VybmVsLCB5b3Ugc2hvdWxkIGFsc28gdXNlIHRoZSBsaW51eC1wZXJmIGZy
b20gYmFja3BvcnRzLg0KVGhpcyBwYWNrYWdlIHVzZXMgYSBkaXZlcnNpb24gdG8gcmVwbGFjZSB0
aGUgcGVyZiB3cmFwcGVyDQooL3Vzci9iaW4vcGVyZikgd2hpY2ggc3RpbGwgaXMgcHJvdmlkZWQg
YnkgbGludXgtYmFzZS4gVmVyeSBuZWF0IQ0KDQpMb25nIHN0b3J5IHNob3J0OiBFdmVyeXRoaW5n
IHdvcmtzIHByb3Blcmx5IHdoZW4gdXNpbmcgdGhlIGxpbnV4LXBlcmYNCmZyb20gYmFja3BvcnRz
IChpbmNsdWRpbmcgdGhlIHB5dGhvbiBiaW5kaW5ncykuDQoNCkZlbGl4DQoNCj4gDQo+IC1BbmRp
DQo+IA0KDQo=
