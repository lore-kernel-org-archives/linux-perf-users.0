Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2061.outbound.protection.outlook.com [40.107.7.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74580198828;
	Thu,  6 Jun 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690265; cv=fail; b=k2vNm3SO4DGjnfT+e5Hlah2osKbNCnHO6r5u8UaQiVnpljWV60LvU8iGs4ox2c5pCR/wQsE90LvsKpqSOEVNIegvZ4YydFDMR9ZaJck7+7LAaz+Vq+J49inK3sVgcR0Sxb0aFCe9ajsBbsG94MzGQd6AbX2ltga6WwRe9pyhe+E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690265; c=relaxed/simple;
	bh=u/IfkUpSrEcuacE//OME6ExUVaqrTYHpeh9DBMpBVN8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PuMWh2u88Y5bX5jMEqkbPOoa/3wuRF2+oDRvyhW8g0RWUfv5/t3SgNfFjzhoHLVCm5db+LgXgoUBNLVATYznNmFzP2ypQ6/gp02osQGzO1oWpBmSbMQ8UZdJn+4gjnWqLQsfv5K83jc71X3pLANcXGt/mOIwvZFvKaNCyyRqaTk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dEdYQv1S; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dEdYQv1S; arc=fail smtp.client-ip=40.107.7.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dEdYQv1S";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dEdYQv1S"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=c+BEguLsB6wQfPGcfU/bdkW4y3FcX8hfkykFQ37DclA5XGx8DJD8yd3LtCLQkDamuPVGl0xrYedUwa1zE43OdSfhKu6LyyHQxj9EE2iAKS4vX+x3U5CtIhlEINORz6V6H04jhMgeG/D5/u5X5kXXMMZwvBtGHtzp/AzWZShkhc+OYWQCbX1escZKN1VRTXQjSdawE3Q9x9DqBAwkI5gBzqAhhH6Pg4pqu2JqranV5t94sJvdsWFRJzNeaks0zVxWcMYBKY6VTSPHjnFWzMwI5WxZRmpAzabyVjqtBDEfxu6UMRveDwxXaUywUmykH/7KFNQgk96waI06eeCmYUrk1g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scLxZuAojuvGpfEvigR3i3IkD1YYuH02J1z5JFMVhFs=;
 b=gR9WHLSa3LNj0qr95AwJZRoJFRmCng1LEsjdr2UXuiRW3oKOtK8aNpoLqyiHLMn0nylLp/1siU+ZjywJMR2i0anmkKhwKICgZt++/btkqkihX2iJGe2Zl6SV/sbLisUaTUkQLz5l0YpOC1YKD+RlJB/nEuv5OKo0UXVnUmc+SxeLQEEbkD70FbObFi68JIKEda8R9aJLuX6PPS2ydaSTcLBEn0PmxwnEzehLuusDkkhyH7ajgVfx3IiXeBNCxoLRQnKJSOdYYWc/DkAAhV23t3j+tLKNL9RN2uwgiaK/URULTzhgm8UcMEQqnysLab8tUx1nLCkO/F1K8/6LZ9Rokw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scLxZuAojuvGpfEvigR3i3IkD1YYuH02J1z5JFMVhFs=;
 b=dEdYQv1SUxRMYMzSNFzN8KpW3/IHytojNpzzySDFXgW5oT8LzghU/MFx65NthF00bNzl+iZVEt3ze11atc9llYfEfY14TjcA6CF8yuWqzobsAaK7Veh3pGdxD5wXyjCnmU0gJPojZpaXnDLgfJuTwEJFez9e3J8iKsDAb3636d0=
Received: from AS8PR07CA0058.eurprd07.prod.outlook.com (2603:10a6:20b:459::15)
 by GVXPR08MB10476.eurprd08.prod.outlook.com (2603:10a6:150:155::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 16:10:56 +0000
Received: from AMS0EPF000001AB.eurprd05.prod.outlook.com
 (2603:10a6:20b:459:cafe::67) by AS8PR07CA0058.outlook.office365.com
 (2603:10a6:20b:459::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 16:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001AB.mail.protection.outlook.com (10.167.16.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Thu, 6 Jun 2024 16:10:56 +0000
Received: ("Tessian outbound 7136819eaef8:v330"); Thu, 06 Jun 2024 16:10:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b7c300637be85c7c
X-CR-MTA-TID: 64aa7808
Received: from 8f348c86b5b0.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6CAA40EA-7BA0-4F24-9594-148AE75A4281.1;
	Thu, 06 Jun 2024 16:10:45 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8f348c86b5b0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 06 Jun 2024 16:10:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZev+d3V7++V1S96g9CJ5PMRyAdDCQD/i0GcdobIgEpt63tI/2GA3fHt0wZGYW8MUMgUrrkB/x9ByPOuJypS9cCbGmXAHOFUfFf3qHWtwHgRUXXeraPph7fdXJF6zbmd3X1RsRpul/x3dMc6Sw55d6jsAc3ReCAlK+7N/pNsoXDAy5Ggws7LYVbo6QS3gblRTr9u1JX1ZSbkD3k1l1xXJqdbnGNMMve8AaJ1+INHUkg+j1ZKRFqo2/MznRQNvClXFIRffveBLncmnFg1n2/4JJJe32sBZvcv5hHeFL22lGpjOk0vL1ocZt4EVhTVk5C05I+bCVMlxe324FlMMyRReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scLxZuAojuvGpfEvigR3i3IkD1YYuH02J1z5JFMVhFs=;
 b=RaIbhoCaJtD8XVWKTiK8Y/HMOf8rKhOQ93Jax5eVa7Hfp+bBqCY68XIXdSCqe9z2Kek+izoZzJLK8K186a8p0jvS/AetBAoMHGTeaoXVSiGcHjv0QNYBeSsVzUtEcgRoQYxvm+Uli0BHNuB/IneU+qmtmo0BH9AZV7dI+dStWvJA5+3qAFmfkslGdmEL7BCqpBVmeDcwVHez3TeDp3gK6WM15K8KVwfSp9zZY0KJ9PLz+3Qft+zdfGsjop5BJhkT6xG1RUk6iARMX6aN3Y7nzhgZKZT7DDETpNifLa0cAYvhDmjN1WQhvw6CiX218y9t9u9K768rdRuFF9/BbJbMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scLxZuAojuvGpfEvigR3i3IkD1YYuH02J1z5JFMVhFs=;
 b=dEdYQv1SUxRMYMzSNFzN8KpW3/IHytojNpzzySDFXgW5oT8LzghU/MFx65NthF00bNzl+iZVEt3ze11atc9llYfEfY14TjcA6CF8yuWqzobsAaK7Veh3pGdxD5wXyjCnmU0gJPojZpaXnDLgfJuTwEJFez9e3J8iKsDAb3636d0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com (2603:10a6:102:150::13)
 by GV1PR08MB8401.eurprd08.prod.outlook.com (2603:10a6:150:a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 16:10:41 +0000
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad]) by PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 16:10:41 +0000
Message-ID: <a54e9c8b-4152-4545-8273-89bb19418e32@arm.com>
Date: Thu, 6 Jun 2024 17:10:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] perf Documentation: Describe the PMU naming
 convention
To: Ian Rogers <irogers@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 Tuan Phan <tuanphan@os.amperecomputing.com>,
 Robin Murphy <robin.murphy@arm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Bhaskara Budiredla <bbudiredla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Stephane Eranian <eranian@google.com>
References: <20240606044959.335715-1-irogers@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240606044959.335715-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::15) To PAXPR08MB6591.eurprd08.prod.outlook.com
 (2603:10a6:102:150::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR08MB6591:EE_|GV1PR08MB8401:EE_|AMS0EPF000001AB:EE_|GVXPR08MB10476:EE_
X-MS-Office365-Filtering-Correlation-Id: 714bd7f1-87ff-45fe-be55-08dc86433f60
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bHFNZU9Uam1GVGYxL0VFQ0pIQWltUmhSTTloUm5OK21sajVQQXFDZHFxSGRD?=
 =?utf-8?B?bWY1V1RVdHRvOE11TDVtM1ZBZWhselc0MmpUSzZLZlFCUWZaVFd3V0hhQjFh?=
 =?utf-8?B?bnNGMTRiT0NPRHJ6ckJlb05qQXFiY2JkYlpFaGxzVFN1dkxIZjlldlNuQUww?=
 =?utf-8?B?UTFCMC9wTU1tOWxoK0xENW9ZRkFuU0gxNHRXWE1EZm9OWVpqT29aV3g0dEls?=
 =?utf-8?B?NjFqU25TZG5TOTl4UFpaOTY2SjZtZ21UUU1RUXF1NStGd3VGS3ViamE5WXR2?=
 =?utf-8?B?dmFHWU5Pck1TcGZDWWIyeU5wdFptaG0vRWhSbEw0LzJQUjRlenYyYitxdndU?=
 =?utf-8?B?RGh2a3VtcHJGREp0ZkZsYmx3cXM3bUhlYTQwdVRUWmZsZEVhbjhpSUdUeFVl?=
 =?utf-8?B?dkYyVnhLeXQ2RmU4N0NGSnlDemoxbDFpdmsrTEFybjBhSDJXOCtVeTNGYmhy?=
 =?utf-8?B?Z0NQYTRYVTYxbnYybUg0K1VwYnlvNG1BT1QvZnJGbWpKMDBWYXdSbTZPVFJ6?=
 =?utf-8?B?WGx3eWpqdlREcHVqWFdVakFnajd3N3duWncxNHdENk9nclhSQjNXUDU3UnBX?=
 =?utf-8?B?cHZKMXpKaEJjTXQrZFRDc0dMVG5KMXNwRmlHaW5qRkcrMG56USs2WW5MS1pB?=
 =?utf-8?B?aFduVkgwRDVBK01TQlBNQkdFT1AwdlNlTDdqMk9JY2VTSlRFMXpKTkFuS1ZW?=
 =?utf-8?B?OFFZUEFBeW9MZm8yOTRtS1RFbFpkZE5zWE5RZXl0SFR5dXprTEUxM2NoUFZu?=
 =?utf-8?B?c1c2Tlh1MVY2V3BwV2F5M0krWHkxanNqRDRUMU1xUW4rM2VxQVZPekFRZm5Y?=
 =?utf-8?B?MWhJcHp0TnBTeVZWT3hKaXZIS01mU24rczBXaVJYTFdwU2FTNGIzcXJEVjVw?=
 =?utf-8?B?L2U1SW5MejFRamJjcktFQWJWOVBxTDI1OVFxcFY2OGFHZ05LdU9ESkhLNklN?=
 =?utf-8?B?WElKaFhCbEp4Zmd6aml0TysyVG9QY3FpVXQwL0xWOTdqczBRcEZMeU8xWDJa?=
 =?utf-8?B?Tk9lZU9YZndNNEJ2NmtYV3pQV3h2aU1RYmFSdDFrRFlSaUY4ZG8yMUdSYzkz?=
 =?utf-8?B?dlJZTmxBdTFaYUhYRWRRcmV5NDNqNzh2UTdhTTRIUnhVd3NyV3Jzek9ZdHR6?=
 =?utf-8?B?eC9pOE84UUx4SG9pMXJTNEtuelk4ZkpqUGxzYm40aEZKU2Zzd3NDL3VrOGUz?=
 =?utf-8?B?SkZ6cDZCc1J1ZUxDWStSWDYrc2IyT3BieVJPNDJBN3dNSlU3V20rZDVQbWZS?=
 =?utf-8?B?NXZxN1g5TUd0eW9jRUY1cGtTbFZwaU80SWp3VThTUDM5bHo4b0cwTGthRllk?=
 =?utf-8?B?Z1ltVmxPb1ZNSjU0RXVzM3psYjVtOTJKOTJvUFl2SXRDUUhsZ3AyT2pSRTBy?=
 =?utf-8?B?VUViOTRXak5JRnZkL1htZ3JpY3NMMG92dmlOak91VGRnNndtY3RjOFMwL0o0?=
 =?utf-8?B?RzdtYlUzOEFvMENpYUhiKzJIT0Z0Ynp6d3ZHNDk4eEFhR0o3ekpzV1BhQ0hs?=
 =?utf-8?B?VUhVM1ZuLytqYnAvOXV0K2I2MzE1WWF4bTRLZE1xUVRiRDkxY3Y0N2RCdWE0?=
 =?utf-8?B?Zi9UWklHRFZKS3p4NGtCR3dnRnBFK0IxVWp0TWx2N1d1Z0JKeU4vOEZtSHNC?=
 =?utf-8?B?Vk9VbHRmK0Fta2g0bFVUdFVhQ1VxWnYxWW13QllvY3FjYjZTSUpZdVpCV2tF?=
 =?utf-8?B?MWJSeWxobDYzYUZOaW9sYjU1WkY5RnJ0ZDlHdlpkN1RFL2xwdHUzcVRBV0FE?=
 =?utf-8?B?Rk8yeXFMZ0VwTW9keVMyR1hOMzlXdmVJdnZXWG1NaERnQnRIQVlaK3BDSmJs?=
 =?utf-8?Q?bFXgERFu6VQlNcW5wHOXcMha3d80QZOWmF/Ho=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6591.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8401
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5b804f44-9b78-4c89-60e8-08dc8643368c
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|35042699013|1800799015|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0hvQ0g2cWVDekpHNHk1NDJ1aG1LaW5ITkViYW1uSnorbENnVWtGRXpLMXQz?=
 =?utf-8?B?QTlQSGFhdWZuREJWUDlMYVdETk5ubS9vRDFDcFplNWdjUDY2Y3JyQkEyMHN5?=
 =?utf-8?B?dnFxM0ZSMDVCd0xoazZnSHNkQ096bEM0d2JSTGlVUjgwd21FaU14MzJmd0pt?=
 =?utf-8?B?eXlmb1VzUWZjYWpSdHlDUDY5aXpyR3lMZUxjVHVLdmRPODV2ZUxZR0lUcVpN?=
 =?utf-8?B?bVRxNWYzaDE1NkQrdXpTWjByYkVJSDI4d3ladjhtQkIzRm5BVDdQL1g0dUNS?=
 =?utf-8?B?QWtnUVk4dnJ4dWhkc0t3aU4wVWI2ZC9LYlFNMWVGU0JKRGdXZWZtUURnRjhX?=
 =?utf-8?B?WWJXMVpFNTZMQ0tQVTJQK2NsMEVnRjR2SFZaK0ZVOGQ1ZlpINnpWWWZDWThs?=
 =?utf-8?B?U3R6N2J2RlFyZ3JqaTI1dkxvTkMvQWI2RXFCT2hocW1RZUt3SzJ6SlgxTzIr?=
 =?utf-8?B?L2grR0ZZWi84akZqMEtMOG9adXYxdm1ZdUd6RjJBNkowUjFFNFR4OFIzVk5k?=
 =?utf-8?B?NThWMHdxZ2Y4UzFDOFJUcXp5SGtzMzV5b3dsaERCcEZZejg0KzhubW9DSUF5?=
 =?utf-8?B?UDJLMDZyRmptaVdHa3I3WmlWeVAxMVVCalhHSE95blM0bVhzeHp5Z2I0YWVy?=
 =?utf-8?B?czZRakoydEJsWXRUL0RLdHBzeHVLNmkyM1VIYmdTUjMwOTJDZzNuVzljS2J6?=
 =?utf-8?B?WXhTSXo0RWxZRGllZE5RbEdhNkZRTkt2cHdSYkNLeVlXUCtubm5JcUlFUzJ3?=
 =?utf-8?B?bktCTnNXWkxVcS8yZWlITjE2aTUvQ0U2K3piSGIveTlpbk9lSmthQzQ4dHdF?=
 =?utf-8?B?akM5VzE1ejEyYzQxazg5SDBPNGVmQWoxbktOVUUrTmlkVWlKWm1BK2YzUTdQ?=
 =?utf-8?B?R3REUkFPVjBsam5RSlFXdXZtVmpZclJLRUxZbkpzeCtMUTJZeHdZbXJWVU5h?=
 =?utf-8?B?TDd3T2daMUhkQUJjRUJROE10b3ZjWGh2ODRCV3JoamRNbzhRQ0tqd3JQcGlW?=
 =?utf-8?B?TmZKaW12UWE3UlVBdTQwN3hBSlg4ZVRSaTdTUlZjdTJmNUtQS3U3VEJtZGRv?=
 =?utf-8?B?bVdheUFua0IrUEs3a1J1aGFFSU1RdHhPdEpDYVVBclZ4Zk5PbTVicjFZL1By?=
 =?utf-8?B?YmdTaGliM0F3d3FiTklvNlJrVFRFd0R3Z1hpczkyK1BkNDRKQzI3MXlVdk55?=
 =?utf-8?B?QWRHUDlEOFdUWlZicElZNm5tRGMwWlNEeEhkVzNUQTZNU3lVU0gwWHd5ZGVE?=
 =?utf-8?B?Y3MvdEFkVmhHOHQ2MnlUWUN6K05meERFenVkdktaQnBWNEh2SHlyT2d5RXRo?=
 =?utf-8?B?MWdSSi9PUDY2c2RaLzZvemR1dXV6b0d6a1RuOHprYnREMjYzVTF0RHA5Vk9E?=
 =?utf-8?B?US9uTDlOOXJ1cTFPWnYyeEY2eFppQ0xOalM1Rm1ZeGROS1hNZGIzUDBXUm1N?=
 =?utf-8?B?UjhkUVIrQVlUdjA2UythZS96ZUZHWGJ1RGs0S1RVTGVHM080SGo0V2N4RUhx?=
 =?utf-8?B?Yzh3djNEQVNvOUNiTG5oNURGTGp3aUU1WXVkZkt0cjlDY3c4dGFSWEYrYWJk?=
 =?utf-8?B?blhvbTBncTU5dXhRTHB6L2ZHNTBpUTVzK0ZYNCsrbE1hMHBFd2JlTUl0YnJF?=
 =?utf-8?B?eHU2TisyM0ptSjFzaUplZFl2Mjc0YXBrUWhuaTM4UThpeklaUTVLMlg3V3lx?=
 =?utf-8?B?U00zYmxpbzZKbHZwMHE3ZzVjdWRESWZ2Y05pMUFhd0VYMVhXWmd4MUFULzhD?=
 =?utf-8?B?VnNVcXFmTm40VzNyYkl3d1hidFpMbWNmVHJOczFqd2NXN2RzbmZna25HRTlm?=
 =?utf-8?B?SDFoYlVMSVVUZTJ1OHBNMVNjN2U4djFuR1ViTFFvM3ZRMkM1NkdVWXFrN2FU?=
 =?utf-8?B?U2t4WExXMVMyMysvT0tRbVhFL09pbzBTQzZ3V2c3Q0ZnMDdpcmZLeUhZME1j?=
 =?utf-8?Q?RNhnWZNVzmE=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(35042699013)(1800799015)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:10:56.3065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714bd7f1-87ff-45fe-be55-08dc86433f60
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10476

On 6/6/24 05:49, Ian Rogers wrote:
> It is an existing convention to use suffixes with PMU names. Try to
> capture that convention so that future PMU devices may adhere to it.
> 
> The name of the file and date within the file try to follow existing
> conventions, particularly sysfs-bus-event_source-devices-events.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
