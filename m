Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705216EB7A;
	Thu,  1 Aug 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515328; cv=fail; b=GpR1Tir3lJAhbqp0ZTf6SQFdj7F7wmHxC/P9uGgJpyUqLx/ENq3/YWZUrqoBbTyFX/mGiamhDZaVcQePLAn9Z1KG6OwQNxDIF/NWh9nLa0GRc5X3+viR8AFUhrTvODLDi//GicTvyCuAc244u0lGSKAn+JapAqOo3U/Dr0UXRT0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515328; c=relaxed/simple;
	bh=BxAV9ocafMLfnyjezh0Gd2dbpxNkk07P22ACwZ/lby0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YgpaoTdndeKcnhjSg/ectLQJLEdf7mF1NRLmcWwE9AwE9X3CS21R6rBoU9/GFEXpsW/8k6RaFb5Sb+eEfIF+/Qyq3Nm3/q5NbXlbP5CNZiRL4tBV4HpEJLkDYLdZCU7B75ya4rTXh/ZTlITFTUy3v3wZTT4iaTfAlXRFICXdhVg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fPuHid3f; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fPuHid3f; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fPuHid3f";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fPuHid3f"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VmYfb2wzbC7ia7j1Art+jtd6MG80ERrqsUoTuRXcPcoyENtmQ7yFyk779F755ejWtE84ftm0R3r2coFgG74wjXYF747ziTA4MIbP/wqso2ReQyZXetZbfAOjl/5IxOOV33yCSgwMDAeMIiKA6OB/FDwjjtPc7v2obvT+K9oJZ3yykW+iomVkQXGdmlRfr5HlcScREO0oskNMqnh9PAAfgdNyM6rkHuZPa+WyZ1945f2SxedQUV8ebaH8EnoLXSqL40nirhbnLRBZs5tvNljBz0sB0nCMEZKzZjGN0FqpmI3MuIYfLMd9T+FhpFsKXNq0g7hCvjmQMwwrMP3Jy3u1Mw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxAV9ocafMLfnyjezh0Gd2dbpxNkk07P22ACwZ/lby0=;
 b=j6DTnnH6HTWBjm0+A7aMmxyAOMb4X7LO8fO7YuiF95YkDR50AOdu2PDjj9lgh3BQimp/Jw0yZzOoQ5xq+Ad1zGROCsx/SLdj6yIEzbNga6ldrCvdUnqu6TyOU2jlxp+fHg1gpal81I2xfh80n57mAnz2cGAocSxpkXgwOHsSCq2jeZJOUbyVOff8cxI/T/7BFjOTus8DWjc1qDqVqLmwCweBxKwCnZnXcpjt9yixA6fr81r9FtZUPLKEUFT5axMoTpxJ+nM7YNJ5GWeOj9Dd2ClJKkDlwSKVuLVgDJEdf2bho20RtAtANdRR5IjdL5XJ/yU3IyOfqxwfvMZqyZXgvQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxAV9ocafMLfnyjezh0Gd2dbpxNkk07P22ACwZ/lby0=;
 b=fPuHid3feMFavidVHNPNeNj57ShqaQnRZacFuKZlXygDjAG/RRNozq5PPvKHH/Ml2aiyVYmMyIhOIBFYJ+G8LzGQz3LsSufe4Q0tFJ3/1L7nIrFNLpcL/OTJXLYM5CdZ9WcsxoFaoaLSyPiLFq5gaQzKgZWnzT4g95jQ+Md4kV0=
Received: from AM0PR02CA0123.eurprd02.prod.outlook.com (2603:10a6:20b:28c::20)
 by PAVPR08MB8821.eurprd08.prod.outlook.com (2603:10a6:102:2fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 12:28:40 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::e8) by AM0PR02CA0123.outlook.office365.com
 (2603:10a6:20b:28c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Thu, 1 Aug 2024 12:28:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7828.19
 via Frontend Transport; Thu, 1 Aug 2024 12:28:40 +0000
Received: ("Tessian outbound 64d41e6a4c04:v365"); Thu, 01 Aug 2024 12:28:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cdd554aec8c03746
X-CR-MTA-TID: 64aa7808
Received: from L2a3c72921cca.3
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 19DA8DAD-04F3-478E-AD6A-CDE71661E97A.1;
	Thu, 01 Aug 2024 12:28:30 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2a3c72921cca.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 01 Aug 2024 12:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhcrwp5bGDOnGnZPaRVIqJIH25A3twTRwBxDzz0goO12/fGulh0psphv+ltI4wKENvxb/o1nUstJiAb6Mi7PNMKL6FBHUFKOkXEFeENH1y0DFbJVpe2e+iup8YkGZDZqHHu2nYlBp9906bHO6oLOqBECqvtMNqKgKaM3EHqmwwQwO4l1t9din8Psk5yjl7KCcwjCxWqok0IjgK3wWlD/2DQkAki1HejyoruoDzVWs2/7Hnus1c/BFE5r33LrJlpyqTDBQzm2sUVvC7YJK7OKtfkQaDvqd6F99vYs3qtpmehH6AnHD5Lit/HYTgOwlZh4+csyjNwZUSCZ5sMYvE+vRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxAV9ocafMLfnyjezh0Gd2dbpxNkk07P22ACwZ/lby0=;
 b=m7yyDzaZn+FBOu75pj1MLTvVph0JmFTpowdcO7Uf3Fsba8bTCEvWYZS5jD6X0NeHuV5fpLfi19UIh8Jm+DuprtwMGwjk7HDa50H2TtRJmRWtEj09SrwokmmFGoji8Rlo0muRU5MiFSfC9sl1GO3kXmlEldsqHPfcVdxy7JfpjX59ql3QbziXCvfRYaJsIRwvSkiEy9t0TRC/vbCMtPNs3LclERdTHlYW4VvGGO8KdLhzXMrvo0hqJ2BE3geg8X8qTOPfhmFNdIRvZTI6NVTuwnyIlDWf7wkTBnRv8Tus4TcSVEs+iRNcVbquaU4GOvUVFgKlVaZbXBEQOLMyAHXFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxAV9ocafMLfnyjezh0Gd2dbpxNkk07P22ACwZ/lby0=;
 b=fPuHid3feMFavidVHNPNeNj57ShqaQnRZacFuKZlXygDjAG/RRNozq5PPvKHH/Ml2aiyVYmMyIhOIBFYJ+G8LzGQz3LsSufe4Q0tFJ3/1L7nIrFNLpcL/OTJXLYM5CdZ9WcsxoFaoaLSyPiLFq5gaQzKgZWnzT4g95jQ+Md4kV0=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by GVXPR08MB7821.eurprd08.prod.outlook.com (2603:10a6:150:4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 12:28:26 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6%5]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 12:28:26 +0000
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
Subject: Re: [PATCH v9 4/4] tools/perf: Allow inherit + PERF_SAMPLE_READ when
 opening events
Thread-Topic: [PATCH v9 4/4] tools/perf: Allow inherit + PERF_SAMPLE_READ when
 opening events
Thread-Index: AQHa4lzBzJ6HynEBMkiaY+prQPXE5rIRJxoAgAEwyIA=
Date: Thu, 1 Aug 2024 12:28:25 +0000
Message-ID: <7b8da3f40cbc30a25fe5fa856627245dc2b6a991.camel@arm.com>
References: <20240730084417.7693-1-ben.gainey@arm.com>
	 <20240730084417.7693-5-ben.gainey@arm.com> <Zqp_vqCn0FEfGFwX@google.com>
In-Reply-To: <Zqp_vqCn0FEfGFwX@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|GVXPR08MB7821:EE_|AM3PEPF00009B9E:EE_|PAVPR08MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c067175-d0e8-4175-9862-08dcb22579be
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UXJueTJmd2ZUL0pNYTVWK3M4akZodC9qR2ZDb2g5YWlodHJCaUxSWW95YWc0?=
 =?utf-8?B?Y1dtNE5ocVNldTFFSzdqTlppRmFTWUgyNFArcVhlN2R6eFpiaDVUQkJEeC9t?=
 =?utf-8?B?YllQVFZVUmtwc3JJMXhGVHJUSU5zdm1NZjQrYkRkcGhMSFg4WnBtYmI0ZjhK?=
 =?utf-8?B?RXBCT2o2SW5rMmNsdUc1T21rUFhEbWVKcndTNTdUM1JVRmpaQzR2TXA1NTFE?=
 =?utf-8?B?VmRpbWF6YUVQcW03OHhOemxPdDJYODgwQnRQd1dFNG9IaSsrb1paOW5ZZ0x0?=
 =?utf-8?B?SW40a0JXcW54ZmN4aUE0V3hXTnVEWCtvaE1VTTNTcXYvWjRvTDNROHY5VVpH?=
 =?utf-8?B?K1FOVVI3NnhzendYMWQ5ZDg1QTRCVXBzWlhhb2tKNXNDdEFMMmRNUG1NU1BM?=
 =?utf-8?B?ZWhsbzRCYXIxTFFpUXJIQ2Z0K3EwSkY3aG5rRTFHVWhTUmppejJSa3UvSHQ0?=
 =?utf-8?B?UzU1U3ZDU2tSK0prZ1JCOS9uRHpCUWZ6S3lYRE9LZ2pEd3FFTFo3YXR3bFl3?=
 =?utf-8?B?a0JMaFpLWDRRVzRZcmYxd0lLQk1XS2hobFkyY1lzczgwVEJLMzR0VlU0QTdp?=
 =?utf-8?B?WHMzS2k5Y2NmaTRjM0VzUjZSQWNsMnZVVytLOWRUTURsQWRoekp3ZWVzMkV4?=
 =?utf-8?B?b1YvVDEzVlYrUjIydmpYdGVvR0JNcnk2dTdENk1NQlBXbUFKbk9GcFZEN3JY?=
 =?utf-8?B?cDlwbmthUjhOSjZOSHhGbi9IekttQ1puWUZCODZSaXRqSkF6MmNIcm1JWEwv?=
 =?utf-8?B?bjZWb3grOE92WlRkY3pZalkxcVFDNk02RW5YN1Z3ZkJ4U1Nud240aHhlNGVV?=
 =?utf-8?B?VUhnNXJVbUtJbGZqNlNMUmhETW1jYk5VdXNUQ0ZXeEF6TUJTYkwzekhLMFBr?=
 =?utf-8?B?blBZYnhMSkhyUDFPTGZOcHU2YUV1cWtCK2tTUWYzWnFRbTg2OTRGUmhMWGRQ?=
 =?utf-8?B?b3F5WnZxbjA2bWJVT0lnTHRmSmNsemZnQno3L3k0OHl6V2Z4Vkp6TTN4L0t2?=
 =?utf-8?B?SVpLcSsrQy9vcnpxaENsa0Vsd1A3YWU1T2lyQzU1U1pqVFJ0VFNnTlY2bUxH?=
 =?utf-8?B?RmpHY2hPeDQzOWFaNFkzdVhWbFNYNnh0TXA5ZDJoZDc4VWh1Y1JkVXVHNVBX?=
 =?utf-8?B?MXJSTXRGeDBPTlJKK0tTVDNyQnFVZHBUcDFwbGlYN0lMNGVBNmJ0b1VNRWRx?=
 =?utf-8?B?enpacEVSOFMyYmEzbjJKYkNoQ0NDNXR4b2hmdUJYNFRGSzl3T3MvR1plVmRV?=
 =?utf-8?B?MlplQnJwL1JsTTZZVFFqR1ZCSVAvSG90RzU4aTBsUFRDUzluWU1yWE9xWHVr?=
 =?utf-8?B?cmRPdGNjbmFEbEpMZmMvM2dXRHJPYTRsTnNLUXBDUkZyeTBVcmFzc2twU1pC?=
 =?utf-8?B?TjlqMGtmaER6Vldha3FXNEp0cGY5Z0d0VU9ydHIyY29FcVd5ZU81MEt2RVZo?=
 =?utf-8?B?U0xVRTFNTnNZVWx4d1RHL241OHZPQW0xcjQwZ09OSys1YkRQMGdSanN4NkNy?=
 =?utf-8?B?OTdjNzEySjBkUjM1QThHcVY2TVJaN1V3dEg1U0pkUnBYQ1BrcmE1STlKNVl0?=
 =?utf-8?B?OERIWmtJOTFZZlI0MU5DamlJSmlsNDN4L0RyRVJwK3JPR2V1d3hTSVgzRzl2?=
 =?utf-8?B?TldBVGRhaXJMaENtbTZqbUNiWXlXcTVJQjRJdGhtejBlSjBkRk1vUW5uSnM2?=
 =?utf-8?B?Ny92b3pSUGtZU092STJ1bkdKZ0dpODZFVTNFK21LMW1Mdms5V2Jwc2tFTUtm?=
 =?utf-8?B?UGdYbDBGdVlOdWtGZUc3T052a1NLcm40aXZsbWgzUGg4Z2VJSGh5QnBQYnh6?=
 =?utf-8?B?QkpoWnR3MEtSTVgzODQyUGxtUW5GTjRQOGdQejJic1RZSXowWm8rM1l6cG1Z?=
 =?utf-8?B?S2M2Wk5HWmxGMGszTTQ0K1VFUE0yTFVLTFBZVFRMeDZKMEE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <65BB38BCE0258348942961D22B5C9CE6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7821
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:350::15];domain=AS8PR08MB6646.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c1a1ce29-7e3b-43f3-a530-08dcb2257104
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnhNL0Q2bUFqTEp1a3dQT0FSTi9zUUlMcyt6a1JRQVV0bzJySXgvYjJGNGsr?=
 =?utf-8?B?aWlRZjZHc0lzckJybVF6Qjh5M0hYYnA0VTVrOUZLK0F1SlJBZkpIQ0FDZFZE?=
 =?utf-8?B?ZFM1RXdnbHJudUJaMzZNYWd4TzlaRys5Z1paU3RMTkZFOTE5QlNWanZwbms2?=
 =?utf-8?B?OXZqaTgydHlMOXFLNll1MkRKaFVIOW83a3JiSWtyK3A3RkFVNjA1ZXVZWmpL?=
 =?utf-8?B?Z2Y3NUtPc2xjYnVCcVlVNzB4MFhCRlYrQ0owNkdXdHRRYkZlNm5ablFlUUkx?=
 =?utf-8?B?c0FXREZWTG1xQStMd0VocGx3dlVicjdDTUNBQTBTNWNXMTRJaUNtNHA4bHFK?=
 =?utf-8?B?QXpFYm5CVUp0cElMalFPaUhCRWlhRW5aUWVGQkZZdk1USit4ZURLTlhjZVlq?=
 =?utf-8?B?Y0ttNDdCd09HTk9XZ3UzL0Nkb3doSENtQStzaUFiaFNpUnk1SjYvQVpkMGp3?=
 =?utf-8?B?VUx3bytIU2txdUlhUElnd2xuSzBaMERoZjl3Z2p2QUVLNkFTSmNPeWVzNUxy?=
 =?utf-8?B?d1U5YW5sTS9pcUZmMXZQTGJxUm05dW9mcXo5M2syejBrbHBnem5EdGw3RXRs?=
 =?utf-8?B?bTlLNnRaQWpqVi9YMVBZZVZEbGhlVDlmTWdhRlF5SU9QcmRYOUM0cGRjLzg2?=
 =?utf-8?B?THhnekR6RkRUWVl3QzVyWTNJZkRrRDFzd0wzNnlpaG9kckEwclVtK1ZhUmxy?=
 =?utf-8?B?M1JHU1lqQXBPeDVVcm1YNVdJVmRpQzJ4QzlSRWdnODZIemIyRmJCa2cyUktn?=
 =?utf-8?B?cjRnblVyWTBaVy9ibmo1NXN1T1ZCaGlTU0NGQ3lRQnNzalZuWmhPTDErSkVl?=
 =?utf-8?B?R1J0eEVNQUJTTG5nd2tPQUJZd1Znd2VUT1VSWnBBMnE0R09NN0QrU3NUWUlR?=
 =?utf-8?B?MThGckk1MUVVVXFUZlpmQW5DbzBZdzdSQmFSUFFTamJDaEJOUU9jdVlaQy9D?=
 =?utf-8?B?d29jVVpNV3dFeHZFeXpkTWhvNm5QbUxnR3NMeTdhb0FZREFTN2Nob3ZHcmVS?=
 =?utf-8?B?TThaZWhCU25YN1lhblJaYTlEQmRXRENhZGFFN3JKYjlLTnNPRmh4Zk1ZTjZQ?=
 =?utf-8?B?YjJLYlRyQmxzaVRwbXJvUkRDZHVJUjFFejFVWnp5YzQxcjhHS1ZTbDJzajVr?=
 =?utf-8?B?TzlQSTNnNXV3RUc0QituTGJqK0FITUF1YzN0aXNENUFIM3FzQU9mR2hDNUJs?=
 =?utf-8?B?TlpKRDNCOU4xQndhVHh5TjRQVk9iaEN5QXRKcXNsWXhGUGs2azFudDJXZTZl?=
 =?utf-8?B?V3FmVzRveVNVRzhqeDVyL3ByaEZPVSs0TXp1Z0ZQSU9LS1hvVFRGL0N6clFp?=
 =?utf-8?B?V2FpSHZFcGpOOGdBWmFvbWlCM3BINGY3bGZxZ0liTE9adkZXc2V2TWZGRzRK?=
 =?utf-8?B?b0pzSmNhcVZFMzcrNEwrSnJubTBxK0Z2RzRzR3V1YWZUODU4WUhpa0ZRRnBi?=
 =?utf-8?B?V2RGa0dFQnROQ2ExTU5RMVIxU0ZrSk01c0o4aEIwdjRlUHowd2I1Mml6VGhK?=
 =?utf-8?B?T2FnVTh1YU8vU3hIMkdTeGNpMHhONGlPRGREODZrWWNubGVJNWJES1N1KzVB?=
 =?utf-8?B?RkhrM21rTXJleHUvRUd4eFlTUlhvQjF2VUxqb243ZnYyb2NWeUkrVjJrSm1L?=
 =?utf-8?B?ajNISiszSGdNb3VGWXh6UmVycWp6NEQyK0VOWEYwNmZWSUVzdEh5TzB4Z1hY?=
 =?utf-8?B?bmlramdkL09rMFErUGMzVEFkc2tGL3QwTFNMSFAwd3NPZXozSEFIbjJlVzhR?=
 =?utf-8?B?QWRCN3VJb1F6cmlGQzJPb1hTeTJTL2htVUk2d3JsMGRYUHIySGNYTnBnV3dp?=
 =?utf-8?B?WlEwL1hsNGhVZVQ3WmVjTnZlZkZxUG9ZaGZjZE56em1SZ3AyQUxJeGtnRG9G?=
 =?utf-8?B?c2dJaUtGTzZhMVBRTFBBSzA1dGdhWnlSMVYyTFFqRGpWNkVnYjFTMkg0b1NO?=
 =?utf-8?Q?LVvT0/KdjqR/J2CdI2toXpElj0ZrmRU2?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 12:28:40.4898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c067175-d0e8-4175-9862-08dcb22579be
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8821

T24gV2VkLCAyMDI0LTA3LTMxIGF0IDExOjE3IC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IEhlbGxvLA0KPiANCj4gT24gVHVlLCBKdWwgMzAsIDIwMjQgYXQgMDk6NDQ6MTdBTSArMDEwMCwg
QmVuIEdhaW5leSB3cm90ZToNCj4gPiBUaGUgInBlcmYgcmVjb3JkIiB0b29sIHdpbGwgbm93IGRl
ZmF1bHQgdG8gdGhpcyBuZXcgbW9kZSBpZiB0aGUNCj4gPiB1c2VyDQo+ID4gc3BlY2lmaWVzIGEg
c2FtcGxpbmcgZ3JvdXAgd2hlbiBub3QgaW4gc3lzdGVtLXdpZGUgbW9kZSwgYW5kIHdoZW4NCj4g
PiAiLS1uby1pbmhlcml0IiBpcyBub3Qgc3BlY2lmaWVkLg0KPiA+IA0KPiA+IFRoaXMgY2hhbmdl
IHVwZGF0ZXMgZXZzZWwgdG8gYWxsb3cgdGhlIGNvbWJpbmF0aW9uIG9mIGluaGVyaXQNCj4gPiBh
bmQgUEVSRl9TQU1QTEVfUkVBRC4NCj4gPiANCj4gPiBBIGZhbGxiYWNrIGlzIGltcGxlbWVudGVk
IGZvciBrZXJuZWwgdmVyc2lvbnMgd2hlcmUgdGhpcyBmZWF0dXJlIGlzDQo+ID4gbm90DQo+ID4g
c3VwcG9ydGVkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJlbiBHYWluZXkgPGJlbi5nYWlu
ZXlAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiANCg0Kc25pcA0KDQoNCj4gPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvcGVyZi91dGlsL2V2c2VsLmMgYi90b29scy9wZXJmL3V0aWwvZXZzZWwuYw0KPiA+IGlu
ZGV4IGJjNjAzMTkzYzQ3Ny4uY2ViMDliNmE4YzJmIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Bl
cmYvdXRpbC9ldnNlbC5jDQo+ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMNCj4gPiBA
QCAtMTE3MSw3ICsxMTcxLDE1IEBAIHZvaWQgZXZzZWxfX2NvbmZpZyhzdHJ1Y3QgZXZzZWwgKmV2
c2VsLA0KPiA+IHN0cnVjdCByZWNvcmRfb3B0cyAqb3B0cywNCj4gPiDCoCAqLw0KPiA+IMKgIGlm
IChsZWFkZXItPmNvcmUubnJfbWVtYmVycyA+IDEpIHsNCj4gPiDCoCBhdHRyLT5yZWFkX2Zvcm1h
dCB8PSBQRVJGX0ZPUk1BVF9HUk9VUDsNCj4gPiAtIGF0dHItPmluaGVyaXQgPSAwOw0KPiA+ICsg
fQ0KPiA+ICsNCj4gPiArIC8qDQo+ID4gKyAqIEluaGVyaXQgKyBTQU1QTEVfUkVBRCByZXF1aXJl
cyBTQU1QTEVfVElEIGluIHRoZSByZWFkX2Zvcm1hdA0KPiA+ICsgKi8NCj4gPiArIGlmIChhdHRy
LT5pbmhlcml0KSB7DQo+ID4gKyBldnNlbF9fc2V0X3NhbXBsZV9iaXQoZXZzZWwsIFRJRCk7DQo+
ID4gKyBldnNlbC0+Y29yZS5hdHRyLnJlYWRfZm9ybWF0IHw9DQo+ID4gKyBQRVJGX0ZPUk1BVF9J
RDsNCj4gPiDCoCB9DQo+IA0KPiBBbHNvIEkgdGhpbmsgd2Ugc2hvdWxkIHJlc2V0IHRoZSBpbmhl
cml0IGJpdCBmb3Igc3lzdGVtLXdpZGUgZXZlbnRzLg0KPiANCj4gwqAgJCBwZXJmIHJlY29yZCAt
YSAtLXN5bnRoPW5vIHRydWUNCj4gwqAgWyBwZXJmIHJlY29yZDogV29rZW4gdXAgMSB0aW1lcyB0
byB3cml0ZSBkYXRhIF0NCj4gwqAgWyBwZXJmIHJlY29yZDogQ2FwdHVyZWQgYW5kIHdyb3RlIDAu
MDQyIE1CIHBlcmYuZGF0YSAoNTEgc2FtcGxlcykgXQ0KPiDCoCANCj4gwqAgJCBwZXJmIGV2bGlz
dCAtdiB8IHRyICcsJyAnXG4nIHwgZ3JlcCBpbmhlcml0DQo+IMKgwqAgaW5oZXJpdDogMQ0KPiDC
oMKgIGluaGVyaXQ6IDENCj4gDQo+IE1heWJlIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiBk
aWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMgYi90b29scy9wZXJmL3V0aWwvZXZz
ZWwuYw0KPiBpbmRleCBiYzYwMzE5M2M0NzcuLjk0MjNjZDY1YzNjNCAxMDA2NDQNCj4gLS0tIGEv
dG9vbHMvcGVyZi91dGlsL2V2c2VsLmMNCj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMN
Cj4gQEAgLTExNDksNyArMTE0OSw3IEBAIHZvaWQgZXZzZWxfX2NvbmZpZyhzdHJ1Y3QgZXZzZWwg
KmV2c2VsLCBzdHJ1Y3QNCj4gcmVjb3JkX29wdHMgKm9wdHMsDQo+IMKgwqDCoMKgwqDCoMKgIGJv
b2wgcGVyX2NwdSA9IG9wdHMtPnRhcmdldC5kZWZhdWx0X3Blcl9jcHUgJiYgIW9wdHMtDQo+ID50
YXJnZXQucGVyX3RocmVhZDsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqAgYXR0ci0+c2FtcGxlX2lk
X2FsbCA9IHBlcmZfbWlzc2luZ19mZWF0dXJlcy5zYW1wbGVfaWRfYWxsID8gMA0KPiA6IDE7DQo+
IC3CoMKgwqDCoMKgwqAgYXR0ci0+aW5oZXJpdMKgwqDCoMKgwqDCoCA9ICFvcHRzLT5ub19pbmhl
cml0Ow0KPiArwqDCoMKgwqDCoMKgIGF0dHItPmluaGVyaXTCoMKgwqDCoMKgwqAgPSB0YXJnZXRf
X2hhc19jcHUoJm9wdHMtPnRhcmdldCkgPyAwIDoNCj4gIW9wdHMtPm5vX2luaGVyaXQ7DQo+IMKg
wqDCoMKgwqDCoMKgIGF0dHItPndyaXRlX2JhY2t3YXJkID0gb3B0cy0+b3ZlcndyaXRlID8gMSA6
IDA7DQo+IMKgwqDCoMKgwqDCoMKgIGF0dHItPnJlYWRfZm9ybWF0wqDCoCA9IFBFUkZfRk9STUFU
X0xPU1Q7DQo+IMKgDQo+IA0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo+IA0KDQpEb25lLCB0aG91
Z2ggdGhpcyBsb29rcyBiZW5pZ247IHRoZSBjdXJyZW50IHRvb2xzIGFwcGVhciB0byBkbyB0aGlz
LA0KYW5kIHRoZXJlIGFyZSBhIGNvdXBsZSBvZiBmaWxlcyBpbiB0ZXN0cy9hdHRyIHRoYXQgYXNz
dW1lZCBpbmhlcml0PTENCmZvciBzeXN0ZW0gd2lkZSBtb2RlIHRoYXQgSSd2ZSBoYWQgdG8gdXBk
YXRlLg0KDQoNCiAgICMgcGVyZiAtLXZlcnNpb24NCiAgIHBlcmYgdmVyc2lvbiA2LjEwLTENCiAg
ICMgcGVyZiByZWNvcmQgLXZ2diAtYSAtLXN5bnRoPW5vIHRydWUNCiAgIC4uLg0KICAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQog
ICBwZXJmX2V2ZW50X2F0dHI6DQogICAgIHR5cGUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDAgKFBFUkZfVFlQRV9IQVJEV0FSRSkNCiAgICAgc2l6ZSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMTM2DQogICAgIGNvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgIDAgKFBFUkZf
Q09VTlRfSFdfQ1BVX0NZQ0xFUykNCiAgICAgeyBzYW1wbGVfcGVyaW9kLCBzYW1wbGVfZnJlcSB9
ICAgNDAwMA0KICAgICBzYW1wbGVfdHlwZSAgICAgICAgICAgICAgICAgICAgICBJUHxUSUR8VElN
RXxDUFV8UEVSSU9EfElERU5USUZJRVINCiAgICAgcmVhZF9mb3JtYXQgICAgICAgICAgICAgICAg
ICAgICAgSUR8TE9TVA0KICAgICBkaXNhYmxlZCAgICAgICAgICAgICAgICAgICAgICAgICAxDQog
ICAgIGluaGVyaXQgICAgICAgICAgICAgICAgICAgICAgICAgIDENCiAgICAgZnJlcSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMQ0KICAgICBwcmVjaXNlX2lwICAgICAgICAgICAgICAgICAg
ICAgICAzDQogICAgIHNhbXBsZV9pZF9hbGwgICAgICAgICAgICAgICAgICAgIDENCiAgIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
DQpUZXN0aW5nIHlvdXIgZml4IHdpdGggLWEsIC1DIDxuPiBhcyB3ZWxsIGFzIHdpdGggYXBwbGlj
YXRpb24gcHJvZmlsaW5nDQphcHBlYXJzIHRvIGRvIHRoZSByaWdodCB0aGluZy4NCg0KDQpSZWdh
cmRzDQpCZW4NCg0KDQo+IA0KPiA+IMKgIH0NCj4gPiDCoA0KPiA+IEBAIC0yMDIwLDYgKzIwMjgs
OCBAQCBzdGF0aWMgaW50IF9fZXZzZWxfX3ByZXBhcmVfb3BlbihzdHJ1Y3QgZXZzZWwNCj4gPiAq
ZXZzZWwsIHN0cnVjdCBwZXJmX2NwdV9tYXAgKmNwdXMsDQo+ID4gwqANCj4gPiDCoHN0YXRpYyB2
b2lkIGV2c2VsX19kaXNhYmxlX21pc3NpbmdfZmVhdHVyZXMoc3RydWN0IGV2c2VsICpldnNlbCkN
Cj4gPiDCoHsNCj4gPiArIGlmIChwZXJmX21pc3NpbmdfZmVhdHVyZXMuaW5oZXJpdF9zYW1wbGVf
cmVhZCkNCj4gPiArIGV2c2VsLT5jb3JlLmF0dHIuaW5oZXJpdCA9IDA7DQo+ID4gwqAgaWYgKHBl
cmZfbWlzc2luZ19mZWF0dXJlcy5icmFuY2hfY291bnRlcnMpDQo+ID4gwqAgZXZzZWwtPmNvcmUu
YXR0ci5icmFuY2hfc2FtcGxlX3R5cGUgJj0NCj4gPiB+UEVSRl9TQU1QTEVfQlJBTkNIX0NPVU5U
RVJTOw0KPiA+IMKgIGlmIChwZXJmX21pc3NpbmdfZmVhdHVyZXMucmVhZF9sb3N0KQ0KPiA+IEBA
IC0yMDc1LDcgKzIwODUsMTIgQEAgYm9vbCBldnNlbF9fZGV0ZWN0X21pc3NpbmdfZmVhdHVyZXMo
c3RydWN0DQo+ID4gZXZzZWwgKmV2c2VsKQ0KPiA+IMKgICogTXVzdCBwcm9iZSBmZWF0dXJlcyBp
biB0aGUgb3JkZXIgdGhleSB3ZXJlIGFkZGVkIHRvIHRoZQ0KPiA+IMKgICogcGVyZl9ldmVudF9h
dHRyIGludGVyZmFjZS4NCj4gPiDCoCAqLw0KPiA+IC0gaWYgKCFwZXJmX21pc3NpbmdfZmVhdHVy
ZXMuYnJhbmNoX2NvdW50ZXJzICYmDQo+ID4gKyBpZiAoIXBlcmZfbWlzc2luZ19mZWF0dXJlcy5p
bmhlcml0X3NhbXBsZV9yZWFkICYmDQo+ID4gKyDCoMKgwqAgZXZzZWwtPmNvcmUuYXR0ci5pbmhl
cml0ICYmIChldnNlbC0+Y29yZS5hdHRyLnNhbXBsZV90eXBlICYNCj4gPiBQRVJGX1NBTVBMRV9S
RUFEKSkgew0KPiA+ICsgcGVyZl9taXNzaW5nX2ZlYXR1cmVzLmluaGVyaXRfc2FtcGxlX3JlYWQg
PSB0cnVlOw0KPiA+ICsgcHJfZGVidWcyKCJVc2luZyBQRVJGX1NBTVBMRV9SRUFEIC8gOlMgbW9k
aWZpZXIgaXMgbm90IGNvbXBhdGlibGUNCj4gPiB3aXRoIGluaGVyaXQsIGZhbGxpbmcgYmFjayB0
byBuby1pbmhlcml0LlxuIik7DQo+ID4gKyByZXR1cm4gdHJ1ZTsNCj4gPiArIH0gZWxzZSBpZiAo
IXBlcmZfbWlzc2luZ19mZWF0dXJlcy5icmFuY2hfY291bnRlcnMgJiYNCj4gPiDCoCDCoMKgwqAg
KGV2c2VsLT5jb3JlLmF0dHIuYnJhbmNoX3NhbXBsZV90eXBlICYNCj4gPiBQRVJGX1NBTVBMRV9C
UkFOQ0hfQ09VTlRFUlMpKSB7DQo+ID4gwqAgcGVyZl9taXNzaW5nX2ZlYXR1cmVzLmJyYW5jaF9j
b3VudGVycyA9IHRydWU7DQo+ID4gwqAgcHJfZGVidWcyKCJzd2l0Y2hpbmcgb2ZmIGJyYW5jaCBj
b3VudGVycyBzdXBwb3J0XG4iKTsNCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2V2
c2VsLmggYi90b29scy9wZXJmL3V0aWwvZXZzZWwuaA0KPiA+IGluZGV4IDgwYjVmNmRkODY4ZS4u
YmIwYzkxYzIzNjc5IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5oDQo+
ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmgNCj4gPiBAQCAtMjA2LDYgKzIwNiw3IEBA
IHN0cnVjdCBwZXJmX21pc3NpbmdfZmVhdHVyZXMgew0KPiA+IMKgIGJvb2wgd2VpZ2h0X3N0cnVj
dDsNCj4gPiDCoCBib29sIHJlYWRfbG9zdDsNCj4gPiDCoCBib29sIGJyYW5jaF9jb3VudGVyczsN
Cj4gPiArIGJvb2wgaW5oZXJpdF9zYW1wbGVfcmVhZDsNCj4gPiDCoH07DQo+ID4gwqANCj4gPiDC
oGV4dGVybiBzdHJ1Y3QgcGVyZl9taXNzaW5nX2ZlYXR1cmVzIHBlcmZfbWlzc2luZ19mZWF0dXJl
czsNCj4gPiAtLSANCj4gPiAyLjQ1LjINCj4gPiANCg0K
