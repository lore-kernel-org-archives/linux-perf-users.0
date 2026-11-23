Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795416524;
	b=Kh+YUgV+VeoqLLBTflW6R9mV0UrXLEee6Qj9g1fH0K9GPaqOGvju403HBYZEZLwPS79b
	 oZHq8mxktSDc9frC/lic88EbLRsQzUdLNwa6+nERifbvVS7AA5tcJjK71v201lvDHB9y4
	 xlSD/L22rVngf8WhrmydypVLOD+nga2yue9iA9IUjCMspZNSli9P19QvX/sal1GMtnPyY
	 n7BdOZlAgAYFMC3pM+NRqUzydEB1kkTwWCsH0HOZy09gM2T2YSF+PEF+MyT1jtzatHAwh
	 6CJG3GI7Kk0yA/RPgeA7red3m7kSABjWkQb9kUedQtBljcu9nk2qcnTaSplblmq7Efw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416524;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PkirmmGBrHXOzWH/Xd1T0m9vDbCZfqu1QYXH+9sGfFk=;
	b=VcIoAsgMECJ3KMOAiWS0010tFLgyyq6CZEys6/4ywJ+lFRn0xG2TqkQYB4juvHALc0rQ
	 VEKDNRAcucfCLcsobfC8K/eluJWHmg3ue4/tII0slXR1pZoQO/S4U7zJq1YOIKdC2FM72
	 D+Oc9mnH6w6lXs142Hb8SL/o4fj+cShK53cDdnKsxv1QGe2vrjAfS6jUnyIoGgeCKg6ta
	 /V8779i1ifZ9fTSgeFUH+3gWpqDA/z7w7kFsMWEsA4S3fv0cUy11QwsvH6eu50J3b2RU3
	 GDLlHn/G9t8vqfSEUtPKPr1llCmQ+2Um4PhSJTBihoJLobMsyPa+1E3bfYS0kozwZKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	dkim=pass header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=aCVqtJKm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.45
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0F606A31A;
	Mon, 23 Nov 2026 06:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26E0F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=aCVqtJKm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjFOC77VBZeD4bO/hf/zS33JycAWWpkAH9Yv2WQ4ObNx1tSJh22Z5VtT5y5wuGxURtn2mYWYbgEW6cZ5ClasdUNFm0euwyE5R430ElH+AAXdLhY2L2LIaTTkt+WV+hzhuMx2tLGHnDzfNk7utyF+vzGhzX12l5kPcmpy/bwS6vijoHgRGou6QY+0RLUvcsU8kYL03R69B7HM0HXdbMO1DPoAKVcDyLBJ31yT1UZROkJXm4tYITlXSo6iHMAGH/vnGc25FRiOKFd0w24kgoeFr1fCXJ2vI5e3btG574CbXXh8QFmhw9Fxm90HrvkFsWVisCRJ/VOPom/U3CopuTbTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkirmmGBrHXOzWH/Xd1T0m9vDbCZfqu1QYXH+9sGfFk=;
 b=kp1yireH3KqD1MHdsj2TmECQgOpMOCnJ8bs6PE/Q8o+un2O817cqlow4q41lvt5lL3ewuJ/2hjQnl4P4QLbWuyOSYvMYPsfYN7Yi56kTZa8iKKE5XSCIaCH9Tzyri3s9TqJCECtezEMQ4DuIdJckDf4uTxpVh7hd5M5mJ0/1rz1VT5yUwT/B2LiWEGc6oUIQqPInDkVL0670kIuW4dzEmAx/69oeHc85CQzPKuD3ntfNhtRQlsxBJ0BfWzu4skr6eZOMqKNdEWpwDFZnQXfAM7Xv/WRCe6b6K/kd1qLvarCu8S6qNtQsc98VmHktLhBHBHXlonNLea1nwjPj1aQoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkirmmGBrHXOzWH/Xd1T0m9vDbCZfqu1QYXH+9sGfFk=;
 b=aCVqtJKmUy0SXnLcCUBvY9FI6dX8Ql/gWdQtNXWimuLrGqUm1H5+KIr0lBTFajYUh78d1pIN2WnU4NIyFswcHbubV+8AXF2X+vKUdq4eENpZnzLmxL/71jifOJ/fgvLOuL0h6aw0FIaIlP4nr4KbMJ8SdFvgzYZLyvQF/hhZie4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by BR0PR09MB492176.eurprd09.prod.outlook.com
 (2603:10a6:2c8:42::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 06:48:40 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 06:48:39 +0000
Message-ID: <d7665267-bcf0-4449-b036-cd168c1fce3c@mobileye.com>
Date: Mon, 23 Nov 2026 08:48:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] mips: {cm,cpc}: Make cm_core_lock, cpc_core_lock
 raw spinlocks
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Fu Chao-Ying <chao-ying.fu@globalfoundries.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-hardening@vger.kernel.org, Paul Burton <paulburton@kernel.org>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
 <20261119-i6500-cm3-pmu-v3-1-c86410934b51@mobileye.com>
 <20261120114644.VM_HFf9o@linutronix.de>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <20261120114644.VM_HFf9o@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|BR0PR09MB492176:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bf4bfb-5503-449e-95b3-08df492dce88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OZFz8YdxUj88dvSo/pGZ3EMyCoEg9T8EfV6gmMAaHnPB5YsMdYtaRlk1keziUxVYwKcGRnTyW/Ze3rANUfz4BEoyDtYTaWThSqRx5WqNP8/et+sYDNes8v/6n+EuxcqaNlPsJTQXWhgIwXOZ8x08+vppXc1zBKq6pP0GqIxwk7PupkBY/L+cymGEyNUzGAZk4O8FBfZXu9uLIU+fjqJuUE9iUtPqirrFD8PtRbz1i801GtugSUcA6HYJS4nEcWTpQ71ZvSpAxzEbW42vmXs584bKZlfg9JYhQbsf8lFIKa4JR/xVtz1ciGq40uCxRp4G9dzAIyDLLwL8gwLJHilEH9KgpLPz76OmNWx3vvW1oa87eAXP/FO1kQMvkgRytd37LhwBsFnljvcWRSLHMccokl51gZlXU29WNOnZ/CV1O4erZ3AP932yiYApEw4qq3UAPkn36WFRPdkXkcWvUcrGT35tsts1dVEfe7THVj7S0ihrD31dXGCp7s9FvKdrvjLkL+9KHQKaBWXd7ZSMC95zuXsuIjnOdjyOacafnCNi9ylRYSiodgNZRIHmDr3xo9b2uuQDEg5a/JaZ4+WIfjxaSLgBNnE5f/PFwogxGueP+on+ZLqHqD6l0pcaoZLgV+Ec+djLmevvnXqFRDp1DYdszjcw9VJN3sEXKvSOLbS9D4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDdCQVFPZjZRbVdicXNEdGFjNTNxUWxmeTZpODg4Zk5taUw3REczci9QS2Mz?=
 =?utf-8?B?bTIyZmVhRTlHbis0NlU5a3BFclgwVjVTMnFMdWdJRno2QW9vNE4ybW5QWWF0?=
 =?utf-8?B?SldlZVgrN2VQTVdSdTVuK3c1RUdXZFJTekJBWWtCTnE4a1Uzb3VlMkNua0JX?=
 =?utf-8?B?ZWpPZmVYeUpOS1ZQM3ZGekRYVFI2MkVnK1l0LzdXZExOTmJSVkdMUWlMa2xq?=
 =?utf-8?B?NFYrU1JGcTJRWC9iZlRpbVRNRkQ0ZjJOUExEZUEyT1dkUDJUeVQxMnhvYkFO?=
 =?utf-8?B?RFBhd2hDb2RQdFM0Z1AybmEwM3NWbWlCMDRESE5JNnRwMk1TMFJUVzRGbVQ4?=
 =?utf-8?B?V1h1N2h4N0FOU0JGYy90VVFjWlBlTWJWcm9adktXZmc0Qjl4REN5TGhpcTIw?=
 =?utf-8?B?cWgwLy9tRWRJSTQ0QUdJTjFFSkJUR1p5ZFFJeUtKRit6S1A2VmI1dmF5REdX?=
 =?utf-8?B?eTZldFJoV2ZJeFBYWnVxWHdMSmlIc3lURTJRVS9WQlNVeDQzNXpYVU1QbXV5?=
 =?utf-8?B?VisrNjZxa3p4ekJWYmpZSlpsODllS3l4Y3JjVXE1RmkvNTlDUFd5SVlzSnN2?=
 =?utf-8?B?QjJnNlAza2FxUWN3NEFaVjExUmxBejlTS2Q3SURXNHFMSXkwZzZ3RmF2TEkv?=
 =?utf-8?B?NUZBRkJ0NUlxTGpVL1FlaEtsYnIyTEthdkhNOHptZHlBYWlPU2RXRTB2eXEz?=
 =?utf-8?B?VDdtQjhnTjdqSG1ZM3h2cEZXN1pHajgzQnJXdkpPUWVDbUwxcjAxM2REUUk3?=
 =?utf-8?B?OUpscWNEUUdBS1IxREJVWm83aUh0dzAwUXQ4QUVMY05hTm8zQzFjelhDUFpV?=
 =?utf-8?B?SE5qcVViTkNPd2xCd3U1RnZaajAvYldsOFRXMjU0R0JmaUlNQy80d05DZDA3?=
 =?utf-8?B?ZStKYUNjV3VOVUhMV2JLSzZPV2paN0xrUTBaTU9DZjBrV1YrMWRxWTJhYUZ0?=
 =?utf-8?B?bW9BSkEwY0xOdE5zTHhPdnRXdGFHQm9KeTJGVmxjUmVtQ0tRamF3VjZ0WkFl?=
 =?utf-8?B?a1hKMDlGaUo3cUF4V29hclI5bWl4bDdsZ3k0VEhhT2xBZWY2V0cvVkhSaUlX?=
 =?utf-8?B?YnRPT2dwNnNNVWlqd1lTMTJvcDdIcnY2dkNnWjBqNGFEQkpRVzhXQlFWcUk1?=
 =?utf-8?B?aklYSXFaMVAzVC9IMERSWVFCRmZYY3lYTzhjMm5KSkZZSkxvL2FHOEdxS2cx?=
 =?utf-8?B?OU1EOWxPZGduQnBuTFFxaWlnMmlleXFKV0dnVWtONGNIU01pMUlpREg0K1Rw?=
 =?utf-8?B?SFA1ZmZRMkttOU5iTU5Qd3M3amNhbGIwV1RZNU8rU1JlZllRMklrR0NabDVa?=
 =?utf-8?B?eFFOek9rZkVXQWpkclUwRTZKb3RvM1hmMEt4aklYWndPWk13VVExdkVvbFoy?=
 =?utf-8?B?c0FMc0Qzb2ZjdzhyVk8venFlYXpHZ3NWSkN3czJxdWxPZ2d6WHdkQUo5VnMv?=
 =?utf-8?B?dkRBZE5teXcyakEzM2NGc3Z3dWNiRlpSeDRPRHN1dEdjb2xMalRpV2VNSGZi?=
 =?utf-8?B?NVF4Yyt5N043bnhZd1I5cXRBQ2NFODlCaGlQRkQ4VkVtT3lSRlZJZVMrY1F3?=
 =?utf-8?B?cUZEVzBiNkE1S0hvaE1oSStrWTBjcHRNZkNJQVp3ZmZqUUE2SWsrVzBKMkZ5?=
 =?utf-8?B?b2dRaFdVY1I4azBGU21GMWNrOHg4cXpnc0N0bmJuYlNUM2NRZHgrUUxGNGoz?=
 =?utf-8?B?UmdOZ1dUeXloRFhGeHJyT0hHL0ZZOFFiQ3JqQnZVQU1HMXhTNllGelJ1QzlG?=
 =?utf-8?B?QVBzeWxSam1FVGxlT05MYnJaR2luanRLb3BuTEx6cVlWQm1UL3pQMnVMb01j?=
 =?utf-8?B?SVNTa3l3UVVWVU9iTHlxM0ozMTRtR1JveWJHR3lqcDVKaFBsY1NpeFYyVndO?=
 =?utf-8?B?MkpEMlBUM0RuQVg1RTlLRWFFV2ptWThMMWxwNyt6bGJjYTdCMnJKYW1ZelU5?=
 =?utf-8?B?dmxQUm1EL1RZZWdKWjQ2ckhxUXY3ajNBcURNeERJMjl5VlFTSi9nemtORlF1?=
 =?utf-8?B?YUhrM3c3TEZFMDNudFVacCtxby90bjFkK3N4MlF5c1pXUFBYcHVFTWJKcTFv?=
 =?utf-8?B?dVpIQmlJWXlwYXprZFNJc3lHOTY2OTgwTDJMUHZqbVQvZjF4ZUN6dTI4VDEw?=
 =?utf-8?B?Mk1FUXBoakRvemF4MlM0b3FibjkweCtyMTVEZTVaeEFtcnIzOVVjNnBlK3hB?=
 =?utf-8?B?cE1Bd09yOUdqS2NPd3NNdy8yL0M5cXB1SDI1WUlRL0Q0WktjVk5GejlaVFUz?=
 =?utf-8?B?cGI2VkhrbCtVRW5HRm5uU3B1UXdmMVFzV1VJVlF3c0pSR1JWc2RPV3FRekFy?=
 =?utf-8?B?VXBadXg3bzZDQlVRM3FvUUxyY0FOSXNhQ2ZramtvOEs1T3RPcjFkUT09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bf4bfb-5503-449e-95b3-08df492dce88
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 06:48:39.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEg1SsN2F8wk/E8E0mp3lTwmW00Jd/h/CLLwrBc2i68eHVM6Um8GVXOr+YVmOaTXc3bvHo5+IhVwwG60JsCYYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR09MB492176

On 11/20/26 13:46, Sebastian Andrzej Siewior wrote:
> The perf interrupts should be per-CPU and not threaded so this is the
> right to do. However mips does not have ARCH_SUPPORTS_RT set. Is this a
> longterm goal? Otherwise it doesn't matter since without it set even
> lockdep dose not complain where it would otherwise.

Yes, very long term goal. Clearing parts that should be cleared

Thanks, Vladimir
