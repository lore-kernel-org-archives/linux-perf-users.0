Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0938AC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28E661176
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351327AbhDNNXQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 09:23:16 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:47259
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351325AbhDNNXL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Apr 2021 09:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fful2zLCDU00W5h4GS2YcQOVQiYA9R12W9/Bw5qSUzW+mTNoa722cy/ASvr29aXPn/4Wfrs9PNG8DogpUOZ7fg/GMvdc9KeCIIv+053OuGaMZn9+V7ocBDBe2Rm5QiVLVCIza5ICFU5uRhXeNNyoEpe9mRHIpja0bELaF7kW3A2gjIu1graexdrPvi77ok5OGjxGdWvuPkyt6ko2SCU4WwAh7ZnYGhQw3UH9iGecAvoJcEeEx8Wu+4N0tnY0ISHDKvjwaymug9zESvsXkwWq7Mx2rARjHkDb0ru2Nyk6idDeiRGcoGFPZs70TTDV4vjm4qxTZu9lYTwL7F3GvBfrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV5vjAQAr5QcS3+hGzBiy49xiXJokEHLsEtDFmnWxb4=;
 b=LSJRaU9YoBdwgarlXeg9FG7VI0nz65tXyzssfNKBczWoYqcvDzOQ1ygNEiLciVseyDToNNMLwFssXsdT0lmXj7GbvtXGq56rC6m7+rCt1kPTQgJCgaQmf1YGyv5PtNLV8s0v/WBaGslv8H/T0p56/bZWtt0bMwo4aQsHUMKi+yG/zhHWc8Gk+YBEAqa0VYnTBWxJ/Ep6UFSij4I1w3O82fdLk7YYZOSsidoEgue5XS9Pni++aE5oEWwf8h4PCfTwoJggTtlAoHvtqwOCfXNt+CrZ8iQNHxPe7uI5WRsLUZjFKjz/tSCUHCEF+UEPVHZW/N7XXBBsiKfhpBObRQZt2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV5vjAQAr5QcS3+hGzBiy49xiXJokEHLsEtDFmnWxb4=;
 b=U+Pek7GTG7Xi5Yn24zVjuwlr1UBxMWrESvg+eag25SFOKpF0Qgu4m8Fy3Qj2KlLsRsABcyXBdeivdrcJAyh+6n8CWpYerEq8ee1S9zrJl7rNW50MeBht8A502nAzeV4Le/AzQAhKXUETD8t1a/UF4xizOW51i9NGs6RYr+KkOFg=
Received: from MR2P264CA0031.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::19) by
 AM0PR10MB3396.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:163::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 13:22:48 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:0:cafe::4d) by MR2P264CA0031.outlook.office365.com
 (2603:10a6:500::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Wed, 14 Apr 2021 13:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=de.bosch.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.201 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.201; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.201) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Wed, 14 Apr 2021 13:22:47 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.2; Wed, 14 Apr
 2021 15:22:32 +0200
Received: from SI-MBX2071.de.bosch.com (10.3.230.176) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.2; Wed, 14 Apr 2021 15:22:32 +0200
Received: from SI-MBX2071.de.bosch.com (10.3.230.176) by
 SI-MBX2071.de.bosch.com (10.3.230.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.2; Wed, 14 Apr 2021 15:22:32 +0200
Received: from SI-MBX2071.de.bosch.com ([fe80::f414:70fb:ddd0:ec15]) by
 SI-MBX2071.de.bosch.com ([fe80::f414:70fb:ddd0:ec15%4]) with mapi id
 15.01.2176.009; Wed, 14 Apr 2021 15:22:32 +0200
From:   "Fontius Sebastian (XC-DA/ESV9)" <Sebastian.Fontius@de.bosch.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Perf call graphs on ARM
Thread-Topic: Perf call graphs on ARM
Thread-Index: AdcxML9pspPNbggzT5KWFDKe/60W3w==
Date:   Wed, 14 Apr 2021 13:22:32 +0000
Message-ID: <e083221298cc4bd09c4d77a85a33c2a1@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.223.118]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a919b37a-3569-49d7-cead-08d8ff48658a
X-MS-TrafficTypeDiagnostic: AM0PR10MB3396:
X-Microsoft-Antispam-PRVS: <AM0PR10MB339627A66CCFCB5B494B6645C94E9@AM0PR10MB3396.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmwcaCJWaBIw5lXY0OZYFperVmm7sqTxQUazITiwfMQK4Pg7BSkRu0OHFUiDpM42pgLD74r/AEh+1gOTBtM5lgij3FsgoKTqdsmEX2yd18zs9IJitMCRnq1tG5bpTSZyBDV+oZeRm1PkHT842GwTMsKTQuDLz5Vhan4x9oavs2jbSm7rt6MHYOIDjZPKhzMlgx2yQyj/njqL7HxfBTOVV5GYY9FgnNL9EhlPKK4t/Y7qWlJ0wRmwtbiFQ4T5OB5LAyxHmNCnAneXhpC19afyTCGW2KJRek8+Ip+/ZtwaNVe/S77ewXeR4ok3pA4+CNbd14XJrErxdzcLK5lE6peSw9YWySvWGgELXRvKNKsGLMScJrxiOFDBpgmytzoHXmcyRwWpT13yx7tI58JR7uxh2DCGvQzi9dmsxI1A7tChAP7KHyi86BZGzpwhkF3rsDK4Da+rrnaXNMxkEFVtnXOxR7Sxte/XRLJm2nQwHfi3s281wvp+DaqI9jbfafBncY9fWAUdgM4PNz0d1RKu1D1ADE29rRLbZuA6jC2KFNjw29ERa8ooDNsJ1Pz4wBVOaUtx7VQoNn83KR5DiF2hPcnxAwyLKyltNtZpTvGi/9Ze13+06MgUDbTtnojMpwjTN2B8vx0+30fIfZtWHR/w5Q0i9StDoSVxMB7nUm6dyuHDRo3KzyiHu9zmIGGQBg/ctUMajrS3Zj/ZcMM4xUSKXfPcQWh9Ag3nu7cPS9GDkF/bpyBVifvfTAoqXxPNHVACQ8tdUxcXXWXnnqRKU1D7CMivjg==
X-Forefront-Antispam-Report: CIP:139.15.153.201;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(70586007)(70206006)(5660300002)(478600001)(82740400003)(24736004)(15974865002)(86362001)(108616005)(7696005)(316002)(426003)(356005)(82310400003)(36860700001)(336012)(8676002)(186003)(81166007)(2906002)(26005)(8936002)(6916009)(47076005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 13:22:47.8209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a919b37a-3569-49d7-cead-08d8ff48658a
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.201];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3396
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkgZXZlcnlvbmUsDQoNCndlIGFyZSBoYXZpbmcgdHJvdWJsZSB0byBnZXQgcGVyZiB0byBvdXRw
dXQgYSBjYWxsIGdyYXBoIHVzaW5nIGZyYW1lIHBvaW50ZXJzIG9uIGEgUmFzcGJlcnJ5IFBpIDIg
TW9kZWwgQiBSZXZpc2lvbiAxLjEgKEFSTSBDb3J0ZXgtQTcpIHJ1bm5pbmcgUmFzcGJpYW4gb24g
aXRzIG9mZmljaWFsIEtlcm5lbCB2ZXJzaW9ucyA0LjkgYW5kIDUuMTAuDQoNCkxldCBtZSBpbGx1
c3RyYXRlIHRoZSBwcm9ibGVtIHdlJ3JlIGhhdmluZyB1c2luZyBhIHNtYWxsIHRlc3QgcHJvZ3Jh
bSB3ZSB3aWxsIGNhbGwgYWFhLmNwcDoNCg0KI2luY2x1ZGUgPGlvc3RyZWFtPg0KI2luY2x1ZGUg
PGNtYXRoPg0KX19hdHRyaWJ1dGVfXygobm9pbmxpbmUpKSBkb3VibGUgRyhkb3VibGUgYWFhKSB7
DQogIHJldHVybiBzcXJ0KGFhYSk7DQp9DQpfX2F0dHJpYnV0ZV9fKChub2lubGluZSkpIGRvdWJs
ZSBkb2l0KGRvdWJsZSBhYWEpIHsNCiAgZm9yKGludCBpPTA7IGk8MTAwMDsgaSsrKQ0KICAgIGFh
YT1HKGFhYSk7DQogIHJldHVybiBhYWE7DQp9DQppbnQgbWFpbigpIHsNCiAgZG91YmxlIGFhYSA9
IDEyOw0KICBmb3IoaW50IGk9MDsgaTwxMDAwMDsgaSsrKXsNCiAgICBhYWEgPSBkb2l0KGFhYSk7
DQogICAgZm9yKGludCBqPTA7IGo8MTAwMDsgaisrKQ0KICAgICAgYWFhKys7DQogICAgfQ0KICBz
dGQ6OmNvdXQgPDwgYWFhIDw8IHN0ZDo6ZW5kbDsNCn0NCg0KVGhpcyBwcm9ncmFtIGdldHMgY29t
cGlsZWQgbGlrZSB0aGlzIHVzaW5nIEdDQyBSYXNwYmlhbiA4LjMuMC02K3JwaTE6DQoNCmcrKyAt
TzIgLWZuby1vbWl0LWZyYW1lLXBvaW50ZXIgYWFhLmNwcA0KDQpUaGVuIHdlIHJ1biBwZXJmIG9u
IGl0IGxpa2UgdGhpczoNCg0KcGVyZiByZWNvcmQgLWUgY3ljbGVzIC0tY2FsbC1ncmFwaCBmcCAt
LSAuL2Eub3V0DQpwZXJmIHJlcG9ydA0KDQpJbiB0aGUgb3V0cHV0IG9mIHBlcmYgdGhlcmUgc2hv
dWxkIGJlIGEgdHJlZSBsaWtlIHRoZSBmb2xsb3dpbmc6DQoNCm1haW4NCiAgKyBkb2l0DQogICAg
KyBHDQoNCkluc3RlYWQgd2hhdCB3ZSBhcmUgZ2V0dGluZyBpcyBhbGwgb2YgdGhvc2UgZnVuY3Rp
b25zIGF0dGFjaGVkIHRvIGEub3V0IChidXQgd2UgX2RvXyBnZXQgdGhlIHJ1bnRpbWVzIGNvcnJl
Y3RseSkuDQoNCkl0IHNlZW1zIHRoZSBmcmFtZSBwb2ludGVycyBhcmUgd3JpdHRlbiB0byB0aGUg
YmluYXJ5LCBidXQgZG8gbm90IHdvcmsuIFdlIGNhbiBzZWUgdGhlIGZyYW1lIHBvaW50ZXJzIGlu
IGEgZGlzYXNzZW1ibHkgb3V0cHV0IGNyZWF0ZWQgYnkgY29tcGlsaW5nIHdpdGggLXNhdmUtdGVt
cHMgbGlrZSB0aGlzOg0KDQpnKysgLU8yIC1mbm8tb21pdC1mcmFtZS1wb2ludGVyIC1zYXZlLXRl
bXBzIGFhYS5jcHANCg0KVGhpcyBnaXZlcyB0aGUgZm9sbG93aW5nIG91dHB1dCBmb3IgdGhlIGRv
aXQoKSBmdW5jdGlvbjoNCg0KX1o0ZG9pdGQ6DQouZm5zdGFydA0KLkxGQjE3NTg6DQpAIGFyZ3Mg
PSAwLCBwcmV0ZW5kID0gMCwgZnJhbWUgPSAwDQpAIGZyYW1lX25lZWRlZCA9IDEsIHVzZXNfYW5v
bnltb3VzX2FyZ3MgPSAwDQp2bW92LmY2NCBkNywgZDANCnB1c2gge3I0LCByNSwgZnAsIGxyfQ0K
bW92IHI0LCAjMTAwMA0KYWRkIGZwLCBzcCwgIzEyDQouTDc6DQp2bW92LmY2NCBkMCwgZDcNCmJs
IF9aMUdkDQpzdWJzIHI0LCByNCwgIzENCnZtb3YuZjY0IGQ3LCBkMA0KYm5lIC5MNw0KcG9wIHty
NCwgcjUsIGZwLCBwY30NCi5jYW50dW53aW5kDQouZm5lbmQNCg0KT25lIHRoaW5nIHdlIGRpZCB0
cnkgaW4gYWRkaXRpb24gdG8gdXNpbmcgZnJhbWUgcG9pbnRlcnMgaXMgdG8gdXNlIHRoZSBEV0FS
RiBmb3JtYXQsIGJ1dCB0aGF0IGhhcyBzb21lIGRpc2FkdmFudGFnZXMgbGlrZSBlLmcuIHVzaW5n
IHJvdWdobHkgMjB4IHRoZSBzcGFjZSBvZiB0aGUgRlAgZm9ybWF0IGFuZCBiZWluZyBtdWNoIHNs
b3dlciB0byByZWNvcmQuIEFsc28gdGhlIHJlY29yZGluZyBpdHNlbGYgc2VlbXMgdW5zdGFibGUg
YW5kIGNhbiBzaW1wbHkgaGFuZyB0aGUgd2hvbGUgUmFzcGJlcnJ5IFBpIGNvbXBsZXRlbHkgcmVx
dWlyaW5nIGEgaGFyZCByZXNldC4gVXNpbmcgS2VybmVsIDUuMTAgdGhlIERXQVJGIGZvcm1hdCBh
bHNvIGRpZCBleGhpYml0IHRoZSBzYW1lICdkaXNjb25uZWN0ZWRuZXNzJyBvZiB0aGUgY2FsbCBz
dGFjayAoaS5lLiBhbGwgZnVuY3Rpb24gZGlyZWN0bHkgYmVsb3cgYS5vdXQpLg0KDQpXZSBhbHNv
IHRyaWVkIHJ1bm5pbmcgVWJ1bnR1IDIwLjA0IHVzaW5nIGl0cyBLZXJuZWwgNS40LCBidXQgdGhl
cmUgYm90aCBGUCBhbmQgRFdBUkYgd2VyZSAnZGlzY29ubmVjdGVkJyBhZ2Fpbi4NCg0KV2UncmUg
YXQgYSBsb3NzIHdoYXQgaXMgZ29pbmcgd3JvbmcgaGVyZS4gRG9lcyBzb21lb25lIGhlcmUgaGF2
ZSBhbiBpZGVhIHdoYXQgd2UgY291bGQgdHJ5IHRvIGZ1cnRoZXIgZGVidWcgb3IgZXZlbiB1bmRl
cnN0YW5kIHRoZSBwcm9ibGVtPw0KDQpNaXQgZnJldW5kbGljaGVuIEdyw7zDn2VuIC8gQmVzdCBy
ZWdhcmRzDQoNClNlYmFzdGlhbiBGb250aXVzDQoNCkNoYXNzaXMgU3lzdGVtcyBDb250cm9sLCBJ
bWFnZSBQcm9jZXNzaW5nIDkgKFhDLURBL0VTVjkpDQpSb2JlcnQgQm9zY2ggR21iSCB8IFBvc3Rm
YWNoIDE2IDYxIHwgNzEyMjYgTGVvbmJlcmcgfCBHRVJNQU5ZIHwgd3d3LmJvc2NoLmNvbQ0KDQpT
aXR6OiBTdHV0dGdhcnQsIFJlZ2lzdGVyZ2VyaWNodDogQW10c2dlcmljaHQgU3R1dHRnYXJ0LCBI
UkIgMTQwMDA7DQpBdWZzaWNodHNyYXRzdm9yc2l0emVuZGVyOiBGcmFueiBGZWhyZW5iYWNoOyBH
ZXNjaMOkZnRzZsO8aHJ1bmc6IERyLiBWb2xrbWFyIERlbm5lciwgDQpQcm9mLiBEci4gU3RlZmFu
IEFzZW5rZXJzY2hiYXVtZXIsIEZpbGl6IEFsYnJlY2h0LCBEci4gTWljaGFlbCBCb2xsZSwgRHIu
IENocmlzdGlhbiBGaXNjaGVyLCANCkRyLiBTdGVmYW4gSGFydHVuZywgRHIuIE1hcmt1cyBIZXlu
LCBIYXJhbGQgS3LDtmdlciwgUm9sZiBOYWpvcmssIFV3ZSBSYXNjaGtlDQoNCg==
