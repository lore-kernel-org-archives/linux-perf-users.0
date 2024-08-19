Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E603A8F0
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034812; cv=fail; b=lyHgoBNah02v4bGTpxP12AbQi/W6vWUTpMW46/KrhRcQDE/xWw4hRtVnDs9vCJA+btJ3WErCyjLJng/Px1c4r33yNqV4aAVZk4MzanxpxXapHfL+VQVdIY8CnjIzNsFEscYQkVJBhEhs0qpH5/EOQgogwzu172jzYeHYLJ4k+uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034812; c=relaxed/simple;
	bh=U9tjMWEo1CsENCI2PIKqPz2qTKfiT+GkPRZr7qQlpl8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oaKdRYEdsCqrGkoPxW5cJuvLu8FWVZMXA0Gne/OqjBmqp+/UclUtKR7tVG9kisGm4yZXWKdSk5fUJNAzUTC3hsBe+5kQITkSCAGCrJgqQkUJ0oLWrFJ41rKdMYePU9Aopf5SYldb7ihvMJ30oUZtmxHuB0y06j6GkGUxLYQ8qVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bJrdLNuk; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bJrdLNuk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3mcfydxQ0adFjZwKPYVUdeTf45b3RfhLfH56HaOyV6CKFyP2NZJRm4XPBCTWXDe3GsJAbUDCOd87UDIblQAqGz1j7gCJla6GV9t9L5APyXh4L5n2+9GKi9D2VpdzY9NjWBfvWv0n/4qlL+cSMCNQwtJAQfV5Tg28MAENnpAHA9IWIKi6GtE/M5rKYQTwTrlJNm7KJVMgwMQzwIHkStBLfr74n+SOY8d+URxnmqYUvb6T8Zg4mPjtk77T8jej/XYpZPiqaKJuHARvib+Wrb3QrqlxsTUrzGJSBZzuzNJs+i83f4pDWVeTnln04GFzd+VNfe95F9cgrKZhXuda3Eclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd4CNFUpFTDqWQaQbtUoqzUuZh2+8xMVimBLZdG/N9k=;
 b=QICVQOVZEUtN6hI1OEAp/Z2X9M8ZbMnbdGgcflY3qkBhBtruSHWX521krgXKVTXiY91Z2TRDaWFzDBugmw5iQBwQGeefav4gfuedtt7wRmFzMVRKXPYU/J01PMPcLi1Gy2M/olcWeDX+xUePpvtJvXh4UZxgrb16c7uhFUipq4OnpBFSZpp+HTdsD9H5KX3JR713gNwY3eorWKVGQUTdvf0l7EGbqf6NM4UKRlc2EzE9VpfmPeHDqOK0OT4D3UAB4D39XlnRXFO0OLYp1l0Z3xas1WQPU5uNEijh2hbVA+adi1C/Y3BpUlR5xoFBN5UdUHrb6V7JvYMnGMdH43Njkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd4CNFUpFTDqWQaQbtUoqzUuZh2+8xMVimBLZdG/N9k=;
 b=bJrdLNuk9lpFSPWbQ+A9ewtfrdocnQshv3VXQ/NoBn0xNOVNYU2S5/BuCNkWJnakn5IE4ATCzpJbMV/jsrj5cEwRI4Ajxn7GexuYSiWotTJ09s/J13sOdM3nrVfFnz19g9YXSIcSnWQhgMBNpL8k0K75u8GpoWwIJQ4MkbDtVHSjGRddXm8LZXQgWLCpT3mrqaxDC+kmUUga1i8e7vRqbH1ysU7FiH0egzOkRdtnph0z14ng889jljNvknoqPG9kWDpe40L9xlBzbowaFZmn9n5Je570ZSSmTAJLxfHPx1OUU5CwS1ouUAizDTsIpV6VpUgBBB4Cdh6RYuXfFmvBqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9706.eurprd04.prod.outlook.com (2603:10a6:102:24c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 02:33:28 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 02:33:28 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2] perf python: include "util/sample.h"
Date: Mon, 19 Aug 2024 10:34:03 +0800
Message-Id: <20240819023403.201324-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: 977a5859-1394-4589-1784-08dcbff74edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUNZYW5pMWgySG9PWjlqZlh1Wmh6emN3YVpEdEZXU1NVL3VSVTNESC9ib3dl?=
 =?utf-8?B?a2o4MkxzZ0JDeVRjM0VGbzVaaGoyTW5vZnZjREY0bWxjRVp5MGJxMERxV2dl?=
 =?utf-8?B?NSs5S3ZLbG9DMkhGWjM0YVNZQnZZaDJnY1lBVndxcFNrS0hZbWN1RnNNMDBB?=
 =?utf-8?B?OGUvN3hPZjl6VFdNaTdvYXZtTXErVTFvSkJwazdad0NBeEpMSW15ZEFQNzJ1?=
 =?utf-8?B?OXF6WXBPc3dvc1Z0MThuNGlEUGJnYURUa3FxUC9OS2tOWUVuR1oxY2ZKdU0z?=
 =?utf-8?B?dStOZlF2dGRVRFZOMzlvb25DMmxwZ0Y3SWhBSHVWNmFQMDA1VCtmcDkrNXNH?=
 =?utf-8?B?d2xtWi9rTTY4NnlaTUdkMFNKSXZid2xBLzJLQ0g4dzFFbDNrMU5oS3pURjZG?=
 =?utf-8?B?T2NuVkJPSlRjTm41TE81UDY2M3ZTL2ZHUnRFcUlDdkk3d2pRbHVLWm5UZWsw?=
 =?utf-8?B?UW12MFNJZkdWdkdvMkVteGRJU01EU2lweVMyY0dFYm5yVU8rMmVtYWxvcll3?=
 =?utf-8?B?dHNyaHFSeEkvYVRwdWx1Y0NPSmtkK2xmZDR4MUFRcUZEdlQyR2xGdHNXYjBE?=
 =?utf-8?B?UWhVc1F4eXpYMGtlcnhVZnowRUVMSU9NamtZT3ZodkhqYjVRYjlnR2d6bkNZ?=
 =?utf-8?B?UnBJMnVmTVFhRDlRd1g4NndOcmpJblIwc0lMTzY5RWtqZzJJWTFwQytjemtu?=
 =?utf-8?B?dS9QeXV5WWhoSjJTbHpIK2ZLTVhXTGdyNDNuSmlOQ1ZqV2FYNExkM2orYThM?=
 =?utf-8?B?dUZHQlVDWGlnUjhiL3BMRXNMVzJIZE1aWmo4OWh5WGtNNVFoSERoalNRSXdK?=
 =?utf-8?B?c3loZE0rUGMyQUc5dy9nM1ZtK2JvOW12blh2bUp4M3R4NytXYmZ1MDZ2VHhP?=
 =?utf-8?B?d3g5RHZldzlnVy9BNUE0L0JpWGxhY0ZvbFFyTkw0WWk2TE5OemtRQUQyK0hh?=
 =?utf-8?B?eE9tZDdkTzVMV0dKVDhYR1d6enozYjdEZHJLNWhKa1RWTW5CTG1UanlrdTNI?=
 =?utf-8?B?OEYxVHB2akhGK2xUdmFkWG95V1Mrd2pHWVBqczRQK2NNVzZYSGgrWDV1Y2Rj?=
 =?utf-8?B?aDV1T3Y4d295T2ZVWm9NVUVKWkRnRnVab0xUUGw5R2FvUjcwU1FORTJVZVJ5?=
 =?utf-8?B?VTdJNjU1bHpsTzlvZTJRenVpTWlGQmN1ZDVFWXRyWElwbUwrU0xyVVpsSFoy?=
 =?utf-8?B?SmdjTXdwOG0vRDlVcmlid0RlSWlYUVBaa0gwaWU2SmZ0aW9qd2pZdUhLc043?=
 =?utf-8?B?WGlONi9SeFBsS0xHVDBNYk5mMDladjM2V1gxZzgzYUFVNFFGbnpqc1FWUkFi?=
 =?utf-8?B?VUZSQkFTeFVqd1VmdGRJUjZTdmFDR0xFTEZhVGFYd1UwYnp1L1pIcE5tVmxE?=
 =?utf-8?B?d0JUU1FNcWF3U2lyWEFOamxySHd5bjNlUTZDYk1qd0o1Nmc1WHBGNU5rVzhK?=
 =?utf-8?B?QU1hRFRPckNNLzFtWjFNSm5tKzJxVmJRRHVaM2wrU3duOTJtWUZkV0F5V2Jy?=
 =?utf-8?B?NW1GRDRJN0hTV1RnZ2xHcmQyTnB6ZXptc3RtbVhIcGhXNUdMY2p6QVZFMEUw?=
 =?utf-8?B?NWZrYzIyRmp6U2tHTHlpemZYQlNmZnpNSVk0dGxzQjJGb2g0T1VCSDVhN25o?=
 =?utf-8?B?dHY2V2dWODFWdytpT20xcjJFR29TRDI1L09SMUpBNGVDR3B4ZC82UnRJS2Fq?=
 =?utf-8?B?VTZVekgxVlY3Slh2UGFVUlBZcE9paTBHejZaNmZPNGxSRm5XL0R0SzlkM1c3?=
 =?utf-8?B?UEVjYllITnY1TGlaaXNiZXgzcTBGYnovMEU2UG82VFZyL0pXQ3QzblRTMFdu?=
 =?utf-8?B?Y3lHREZ1NFNzbmJaRGVNNCt1dllTb2pCeERndTdrZXZKeXF3alVHSlBKRXRG?=
 =?utf-8?B?YTc2WHFjRTdhQzZiTnUxMnB4SjFudkphYVBKV2JSV1lzdzBER0hMTkl6LzVC?=
 =?utf-8?Q?m3qVRZM5nI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1FRdVlydXErby9OQmMwaUJjZFp5YUdJeWN6Q21TNjRvNmQ1a29uTllqZE8z?=
 =?utf-8?B?dGc1b2YyTzFsNjIzTm4rQmwrRktOd1NqSGZmaUgzM3VVY3VuaWlZeWNjbXhJ?=
 =?utf-8?B?elFQVlJUa25MWjFINjlacWJzYWx4bGh3VnFrTTM2MHFqMnY0eDlPQUZGeWdU?=
 =?utf-8?B?OHZSakhiVHBXNXJMRGllWjNzbk9zZStMSGtyaTJEOW41TDFiSjdvUFl4RHpL?=
 =?utf-8?B?WGZ6dHIvV3dVWUptVmV2T25FZEkwRVBNMnUrTXdSSmVxSVY2R3UyNVVRQ2Rs?=
 =?utf-8?B?bXhWLzk5TTlIOEVheXVWUkcxdzBpWW05ZU8rYldXOXJ0K1l2aTBDNGE0ekRo?=
 =?utf-8?B?b1o0TWlzRUNETEpEY0tEM01rQ0hyZnlDOG1SR25ZVGY4aFBPdENPZlhxNGo2?=
 =?utf-8?B?TWtya3pqTEtPdlo3STJFeEFOTjI5VGtYYkNCUUxkSGVuendGMlJnanorMUY0?=
 =?utf-8?B?MkFZZ3JHYXN3WFcvSytHVkk4L0l5eDdlY2w1dzhrc3NUMTQwTG82d2RmMmMz?=
 =?utf-8?B?c0NQMkYzd1UxNS92S00yWFZuY3IzZit3TmZ0L0lma1h4YUcxbnNONW9raEIr?=
 =?utf-8?B?MVdZeDh2blE2SFJ2bDNxZXdiZ2x3dSt1dVJNdForSGN0ckd4Zys3Zks2Nmk0?=
 =?utf-8?B?SnpxOUZCblVTWndBK09sdzRINHlDblJwMTFNcm00VkRVOGNJbzd0YVZuY2dO?=
 =?utf-8?B?OHVuVExwOUVGMVhVUEVoMEZIT214ak95TEZxT3UrK2tETGdMQlcveUlhRUNh?=
 =?utf-8?B?ZDNyT2JXa1BBNEhHeGMvWjdLN1ozSmkvVDc4ZEg5ZnIwTkZEWldqcjV3VW5m?=
 =?utf-8?B?R3JmbUk1YXRwUUxDUmZmQ0NITmVTTExOTEx6bGpIYnpQMFNra2NDTTJjd3lL?=
 =?utf-8?B?VFVheU1pNG04V2I2bk4reVBDUm44SC9zUm9tYnByZFNuMThQYU9HL1VzcWVC?=
 =?utf-8?B?R3V5MUhyMktjQ3RvcldzdUZGM3VGd3dad3BFcTNrSW0wVS9HTjg2UjFXT01I?=
 =?utf-8?B?WmVlTktWZEg5bnR1MVloYk50cHV3TTB6RTkxQUFxYWpsYng0ZjlLNTZTNVFE?=
 =?utf-8?B?TUFJU1hGUG42ZU1COGMxby9wTVA4cUw0K2V0SWE2VDUxTEh4dnBXUkJRS1FG?=
 =?utf-8?B?SEZ0SVRLaWdyRHkvLzl4T1lKUTB2b3g1dnNURWJ4dDlPM1FFbGNhcUhrSU96?=
 =?utf-8?B?blUxaDFUTGl1a3Byck9WQWxrL1A4Mk9POUpMNnpidEJFckRTT2Y1dU82ZkJP?=
 =?utf-8?B?bHpoQTU5ZDZIakQzYXN2NWcrN2Nuckg0T3o1R1J5ZkUwNFJQVjhLSnkvSlpH?=
 =?utf-8?B?YmNuYUZLcUQyMW14VUtHRjBiUy9COXlFVW8xeHRGaTR2UnNIYk5wYkFtUWlx?=
 =?utf-8?B?UlgrQWptSzl6aFhzaTRZZ1BYOEE3U29TNG9ENzBWNXlZQjEySGZpbm9oZHlW?=
 =?utf-8?B?cjRCU0t5Y1NtNGxBRmZWcXJnc1dlZUE4WEo0WG11K1plc1h0bkFiQ2FDNGY1?=
 =?utf-8?B?YUcxdVdvVldyZ0hMZVU1QzN6eVNNbGFDbUhOZlBCa1VwNm5TWVJyakJlTC94?=
 =?utf-8?B?Mkk3eFVoK3l5L25WTDBCalhQTHdqallWZGZpTE0rNXZVdVcwdXNnblU3UERs?=
 =?utf-8?B?OU1XQjBSZHdVV1c3R2oyK0RIYk9CSFNWcElyUDZUUU02aXlIcm9DbFRHb21X?=
 =?utf-8?B?OUJzV1BOTVdVb1p4dTEwVXo2Q0dySFNRTGRmWDZoc09YUGhHKzBtNHNnTWh4?=
 =?utf-8?B?KzVCYjRNb3hpamxKYlQ1bys5NFF5cmhDelU5S2ZQMmgyTWo2Y2JNa1BUMTEz?=
 =?utf-8?B?ejFJUnZNZWcvd0c0QWZiT1VDTzlBeitQNklKbmoweWl6RG5ZYm1qcE1WeWRB?=
 =?utf-8?B?d1hYL295UWxkVDU5enB0b0lzSE4xNm1yZzFuSTBtQ0lVWTRSbkNaNFJnejl2?=
 =?utf-8?B?VlBCZjBqTnYzcTh2ZnNjb09ZbUhnNjlHTllNNUZEbnZoRWd3ZTRYUHc4aExl?=
 =?utf-8?B?M3BvekQyMnpuZEF2cXUvVlVWdlcwSFFtczU1MXFOcjhCY0NzU1FsSjlvcE1P?=
 =?utf-8?B?MUlOK2NwM1MwbjUrOGlIL2dMVTBJQ1drbGNXdzFEZEdIMlk2SlZCVVB0R3N0?=
 =?utf-8?Q?3PV3KwMbS5nfuKip5dguaBuDk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977a5859-1394-4589-1784-08dcbff74edc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 02:33:28.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLD1r/J+AMZyfdQgC6ZNpWvjl9QWSq4eUOlKZ/9UXJWlYDjB2SoQkA7aUsTVGTGcbeRu6HfcWYzFegapR7kMsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9706

The 32-bit arm build system will complain:

tools/perf/util/python.c:75:28: error: field ‘sample’ has incomplete type
   75 |         struct perf_sample sample;

However, arm64 build system doesn't complain this.

The root cause is arm64 define "HAVE_KVM_STAT_SUPPORT := 1" in
tools/perf/arch/arm64/Makefile, but arm arch doesn't define this.
This will lead to kvm-stat.h include other header files on arm64 build
system, especially "util/sample.h" for util/python.c.

This will try to directly include "util/sample.h" for "util/python.c" to
avoid such build issue on arm platform.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - include "util/sample.h" in "util/python.c"
---
 tools/perf/util/python.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3be882b2e845..31a223eaf8e6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -20,6 +20,7 @@
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/kwork.h"
+#include "util/sample.h"
 #include "util/lock-contention.h"
 #include <internal/lib.h>
 #include "../builtin.h"
-- 
2.34.1

