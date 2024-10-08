Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020128.outbound.protection.outlook.com [52.101.51.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907420ADFB
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411897; cv=fail; b=VwtnGbsmtH/pjzRKY0mLmy5RWFhb/nUdNoumwk4O58KrqClT861YmoMyCKywp1CT2uF1vqItCwd0dDF5NVJ5GjoxfczDfmV6+zOuguW7PFvVtCuF6TwPqnAJbPGqH4C721FfTCzxuRTof7M+lyKhQFDvfRvj7ExrVHhq7M5CTQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411897; c=relaxed/simple;
	bh=61LxgCpnPkZvN5R3t05xUn4Scbm43YNNTukUcyABtBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PSUdjCwBUAz14UqFrXDYLzEBxm1A+w+MVAqRfUumVQKNIx94d72kdHJlZMtzFxWAtp3v1m4Xs38Og0Th5soIGvGkzPuEmlWySvEW7t+XPGIatd8F9w2nBaSLaOo9SvxDnzApGQ3A0zsEDCgYdBeLDt7U1pTkdbQ2sh5uOyT0JV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jdUPOO91; arc=fail smtp.client-ip=52.101.51.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jdUPOO91"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyrMWk4hy1vquKGD+R7SON1PiuvvL1E0Wcz3Lqh9RpyHkRGHNWpaQ/xB8evVPGM4j1lZVjj+LqcejgZTDbR7p3biFp8q7D+F/LiikSRAGKvmRtwoAAJicN9YiD4O6YQMySVAMstgshHe0y1soFb5KFzVwt+y9CfVWVGwn2jZfmL8AZ8mUDXKs9tdu4CQuIpC8Gu/8xZnFKCwpXygW20D8UeXWxoZAIBu+d8lpPMlPMKNJ5JzQmMisorjYbT1TF1+l1qoX++GJe7Lbecpf9keFN9hxWMVVN7Gp7MNcyemnEwVvYNG0jf8TsYG4G3qvl0o+W9x7ktZdmkEuCXHc+mChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmK0rf1B9T9y91ZBKr0zWgTJRVX6Bjtyx/JS/VMV/g0=;
 b=ohYkBKTebMM3r3u87P7kfZBt2PzXEt0MHj/Juq8aMDhztYFLjXXDg+4G822AlTDVN+GZMZHS9/7M9Jevzo6ChlKhB6E/tjy1qzXhAcOu7ti6pzYYit34Z8vlFj7F5wnT1BxFY+iuSco9DgSVtlqKLgun0w7MNbEZgYisE06aJXm7KgvXheECb6GQ8Xg3fhOtxNmndJxlZwf5DECUMrEYYCLbm3CS9feP7RgskQgVEbcQaM+Uq6gwzH+wJZbBM/H10RgYUrNDo9NvI4EK768AlOpeb6AljOHYasEcdK5gHJ+KkvHynQAwSjrXgAcqUIcJE3pNP4OQo9UqH//arN7oUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmK0rf1B9T9y91ZBKr0zWgTJRVX6Bjtyx/JS/VMV/g0=;
 b=jdUPOO91HZiG7vYWhkzCB5gS+FFrWFqTpF4depXcHI1luVL5kNr5E57gH9heAH7e5c9sauKs+6YCzKepNQd9U/SxFuPU5UYw6g1NwXIr2Q+QqdKe23fK1nwAr4t+dJ6njP9hhwWPs/Vsbx+2WPI6N8bsG1fVF5vDr0mGDzk7AXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 CO6PR01MB7483.prod.exchangelabs.com (2603:10b6:303:143::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Tue, 8 Oct 2024 18:24:48 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%6]) with mapi id 15.20.7982.033; Tue, 8 Oct 2024
 18:24:47 +0000
Message-ID: <c2b1d122-83e5-4392-9009-2d22e59aa14a@os.amperecomputing.com>
Date: Tue, 8 Oct 2024 11:24:45 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V8 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: Namhyung Kim <namhyung@kernel.org>
Cc: leo.yan@arm.com, james.clark@linaro.org, mike.leach@linaro.org,
 suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <ZwTIbRbAX2EX31X8@google.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <ZwTIbRbAX2EX31X8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To SJ2PR01MB8150.prod.exchangelabs.com
 (2603:10b6:a03:4ff::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8150:EE_|CO6PR01MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ec1c4d-cbda-435d-194f-08dce7c67da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2lsRlhiN2Z1UE94OFpXUGVhSTF0b0hVbGhzOUZVMTlrRjhSbTBFTlBFNm90?=
 =?utf-8?B?NXFOVVFzZ1h1QzlYSWc0QjA2Zk5UZjV6L2c4S1ZkTFczbFBIaFJnVWhnYnFz?=
 =?utf-8?B?amVSaHpRSC9rVW5PUi8wa1JaRW40Y2crU2p1eVhLcGFGWG1OdENYeHI5NWJ6?=
 =?utf-8?B?a2FCMk5QM1NqSkI1bnhIS3dyWHRrUVFmUnBIVHpUQ3lqaGsvclV5bURUWGNW?=
 =?utf-8?B?c012bElNQWpyZHA2V1pTc2oyNk5BcnkxMTdlL3JkYzVxOGdJdHpucjMwSU5D?=
 =?utf-8?B?TzVQUXEvNURrOWRPeUdyYS9Yc3V4bjREUWxDc2o2blhqTUp5R0k3blhiQy8r?=
 =?utf-8?B?NXRQY1FTV2ZjUVdCeG4yWHk4bExhVFNnVGNYam5CZmNSUGY1MHQyQTMvMHpo?=
 =?utf-8?B?RHh2c3BjM2h4dHlTd0Q4UE5kSjFEdDh0ZnlqZVR1c2JYbXFVMWI2ZUYxU0tP?=
 =?utf-8?B?cnNQWmhLdHRIRGk5RVpock5XRjA1ckovZGFLMjFWajUzMVc4YzBzUml3SDdi?=
 =?utf-8?B?Zm5ibXRya0o1amFOekdKbGZtMUplNGYzMzZzQ25qNTFTdi9QbGFTYThiWVpT?=
 =?utf-8?B?dmVGL3A2OStMTGlVTWlWZXRteExCY3dIcG5Ud3RxOVVqcU93L3NUcHl2anBj?=
 =?utf-8?B?RDdVTm5IN2phdjRTRUpISGNrV2ZkV25tT1VKNnNqK2VidElha2RHRGRtNHJC?=
 =?utf-8?B?TElTWUhNK0I1RnhscEMzTmNFKy9OaHZoVzNhNVdQUXN6NFBkQVZWUWVVNytX?=
 =?utf-8?B?Z3hqNzU2YldpY2Nadm5yUGxkVzIzSEQwSkZXbzJCN0lpenYzSFp1VmZXMGVB?=
 =?utf-8?B?alA0OWFzWTVuZHBlN3VNZnBPUlk5c0Q5aEtSLzA4YTUvbjA0Y1pRbzdvSHFo?=
 =?utf-8?B?WFBwM2xuV2Qyako4VEpCcUR2YmllSDJ3UTIwcThhUGQyZWI4LytpcE9YYTN2?=
 =?utf-8?B?T2xSaStqUHp5RHdHSWhIQUgxbEx1TExkdXUvcXl0MXZvcitUKzhUTVBRd1Va?=
 =?utf-8?B?bmpza29Wazl6R1RzdVJDUjNuZE9DUTgrK1UxUjl5dkRDZWhqWWFSRFVsTWI3?=
 =?utf-8?B?YmZsZmEzMW1keXRMU0M2S1JGM3BDeWJxTVF6bGQzdVh4QjFlb0VxTHNwalcy?=
 =?utf-8?B?STUrTWNNcjlSSzQ4d2hRbEdZaXlNYlpkZHZwaTRPNGhidDEzeFE0RktwWlht?=
 =?utf-8?B?bUt3cUtWTERnWGZOWlBkK2w2TEMybjZSc1VYVnppdWt2MVBPTGJLaTNVV1NX?=
 =?utf-8?B?dDBrOVEyOC84S0NjeXJCR08rNFFqNjN5ZEZlZWNJYjQ3R2dQRERXcTgvaDB3?=
 =?utf-8?B?ajF2NCt1SFpBTU9qcG02dXVnYUF2VXJnNjBkaDgvSWp6NmpzVDk1TUhOUWFs?=
 =?utf-8?B?TkRoVGhsblBoM214bjR5UW93WmpzR3d3SVlYYTRVTEtPb09ua2lWTStyZU9B?=
 =?utf-8?B?Ujl1clUzQ3QwVXY1ZmpwRTNtYkxubE1tcEorK2pwaFRXQnB0RTViWTNnV1hW?=
 =?utf-8?B?TDdMQkRLY2RnZE50bDIvRFo0V1pTckV1UGdtQlVNSTNhcE83NDBEbGVZV2lK?=
 =?utf-8?B?YmUwTC9UcUtMYnM3YW5RdGJ0TUc4Z0pqbHJwUTF4SkY2eEpBczBET0tWaDJ4?=
 =?utf-8?Q?aVkxnnARgkdnsy7xAxkWO7QLibxf6XOscRwf7dkkpiB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3kzUGR4MXFlV25ETGF1SWNzVjhJVi9EMVJTekZqR09nMmxHc0JJRFAzU21k?=
 =?utf-8?B?a1c4Njc1dlVjSENGZTA2bGhzTzFLNUo2Y1JEUHRTelFJVitUaWVIcy9aWXRw?=
 =?utf-8?B?dkhlblVXcWFTOFJwdVZvampzbHVWS2VBTlU0ZWFpSHdIc3AyMEdjSTVaVy9q?=
 =?utf-8?B?WGxOUXg0M3VRN1kyMEZ5a05ZQXdoR04wbHhYWGtId1JjRnlQdy9qUnk5WjVZ?=
 =?utf-8?B?bkpwYWRvNWVDWWRmOEt3RlJXUDhzNmFTYmVJdkdENEdZeE9tT1dyTE01d0tP?=
 =?utf-8?B?VDMvanJLRTdYblRFSDZDN3dRYVgvNWt0U2owdkJQZS9HaVNyQmUwWXo0R3dY?=
 =?utf-8?B?U1IyeWwybU5hTUhRWXpBOUR1R2lCVWdLeG5BejlPcTE3M1pJY3NWam1HVjdN?=
 =?utf-8?B?UnBzS3ROOFg1cUdnWE1nYlUxM3F5R3JBMWprRnJrcEpHalVXeFNuQmdSL0FU?=
 =?utf-8?B?ODZOWlJ1ZWlhZWFRd1A1YmRXWDh3UnhFNWFGM0lwQk1BZ0Z1QVRoeVJ4aWlW?=
 =?utf-8?B?NmxqRUQvYVdua0dObERnU1dPdExQZldkY1dmaFRiNnMxU01sQml6aDB2Y1Mr?=
 =?utf-8?B?RTlEMFRoRDYybit1eEkrMWhsRDJMbXNIOGFVSlA3a1JGTzZaMjNFMG16UFlH?=
 =?utf-8?B?d1dlN1JYeUloTUVGZm1LSEN2WHdEZjl5b2h0cFJxd3hUclprTzkvdStSSS82?=
 =?utf-8?B?c1hJVXpnTURNSkpDa0dmRHJjYTVjNk03ZWhPdy9PREpicHFMaEdZM0xGeUFX?=
 =?utf-8?B?OVlhamo2VkN0V0xsa08zbVZTTHhKa3VrQkdmZUpBZmFXd2V3WjRrR2V5MFdr?=
 =?utf-8?B?Z3l0c29hZ0V0VTJaZXZQOEhYOFgzdndMMTRzNFV5OGZmWTBxbTRCajhPRTlh?=
 =?utf-8?B?MmJmdUJld3ZtKzh3eEoxQUl5TUxxREw4cjVSZWE0NUREZmFPNDFxLzYyRjVi?=
 =?utf-8?B?SDIrbE1ia3NPK3IyTzR4YWNPZ1BFNnlXcFk2NGQzQjgyY3VlczNYZmhsL2Iv?=
 =?utf-8?B?WnZHa0xTdFk4dUlReHhmTytFRjRMMGtBM2V1alJiM3U1aDNBRVphY2ZsRmhY?=
 =?utf-8?B?bmVNMWw3ZmtLdWpjb3pEdHpyRXpNeWh0citncTJ4bVJIbGxacFFLVlRCS1Vs?=
 =?utf-8?B?aGN5QTQ2RnBEU3RlU3RqMGoyVitnN2cwYlNoUGZZbGErUlVZK3pVdytTUlN4?=
 =?utf-8?B?cW16MlNxaTNHRThyaURxZ1dtdVlzc3RlRHJ0ZXREYlhldnFBVDRJVWo2VUdN?=
 =?utf-8?B?NXRtRzArV2QxZ2QzRXA5bEh4Y1k4Nnc5RVZCQUF1cXZ1aVhUL1hTTjJlN0VF?=
 =?utf-8?B?Z01OSnhPU3J5UXh0SFRzZDNBYVBMSTZmbStJVk9OaHcxUE1SUWRIUnZHUnNB?=
 =?utf-8?B?d0VHVjRQLyt3QWI2WWczZmdXRTE2VmE4VEljZ0R3U2Y3dTNxRGt3Mmo4Vi95?=
 =?utf-8?B?dzRkUDAvdWFOWGlZc2QxVkdXdnhqU1p1NTY0clJMajNTSTNvTjB2NmVvWG1t?=
 =?utf-8?B?N3lFMXZzK3hNSkRObjBuY0lFTTlNMWFtRm55VWtqOTgzNjYyblVFMG1LeTVS?=
 =?utf-8?B?QytnSVRlOHl0UU1TT09jMzU1c2VHejNJWUIveHluSHpYZUlWbFRuUms0bkVn?=
 =?utf-8?B?cHBMRFVQSHkyR3NxM2ZEekhZNWlRRVhDZlAxNHpZL1VsYlZDQzd4ZGh3SHoy?=
 =?utf-8?B?c1E0TGZWNytLaEF3OG5SbVg1TG1mT05xblBiNUV3dWRaUnZkZENlTGZvTDRz?=
 =?utf-8?B?M2FRaFc1NlZyeFVCYllwUmJjYzlLOGxBQmI2MzhBSzZ6TjkxOUQyU3VCaStK?=
 =?utf-8?B?NkJzT2hncjB5MnNPemJPdEcvNlI0REU1eUNyL3o2Q1ZOblkwVEVUWHFQZGF5?=
 =?utf-8?B?a3h2RUs2QXNnNUFQNEhyNlpDSzdYbE5yaFYzSEpFTDlxT3VhbGFQclo1SGJK?=
 =?utf-8?B?b1huNkphaU0rbDM5UTBwUitYMnJhQ3lSbkdBRzY4NW5Jay9tN3haVTBRWVNx?=
 =?utf-8?B?SWR0TStrYk11cUxTQVZQdnVTWDNlY21lTG5hTjZCS1Y3dzI2QkhTdW9icDlD?=
 =?utf-8?B?ejVLQitoS3Z6eXk1WW5ySmhhd2FPZnNZaFRMZjkzWmlkNTNGWnUrc3lvNlpL?=
 =?utf-8?B?RFl0UUUyR282bHFwTGF1OUtyQ1IwN2c0dEZzcVZVUUpwYktEYVZuTVVRMlQ5?=
 =?utf-8?Q?3Sd/S2vs4LJzRigkRbVT4Fzjsaa50sBQoKanQvX96AVG?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ec1c4d-cbda-435d-194f-08dce7c67da7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:24:47.9260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy2JuEpFNPOmnADqyxQ2/6arrDAzM9TKsV6fUEqYmtTFnwE1AneicxGU1uQrSNPhuC94QeNo5nOjbVk1RsptyNz13JPWXOMVfl9mZVvRZcxdKnhumomwUaZFn5o3AbVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7483


Hello Namhyung,

Sorry your question is so late. I don't include the ELF headers here,
but the problem can be seen with a perf.data packet dump of user
instruction trace capture. The problem is with the non-zero pgoff. The
arm-cs-trace-disasm.py script was never passed pgoff information to
adjust the start/end disassemble range passed to objdump. This patch
distributes the fix between perf and the arm-cs-trace-disasm.py script.

Here's a brief excerpt from an e-mail I sent to James Clark describing
the patch before I submitted it.

Regards,
Steve C.

-----------------------------------------------------------------
.
.
This e-mail is to document what I know and don’t know about the problem.
The background is Fedora 38 introduced non-zero text offsets into common
shared objects and executables (e.g. libc.so.6, etc.).

If you were to ‘perf report --dump’ the perf.data of a user mode
instruction trace on Fedora 37 and grep the PERF_RECORD_MMAP2 packets
you’ll notice all zero values (@ 0) for shared binary and executable
text offsets. Repeat the same for user trace collected on Fedora 38/39,
and these text offsets show as non-zero.

Fedora 37:

4294967295 18446744073709551615 0x8ac8 [0x78]: PERF_RECORD_MMAP2
2389577/2389577: [0xffff85124000(0x42000) @ 0 103:04 805306555
1941233998]: r-xp /usr/lib/ld-linux-aarch64.so.1
4294967295 18446744073709551615 0x8b40 [0x60]: PERF_RECORD_MMAP2
2389577/2389577: [0xffff85161000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
4294967295 18446744073709551615 0x8ba0 [0x68]: PERF_RECORD_MMAP2
2389577/2389577: [0xaaaab09b0000(0x10000) @ 0 103:04 1140851919
994218038]: r-xp /usr/bin/dd
4294967295 18446744073709551615 0x8c08 [0x70]: PERF_RECORD_MMAP2
2389577/2389577: [0xffff84f70000(0x1a9000) @ 0 103:04 1677721733
3891973508]: r-xp /usr/lib64/libc.so.6

Fedora 39:

4294967295 18446744073709551615 0x8ac8 [0x78]: PERF_RECORD_MMAP2
18229/18229: [0xffffa5512000(0x1d000) @ 0x10000 103:04 161 4093340249]:
r-xp /usr/lib/ld-linux-aarch64.so.1
4294967295 18446744073709551615 0x8b40 [0x60]: PERF_RECORD_MMAP2
18229/18229: [0xffffa554f000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
4294967295 18446744073709551615 0x8ba0 [0x68]: PERF_RECORD_MMAP2
18229/18229: [0xaaaade7e0000(0xb000) @ 0x10000 103:04 536876423
421616320]: r-xp /usr/bin/dd
4294967295 18446744073709551615 0x8c08 [0x70]: PERF_RECORD_MMAP2
18229/18229: [0xffffa5360000(0x11f000) @ 0x30000 103:04 536873199
2415801053]: r-xp /usr/lib64/libc.so.6

The arm-cs-trace-disasm.py script never gets to see the text offset into
the dso binaries, so has no opportunity to adjust the start/end address
range passed to objdump. This wasn’t a problem on Fedora 37 and below
since there’s no start/end adjustment for a zero text offset. On Fedora
38/39 distros, the instruction trace shows unconditional branch
instructions which do not branch to the target address, the clearest
indication of trouble.
-----------------------------------------------------------------

On 10/7/2024 10:51 PM, Namhyung Kim wrote:
> Hello,
> 
> Sorry for the long delay.  But can you please explain your problem in
> more detail?  Showing ELF program (or section) header would be helpful
> as well.
> 
> Is the problem when the text mapping has non-zero pgoff only?  Is the
> kernel symbols working correctly?  Or is it just the Python script
> broken?
> 
> Thanks,
> Namhyung
> 
> On Mon, Sep 09, 2024 at 03:30:02PM -0600, Steve Clevenger wrote:
>> Changes in V8:
>>   - in arm-cs-trace-disasm.py, ensure map_pgoff is not converted to
>>     string.
>>   - Remove map_pgoff integer conversion in dso not found print
>>     message.
>>
>> Changes in V7:
>>   - In arm-cs-trace-disasm.py, fix print message core dump resulting
>>     from mixed type arithmetic.
>>   - Modify CS_ETM_TRACE_ON filter to filter zero start_addr. The
>>     CS_ETM_TRACE_ON message is changed to print only in verbose mode.
>>   - Removed verbose mode only notification for start_addr/stop_addr
>>     outside of dso address range.
>>
>> Changes in V6:
>>   - In arm-cs-trace-disasm.py, zero map_pgoff for kernel files. Add
>>     map_pgoff to start/end address for dso not found message.
>>   - Added "Reviewed-by" trailer for patches 1-3 previously reviewed
>>     by Leo Yan in V4 and V5.
>>
>> Changes in V5:
>>   - In symbol-elf.c, branch to exit_close label if open file.
>>   - In trace_event_python.c, correct indentation. set_sym_in_dict
>>     call parameter "map_pgoff" renamed as "addr_map_pgoff" to
>>     match local naming.
>>
>> Changes in V4:
>>   - In trace-event-python.c, fixed perf-tools-next merge problem.
>>
>> Changes in V3:
>>   - Rebased to linux-perf-tools branch.
>>   - Squash symbol-elf.c and symbol.h into same commit.
>>   - In map.c, merge dso__is_pie() call into existing if statement.
>>   - In arm-cs-trace-disasm.py, remove debug artifacts.
>>
>> Changes in V2:
>>   - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
>>     checks per Leo Yan review.
>>   - Updated mailing list distribution.
>>
>> Steve Clevenger (4):
>>   Add dso__is_pie call to identify ELF PIE
>>   Force MAPPING_TYPE__IDENTIY for PIE
>>   Add map pgoff to python dictionary based on MAPPING_TYPE
>>   Adjust objdump start/end range per map pgoff parameter
>>
>>  .../scripts/python/arm-cs-trace-disasm.py     | 17 ++++--
>>  tools/perf/util/map.c                         |  4 +-
>>  .../scripting-engines/trace-event-python.c    | 13 +++-
>>  tools/perf/util/symbol-elf.c                  | 61 +++++++++++++++++++
>>  tools/perf/util/symbol.h                      |  1 +
>>  5 files changed, 86 insertions(+), 10 deletions(-)
>>
>> -- 
>> 2.44.0
>>

