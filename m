Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BA15E5A0;
	Mon, 27 May 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832080; cv=fail; b=RUWF1DkxCAIuiKRh7IIgl6ddf/lbaMA4b0caXmBh2WRJVKE5hbLwZB+0dLNTrkEyCeIXMBYEDtHOE6/Zirqc+U3woW/ddgWKSeA2jTN7pLRjPOPY/61V5+NStV2Uy+CKIapi6llhrjSSQgFBeTHh2L/vCieUVep61XuE66WEhgY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832080; c=relaxed/simple;
	bh=yB/tvs72OYlawXj4rK/nBTeIrEgvA8aoF+o+Kt6exlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=djPK8nvq2h77BIGUwUXWDcfrzsmFMHzsBWiJC3Piy+2f/qLP/pnac6WWBQfWYGghCjErToFRsH8pVMKKEjjkm2CHEko61sahtma7f9Kr9Z0dAih20lF7ihu0yR5CEpiHbxAflbLuXnbrYdCamugqTvziZ0C0T8mh8j4jdmf6MfU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RqCF7TEI; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RqCF7TEI; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RqCF7TEI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RqCF7TEI"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=IIzH9vklWSmakIRRMEu+ZbWWTCiN+LOG10sO/S7t+FT8PrpFSVONwMYJ6WiBAvI2XHy0z/bGo/enuIH2KMlGcMQOK2YtXOuosoOe3jNuzYoj0NF3e3jIRh1OlwtJnTlOnpban+vFn5z6RhUzNwENKjZTgl837ZrElpdflu+JoDGimRT6CTBOo68/Hv+Fmfd5rGdJmdMirruhSEmRjYaqaQCH8XJp5yht2rEiepj/zp5A5uax2AE3TxBFj57VOojnuBUqi4TSBmvBKs8ivqxKmtSkAb1HrUrzIv7doIu/ZBSeKI0DFXoxc52v0hxHgdU6fXfjkwUMCydhjzic24e5ig==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB/tvs72OYlawXj4rK/nBTeIrEgvA8aoF+o+Kt6exlo=;
 b=bGt/xVTDTCAu8HMOFqrv8Ks+cxhS/Rm5HrqE8U+fuddm3v3p2I3NRuBACNYEvPKdC/bC0ujvoVGG8b9AWiloxqxFdDmyxZBxBczkHvf/8+ssatAqxKo6gjd1IdQIICt9X+YZ1r0JwqfLFNnPHE4P0SNbmWHGF5gqHm5XgwsEfI2Mi80AhJLcOWA/5u4D6xe2zy4cbC6Mnl2XrZsVGx+FOmRly5S3p1Zk0ZZ2NXyZeXcfDpc+TY5HXpSa4VNwFebQmaDyHYdlmxC1SgogENGt3q24ZVhxxX8wG3vZ2C/8tp350rYhWrWfgp2h7GweEdYwf38Rxk6+fiJ/JbQcHqA2Xg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB/tvs72OYlawXj4rK/nBTeIrEgvA8aoF+o+Kt6exlo=;
 b=RqCF7TEI/Ua+2rpUnxEqh+EigDEZVvABnELPcQ6/pEdHSlycg5DMD/k3y7BQv19d++wtpT/dhSGmY+fhpCDVFFFfrnu4n4ZN32SFUonzm+CbcaQOzWS8ehQhq6piUf7vgjPU5paA2mU+zOAmzQJiRHgYALlnqKAOgwO2Zd96CJw=
Received: from AM6PR10CA0085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::26)
 by PAVPR08MB9580.eurprd08.prod.outlook.com (2603:10a6:102:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 17:47:52 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:209:8c:cafe::c5) by AM6PR10CA0085.outlook.office365.com
 (2603:10a6:209:8c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 17:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Mon, 27 May 2024 17:47:52 +0000
Received: ("Tessian outbound f97ed8ca492d:v327"); Mon, 27 May 2024 17:47:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 242fdde06ef49903
X-CR-MTA-TID: 64aa7808
Received: from 53727e4c9812.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4DC10D99-63A9-4C11-B853-68ED0FB7D0D7.1;
	Mon, 27 May 2024 17:47:45 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 53727e4c9812.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 27 May 2024 17:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQq/YbqzpkzIJqbMAnaqx2FSph54jlCloxjZTup5cMyf0CPmPoQlB5kSYhXl2A1AIVbZi/HXtGnucuQGwQ6jaEQajDFZxgbP73hcrie1iH5bJT2vnL4UDSJEN6zMNvk8g8PGK+Rlhf8Np7yGMGunzcJy129CnzBUaxTbH4e71odqPnLagKzUrvAYTjKoyzYmdh590LYMtzC/CmQi0qcuGyyQ0fyPg7kkclE816VMANkHBi/l6IpJB1/7amfLuglXexsDx47MhIb8Vz8w+1pEMGLbyBHgoTdsE/uWHhO8k7hcwIWB/N+QKcrRr/MTY2Ym7p6Tafsq5YjgyhWID2aKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB/tvs72OYlawXj4rK/nBTeIrEgvA8aoF+o+Kt6exlo=;
 b=FgEBmEHcXINxyQKGZckk9fOUdcboiBQ5fmz+4Hkk3D9TFKEH46PBIFcHR7Uj9FvGryvX7XsVC9HBswXMmVyon+3nCytO4R5KHy5bslruWWen5h4VKmn5S6wzywfMNnqcLp2TKVW/4im570RshzFcbdhZpAZO+sVLKV+YenKZXmdJYgoeEAIyHuqJGp/m4BYE63W8NWpl0MYufFfi6op1OMf/V7uo/jPY7vId5Um1RFZ6y2knM1FiG8ZJTlMOmzvHdmxSFcYKBguLLC4ptbCl8y35+LdNzYTy7NPDBo00FeTIzYskwTvvyaAA9LeD+GAx4GEYLqMF2FunbsxuGNyxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB/tvs72OYlawXj4rK/nBTeIrEgvA8aoF+o+Kt6exlo=;
 b=RqCF7TEI/Ua+2rpUnxEqh+EigDEZVvABnELPcQ6/pEdHSlycg5DMD/k3y7BQv19d++wtpT/dhSGmY+fhpCDVFFFfrnu4n4ZN32SFUonzm+CbcaQOzWS8ehQhq6piUf7vgjPU5paA2mU+zOAmzQJiRHgYALlnqKAOgwO2Zd96CJw=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by DU0PR08MB8446.eurprd08.prod.outlook.com (2603:10a6:10:406::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 17:47:42 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 17:47:42 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, James Clark
	<James.Clark@arm.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"irogers@google.com" <irogers@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v6 4/4] tools/perf: Allow inherit + PERF_SAMPLE_READ when
 opening events
Thread-Topic: [PATCH v6 4/4] tools/perf: Allow inherit + PERF_SAMPLE_READ when
 opening events
Thread-Index: AQHaq4MgKfMNGi8SV0Kj9Yp119Y5OLGln/OAgAXE9gA=
Date: Mon, 27 May 2024 17:47:42 +0000
Message-ID: <a12573d18f7c8bf73c24c572e43965e3f250acea.camel@arm.com>
References: <20240521133029.83654-1-ben.gainey@arm.com>
	 <20240521133029.83654-5-ben.gainey@arm.com>
	 <CAM9d7chssov_fW3ZbpYqGRyhS=xuHLyJ7=rkxTNnJ6fkgEdGJQ@mail.gmail.com>
In-Reply-To:
 <CAM9d7chssov_fW3ZbpYqGRyhS=xuHLyJ7=rkxTNnJ6fkgEdGJQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|DU0PR08MB8446:EE_|AMS0EPF000001B1:EE_|PAVPR08MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: c073e04d-126f-458e-1ca3-08dc7e7521bf
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VXhSZWk5dnhFdVUxbnlqMEpjSGw0ZFVPTFloeHJ6N25aSCtzVGRYZWx5SWJB?=
 =?utf-8?B?K201dGNwOThtQTZleG9KYlI2bHdqenl0QXhFVnVFeFNZMUxLRDJpUlEvejFX?=
 =?utf-8?B?YUlMaElKTUROTTgwTnVxMGRzdzhGSHpnZ2JWNUhxYU93K21RaXhod0ZUQ2Fy?=
 =?utf-8?B?L2RpOGtLaUo1dk5SYjIxNXBGK3BIMlpzdzhTVWFyTFl1TStuQ3BpOFhXM2lD?=
 =?utf-8?B?bnY3cThGRjdJbU9Pa1E2WFRqZlpNODF4MU5UMmJvYTRRWUo0a3Y1eVhuSXMz?=
 =?utf-8?B?dTgwQWg1cEUwL2dQcmpZcStGTWNhdnlVaElxMFVmY1J6a2lNeW9BZzhYVzg3?=
 =?utf-8?B?WExGU1NSeWltaHlsdldrWWNVSGJGMDcyQ3hFaHBIOTdxZE5OdXlOT0FWUFVt?=
 =?utf-8?B?N3pkTXdCQ2dveXJEY0xkNmVGand2dW1LTjgwcUdtK29FQVk1UkYreTNYQWxt?=
 =?utf-8?B?ZUg4RFQ5M2NTL044bkVVR3JrWUY2bnlLYjVBVjJXMXNPVm1SYlRSMTJBZHl1?=
 =?utf-8?B?YWRHZ1FqbDMzZ1lOb1VWRytaYndsRjU1dng4K2NEV3ZRZFI1Ri82ZmxTcFo3?=
 =?utf-8?B?UDNRSU1FT3ZXTmw3d2doSUpKNTFKb0F0Y1VLNkNxTUxKbFRVL3FILzJLRGlI?=
 =?utf-8?B?Qnp3dmZzaUVFejBKYlpBdjhSSTY0NllDanluYS94MlFZVzNtZDlweXVGdFlO?=
 =?utf-8?B?OWhFbE9GZmh4em1uUHl3TElQU3dKVDZLeEVhRnpBREkwTGFreDN3VmVYNTZq?=
 =?utf-8?B?UXJMQmFIUlB4V0ZIRnFvMVFtMFlwL2pyTDg1WjF3cmRYVVdFaVp2THpuMDk4?=
 =?utf-8?B?NFlzVkduK2VjejBMQmJpOHdxVHJaMFh0eXR3TkhkVHFTaWtNMVdwK2t0d1BK?=
 =?utf-8?B?bG5Id1ZtMGo3SGs5ZFJVbWJqQTNycXAyOVhpR1I3a3k0UkJxM1hRU3Zubm94?=
 =?utf-8?B?SE5ocmFteHhkbkdsTndCZFdXamtLUXgrdWZLSWs4a3pIUWhpaHNKY2hkS2t5?=
 =?utf-8?B?WncyaXg0ZmZ4aFBFUno0eXlxczkwZnBQQUcydnF2V0Jad2JHbEhTb0dlMUs5?=
 =?utf-8?B?N1VMKzgwZlNWWmJYeFNiU05oYXJYb3A5TVlYa1FGV0IxZDV3NGppSHVEcnJH?=
 =?utf-8?B?TWNDYkpjc3IrQ1dGVXlZcWpQRzA5a1NBWFlXd2dTMmNlWWpxZ2RWZytIZTR5?=
 =?utf-8?B?NWRtSm16K3M5UFNMeWpJaTlNaURXMkN4aTJPYmt5cTFlYmtaVThqVEVsMita?=
 =?utf-8?B?RVdRNjg3elpBYzZVRGZSSjlwVTkveVZkRkZPL2ZRaTJCcjRrL2NpZ1RzcXJn?=
 =?utf-8?B?RzM1WmhRdWlySkVLWHFNTnBaWHJKSkVGSWVJSE1URExJZExUSDRTdG9PaE9o?=
 =?utf-8?B?SUxwMTNING9GMGsvdXpBYkJCWE4zbEgvUzV2dUg2R00wUEhSYnNsS29UblBr?=
 =?utf-8?B?VlFlYno3MFEwWlk1elQydGFaSXM0STdadlErT0NXTTJOcWtWNkZLZStlK21M?=
 =?utf-8?B?aWpiTWNLN2dwZG80QTZqMDN0NG9sSElkRDRHc3NiTHJ5R1lQV2dkci9saXkz?=
 =?utf-8?B?UDk2YW1sOXd2SVlKbFVrNk52MkpaTytHMThZZ0tIelI1S0pwWCtIRm5YUmY4?=
 =?utf-8?B?RG5ORDAycC9lbEZTdXN6N0EzWkdCQ3QzSXY5Y1lOV2dMeDBFTitzbnAyQ2Q3?=
 =?utf-8?B?RjY2Ny9WRjh4enlIbkhySWdoR3pXMlJwM0Z2KzNKU2wvSVo1ZkFWYVFsdEx5?=
 =?utf-8?B?TkIxUVhidmUrRWtvYnhCTFBrU2hiNFhjSFJXSHZ3R0M4TWdpR2hvbi9hdVBD?=
 =?utf-8?B?T3hnZjNuNmlEbW9tbEJGQT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFC8A7FD2465AA47AF37168B5FCD9C5A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8446
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	58754c45-f143-47d6-d69e-08dc7e751bdd
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|35042699013|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU5GK3VvWnJoaThMckRkNHRPT3daVEF4V3I5VTUwK2dsVE9ZUEM1MG1yOFg1?=
 =?utf-8?B?Sm9rVHh6ZVdPcDRsaEFjMTgyQVFEVmFLY1IvUjc2Vmx5cEtvbmZ6RWl1UzRi?=
 =?utf-8?B?RXU5Vmp4Ymt6aWxmLzFoZUgvUnlCODZubk1jSURwOVJuZVNyWFJ6U0dlbHNm?=
 =?utf-8?B?MURsOGw1L0t2YXovZUwwc2xXVVBrZStBc1hybldDK1E0MTZYQnR3TmFjQXlS?=
 =?utf-8?B?VjF6VGZ0OGN5T3RYUGpBR2tvdlFydlY1OGdqNVUwbUtwRkZ6Q2ZuVFpFUk0w?=
 =?utf-8?B?WGl6ajVISERDbW11TVVmSUYwSjFTZXY0ZGFDQlJTcmJXMURqTkEyR0oyU01T?=
 =?utf-8?B?LzJYQkxEcnlHU0x0UGFXZjFNMDFzbTNrODYraHlqdm16ZmxFL1BkYkZ4cy9D?=
 =?utf-8?B?WlhVMXI0VDFESGxBQkFjMDJISVovMFdMcXh6RlQxM1BoL0Y2a0Q2UVlsekhY?=
 =?utf-8?B?NmdXem5rK2xNNXMrTEZGbHRqMGZQQ2p0Sm1JTHh3VC9GYnAxZzJKWE5lMnpJ?=
 =?utf-8?B?V3dFekhYdzgzTXVBcnA2UUZ2b2xmcUFxWElHdUcrZFJEbTVSeDJWbDVWU0hl?=
 =?utf-8?B?cjh3cm0zYkFldlpYU3I1MStsNTZkTkdDSVN1UGdRV2ZqNjh2OW5mcDIwR2lN?=
 =?utf-8?B?VWplUCtYMEtoMXYvRjJGeEhFUUIxT3BXVXVZejNFbFBVeTYrTElPcERhbnY1?=
 =?utf-8?B?cTdCL3U0WVlpWDlsS0RQMDg3ekVvZDdQYUJJTHJSNkV4VlBZTGRoTXgycW5R?=
 =?utf-8?B?OTJmTnVGRHpuQUVPUmRDUWdXSUN5ZjVRWnd2U0ppZjBxZ1JvcUdnenJLaXJK?=
 =?utf-8?B?KzZpczIvcjVrVmdweUM1eHh0NnA3N0pBRVVzSWd1QXQvSmgwY1kyZXNmRGlz?=
 =?utf-8?B?WkVEWGJybldwVFV2cVBYclI3emtPZDVTSjdjc0RZZnN6cXJwVTU3c3Q1b3ho?=
 =?utf-8?B?OEd1N0J2TTFWK0hSYWNJMjdncnBMS2VFWW8xelFmaXd0UnJqUnVad1dGWFli?=
 =?utf-8?B?YWxxd1RiMUZ2UFJuOXBadVJZSmRCWkd4WnQxZWdOMy9lNTFBR0dHR1d2aEZZ?=
 =?utf-8?B?NGZrTDRVV0w4WFJOQWVRQk1iSzYrTWZLZHRtMHVnZC9lczU1WExOQXh5c3V5?=
 =?utf-8?B?Q2J1UHB5RzdsQ1NhQWhXNjhqNGtpUTJuYjgyaS9EcVdvWk8yNWFmWGQ4VFh0?=
 =?utf-8?B?OU9DSHQ4aEZDM2JmNXo4ajhrOFpaSHhVK25rbVNxS29WamZab0J5RllBOFgx?=
 =?utf-8?B?VCtnQTZGV1ZlMnZaK09DVllRemdEQ08xV2k0UHI1NlVUU01RRGRleUtibDB6?=
 =?utf-8?B?RGNiemRzaWFTNHpqUURLZmZKanVyYjc3WFg4cmpkMkdBZlFiTVZtNUlscmRG?=
 =?utf-8?B?NG1JdkxRMGpWd2JvQXFjOFlJdDczN0htQnBoZFV1anNhL2dtbzE1U1hsZWYr?=
 =?utf-8?B?OXMzWmRCU2ptUFEwNHFWZVRKeTNvaHR6dVloamdGWkJoNWxybXpFM1JJc2I0?=
 =?utf-8?B?K1hDVWxHbmVjOE9LUkkwTVpPR1RDUUVnY1FRNFoyNVhTTkZjbzdhMGU0TDdE?=
 =?utf-8?B?YU9LY2pEMzNSYUVYUnAzLzlaUXZac0xTVU9Ka0ZtT1dPRGk4YWt5am1qbWdp?=
 =?utf-8?B?YXlHbU1OaGJjMmNZRGhyeE9wNUNaSVZ2MUpkOXlQODNHaktScEl1emZsb1BB?=
 =?utf-8?B?bHNEUFFZWWtiUGpIbWRvYVlQazFTc3JjOE9yNEt1a1dkMHFnRXorYWttTG5T?=
 =?utf-8?B?enEvcHRsb3l0U0hZVzRoWTF4b09FUUJoNkhob3FLeWtUMVlzYzNDUXFzbko2?=
 =?utf-8?Q?S7RQwfW157fXq80D7m3wmCnGB5DGN1i+34ofY=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(35042699013)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 17:47:52.1276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c073e04d-126f-458e-1ca3-08dc7e7521bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9580

T24gVGh1LCAyMDI0LTA1LTIzIGF0IDE4OjQxIC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IE9uIFR1ZSwgTWF5IDIxLCAyMDI0IGF0IDY6MzDigK9BTSBCZW4gR2FpbmV5IDxiZW4uZ2FpbmV5
QGFybS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIHRvb2wgd2lsbCBub3cgZGVmYXVsdCB0
byB0aGlzIG5ldyBtb2RlIGlmIHRoZSB1c2VyIHNwZWNpZmllcyBhDQo+ID4gc2FtcGxpbmcgZ3Jv
dXAgd2hlbiBub3QgaW4gc3lzdGVtLXdpZGUgbW9kZSwgYW5kIHdoZW4gLS1uby1pbmhlcml0DQo+
ID4gaXMgbm90IHNwZWNpZmllZC4NCj4gPg0KPiA+IFRoaXMgY2hhbmdlIHVwZGF0ZXMgZXZzZWwg
dG8gYWxsb3cgdGhlIGNvbWJpbmF0aW9uIG9mIGluaGVyaXQNCj4gPiBhbmQgUEVSRl9TQU1QTEVf
UkVBRC4NCj4gPg0KPiA+IEEgZmFsbGJhY2sgaXMgaW1wbGVtZW50ZWQgZm9yIGtlcm5lbCB2ZXJz
aW9ucyB3aGVyZSB0aGlzIGZlYXR1cmUgaXMNCj4gPiBub3QNCj4gPiBzdXBwb3J0ZWQuDQo+DQo+
IEJ1dCBJJ20gYWZyYWlkIHRoZSB0ZXN0IHdvdWxkIGZhaWwgb24gb2xkIGtlcm5lbHMuICBNYXli
ZSB3ZSBuZWVkIHRvDQo+IHB1dCBpdCBpbiB0aGUgc2VsZnRlc3RzLg0KPg0KDQpTb3JyeSwgbm90
IGNsZWFyIHdoYXQgeW91IG1lYW4/DQoNCklzIHRoZSBpc3N1ZSB0aGF0IHRoZSBmYWxsYmFjayBv
biBvbGRlciBrZXJuZWxzIGZhaWxzLCBvciB0aGF0IHRoZQ0KInBlcmYgdGVzdCIgdGVzdHMgZmFp
bD8NCg0KVGhhbmtzDQpCZW4NCg0KDQoNCj4gVGhhbmtzLA0KPiBOYW1oeXVuZw0KPg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQmVuIEdhaW5leSA8YmVuLmdhaW5leUBhcm0uY29tPg0KPiA+IC0t
LQ0KPiA+ICB0b29scy9wZXJmL3Rlc3RzL2F0dHIvUkVBRE1FICAgICAgICAgICAgICAgICAgfCAg
MiArDQo+ID4gIC4uLi90ZXN0cy9hdHRyL3Rlc3QtcmVjb3JkLWdyb3VwLXNhbXBsaW5nICAgICB8
IDM5IC0tLS0tLS0tLS0tLQ0KPiA+ICAuLi4vdGVzdHMvYXR0ci90ZXN0LXJlY29yZC1ncm91cC1z
YW1wbGluZzEgICAgfCA1MA0KPiA+ICsrKysrKysrKysrKysrKysNCj4gPiAgLi4uL3Rlc3RzL2F0
dHIvdGVzdC1yZWNvcmQtZ3JvdXAtc2FtcGxpbmcyICAgIHwgNjANCj4gPiArKysrKysrKysrKysr
KysrKysrDQo+ID4gIHRvb2xzL3BlcmYvdGVzdHMvYXR0ci90ZXN0LXJlY29yZC1ncm91cDIgICAg
ICB8ICA5ICstLQ0KPiA+ICB0b29scy9wZXJmL3V0aWwvZXZzZWwuYyAgICAgICAgICAgICAgICAg
ICAgICAgfCAxOSArKysrKy0NCj4gPiAgdG9vbHMvcGVyZi91dGlsL2V2c2VsLmggICAgICAgICAg
ICAgICAgICAgICAgIHwgIDEgKw0KPiA+ICA3IGZpbGVzIGNoYW5nZWQsIDEzNSBpbnNlcnRpb25z
KCspLCA0NSBkZWxldGlvbnMoLSkNCj4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3BlcmYv
dGVzdHMvYXR0ci90ZXN0LXJlY29yZC1ncm91cC0NCj4gPiBzYW1wbGluZw0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgdG9vbHMvcGVyZi90ZXN0cy9hdHRyL3Rlc3QtcmVjb3JkLWdyb3VwLQ0KPiA+
IHNhbXBsaW5nMQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvcGVyZi90ZXN0cy9hdHRy
L3Rlc3QtcmVjb3JkLWdyb3VwLQ0KPiA+IHNhbXBsaW5nMg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3BlcmYvdGVzdHMvYXR0ci9SRUFETUUNCj4gPiBiL3Rvb2xzL3BlcmYvdGVzdHMvYXR0
ci9SRUFETUUNCj4gPiBpbmRleCA0MDY2ZmVjNzE4MGE4Li42N2M0Y2E3NmI4NWQ1IDEwMDY0NA0K
PiA+IC0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMvYXR0ci9SRUFETUUNCj4gPiArKysgYi90b29scy9w
ZXJmL3Rlc3RzL2F0dHIvUkVBRE1FDQo+ID4gQEAgLTUxLDYgKzUxLDggQEAgRm9sbG93aW5nIHRl
c3RzIGFyZSBkZWZpbmVkICh3aXRoIHBlcmYgY29tbWFuZHMpOg0KPiA+ICAgIHBlcmYgcmVjb3Jk
IC0tY2FsbC1ncmFwaCBmcCBraWxsICAgICAgICAgICAgICAodGVzdC1yZWNvcmQtDQo+ID4gZ3Jh
cGgtZnAtYWFyY2g2NCkNCj4gPiAgICBwZXJmIHJlY29yZCAtZSAne2N5Y2xlcyxpbnN0cnVjdGlv
bnN9JyBraWxsICAgKHRlc3QtcmVjb3JkLQ0KPiA+IGdyb3VwMSkNCj4gPiAgICBwZXJmIHJlY29y
ZCAtZSAne2N5Y2xlcy9wZXJpb2Q9MS8saW5zdHJ1Y3Rpb25zL3BlcmlvZD0yL306UycNCj4gPiBr
aWxsICh0ZXN0LXJlY29yZC1ncm91cDIpDQo+ID4gKyAgcGVyZiByZWNvcmQgLWUgJ3tjeWNsZXMs
Y2FjaGUtbWlzc2VzfTpTJyBraWxsICh0ZXN0LXJlY29yZC0NCj4gPiBncm91cC1zYW1wbGluZzEp
DQo+ID4gKyAgcGVyZiByZWNvcmQgLWMgMTAwMDAgLWUgJ3tjeWNsZXMsY2FjaGUtbWlzc2VzfTpT
JyBraWxsICh0ZXN0LQ0KPiA+IHJlY29yZC1ncm91cC1zYW1wbGluZzIpDQo+ID4gICAgcGVyZiBy
ZWNvcmQgLUQga2lsbCAgICAgICAgICAgICAgICAgICAgICAgICAgICh0ZXN0LXJlY29yZC1uby0N
Cj4gPiBkZWxheSkNCj4gPiAgICBwZXJmIHJlY29yZCAtaSBraWxsICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKHRlc3QtcmVjb3JkLW5vLQ0KPiA+IGluaGVyaXQpDQo+ID4gICAgcGVyZiByZWNv
cmQgLW4ga2lsbCAgICAgICAgICAgICAgICAgICAgICAgICAgICh0ZXN0LXJlY29yZC1uby0NCj4g
PiBzYW1wbGVzKQ0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rlc3RzL2F0dHIvdGVzdC1y
ZWNvcmQtZ3JvdXAtc2FtcGxpbmcNCj4gPiBiL3Rvb2xzL3BlcmYvdGVzdHMvYXR0ci90ZXN0LXJl
Y29yZC1ncm91cC1zYW1wbGluZw0KPiA+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGlu
ZGV4IDk3ZTdlNjRhMzhmMDcuLjAwMDAwMDAwMDAwMDANCj4gPiAtLS0gYS90b29scy9wZXJmL3Rl
c3RzL2F0dHIvdGVzdC1yZWNvcmQtZ3JvdXAtc2FtcGxpbmcNCj4gPiArKysgL2Rldi9udWxsDQo+
ID4gQEAgLTEsMzkgKzAsMCBAQA0KPiA+IC1bY29uZmlnXQ0KPiA+IC1jb21tYW5kID0gcmVjb3Jk
DQo+ID4gLWFyZ3MgICAgPSAtLW5vLWJwZi1ldmVudCAtZSAne2N5Y2xlcyxjYWNoZS1taXNzZXN9
OlMnIGtpbGwNCj4gPiA+L2Rldi9udWxsIDI+JjENCj4gPiAtcmV0ICAgICA9IDENCj4gPiAtDQo+
ID4gLVtldmVudC0xOmJhc2UtcmVjb3JkXQ0KPiA+IC1mZD0xDQo+ID4gLWdyb3VwX2ZkPS0xDQo+
ID4gLXNhbXBsZV90eXBlPTM0Mw0KPiA+IC1yZWFkX2Zvcm1hdD0xMnwyOA0KPiA+IC1pbmhlcml0
PTANCj4gPiAtDQo+ID4gLVtldmVudC0yOmJhc2UtcmVjb3JkXQ0KPiA+IC1mZD0yDQo+ID4gLWdy
b3VwX2ZkPTENCj4gPiAtDQo+ID4gLSMgY2FjaGUtbWlzc2VzDQo+ID4gLXR5cGU9MA0KPiA+IC1j
b25maWc9Mw0KPiA+IC0NCj4gPiAtIyBkZWZhdWx0IHwgUEVSRl9TQU1QTEVfUkVBRA0KPiA+IC1z
YW1wbGVfdHlwZT0zNDMNCj4gPiAtDQo+ID4gLSMgUEVSRl9GT1JNQVRfSUQgfCBQRVJGX0ZPUk1B
VF9HUk9VUCAgfCBQRVJGX0ZPUk1BVF9MT1NUDQo+ID4gLXJlYWRfZm9ybWF0PTEyfDI4DQo+ID4g
LXRhc2s9MA0KPiA+IC1tbWFwPTANCj4gPiAtY29tbT0wDQo+ID4gLWVuYWJsZV9vbl9leGVjPTAN
Cj4gPiAtZGlzYWJsZWQ9MA0KPiA+IC0NCj4gPiAtIyBpbmhlcml0IGlzIGRpc2FibGVkIGZvciBn
cm91cCBzYW1wbGluZw0KPiA+IC1pbmhlcml0PTANCj4gPiAtDQo+ID4gLSMgc2FtcGxpbmcgZGlz
YWJsZWQNCj4gPiAtc2FtcGxlX2ZyZXE9MA0KPiA+IC1zYW1wbGVfcGVyaW9kPTANCj4gPiAtZnJl
cT0wDQo+ID4gLXdyaXRlX2JhY2t3YXJkPTANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi90
ZXN0cy9hdHRyL3Rlc3QtcmVjb3JkLWdyb3VwLXNhbXBsaW5nMQ0KPiA+IGIvdG9vbHMvcGVyZi90
ZXN0cy9hdHRyL3Rlc3QtcmVjb3JkLWdyb3VwLXNhbXBsaW5nMQ0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwMC4uOWI4NzMwNjI2NjMyOQ0KPiA+IC0tLSAv
ZGV2L251bGwNCj4gPiArKysgYi90b29scy9wZXJmL3Rlc3RzL2F0dHIvdGVzdC1yZWNvcmQtZ3Jv
dXAtc2FtcGxpbmcxDQo+ID4gQEAgLTAsMCArMSw1MCBAQA0KPiA+ICtbY29uZmlnXQ0KPiA+ICtj
b21tYW5kID0gcmVjb3JkDQo+ID4gK2FyZ3MgICAgPSAtLW5vLWJwZi1ldmVudCAtZSAne2N5Y2xl
cyxjYWNoZS1taXNzZXN9OlMnIGtpbGwNCj4gPiA+L2Rldi9udWxsIDI+JjENCj4gPiArcmV0ICAg
ICA9IDENCj4gPiArDQo+ID4gK1tldmVudC0xOmJhc2UtcmVjb3JkXQ0KPiA+ICtmZD0xDQo+ID4g
K2dyb3VwX2ZkPS0xDQo+ID4gKw0KPiA+ICsjIGN5Y2xlcw0KPiA+ICt0eXBlPTANCj4gPiArY29u
ZmlnPTANCj4gPiArDQo+ID4gKyMgZGVmYXVsdCB8IFBFUkZfU0FNUExFX1JFQUQNCj4gPiArc2Ft
cGxlX3R5cGU9MzQzDQo+ID4gKw0KPiA+ICsjIFBFUkZfRk9STUFUX0lEIHwgUEVSRl9GT1JNQVRf
R1JPVVAgIHwgUEVSRl9GT1JNQVRfTE9TVCB8DQo+ID4gUEVSRl9GT1JNQVRfVE9UQUxfVElNRV9F
TkFCTEVEIHwgUEVSRl9GT1JNQVRfVE9UQUxfVElNRV9SVU5OSU5HDQo+ID4gK3JlYWRfZm9ybWF0
PTI4fDMxDQo+ID4gK3Rhc2s9MQ0KPiA+ICttbWFwPTENCj4gPiArY29tbT0xDQo+ID4gK2VuYWJs
ZV9vbl9leGVjPTENCj4gPiArZGlzYWJsZWQ9MQ0KPiA+ICsNCj4gPiArIyBpbmhlcml0IGlzIGVu
YWJsZWQgZm9yIGdyb3VwIHNhbXBsaW5nDQo+ID4gK2luaGVyaXQ9MQ0KPiA+ICsNCj4gPiArW2V2
ZW50LTI6YmFzZS1yZWNvcmRdDQo+ID4gK2ZkPTINCj4gPiArZ3JvdXBfZmQ9MQ0KPiA+ICsNCj4g
PiArIyBjYWNoZS1taXNzZXMNCj4gPiArdHlwZT0wDQo+ID4gK2NvbmZpZz0zDQo+ID4gKw0KPiA+
ICsjIGRlZmF1bHQgfCBQRVJGX1NBTVBMRV9SRUFEDQo+ID4gK3NhbXBsZV90eXBlPTM0Mw0KPiA+
ICsNCj4gPiArIyBQRVJGX0ZPUk1BVF9JRCB8IFBFUkZfRk9STUFUX0dST1VQICB8IFBFUkZfRk9S
TUFUX0xPU1QgfA0KPiA+IFBFUkZfRk9STUFUX1RPVEFMX1RJTUVfRU5BQkxFRCB8IFBFUkZfRk9S
TUFUX1RPVEFMX1RJTUVfUlVOTklORw0KPiA+ICtyZWFkX2Zvcm1hdD0yOHwzMQ0KPiA+ICt0YXNr
PTANCj4gPiArbW1hcD0wDQo+ID4gK2NvbW09MA0KPiA+ICtlbmFibGVfb25fZXhlYz0wDQo+ID4g
K2Rpc2FibGVkPTANCj4gPiArZnJlcT0wDQo+ID4gKw0KPiA+ICsjIGluaGVyaXQgaXMgZW5hYmxl
ZCBmb3IgZ3JvdXAgc2FtcGxpbmcNCj4gPiAraW5oZXJpdD0xDQo+ID4gKw0KPiA+IGRpZmYgLS1n
aXQgYS90b29scy9wZXJmL3Rlc3RzL2F0dHIvdGVzdC1yZWNvcmQtZ3JvdXAtc2FtcGxpbmcyDQo+
ID4gYi90b29scy9wZXJmL3Rlc3RzL2F0dHIvdGVzdC1yZWNvcmQtZ3JvdXAtc2FtcGxpbmcyDQo+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAwLi44ZTI5ZmMx
M2Y2NjY4DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvdGVzdHMvYXR0
ci90ZXN0LXJlY29yZC1ncm91cC1zYW1wbGluZzINCj4gPiBAQCAtMCwwICsxLDYwIEBADQo+ID4g
K1tjb25maWddDQo+ID4gK2NvbW1hbmQgPSByZWNvcmQNCj4gPiArYXJncyAgICA9IC0tbm8tYnBm
LWV2ZW50IC1jIDEwMDAwIC1lICd7Y3ljbGVzLGNhY2hlLW1pc3Nlc306UycNCj4gPiBraWxsID4v
ZGV2L251bGwgMj4mMQ0KPiA+ICtyZXQgICAgID0gMQ0KPiA+ICsNCj4gPiArW2V2ZW50LTE6YmFz
ZS1yZWNvcmRdDQo+ID4gK2ZkPTENCj4gPiArZ3JvdXBfZmQ9LTENCj4gPiArDQo+ID4gKyMgY3lj
bGVzDQo+ID4gK3R5cGU9MA0KPiA+ICtjb25maWc9MA0KPiA+ICsNCj4gPiArIyBkZWZhdWx0IHwg
UEVSRl9TQU1QTEVfUkVBRA0KPiA+ICtzYW1wbGVfdHlwZT04Nw0KPiA+ICsNCj4gPiArIyBQRVJG
X0ZPUk1BVF9JRCB8IFBFUkZfRk9STUFUX0dST1VQICB8IFBFUkZfRk9STUFUX0xPU1QgfA0KPiA+
IFBFUkZfRk9STUFUX1RPVEFMX1RJTUVfRU5BQkxFRCB8IFBFUkZfRk9STUFUX1RPVEFMX1RJTUVf
UlVOTklORw0KPiA+ICtyZWFkX2Zvcm1hdD0yOHwzMQ0KPiA+ICt0YXNrPTENCj4gPiArbW1hcD0x
DQo+ID4gK2NvbW09MQ0KPiA+ICtlbmFibGVfb25fZXhlYz0xDQo+ID4gK2Rpc2FibGVkPTENCj4g
PiArDQo+ID4gKyMgaW5oZXJpdCBpcyBlbmFibGVkIGZvciBncm91cCBzYW1wbGluZw0KPiA+ICtp
bmhlcml0PTENCj4gPiArDQo+ID4gKyMgc2FtcGxpbmcgZGlzYWJsZWQNCj4gPiArc2FtcGxlX2Zy
ZXE9MA0KPiA+ICtzYW1wbGVfcGVyaW9kPTEwMDAwDQo+ID4gK2ZyZXE9MA0KPiA+ICt3cml0ZV9i
YWNrd2FyZD0wDQo+ID4gKw0KPiA+ICtbZXZlbnQtMjpiYXNlLXJlY29yZF0NCj4gPiArZmQ9Mg0K
PiA+ICtncm91cF9mZD0xDQo+ID4gKw0KPiA+ICsjIGNhY2hlLW1pc3Nlcw0KPiA+ICt0eXBlPTAN
Cj4gPiArY29uZmlnPTMNCj4gPiArDQo+ID4gKyMgZGVmYXVsdCB8IFBFUkZfU0FNUExFX1JFQUQN
Cj4gPiArc2FtcGxlX3R5cGU9ODcNCj4gPiArDQo+ID4gKyMgUEVSRl9GT1JNQVRfSUQgfCBQRVJG
X0ZPUk1BVF9HUk9VUCAgfCBQRVJGX0ZPUk1BVF9MT1NUIHwNCj4gPiBQRVJGX0ZPUk1BVF9UT1RB
TF9USU1FX0VOQUJMRUQgfCBQRVJGX0ZPUk1BVF9UT1RBTF9USU1FX1JVTk5JTkcNCj4gPiArcmVh
ZF9mb3JtYXQ9Mjh8MzENCj4gPiArdGFzaz0wDQo+ID4gK21tYXA9MA0KPiA+ICtjb21tPTANCj4g
PiArZW5hYmxlX29uX2V4ZWM9MA0KPiA+ICtkaXNhYmxlZD0wDQo+ID4gKw0KPiA+ICsjIGluaGVy
aXQgaXMgZW5hYmxlZCBmb3IgZ3JvdXAgc2FtcGxpbmcNCj4gPiAraW5oZXJpdD0xDQo+ID4gKw0K
PiA+ICsjIHNhbXBsaW5nIGRpc2FibGVkDQo+ID4gK3NhbXBsZV9mcmVxPTANCj4gPiArc2FtcGxl
X3BlcmlvZD0wDQo+ID4gK2ZyZXE9MA0KPiA+ICt3cml0ZV9iYWNrd2FyZD0wDQo+ID4gZGlmZiAt
LWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvYXR0ci90ZXN0LXJlY29yZC1ncm91cDINCj4gPiBiL3Rv
b2xzL3BlcmYvdGVzdHMvYXR0ci90ZXN0LXJlY29yZC1ncm91cDINCj4gPiBpbmRleCBjZWJkYWE4
ZTY0ZTQ3Li43ODU4OTJhNTRkOWUxIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMv
YXR0ci90ZXN0LXJlY29yZC1ncm91cDINCj4gPiArKysgYi90b29scy9wZXJmL3Rlc3RzL2F0dHIv
dGVzdC1yZWNvcmQtZ3JvdXAyDQo+ID4gQEAgLTksOCArOSw5IEBAIGdyb3VwX2ZkPS0xDQo+ID4g
IGNvbmZpZz0wfDENCj4gPiAgc2FtcGxlX3BlcmlvZD0xMjM0MDAwDQo+ID4gIHNhbXBsZV90eXBl
PTg3DQo+ID4gLXJlYWRfZm9ybWF0PTEyfDI4DQo+ID4gLWluaGVyaXQ9MA0KPiA+ICtyZWFkX2Zv
cm1hdD0yOHwzMQ0KPiA+ICtkaXNhYmxlZD0xDQo+ID4gK2luaGVyaXQ9MQ0KPiA+ICBmcmVxPTAN
Cj4gPg0KPiA+ICBbZXZlbnQtMjpiYXNlLXJlY29yZF0NCj4gPiBAQCAtMTksOSArMjAsOSBAQCBn
cm91cF9mZD0xDQo+ID4gIGNvbmZpZz0wfDENCj4gPiAgc2FtcGxlX3BlcmlvZD02Nzg5MDAwDQo+
ID4gIHNhbXBsZV90eXBlPTg3DQo+ID4gLXJlYWRfZm9ybWF0PTEyfDI4DQo+ID4gK3JlYWRfZm9y
bWF0PTI4fDMxDQo+ID4gIGRpc2FibGVkPTANCj4gPiAtaW5oZXJpdD0wDQo+ID4gK2luaGVyaXQ9
MQ0KPiA+ICBtbWFwPTANCj4gPiAgY29tbT0wDQo+ID4gIGZyZXE9MA0KPiA+IGRpZmYgLS1naXQg
YS90b29scy9wZXJmL3V0aWwvZXZzZWwuYyBiL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5jDQo+ID4g
aW5kZXggMzUzNjQwNGU5NDQ3Yi4uNTU3ZDQwOWM1M2Q2YyAxMDA2NDQNCj4gPiAtLS0gYS90b29s
cy9wZXJmL3V0aWwvZXZzZWwuYw0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5jDQo+
ID4gQEAgLTExNTYsNyArMTE1NiwxNSBAQCB2b2lkIGV2c2VsX19jb25maWcoc3RydWN0IGV2c2Vs
ICpldnNlbCwNCj4gPiBzdHJ1Y3QgcmVjb3JkX29wdHMgKm9wdHMsDQo+ID4gICAgICAgICAgICAg
ICAgICAqLw0KPiA+ICAgICAgICAgICAgICAgICBpZiAobGVhZGVyLT5jb3JlLm5yX21lbWJlcnMg
PiAxKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYXR0ci0+cmVhZF9mb3JtYXQgfD0g
UEVSRl9GT1JNQVRfR1JPVVA7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYXR0ci0+aW5o
ZXJpdCA9IDA7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAg
ICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgICAqIEluaGVyaXQgKyBTQU1QTEVfUkVBRCByZXF1
aXJlcyBTQU1QTEVfVElEIGluIHRoZQ0KPiA+IHJlYWRfZm9ybWF0DQo+ID4gKyAgICAgICAgICAg
ICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoYXR0ci0+aW5oZXJpdCkgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGV2c2VsX19zZXRfc2FtcGxlX2JpdChldnNlbCwgVElEKTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBldnNlbC0+Y29yZS5hdHRyLnJlYWRfZm9ybWF0
IHw9DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQRVJGX0ZPUk1BVF9JRDsN
Cj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gQEAgLTE4MzIs
NiArMTg0MCw4IEBAIHN0YXRpYyBpbnQgX19ldnNlbF9fcHJlcGFyZV9vcGVuKHN0cnVjdCBldnNl
bA0KPiA+ICpldnNlbCwgc3RydWN0IHBlcmZfY3B1X21hcCAqY3B1cywNCj4gPg0KPiA+ICBzdGF0
aWMgdm9pZCBldnNlbF9fZGlzYWJsZV9taXNzaW5nX2ZlYXR1cmVzKHN0cnVjdCBldnNlbCAqZXZz
ZWwpDQo+ID4gIHsNCj4gPiArICAgICAgIGlmIChwZXJmX21pc3NpbmdfZmVhdHVyZXMuaW5oZXJp
dF9zYW1wbGVfcmVhZCkNCj4gPiArICAgICAgICAgICAgICAgZXZzZWwtPmNvcmUuYXR0ci5pbmhl
cml0ID0gMDsNCj4gPiAgICAgICAgIGlmIChwZXJmX21pc3NpbmdfZmVhdHVyZXMuYnJhbmNoX2Nv
dW50ZXJzKQ0KPiA+ICAgICAgICAgICAgICAgICBldnNlbC0+Y29yZS5hdHRyLmJyYW5jaF9zYW1w
bGVfdHlwZSAmPQ0KPiA+IH5QRVJGX1NBTVBMRV9CUkFOQ0hfQ09VTlRFUlM7DQo+ID4gICAgICAg
ICBpZiAocGVyZl9taXNzaW5nX2ZlYXR1cmVzLnJlYWRfbG9zdCkNCj4gPiBAQCAtMTg4Nyw3ICsx
ODk3LDEyIEBAIGJvb2wgZXZzZWxfX2RldGVjdF9taXNzaW5nX2ZlYXR1cmVzKHN0cnVjdA0KPiA+
IGV2c2VsICpldnNlbCkNCj4gPiAgICAgICAgICAqIE11c3QgcHJvYmUgZmVhdHVyZXMgaW4gdGhl
IG9yZGVyIHRoZXkgd2VyZSBhZGRlZCB0byB0aGUNCj4gPiAgICAgICAgICAqIHBlcmZfZXZlbnRf
YXR0ciBpbnRlcmZhY2UuDQo+ID4gICAgICAgICAgKi8NCj4gPiAtICAgICAgIGlmICghcGVyZl9t
aXNzaW5nX2ZlYXR1cmVzLmJyYW5jaF9jb3VudGVycyAmJg0KPiA+ICsgICAgICAgaWYgKCFwZXJm
X21pc3NpbmdfZmVhdHVyZXMuaW5oZXJpdF9zYW1wbGVfcmVhZCAmJg0KPiA+ICsgICAgICAgICAg
IGV2c2VsLT5jb3JlLmF0dHIuaW5oZXJpdCAmJiAoZXZzZWwtDQo+ID4gPmNvcmUuYXR0ci5zYW1w
bGVfdHlwZSAmIFBFUkZfU0FNUExFX1JFQUQpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHBlcmZf
bWlzc2luZ19mZWF0dXJlcy5pbmhlcml0X3NhbXBsZV9yZWFkID0gdHJ1ZTsNCj4gPiArICAgICAg
ICAgICAgICAgcHJfZGVidWcyKCJVc2luZyBQRVJGX1NBTVBMRV9SRUFEIC8gOlMgbW9kaWZpZXIg
aXMNCj4gPiBub3QgY29tcGF0aWJsZSB3aXRoIGluaGVyaXQsIGZhbGxpbmcgYmFjayB0byBuby1p
bmhlcml0LlxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsgICAg
ICAgfSBlbHNlIGlmICghcGVyZl9taXNzaW5nX2ZlYXR1cmVzLmJyYW5jaF9jb3VudGVycyAmJg0K
PiA+ICAgICAgICAgICAgIChldnNlbC0+Y29yZS5hdHRyLmJyYW5jaF9zYW1wbGVfdHlwZSAmDQo+
ID4gUEVSRl9TQU1QTEVfQlJBTkNIX0NPVU5URVJTKSkgew0KPiA+ICAgICAgICAgICAgICAgICBw
ZXJmX21pc3NpbmdfZmVhdHVyZXMuYnJhbmNoX2NvdW50ZXJzID0gdHJ1ZTsNCj4gPiAgICAgICAg
ICAgICAgICAgcHJfZGVidWcyKCJzd2l0Y2hpbmcgb2ZmIGJyYW5jaCBjb3VudGVycw0KPiA+IHN1
cHBvcnRcbiIpOw0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvZXZzZWwuaCBiL3Rv
b2xzL3BlcmYvdXRpbC9ldnNlbC5oDQo+ID4gaW5kZXggNTE3Y2ZmNDMxZGUyMC4uMjFiOGI3ZTcw
ZTc1ZSAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9wZXJmL3V0aWwvZXZzZWwuaA0KPiA+ICsrKyBi
L3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5oDQo+ID4gQEAgLTE5Miw2ICsxOTIsNyBAQCBzdHJ1Y3Qg
cGVyZl9taXNzaW5nX2ZlYXR1cmVzIHsNCj4gPiAgICAgICAgIGJvb2wgd2VpZ2h0X3N0cnVjdDsN
Cj4gPiAgICAgICAgIGJvb2wgcmVhZF9sb3N0Ow0KPiA+ICAgICAgICAgYm9vbCBicmFuY2hfY291
bnRlcnM7DQo+ID4gKyAgICAgICBib29sIGluaGVyaXRfc2FtcGxlX3JlYWQ7DQo+ID4gIH07DQo+
ID4NCj4gPiAgZXh0ZXJuIHN0cnVjdCBwZXJmX21pc3NpbmdfZmVhdHVyZXMgcGVyZl9taXNzaW5n
X2ZlYXR1cmVzOw0KPiA+IC0tDQo+ID4gMi40NS4xDQo+ID4NCg0KSU1QT1JUQU5UIE5PVElDRTog
VGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlk
ZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5k
IGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0
IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55
IG1lZGl1bS4gVGhhbmsgeW91Lg0K
