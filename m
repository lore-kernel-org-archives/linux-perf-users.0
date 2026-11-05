Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897331;
	b=40j0b+D7pfr99qVXM5eBWlF0q8tz670UNvSlwSLpq7K9E5I+2g2+JKD012F4nttHfi4W
	 7oQNk+72i5r1M2ULMyagDn7CMRyChoqa1C2cI80QmU1ORjWtc7j5rnaKuZpzdOEX3WPlH
	 LOCBsBo2+cISrj0QooXsb9SjA1UEQrQWH0HtztiwcF1/kHz4EPKDxOEl0YWLYH1u7y7Sc
	 CY+oQ8cA/f5qViXobGeC1JedXsjBnMpdRsWNnGqxBX8Qy134J4gjusDF8C7PvrvB1j4Qc
	 /TtaCCJsqkh6KbA9QMUPGnY2O/LIvAoZUZ7hdHNjnA4/UGmhSYhze6LYFVkIX2lvWfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897331;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info;
	bh=Es5TNEi2aSp5OhhvFZ7RQ4rETmyJ+9dSxDDw307UkaY=;
	b=MSuji2Eulf3KxwodLD/K4MhXHjPrewETJMCAOYGlcAquih8gD3hkkejucg55qLgdYGzd
	 o7rHkNxGPeMEFxhLCy3e1iYlU0EjB3+tL/yWN0i6sBeiUc+u57GVYs8DEqp2Mvdyhxz0t
	 heaEEPcARBTMHcb5V1YKedYhenQde7QEAsg9a6cx8LE+elBgUVrk11J3dtU+wi6fdaLXI
	 JD6yeZcITJmL9ByR/zTt6Xhp8pQQ0qIt0qoVAsHlRcdtFotmkzUbC1GWzN1MITMSvqVDN
	 SPBfjgJX3cAFdKf/xF8GlVRUfAZXhgyPvmdrWaFtb58zKagbw98iLAPpuBbxwZ5cqoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="mJ+/Y4+s";
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=O7vlfz7j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D587606A329;
	Thu,  5 Nov 2026 16:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D587606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=mJ+/Y4+s;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=O7vlfz7j
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5DKQEr1473209;
	Thu, 5 Nov 2026 16:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Es5TNEi2aSp5OhhvFZ7RQ4rETmyJ+9dSxDDw307UkaY=; b=
	mJ+/Y4+sh78hAyi3FBoRKmsc2ylKQ8bVhQeNONXD1gFsLsZ5yTB18gFPgr/A69Nn
	AB6LYnufV83vEXJQct+uGqz+fvuQxIIeFS8lTJczJlGLIEnrczdz8DBEyYJWRkdl
	utS8D4dX2gv7+KlvWbSe+XUME5EfIO8YtiHb0vleCNoqHQe1WC/X4iabq2C7Ejfb
	BXtezwwoyEHDUQqMjMWDlGJ6yvC8VOxjedAH83ExjW2xFc0iVdSjP6a06Mu/GLfR
	bdmrN2nAEsUJ8VQ6fuW2CB/Ip3JjobYrIkadaSUjodhD4TVsR/4Fv2vd90FxaOf+
	YxZEeFA5ryJvWEJGb+M9hw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn876rpsx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 05 Nov 2026 16:48:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5Gfa6V1440714;
	Thu, 5 Nov 2026 16:48:31 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hrv6auxaf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 05 Nov 2026 16:48:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiZ6po8h5vkpFnBh9riNp/dSRev1iziymc/04uB40A7GbSbB+FC17hCIvixH5dIea6Zl4k/7lv9KMSAFMEsEXffePOn+97aA8QRrXQ1KVNoJkTolkPGrd12T37CEvFkCSiViVEx5BMxZGJT500bLkF9rKoJgZcT3RmtF6UFg2Zi3pUBizDNpO+09z9j4c6BHq+IM2wa2tALYCRDUjxYUThcjvhGe6dhyDexsUIylPeRAHt+1khkI7ea5KjgdT4KeBWLAiJ3ozq185j4UuZ2IKcFCPXHpTBoeZ2JAd15XFo3CkeyD4gbsq4GRu86P6J6m6gakR6AISzebIwre5I23kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es5TNEi2aSp5OhhvFZ7RQ4rETmyJ+9dSxDDw307UkaY=;
 b=prrJ0GmE81FKudt0lJWpiQmR3xk5cw/x3RZurS+BMpODWyuwYuuFnwKhxzC1XCBgx5lwQWhSjLrwAj/iD7k/iJS9Al3VRrxhOsSkGQFOTXhmnLDvkg0KmW4WR2gdJ8z4Mg/0PHcqmfNSfDp9g+VyCs3eALir+6olXK9XjZFSr6e7gQesoXTkbyurR3VYq5YlwK/JuhLMBUQCG1oyL0RyfeFNjuA0ihumfugVsodulobEzKA2b/EIk0gVqSj4/H3v3PW7yYHbdWVu1niIpByc8r0Py/DIsLLimDh+JEhg9m+P9D2ir252k2cI7LPAXl+6XN/KC2XCawgiGOgt2AaUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es5TNEi2aSp5OhhvFZ7RQ4rETmyJ+9dSxDDw307UkaY=;
 b=O7vlfz7jtL5niX540rUL32xaLunytLBICtUJHuJhCNQRwkvz7m96FV5js6GYZyFsdXsn9Blfhu0B8xhs/lPwzoC+xKN3jyjRE+XeCo3CgrqbLhkcx5y8V2M6tYTL8h/fI0K0Wp+utVgxVr9bW7U1suTtEqYmtXSy7g2CEPaF71c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB2555.namprd10.prod.outlook.com (2603:10b6:5:b7::13) by
 IA1PR10MB6687.namprd10.prod.outlook.com (2603:10b6:208:419::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.10; Thu, 5 Nov 2026 16:48:29 +0000
Received: from DM6PR10MB2555.namprd10.prod.outlook.com
 ([fe80::4aae:bf10:529c:9275]) by DM6PR10MB2555.namprd10.prod.outlook.com
 ([fe80::4aae:bf10:529c:9275%7]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:48:27 +0000
Message-ID: <b4777494-c583-4a4b-a397-6e1cd3a8d72e@oracle.com>
Date: Thu, 5 Nov 2026 08:48:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: perf: allow opt-in "no-dso." files in /dev/shm
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
References: <20261013213842.1870582-1-stephen.s.brennan@oracle.com>
 <auuckurvVVn0YXSg@google.com>
Content-Language: en-US
From: Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <auuckurvVVn0YXSg@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:510:f::28) To DM6PR10MB2555.namprd10.prod.outlook.com
 (2603:10b6:5:b7::13)
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
X-MS-TrafficTypeDiagnostic: DM6PR10MB2555:EE_|IA1PR10MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f8f1e9-4ed3-4753-ae63-08df3b5c9d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|56012099006|261102123227099003|261022105027099003|261021121427099003|261026121527099003|261028144727099003|261026140227099003|261022075727099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	VUmwinF8Uv51ogo5dgLbOX5jHYgZ+AKdOLxHtBEA2NQwHjXaWZf5/e41YvWgetT5IE0uM48o98juJfGZgM11HlwEMJhYzMsDSV2mZ8zG8mTXvDXy6GCb5eC0Q2SbinNkJW4LBseiWpkFAtQzUXjehZBC0GgZzFBMdiIevWgZWvdYVqOuXrCM7TiJHQFyY0UUFFHw21eaW5SXXL/dAnNV4qqPvnsgmmRi7T7OE/Dlsbk5Rqrs7dklCe7mk5tYYs73XqvmDB5DqCLvodmfcF5D9EWsGn17+H1eUKJGzxHcuc6BisqqHGPe9xdhKKXBd0r/y1VPVLhTeKSv2R4RbWPltD8nZivjpzCLH1Mjj0rdQRuMFOeYrLi/Uf4Dvq+0UQEsKOXpuoEpwT4PU6fZqCXSsHq2X8o9BW3e35soR0TRZAOwBSWmUzXztKe+GV/sCixwqv8nWU7zAUsJ2RGZwo5c/9r9eCn4gwADYA7jgyzE+p24tm3BiWD5/J3V4EQieGxTEdPeVyLuYuh/9/+mtvoytK2THNsHWqWRlFdyu1Ji6od/OkYaJABS90YgOwaLkPqyU34YqjUtOTC6K3SYVTx5q75I/h59gwcLaBDmOzxN6/wZ4/Kl2zQG+XenVkINBmtmog/wgxosciPx6/XZyR02I/soLcQtAvqx/rJJCcfgPLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2555.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(261102123227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(261022075727099003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnlrNHlkanc1QWh2VCs5Y3IvQ1Rjbjh3TDJoTnVCdGxFMUZWMkg5WWtsOVFj?=
 =?utf-8?B?S0s1MXBBWk10K2phQ1JmUU5DUkZnbURmS1pSZjJZWFRSbXZ2REJCUUJYOUxQ?=
 =?utf-8?B?NGNySXh2ZDNMallZWXN1WXV2TVVqbkMyUi9HaUZkaXRJb3pRQmdLNmhYZWlX?=
 =?utf-8?B?MzQ1TWVOZlY3blpzTC8yZlozaGlVYzFzMUlha200eC8xSGZyQldYZEk2elpj?=
 =?utf-8?B?cUJwd2NuYm1XbmE1UFRPNXF4aXp4RURlcnZWN1RiMDZqSFExM1c0RzllMzUr?=
 =?utf-8?B?eGptOWlPTzIvSHFQbExzS3paVi9DUE5Jck51dlM3ZHdPQ2R3RTI5cEwrZzd5?=
 =?utf-8?B?b1M1Q1o5VndlNmpqbVlpZG1vTzBIYXBPaG1QazY0SkZwNkhsU2RKYjhTNkIx?=
 =?utf-8?B?YnBYZTlaakJHOXE0dkpWSWdSalNNK25vQU9rdHJ1d2c0Nk5YY1AyTWh1UkU1?=
 =?utf-8?B?VDBrUTRJYUhaTlE5TXRCN2ZCZ3JHZ3pybEhlcStTanJsV0xwdnEwU3dEdXAw?=
 =?utf-8?B?L2s5eDN2a0RwOUNpTmpSM0tmbnY5OG5xM29uU0tEZ0hZUTVyaVFDVVlVTC82?=
 =?utf-8?B?aHVwWC9oU280ZjZ2b3I4QjdTcVVPaXRVZDY0Z2IzaGg2dW1DZU1xMlV6MWxr?=
 =?utf-8?B?V2Vncmk3WnJBWHFIMTRnV25tRVN4eU10a3hzTWVnRWViN0NveVpja3VaV1Rv?=
 =?utf-8?B?T0Q3SFk1Q1Fuc0N5UFkzN01PQURHcU90WmMwbUI0ZWx1bUo4bzZ6cEFCdG8y?=
 =?utf-8?B?ckI5UHBWU1dwN2lrQmV2L0s4bHFYRHErRmJoSlp5T210L3BaOVY3T3VNN3hV?=
 =?utf-8?B?NkNpc2Y3RDF0ZVY3STgzQ2dRcVRaWjY4K0Zxd1VKTHRZZWFXeEN1d2I0SThz?=
 =?utf-8?B?cHBvdTdyZm1qR3c4Q3NtM0FCRE9JZ2VXRWxQRjNvTVZsbUlmTm9WL2VERGtz?=
 =?utf-8?B?S2psZE95S3VLdW9VUFJFS2xGUDRTNVpIaEcxRVF2MmFBUHd3NG5XaHMzeS8r?=
 =?utf-8?B?TXdCNGFHY3NyRE1WYUVSTU9UR1QyZGFDMVBiSEVkZTFyNlhDamFZT0pGOW96?=
 =?utf-8?B?cmxna2dQc3VreXErVFVLRE83U01TQWJpcWt6WllOb1BFeEh2NEtpSk93Rmxz?=
 =?utf-8?B?TjFkeWg3WTlZeDBpYTFibG9nL3d0dzhpSHNjZ0ltZitNT0ljQWR4bzhsTmtu?=
 =?utf-8?B?ZURUOE1takp4djNlUlFSUkFmRi9hbmRDTnJjKzFiREk5Nm9pc3Iwa0dOelFQ?=
 =?utf-8?B?SWJKM3pyeGZCRng1V1NUeW5BZEQvbG1ZZnJJem1ncnNBT1QvR0UrWGFQaHVs?=
 =?utf-8?B?b3NqSUsrWnY4ZjduRlFJRkNyMTlWMVY5Qmx2VGZVTkcyVUVqUjhyR0lqRTNx?=
 =?utf-8?B?V0pBMlJHdG90V05hYVpRZHRSbVIyTVJwK0V6bmV6cFlQcGVtb0E1ZlhZNnR0?=
 =?utf-8?B?eXRZU3U0SkR1VWhtTkpVR1VOZ2ViZzRuQ1dHKzd1WUpUUVZtNnpOTVExejJZ?=
 =?utf-8?B?ZWprWEMyZDBkTExqWm4rajFvZHRBcXN3RHdQY0hicE81dmd3R1hzMnlPeitX?=
 =?utf-8?B?TmZ4cUlCN0NmQ1FPU0c5c21lMEt2WDFqS3l6YWk0bXd1bTEzaEZoV0NhdjNR?=
 =?utf-8?B?WkRwRU5hN1RPMHo4VDBhc1BOaG5NZG9Jazg4OGpsOE12bTN5NWdVc1dOdVNJ?=
 =?utf-8?B?ZVpBR25TTkV2TlBiTjM3eDhBdU16eHRtMjhaMWpmNWI0TXhuZXJtb2pjc3Uy?=
 =?utf-8?B?c2g5bmFuYnVxdWJ5T2J6bkZpTStGV3FJZVR1S2RYa2IyWmdBODNudnVpdzVE?=
 =?utf-8?B?OUZRaU5mazZuZkR3RHIxTWkyYzNmcE5ySkxENGM2YWlJVkxOWTZjUkY3VDZT?=
 =?utf-8?B?TEF2TVVncDZUZWNnM3Fma2ZidGxHdXVXNENMemRYYUw5Unc2MldwUXdkSU1r?=
 =?utf-8?B?WFBmc2Zxczh3R1o2QjlnU1FhckV0ZlpDOTF4QndsZnl3U1hGNVBQSlowVjhs?=
 =?utf-8?B?d3VQRVorTzI3MkdLbWZrUnpsK2VuaDdDdzdqL2FUSHViRHRZQnExMTlHODBG?=
 =?utf-8?B?OGlkZTIxT1dlWWFMWTJOeXV6cEUxT1ZyR0NmYjl3TlcrKzd0TWhzQTdDWXRo?=
 =?utf-8?B?UkNnaWlRZXV3QVJIUnJwS0lVRkZFeWtlSlpUbFNsbytqK3ROTk9jREJQTURQ?=
 =?utf-8?B?NENGSUJiaWRXaUgvbDcrTTZtVjhmRVhtRUNtQ0d0alV3MVoxUEtOQ2JnTE9R?=
 =?utf-8?B?K3lhZ3NTVzlLTXkwNjBrajFMSHVWK2Y3aFlBOEZyMkRFUGtnWEdIdjkvOGF6?=
 =?utf-8?B?N1VDcFlRMlhWUStHNTBNaUt5T2VWVEJwSkNWamNESDlmdGVPQ2pzZzVWMHRE?=
 =?utf-8?Q?2hLRT3CJsG0VkxAY=3D?=
X-Exchange-RoutingPolicyChecked:
	lg0tM8/dPJNrbshoyyya9VVMJ0TsjmqVn53I6XFBX2TyXW2oHibOdu3MUcenU6HtjL5NMLXLjkNAeCaZslX2F3eGxZG/RTpdH9+FlKHzkvFTLKXjfWMKK9LZP5PW4hibgE2aoMbIiLBB9XucLVPUwK3z3RLATca0oSVQ1D6a2tqwQu67qlV1cUUnIyMjxl+QOfRgArCWzKaVuEjeub5Q3pJfEYnHxUjqesIzmptL3dswmRAyf9AqoFeyCrvNUhoBGL+VYxOVjauFNhGNDf4F0ot3R/pg2XDdP37QD5K5cgmsY3cHJINNr5qrprCFKxUViIDDgcp1rwl2jo6uOkx3sg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e1fFe4E5h2HcCgoE6fbRGAZbuUW3T3E4PE/8ChQ3t6KK2HJgBlAznVWZde2etyogPQLKr2RpLMnoTmrayUBBdgpJxzG7hQdQrWdJNHHrygU3nKzXp4ailuejFhvE36C8tX/g5gRj3vDVGFqu6i9wDvq218YnaEI1GmcmfcWySGAEtKlwYSlj01S0/06rGUOqTdxExX5X7Jq6ikh15mLahy0dPE5Ylfz2wT7cG2Mcj9725wJO0UPETtxXPPKJvipNq10mXh4C4wkVFyR2QBSRnFFswySL7hecchYsVhnR8MOW4Lwhk/ltcRhxsS+5S1yuGX6Q2L7RN+3COOhAnPBC/3FnYCfM9NvkNqPjmBWjoJ6fEDoByO6zwO0mmJMh53w+0FkCXTntQMPehNYOF1sOpgAofmmYp+jhFJDRVH6kUsDgGvjOowFt2ukhSBtnJsB/EESfD03s2zDFBLLupCQruFPJNmOxRk6eE8fy+B3UvWjBdI8b7OCaNjrgY3mI+PKFJWOhmH1t2vWFRrp7K8GIU8gyHEOYumeLXXTxl3a4cYOgr3McA6606gdap3RZB6K2emiUf19P+y8NeHNSsB5em3yHk1nF3+72Jm2pQ6QDzU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f8f1e9-4ed3-4753-ae63-08df3b5c9d73
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2555.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:48:27.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m3+NYeVUa4+Ypw65pQBg6YjGRa7CEc/DgWdvpryTgm5xTiQ3I1wU2Gx8ntmXsdA4kM6TEO9DZA5Zv+I4OjWex5/cDWbtAD7lx5PO6ohumE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611050066
X-Proofpoint-GUID: 4tdEdr4JwJp-uHV-RG7FeehzPVvse8YA
X-Proofpoint-ORIG-GUID: 4tdEdr4JwJp-uHV-RG7FeehzPVvse8YA
X-Authority-Analysis: v=2.4 cv=JJauIMKb c=1 sm=1 tr=0 ts=6aecb35f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8
 a=HnaOQimmWgcX9jMELl0A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX47v/BoZ+6rBo
 gudbBq39ATqyG9/0EofEQkPnB4fYDg1WyXp0OntdrWEax4ju/ittlSdDKvoPbHhXsaD+b6YfuZq
 9gtlXH8xcYfodYqmupf4KJgVo11wDaR+ftn69uApACS9dRLNjl9jBWSCahMWrfxEZhHe16Pz5Ty
 ig9ZgNo6oDqVRwFg7Dr7Fw4zi8IQ+pXEuEh6NGTFqh7xlPYxuC6daf2SvyWIEdlcsMueZCAsGLE
 31h1qWylOSqi7q05YGL6skkToM+cXJv3I1I3RUbP+Oc/sdRUXPTxt/kOxxpTjzNEg4kdk5Ym4K/
 QPkX4JAUdGLLoNBtvX2eZvEUovTfVRCIstk9UtzhZt7+W7EpEjRDsCxULutsMMaTE63Ypd/jy9N
 ZHA1XS95/Hmo3UFcFCE0/zsNdLBuXcbyTUiFiePzWktcQLZQ+tO4YmIJ62mHI4ikabnhPWN/kDd
 kr1cE6s7mOB4rYuIQ9gDYOaMWk1ejYf9A0r4d4TY=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX4Ok+Eid1TgTl
 PMcra2lCFa1TjWA3Vflj851tPlJn5BiGQfT8jMyRPCLGFzcdfpnwMZj7WkUWWqxgEWiVs8E54h7
 uY1Xvi+XqOoNYvh13qrdFo+wcyAKCUO07cXdIfA54z4v6G7qAks/

On 11/4/26 12:58 PM, Namhyung Kim wrote:
> On Tue, Oct 13, 2026 at 02:38:41PM -0700, Stephen Brennan wrote:
>> Applications can place JIT-compiled code in POSIX shared memory so that
>> multiple processes can execute the same code. On Linux, these shared
>> memory objects appear as file mappings under /dev/shm.
>>
>> Perf uses /tmp/perf-$pid.map to resolve symbols for executable SysV
>> shared memory mappings, but it treats /dev/shm mappings as ordinary
>> DSOs. As a result, applications which provide perf-map symbols for JIT
>> code in POSIX shared memory don't get those symbols resolved, while they
>> do with SysV shared memory.
>>
>> It would be incorrect to classify every /dev/shm mapping as no-DSO
>> memory though, because /dev/shm is just a tmpfs mount, and it can
>> contain ELF files.
>>
>> Add a filename prefix "/dev/shm/no-dso." which is recognized by
>> is_no_dso_memory(). Applications can opt-in by naming their shared
>> memory objects "no-dso.<name>". Executable mappings with this prefix
>> will use the perf-map file, while other /dev/shm mappings will keep the
>> existing behavior. This allows applications that already emit perf maps
>> to use POSIX shared memory for JIT code, without needing to implement
>> jitdump support.
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> 
> Applied to perf-tools-next, thanks!

Thank you!
Stephen

> Best regards
> Namhyung

