Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023078.outbound.protection.outlook.com [40.93.201.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A651DE8A6
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937097; cv=fail; b=V1UdYF84SwaR+mS0gSGXCuuptAawS8rBbVMa7DNlLMxhvnjPMTU5Q/mpnQUwHlI/XNl8AHKD9L1kbzOS2gR1zTfJtNGmZbhuyv9jRqubp2DrpufegXzYt7zo1Z5lzPlq22W0ivTwOQUlIGPCs8CsLvFCk8LsN4rMHjYtI7W66TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937097; c=relaxed/simple;
	bh=WNc7f1c4vCkyIiIKueYqNOXTNraE5DU7SCBqSMMEz6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vxmz++tJlHzFBvwLP5v8z8ZrE97IeJLWuBwyPUq/fKa/is5yrpHV2+bQrWmkhMHPITd7PwErrlUKZllgdUqhvrIjO+iiMSyt6jB1JsxftdzlihhLIpoNAo84H7kmkrclF2/RowFKgk43A5EdseqkKisB1nmIETeJcnh9mqpenZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MikUQ2Gj; arc=fail smtp.client-ip=40.93.201.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MikUQ2Gj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoctPbeX4mtHS943cHjgkTpbRWIZyMTHQvKJpp/KChE4raHER2GoVQy/3WbcBykJqvUj/pkxOj2xg743BJ2X932FSiGNHvkrvBPvFby1nBTj7359tIqNnFc71Gu7CBjBVZuGokicQJHgJoeDamc0RyQF73ft1SiF153Wiu3+sB8GushKCsUnjhyQVRn9GN+E5T3c4E+LBLI24Vi5AQ3yZpVSqzH2mpGBIVPM6KQ/Y2QzY70LA8ARRD+DWRNQOJp697jeOdrjdwOAD9E75tMRYBv2938xMUatK0v1YnMd3UVX655GCKveWAv5Reyq1FRu9bTxk3Yb14p4QI//oTCOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOO1qVYCues0e8+cZFU+gLopZinUMHkaTDINMMJjlRQ=;
 b=tQ2TJyaLyiScgSvKt1c6AODDURoekBexwDynnHz72s7SVGeYs+LUotw7bP2V9iGJHHgXAc/DAsU5zaC41OLkH8++nXmbHQZlMbMpVsaNJGUd2SDmCITEVZMWj0Jo4qosQN35pKI3LATUIfZBQsO157pkOJxtLB2Ph61KzI202H9A++hGh0IYNvgsf4/S8vtEl6ZscJObf7tPNWlGizfJy+p1ouzhzmQTueLVaoGulsXYETXKZHtFhOr+a+4sBMP/SQSRmDML/656IYxZgTSKllTp53V6wCtca8o7q1ft0fldqzoR1yRz3T/q+d4WWLnxgEyM+tDgHdWUgN8qw0dNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOO1qVYCues0e8+cZFU+gLopZinUMHkaTDINMMJjlRQ=;
 b=MikUQ2GjieStwi3U1UM2UFmsEZIZAIFhB76Jme4fMTUgeKl4o22ukmLE0+v/uibUHuB1G0nGnpeY2E/q1R1loiqS7qW4gQmgCyuWZxnBE62o5BdegLW5v33EWD87Kqt6MAbWwhqN+X1YFXfKbg9tWONwsAuQst72mH27EM0i/oI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 LV2PR01MB7549.prod.exchangelabs.com (2603:10b6:408:17f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Wed, 6 Nov 2024 23:51:30 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.8137.014; Wed, 6 Nov 2024
 23:51:30 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	namhyung@kernel.org,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V10 RESEND 2/2] perf script python: Adjust objdump start/end range per map pgoff parameter
Date: Wed,  6 Nov 2024 16:51:09 -0700
Message-ID: <6107521c4fb1d4ba2da57a6d81c17b54f259feac.1728599785.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:59::32) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|LV2PR01MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ce2ff6-ae92-4370-1178-08dcfebdef95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFZJd3hUNjVZbVhIMGhrb0ZxYjVTNno0M2pYMTU5VGExcVRSVEorL0gzZXZl?=
 =?utf-8?B?TE54UXpoZVJHK25kMEUvdUs1eFRmRWlna3IxdHUrWmpYSFhTMXpJSFdianFs?=
 =?utf-8?B?WHpjaDRqV0h1MjNWM05xYXZQRHdQb01ycUdBbllETE1aQ2JQYVJZQzEvcWhs?=
 =?utf-8?B?ZlNHQ0E2dE1GV2dzZnMrSFkvK2U4Y3JMVGp3UjFFZngyQ3V2RURsTzdBczJE?=
 =?utf-8?B?dC8vQ0FUSmNsNlJvRVRCc0IvendVR0pFRnNqNzZHQ2JZVTFpMyt1V3JMLy80?=
 =?utf-8?B?UjJKWnRHVjE4L1d4SlRrMTV2dTN1Nm1vK0lpS1hhbVlFOUV4VWU3VE9rS1py?=
 =?utf-8?B?d0VkYUdERTNTSkhtVEdXWnkySGxhbFlWUWxMeGk2VzRwRnBNOUR1Zlh6KzFN?=
 =?utf-8?B?Zkx4Mm5RRTNQektPVTBvd2lZenFEcW5OT0NRYjArUEdLTjNxQmxqWjhURm5y?=
 =?utf-8?B?TTdJTlk3U3ZGZzROdkx2c2ZLbTUxVTVvbE1kUFFKekNiaCttSnJWeHdxN3Fz?=
 =?utf-8?B?am5YQzNRSWVkTzh2azNNakxLNndCWFR3ZWdzd1VMR0tlYm1PSlF5OHBEaEgy?=
 =?utf-8?B?UGovRmgzR0t1WmZMN2traTE2Z1k4eWZ0MzMvMVpaOFRrYjhIYUhCNTN6NEJP?=
 =?utf-8?B?d0w0d3dSdGVqQlhjN3JINmRUQ3BJSkQwdmNJT1U3N0pDNVlyT0YxRk9wNFdZ?=
 =?utf-8?B?NmpUVmh5a253bUNTcU5HcU0xbU1wdXBySE5tSVg0aVIyL3RvYkgyb29iNXVa?=
 =?utf-8?B?ZlByZndqcEM3UHFmYXdtRHNWcG9Sa0dub2tDV0lyZ0RrRDdLb0l3NEV0V2tM?=
 =?utf-8?B?V2cyZk9LVFJLMFU0MGk1UWVCQmJlVTlMSkJ1Qm9oUUNVRm85RkJtUGlsMU5F?=
 =?utf-8?B?K2NkYktjRno5SnhiVlF4bHNueEFrUXNtWi9QbG93SUZyRDBzQ1VOdXhpZHNu?=
 =?utf-8?B?dG1ValY3Z3lzcmhudXplcTVFc3NHcjJBSlZ3VkQxaXVneWRNeDBVZ29veW5z?=
 =?utf-8?B?cEVpTUVkTGFJTXducVJhSkpLT09EWTJmWE9mczZRNWRFMW9kRzJLWXZkR0Rs?=
 =?utf-8?B?NDN3dWJpbjEybHhxclVmZVBGNGh1K3ErWm5tdDBuR1RlSDNWOGlOUUNrWFhJ?=
 =?utf-8?B?VGVCVGhmaEdnNHJRZW9Sc2xndllPTmRVQ1VOWmZzNlA5bllBUGdoK1ZSZG5S?=
 =?utf-8?B?bHJFd1VWc0dDL2Uvb1lKQU1CQms1UHdyOHVSNHh2eVU1eW9HZEhjTTRvaWlT?=
 =?utf-8?B?NWFsYVZUR3Zrb3BvL2JnYlo4QThqNHZ0Q01EN0Jidm9oM3F1Q1VHbmRrV2Nr?=
 =?utf-8?B?d1YvcU9tTkhYaXpOL2RLU1FFS0xRSUJ3MDhZUFFZSGVVM1lEMURkL055ZVlD?=
 =?utf-8?B?S1FKOWIxWVFLQ2JSWUlmMy9sejI4cTNOY1c5Vmpsaml6NEFnTHlURHVlUW4w?=
 =?utf-8?B?RmdsWUgwd1BCSzhkZU5GcndKZ3IwUVdFcHZPbHErVGVsL0w4cG95M0d1NzdM?=
 =?utf-8?B?eXd2UkFlUkJCaFhVTEh0Mk85bTQ1WldleDU5N0pDZXozZzg4dUhtS252Mjlh?=
 =?utf-8?B?RWpCRDVtOUNWblFIMDdzWTJQbEREYXhmRTFuM1RHZWJKMHhETlA5SUNKVUMy?=
 =?utf-8?B?b1cxcHBqWlBvZGxGL21HUm1lMk5DTWZoTEMvZjJURDk2NVloQWRxa2VhaGU3?=
 =?utf-8?B?d1BVUFBCR1BNNlBlalBBKzlHT04zZFdydUFxZEJIbUlXQUNZVnVRT0t5R3Fm?=
 =?utf-8?B?ZWt3NFcxTVB2ZEZETUxwRkdZNTRnTk5GZi8xeFVnR2gxazE3N0dOaUN3ZCt5?=
 =?utf-8?Q?fSNRcUffSlkiKobkpIhUrLiTgOx+Wkm+8RYCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3U3bEc5b3QvMUVRZzF4a0Vmd0RLUjB5QUxwRDRSckVBajNyWlJ6T093eHpk?=
 =?utf-8?B?K3hLdmRnK0FlSnZMVU91RTlSVVNackdYU1FsYkdRYW10WFBydEdzVjloZ1JC?=
 =?utf-8?B?dDVVaFZ6NVdZMklnaytTYzUvZ01EMXBGdXRyc3hvbVlCMTYrUkN2cnYwdjRX?=
 =?utf-8?B?cXhPWllzaWRFYUo3c3JraUR4U1piTlpTNlNZZkRSK3VoSSt4dEZkZkhBckJY?=
 =?utf-8?B?bXhHMUFNcFBPVmZxTndWTHVaTnQ1alRJUVJ3aVA4eUhWdytqeGZMbGVqZWd5?=
 =?utf-8?B?bjNra0pKWURrRDQzcVdBU3M5U2dQbll4bDJieFlKWUV0VnphWElkNW5XVG9M?=
 =?utf-8?B?enFTNDllejRJcVdXZDZBaTlRdXV1QWVQSlVKK3lWU0FUaFRtY29CNDJoall4?=
 =?utf-8?B?VkgrVGRCSzNieFR5ZnY1d3Ric3RPcUJOVGFvWjVyQWwrbXF6QVpIekJLbCtF?=
 =?utf-8?B?WEk1cFU0NldSOXpXVzRCMHdXOThJVGZIdWFYYno1S2RqV1piNGtwSjhtNlhs?=
 =?utf-8?B?ek9VUEFBYzc4SWZQRmxXNmc1a3dhdDlyUFNpQzVNSFZWM3d1MnFBdUVTRmsr?=
 =?utf-8?B?bDUrT1g1ZkhpeDZ3QlI5UmZZZ0JLZjhOaUI4NEVteEpOUjM0d3pydHIvWGZ3?=
 =?utf-8?B?UmpuZFY1ZjNYbWpzR1FwaU5Ed0NobWVid29RVkJBeTZpVDRwZDF4MGIzNC9N?=
 =?utf-8?B?azl5T0lpZkN1Z0hjU0tMWnFacGZFZmFSMVZ4My9JUkFWSzFxUmNuUVRBcnhw?=
 =?utf-8?B?SnRrTXg5YUNVcDQwMWp4Vk1XMGJzS2xDRUVGbklFWWh6YnB3b1pLM1o3eUI0?=
 =?utf-8?B?K2dyYzJjUkNoNWVNdnRzN0gyNXJSbm9ha0pxTFcwbjVCRlBQUHg3cnNpKzlL?=
 =?utf-8?B?SXNEZkxCTllFaDVadk4zelR4RzVubWFBNVcvdkRMRWZvWUtYak56WHQyZTB0?=
 =?utf-8?B?RlRHa2RJdzBhZU5aZWVuWnc4MnFkWThIR0pmUWszclR0Z3lqTkMxZGs3SnhV?=
 =?utf-8?B?NkNORi9NYnN2a0xsQmxGUUpuQ1N0MVlyZU1Pa0FIQnB3TXRKMDk2TCtpb3ZS?=
 =?utf-8?B?bDQxTkNOQW00OThwNExNNm5xSXI5T0ZpQXVjeFBuelN4WjN6UnFHY240WVpM?=
 =?utf-8?B?bk9RNVFITjN0Z2R4Wk9lSERsaEttRDVWOEhNTFEyNzh1Q0dkelc0WWtiNzBx?=
 =?utf-8?B?Nk41Q3gxblBROGRtSW1FSlYrMmZBNEdmR1pidy8vdGN2UUR6czFvSHBFUEQ5?=
 =?utf-8?B?ZXpZT3dvYktyRXY2U3IzU1FLNy92TS9iK010aUxyRlRVMVdhRE95S0x6bnpk?=
 =?utf-8?B?SzFMUSt6eWRpYkpLUXJjUyt1WXViQzdseGVpVHpLOWJMa2JLaXBUdUxwN0Js?=
 =?utf-8?B?Y3VUV0pBZXNtNlB0c3BrRi9wRk4wY3VGT2dqNWVEOWhJdXpRTWd2clFLQmVV?=
 =?utf-8?B?cWRyWDF4QVdJa29TS3VHTnl2UjhBWjJyMDl3WEtiOWk2eUwwL04zNlhqMXBS?=
 =?utf-8?B?cmtRaWRTWC8xbGJaTGtGelBBMDZvRlYyK2lFVW1kSnFwaStLcldPNnI4ZFRL?=
 =?utf-8?B?cUptM1FMRHlsVy9LbGpLcFV3aVFJSkpGUnVKelM5eVJNV2NFK2VOZlpoLzJk?=
 =?utf-8?B?b3hzeXNnN1FQUEVOS3BHOFhwS2FhZFJiRkVsdlNaRmwzWEMrcW9Cc3NmNWRj?=
 =?utf-8?B?d2xEa21hS3ZHSWRkVS9Xems2OTcvK0tjMjFoUGFuQWtIRDNJSkNhdUdzRjEy?=
 =?utf-8?B?QlFNclVPOFJydXNYY2dYRHZRU1JHcERYNzlxVDJaOUNJaGMrSkZ3REdUSG0x?=
 =?utf-8?B?amdOT0U4OVZnd0xpOWxrMGNwbTFEck9YRjk4Kzg4ck90VUQ5eUpQcE5LUUZn?=
 =?utf-8?B?Nk1iK0V3NWY5Q0lWSzZVRGtGckgvT3pYdzd5eGZMWG9NZVpXRDJRR3RTUmpB?=
 =?utf-8?B?cklidEVPZVVqdElySTJ1MjJmUlY2WVBoMzhDRUdZemZ2ZHVuRTR2ZVAyZU5z?=
 =?utf-8?B?cEE0NGtLRDVQRkVSbUR0YWVGTndRakxDZzE2ZVRDZkRDdWtTVGJlVDkrVkhX?=
 =?utf-8?B?YzN0cG5uUmZyY0dqa2xVN1I2bEdXZlNKZ3gwN0s2ZWR3UWcwa1FJaWpldVlP?=
 =?utf-8?B?MkE4QzdSZGhjMGo3bkpPUGsvN21MR2lYQzk5TURiU2ROQzhpZ1JGaGFiQld6?=
 =?utf-8?Q?drZy+RGuTzwY82WGYAE/ZLi988rQvS7/5SUiRwVGJ/XR?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ce2ff6-ae92-4370-1178-08dcfebdef95
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 23:51:30.3229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTZbxpBgshmZq9XdFjLVJYsK9NKsPx7IgnRg6iCHNGreDV6DwpSA6CiSvVjxyyATGPQeQbbrb6S7TtDFI3VcwXlXkg51qBUciU332hUIFXzg55oykiO8WUW6tuBvxFf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7549
Message-ID: <20241106235109.9iMf-BLvszE2JAwG-st4K70M2_LpLVwwDtv1ZiRlj_c@z>

Extract map_pgoff parameter from the dictionary, and adjust start/end
range passed to objdump based on the value.

A zero start_addr is filtered to prevent output of dso address range
check failures. This script repeatedly sees a zero value passed
in for
      start_addr = cpu_data[str(cpu) + 'addr']

These zero values are not a new problem. The start_addr/stop_addr warning
clutters the instruction trace output, hence this change.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..e29a4035723c 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -187,6 +187,10 @@ def process_event(param_dict):
 	dso_start = get_optional(param_dict, "dso_map_start")
 	dso_end = get_optional(param_dict, "dso_map_end")
 	symbol = get_optional(param_dict, "symbol")
+	map_pgoff = get_optional(param_dict, "map_pgoff")
+	# check for valid map offset
+	if (str(map_pgoff) == '[unknown]'):
+		map_pgoff = 0
 
 	cpu = sample["cpu"]
 	ip = sample["ip"]
@@ -243,9 +247,10 @@ def process_event(param_dict):
 	# Record for previous sample packet
 	cpu_data[str(cpu) + 'addr'] = addr
 
-	# Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
-	if (start_addr == 0 and stop_addr == 4):
-		print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
+	# Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON packet
+	if (start_addr == 0):
+		if ((stop_addr == 4) and (options.verbose == True)):
+			print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
 		return
 
 	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
@@ -262,13 +267,14 @@ def process_event(param_dict):
 		# vm_start to zero.
 		if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
 			dso_vm_start = 0
+			map_pgoff = 0
 		else:
 			dso_vm_start = int(dso_start)
 
 		dso_fname = get_dso_file_path(dso, dso_bid)
 		if path.exists(dso_fname):
-			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
+			print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
 		else:
-			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
+			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr + map_pgoff, stop_addr + map_pgoff))
 
 	print_srccode(comm, param_dict, sample, symbol, dso)
-- 
2.44.0

