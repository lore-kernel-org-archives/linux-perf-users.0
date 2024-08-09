Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F5193065
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Aug 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204391; cv=fail; b=uBT2qm8bGyQywKXCqplfTE0DQfr56UhHz5lL2ahN6IeVRIE9vS+8Qz6ZJdPXr/xvFzHPKLs6bEmSCqoZboULZ4JiuE6SGeEeWy9afJMQHTfJ05cWbT0MTwQ1x4FnpDxjlDUHey92ETDjDoXaTmornS2U3C8HT1tPftsb6rkQLP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204391; c=relaxed/simple;
	bh=HQ8AfyECOh/+S/crhBu+8AhfCsumaHZrdtWqAelbbUw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iBct0t4FFv6Z+P+t0VmnvR2UGiBPxYR37i1tV2R5mv9YyUVXr8ftbas7ypDGYs3QGI45t6HTLI/dBs56D+JZtBEMbvIkwn8c0zIy8DQxmyQKTSGySs2+LcyzIPgGqtywI6mjrs8aQM8esiP9V+fXs/nSU7mElFMoVYpwH6fkh+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SuMkxsJY; arc=fail smtp.client-ip=40.107.105.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SuMkxsJY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yc05byRWrWcdYtVS59XHBFtnV8VbVIa1UL9HLOQZ261Bt+i5DBc03g5npGAmjkb1s7ikGjPD79rqDdBUDujnldGWm3eeQTiPcECxtdWRJ3ulcaujCVOPZnLTkJoEajCA1YnvwwZ+WLm6I3vZcuCFLrkU1fL+sERGNjuvSxnhvCNpW9khhdWGyGKxy4hDZps4eMdOkZMWcBqygSSZa+15JxK1Y+IpZziDBJPVZ6SgDR1/GUrdtmeOEIRDbMjdLYEO+4Bwk6h3KbmT/Wtf58xjaqqLS5xDKKTJG+Zht4N5M74nKQs9BMUrQYEyJt45fJBXSfjO1OzCN5b9GCtCxzDSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW9MWnfurUdzHPYOb6EzrIt7yBfT+VLupPUFcR7X6YI=;
 b=Zbgx3R60MixD+vKrHeAhP2lhOmiT1cN3NagPkX9/3rjkI1kcjlcn0aetc69CVFPysb+4NyvpUlZHXfc7vngTqmHYsogOMWymOeJbhGoYx70aRdw0I099GqMUvZQieKBreaQ+7zkWOc+PpSK6ThyjGJftS+aMg5cV0fNOp7nPqxBj93MIiAWx/eqEYbZPkgU2F/QdlELpWhF/ePa2671LHjfItrRG+7vWFltWWAXO1NC/HjUA3Rcl802c9vXYdKX0eA5lIkALg2ra97iZgBqT9tY+oN93pPKxx3Dqv3rL8fSf1Fgyc9jstydgajj9GFCC9/VVWpWRfwm2t5r+C08yVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW9MWnfurUdzHPYOb6EzrIt7yBfT+VLupPUFcR7X6YI=;
 b=SuMkxsJYUjhgc7AvMrt7m2i/heQ+XrslCJfGlWKZu76qaxGnMV2tg09Jl2sqR2JKZw4SwiA2JULfI3CiAlzH6iI126ApzoIs/vJMnCK/NlWRVUDtvbuuv8LHAOoHGr3EpyTxT/FBK5PBhzKYDwYBPkSOHUiwrYrAIcid4s1HMfWBPHp3fVTnsTJRZsiZWNPKkb2qEJGB4mCbVQFNYyyjuV4SwGdIZRvWrLqPomfx3SCXNA+wANmKzDJ80egaCyeS9PklMEBjDOHTLmh6pOEZECRtPHFcB5dxht5FT6siQKFeZ1vUs1R51GGh1MtkZbB7/ifo3ghtLJteizaNHGjEpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8282.eurprd04.prod.outlook.com (2603:10a6:10:24a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 11:53:06 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 11:53:06 +0000
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
Subject: [PATCH] perf kvm: move HAVE_KVM_STAT_SUPPORT down
Date: Fri,  9 Aug 2024 19:53:35 +0800
Message-Id: <20240809115335.540947-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 34df2395-b8d1-4e78-94bf-08dcb869d4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTB6MHBGczVyTU1iSCt4UkhJY3IyUVNlRGFWOXIraU8rcHNLUDN1bkxTdEFM?=
 =?utf-8?B?bGxiWlFvYlRBWG1UWmFPV1Y0UGJNNnFDMmVNbkJGSHJtc2hLNGJuUXQ4VFgw?=
 =?utf-8?B?NG1RRTA0REdEVkVaZHdBcWl0YjZycU42OVh3SlI5L2hpTjNpTnFDWVNPVHAr?=
 =?utf-8?B?QXdyL3BkUVJWRW04bnVpM1pWNElNaVl3Yk16ZWJhdTN2NE9tZWl0ZUdOZ1R3?=
 =?utf-8?B?aWJSc3VRQmd5S0dUdXo1U043VE1PT2hXb3VRUW53OTdlTEZxbEIyN0lTeTVE?=
 =?utf-8?B?aFlhK05EMlFTb2R4dkk1OFVhN0hQc0NGUWdhODBTN2Y5TnhRY1hGcVNEdnB4?=
 =?utf-8?B?blFUKzBCR1BtTlMvQTJJQmhkZUVkV05EM2VSYWNxVHNzOFdiT2NnMVhCNjV1?=
 =?utf-8?B?dWhobXBmQUoySS9PakxEa2l4czNnQzNLZjRiLzRMWmNMakdKSGozVjB6QnhE?=
 =?utf-8?B?QS9CczJUVkcrZk9zN01SdlF0d1ZWS2ZsL2NLNnEzMGk3MGhub3RxK2s0d3Za?=
 =?utf-8?B?SWhZRDA3TkRFTXN6ODBpOTBtdk9uZ2JlMWxHRmFiYVI0RlE2OWZNVjYrQkpX?=
 =?utf-8?B?bG1BdnJIM2Y4S25zb3N2bWVaTHZzMU15T0RwUkxBSXJsU0ZCWTBaNEJTYStQ?=
 =?utf-8?B?cnBoWlVQSTJBYW9iL2piUS9hRi80UmIzUzg0ems4bnBiV253WVpndlhJRUpF?=
 =?utf-8?B?SnlodlUyMDJid3FVMnp6M2MrampSZy9qemZKaVhhM3RycUdTMTNvSHlmWGow?=
 =?utf-8?B?bjl3MnZlMlpKd3Bha2t2TTQ2b0o5ckJXK1hiN3lNSFJid09aNzRUeVBzNDRY?=
 =?utf-8?B?ZWx6YUZvdFhYUEJQL1pvY3Mya2lDU0ZKMVMzRVhPU1UvVUc5Z051TzM2QXJh?=
 =?utf-8?B?SkZ4eFl5cCsrbzhRL1A4ZzBFaWUrejlkQzZnS2JQMXdJbTJoMzBwSXN4aWRx?=
 =?utf-8?B?L08waWxZT1V5aTdxRXJBUjdrMkVIekdzS3hOK3dpUGp0bVBpaVdVSU8vZmky?=
 =?utf-8?B?a3VUVUxaaThUZVBjcmc5YWVMbEJyRmRwV1JHSHk0WGpXVjh2eGxkM2gvQTk4?=
 =?utf-8?B?SzRkWHJWRjcvcG1SUjNSQ1YzSGdHdmZidmhxR1czeGdlcExzcVZ5MWdSOFFn?=
 =?utf-8?B?S1hGNGpMSWM0VjV0anhraDBOOEhnZGp2bGZqem9PM3ErUVFYWVhzd21RMDQ4?=
 =?utf-8?B?Q1YrQmMvL1B6aHo3OFBsRnB3U29IRFZscDR6bHJvdE5PRi9FdS9SQlpLZUNv?=
 =?utf-8?B?bEszQVVrZDhWS0RGNHVxa0JNWE1NK1ArZDJnYzJmRXkrY1NjeFY1ZmJhaUxY?=
 =?utf-8?B?L2M2RVk5UWp0d0ljUDFCc3dENVB5Q1FvenhhUExqREpSU3hHc29INDNaZThD?=
 =?utf-8?B?YkNBUUptNzRKd2RIdWlVQkZEaDNXQ3o1NjlYU0VhRmJrYkx5MXJEd2cxdi9Q?=
 =?utf-8?B?amh5eThGdUU1L3NNWTFId3Q5eTkweEVVVkpXWFdVRXIyaUFmNUtxdE5hZzJO?=
 =?utf-8?B?MG9uRFlNWEpwRWtIcUZQWk1oN2VUaERKNFVJMUtTSHZySUdscjRzTk5ETVlJ?=
 =?utf-8?B?MXVYa0Ird1BRTHNIcGh6ZTA2WkZGeWtNNWdIb0I3K3hYbVFlSU5OSjNkWjRh?=
 =?utf-8?B?M2JybVNlM1pMQzY3aWEzKzVJbFVNUGFYdkxEbE8xSXhFVG1tRlZnNTN1NUo5?=
 =?utf-8?B?VDZnV29wVGpZS3ZlUEczYzBFODhtMGY5cWhrcnRsUGdnOGYzT3ltRzFISmEr?=
 =?utf-8?B?UEk3djNaK21UQkw3aW5zUUNQL3FMSFkxOFVPVkdad3RQTkgxTXpwWHk4Qkph?=
 =?utf-8?B?TElWckducnZOYnFJU3BsL2NsU1dtd2hvWGhWN0sybUVkT29GcG1LM1cvS2Fr?=
 =?utf-8?B?M1VlMldIMzZMU0RYU3VQZmVQWkthNWcxYjhHNU9zK3ovUC9qVGhrZmVreVEy?=
 =?utf-8?Q?5RfEbbojMRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU5oWDBxWnd1WHlFLzU1c3cyaXc0OUx1UUpxTEdMa09WRFdaYU40eFd6c0kz?=
 =?utf-8?B?dm9XVkYwNjZRVTRiR3FvWmVBSUtPbTdCZGp5VkNvS0VNU0NqUGdXTkhIckxZ?=
 =?utf-8?B?WUd5TWcrK1V5YzAxMHlrQUxTMkpzZEJXTFA0RVY4WjhmQ0tYODVuU1lacmJh?=
 =?utf-8?B?a29iQ2ljMEw2YUtHb3BsUG9YSXZNVGZnU2VSZWYrOHo0YmNpMUY5S3RJOE9N?=
 =?utf-8?B?YUgwdm9zZStXNk9GV0ZjTnFiU1Q5NzhvcmV2RnlBcmRQaHlZUWdtd0pTQ0dY?=
 =?utf-8?B?MWRvaUJVbjJieGJMdnk2em5Ic2FZWWl2anBSMTQwaVZ5NlB1dHRUUkFZOVls?=
 =?utf-8?B?SEFiZHp1SlhRbnlMczNuVXUzdnpKbCs5OFNFcUFaZXNUNUovNmpvUTFNNXRx?=
 =?utf-8?B?Q0dEUy9uQVc4d3N5LzJZY2FmY1VPcFlLM0R2VWZBZWoyY1h3YVNONXNMSEo1?=
 =?utf-8?B?L212TzJXdXpFSExXZ1B4ZTBaaDJGVjhGcXVYTmJTc0JERjRnd01UREdGV0o2?=
 =?utf-8?B?SkxTTkNuUmZsa2tZNkVCNDAvMkF4WU5STFQvRkMxUzkrZnhjaVQxYnRSVHBW?=
 =?utf-8?B?TU5YQWZjbkJMeUN6TlJ1ZFc2OWJqdlFQcUJkTm43RUwxOE43aGFKLzlHVXl3?=
 =?utf-8?B?WlVia2ZQRlQwYmlZNzZFTmQxeDV6aWxMUjVFaytVMUovZUZzend3YVl0Q3lP?=
 =?utf-8?B?L3ZKMEtyS1NUNWE2NFQvLzI4djI5c0tGQmY3WWw0K1VMYzI4UVBkTGNFMXhG?=
 =?utf-8?B?N2VYb2hYSW1GclFTb0VPalFkYzJuaVN4aUpZYjJ3dmtwMHhxR2t5cndYak1Q?=
 =?utf-8?B?cWkzaXBYLzVRMWNUYk8yYWduU0JGV2VUSnRNSWtqY0RwRU5YVWhkS3FzY093?=
 =?utf-8?B?TFMzdzIvQnhCekVoS2lkSmtNais3ZWY3aWlzYkJqbEZUYURQTG9LSk5YbzVL?=
 =?utf-8?B?QTN1V01aZGhZVnBhU0FqR3IzVlZ3WnlxQk5rdytrR3dUZWZnejFRUXdFL0RJ?=
 =?utf-8?B?RTBkcHJ5S2xIK2V4NGVFVkhXOE50UDdZTlQvNnk4a1lFcXI2RjZDWDJHNE96?=
 =?utf-8?B?Y0I4R1JieVlRWktXa0lTZVUvN2htYUswMXpDSklkSFFhejdhQkZyR3hCUHN5?=
 =?utf-8?B?di9Bbjk0b3pRN2UyK1NJSE9XYVpOdWxxdUR0Y3V1WkVPbVl6dmxkdFA3cDBZ?=
 =?utf-8?B?OFBwVlFncnR0STlzWDg0QzlFWGNtMFdraXl3R0diQ1JIYVFGNExISEtEZjUx?=
 =?utf-8?B?UzJMVHNzNHVYVGx4WTlmM3ZySnhkcmpXNnpiQlFXSVYvY0l5ZitRYXU2VWlE?=
 =?utf-8?B?bERqOUZnL2ZjWHMveUE4YXJRSmFyaTJDUTRucWRkMkwzTXhWQmVGd2JNcmtB?=
 =?utf-8?B?QVZoamRDN1lrRHVSR1lOSGQ5K21LMHpDNmc4TURCUVA2U2JIRS8xcFNzWmox?=
 =?utf-8?B?M1dNTzdCeHNvNzRKUE1JajRCTnZkY3YzdUZzR3ZLUTNTN2JBdGtURndQSGFP?=
 =?utf-8?B?MTdsWkpSNTlTVUtTZVZSVU0xUTBjQXJRcEtoNHExbHpDWVg0bk16TTNscmFq?=
 =?utf-8?B?RjlhRXN3WDd3bTJMbVFTVlJnOVYzeWlyQStZRDhnbGxGZGQrK2hoTkRsVXhS?=
 =?utf-8?B?cGlqMllJQkJDVEhTN0ZHTWwzWldVR2NzN0NSWGU4VWxnTDhSbWlucWJyQ1hh?=
 =?utf-8?B?Mzg3c0ZqWDhwSU4yVXlVQ1U3NTU1WkZGdGhubXJ5SWNFVkRDb0NpTzJJajlv?=
 =?utf-8?B?VmNZOGx2SldFUWtBYU5uUVBadFJ0a3lEMjhuWVZwR3NDUDRpRGhSNnVKNkxw?=
 =?utf-8?B?dWhJZjVWaUNBS1h6T0NGM1VRM0lvYjFmTWViNTF1Y1d1bHIyL0g0cENYRFI1?=
 =?utf-8?B?Z3VWVTYvT1dLVlFjaWtDeGw2OHVvTDMycm95ZVRGaWthcXZyaXAyUkRQUkNS?=
 =?utf-8?B?TmU1bWg2bHo5RkVKbm1ybGtENXJySkdnVXUzaG1vTlV5aVZBeXRKRXBjblFO?=
 =?utf-8?B?bjROV2txdE9BdnI0WXllbWRUMGxZdGJSbWlpQ3l6RCt2eXBraUhaL3hCKzhC?=
 =?utf-8?B?cUV0LzJVRHV3MGZPQnhtMUluQkFYQlZMNG9qYnV5M0NsT01ybjQ0RDd0STBZ?=
 =?utf-8?Q?n5x/u25abN8tQGRT6M+k21NDe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34df2395-b8d1-4e78-94bf-08dcb869d4a3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 11:53:06.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb+lMWa68TKOc7tzI8iNH4xrYkG4IPzZy+zNnngZoWgvmoebL8fKFVj5IQQ+YMxHebC/vjEOvb9e68Ph4scFlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8282

The 32-bit arm build system will complain:

tools/perf/util/python.c:75:28: error: field ‘sample’ has incomplete type
   75 |         struct perf_sample sample;

However, arm64 build system doesn't complain this.

The root cause is arm64 define "HAVE_KVM_STAT_SUPPORT := 1" in
tools/perf/arch/arm64/Makefile, but arm arch doesn't define this.
This will lead to kvm-stat.h include other header files on arm64 build
system, especially "sort.h" for util/python.c.

This will try to move HAVE_KVM_STAT_SUPPORT down, so normal header files
can be exported to source files on other arch too.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 tools/perf/util/kvm-stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 3e9ac754c3d1..92f1191cd462 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -2,8 +2,6 @@
 #ifndef __PERF_KVM_STAT_H
 #define __PERF_KVM_STAT_H
 
-#ifdef HAVE_KVM_STAT_SUPPORT
-
 #include "tool.h"
 #include "sort.h"
 #include "stat.h"
@@ -13,6 +11,8 @@
 #include <stdlib.h>
 #include <linux/zalloc.h>
 
+#ifdef HAVE_KVM_STAT_SUPPORT
+
 #define KVM_EVENT_NAME_LEN	40
 
 struct evsel;
-- 
2.34.1

