Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020094.outbound.protection.outlook.com [52.101.196.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5BF30EF6C
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119531; cv=fail; b=CuRw835Y88Yc6RAeQ8cIqRlfNF5yHHpowf1ZO1LvPox4tJTTztElkTdiJoU7ygjaoX7mcB44kH5QWGiZtS8KmLJkF0H0t4DpHsfKqfRxEy5WYS8khxLMpW1ezqRTKo87qtJZNETGdgC9aHGT3dUswoKZKgR8nXmK7rrJ0bwF6uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119531; c=relaxed/simple;
	bh=+8ktsYMKQngbtCk9+fW4H7umJwXiYPNgzSe+y1dGXHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1s164pqVrYM6SZpebzfye22U2KcsLB7i2dO8b0BgMvYpk2E60L3YRQKFNSb5MdClraNLHnjwCKZlEqSbnviYCWz1ZKr3Opj+QgRiEU0xErJIX/T6ilsiClNifDfc15AKK213TEjDdW8+gQpngSiBSZwp5/H1r8IyiACOtGLTbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc+WVU/sDpPYg1qQyEgjG0HMzXaFMkE+CrN3I71OKaGSrJoVgO2WMKQiVLZ0QmQnipGKsYGnnsTPVkUVMp3XLqIDcJXs3z6XFvKg/BShkVkcp69z9T0Dla2JgPOHSEwHr220lLj0gk8WQBCreRPCLtvGKv84CcqIvbWpR5MWGkO6Z3XrbCbL/60XDBiazNbfsT10DXI/3ws6fYM3jsum9AJL4RjYC6WqSRlrjOvQEte/goSA6+ssXpAn9hAa4cYhv27EBda5NBxLguMPeKgfQta+9fdP4oJd9292Rd4XfGUEbkz1Ucs0y3Pf3o2Uglw2QqR5RxO2wpdA2kXD+/fYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=z/zM5V0xMZnGPy/HTQFqMNVf56MrsZMyPCcu4l7v3Og=;
 b=GmQNuHDlpekTqNojy60ObkiV29p0iKviVmSjv3wY7Pc5pyo4PPCw4uN/8las468wb+70fnDW8sPqh+doLmALOFJFNzQ8Ew/Fsc+sMIwEXSyzeAVrs/MakSsODj4LltSfoybssfxTDZrfFkKegEWtADQybX09B+EtmxCqTsf6mscPHdYCjhK+X2Wxfndrrhv5k/3VoxcmzIQBX6NNgVz0b1106UJdizNYmgaKJVQnO543eJ+PzT8frMrXDpm4FVe1IeGaQScs7noL/FoMOo3Ym6ut9bzM1ZK+3uR6GZcttckt3vcQKWEA+DPxMStvq2KfTGclHDoG9c9fN69DT/ZmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6331.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 02:58:45 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 02:58:44 +0000
Date: Thu, 15 Oct 2026 22:58:40 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v5 1/5] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Message-ID: <gzfztr7g7ecet4wl7vglyp5ybs4soit24ytd52z6vdgzrlkfdu@xoq6e6oyg5pr>
References: <20261015011155.414667-1-atomlin@atomlin.com>
 <20261015011155.414667-2-atomlin@atomlin.com>
 <sashiko-outbox-172085@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-172085@kernel.org>
X-ClientProxiedBy: BN9PR03CA0411.namprd03.prod.outlook.com
 (2603:10b6:408:111::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bce5cb3-b3f3-4bda-dd03-08df2b3163f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|5023799004|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bEsIzuBtfwKKrT69d8++z0s7noFwsXgoS0om888uZAn5oGijHV4nak6wvWeaRC4MLbEBJzBcREZsiRZnTiqJ1SrkQVt1Q+uIQkCSZ17zG/VjmMdf2RbUs5wk/GOKknCokh/Qgsu2iEWoOGoy043mQ+Ux4EfQzLvtWMayBvk20ylAqwZFHcr5pQuYhMNFzve1sLJm4nPc7rWyiC8KP9dyGQkZ8nFwXQ+pf4Tmfwimh/rm0PKw9HpCskKJmzBV6xjOsEoGQU5gF1GBG4a9Ou1f6iSNDqiaeosMt01kTk+ad2/WPPMX8TJcVNTxTjR53KuCYhaPxdaUnX3X7hf8MJNiUmYheKRjupRLk+t2DWDu4yKkSdhRNAZ5TnfzKeslAodxhNaXpnIzXYt4FQCMhFL+qWV5tU1naqkt/SkkuAeToUMi8yNDy6RtzCzEH1/oij33D7BoVKFTeTe3rFnZKusLJaucNAkpWDsOQdpm6XMgghz5cTseVGWo/sgAj3MWV1lC4mMHD19F8ZKV0xqOWh4OWPW8JfsOoFUNfmjmAAk0Waoc315jU5S98riqbhVuxK1a3niYXhlaPifLtYTUOmb7K69JDY3WDa1IyHKd0Qj6K02Qvw1kvNAGOQij14Gdo/d3lvthEKx8ipmjE/Tmt1g0lw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzJNVHZnWWRPUG1KMWJRZXhUdVhzejdBaVVsVXFIaWRoODNoRng3WStuNUxH?=
 =?utf-8?B?UmxUNnEwL05udnNZUllOaTJvNzM5NitoWFhQK0lyaWVnczZvS0xOOWN5SWNr?=
 =?utf-8?B?UDJIdDFOd2E2dHkxb0dDdmo5dVJBRTYyaGROeFI0aHdDNTlNclVtaUw1VmxW?=
 =?utf-8?B?RUk0alNqQmt0RU9lZ3BhRE94bVU4ZHBjRUJMN3lwYnVSUG02a2cvQi9saCta?=
 =?utf-8?B?dVdVVCs1MjZXOFdKNW14YjhpU2hIekxnQTdhb1BaV2RFbmF2WndreVM2UnVO?=
 =?utf-8?B?VUR2M1VSV214Z3ZaRkZqOHpsTDVsNjdsejJRMVZ6V3FOTjZsb24vbFVFbWlu?=
 =?utf-8?B?WkcycUZqY0JTSW51L0dvcmhCNmp2TmQ3NkViTEhIS0liWHJuZmduL3Y5UXVp?=
 =?utf-8?B?ZGpvRVJvUUdhMERXZGdXWDJyVEZMbk1kNTE0TW9aQVZ6NFp1MnFFNVMxTGF1?=
 =?utf-8?B?NXpEZlNXVXBCOHdvM0pyeXByRFczZC91aEVQVWJ5d3ZkUGxCWkgvS29CSUIy?=
 =?utf-8?B?TXJ2MlBLeWloMnhISzdYSDJya2dBMXdoVnNBODVrbjVRcFRRL2p6d3BJeE5G?=
 =?utf-8?B?MEZXVStwcFJJZWdGTlVObnVwUGZBNjNHZGVYYkViSnNCa2habU9Fc2wvcCtn?=
 =?utf-8?B?bm1JQ3RpbFUyb2VFMVVUYlhGT1Jzcnk3b1FVVWFka1dyWlZkZVg1Smxlb2Zv?=
 =?utf-8?B?aHFJTGdUYTBaNWZUSlNPUWZPWm5JQWRwZU0wVnVvMjN0eUhaL0VWT056cXhq?=
 =?utf-8?B?ME1xODMwZzNNQ0NRb0twYVJPQU04UU1DVUo5M1B5aG1yWUVFaGtub3A2eVhp?=
 =?utf-8?B?Zm1ncHVZY1JPbG0wYTFjTVUrY0lyRzdjZHMzWW1lbUpVaXBsUG9JcjFialRQ?=
 =?utf-8?B?MGZWZVNOT3ROYlBITjJqMklnV2JpM3VGdEpnN3Mwc2JIYzV5L0JTTjc2QVRa?=
 =?utf-8?B?Rk82dDZTbS8rUGt5MmJNaUlSUzg0K1BLdUJxTzdMVDZob2lkb2o0Q21sUDE1?=
 =?utf-8?B?OXJ6SUlEQjNBWFAzRndpUGM2SHVkTFNPaW8yT3NOTUpxRWRXdFRwNHpXaUpJ?=
 =?utf-8?B?Rldtdnd1eVZtZTJtaHJHeHhZRnFmSmQ4bStadUdvMzV6MVo5S2E3UUhwU3Yy?=
 =?utf-8?B?ZlpFeGp3ZisvOFJUWTZQNEpkSnJ3ei9NQXVyOFcrT0Z2QkNONisySFhnNGlY?=
 =?utf-8?B?NFhudHJ1V1ZHdVYrdmV4bEIzdjlyZU9sTmFlVEFDd0NIQWZpMksrbVgxaFBr?=
 =?utf-8?B?SGsxQmROelZycVVXZTRwNnBTT09PaEVkaE13SDFzZExIVklXa1FhcWpWZGl4?=
 =?utf-8?B?N2RLUlA3eFQvZTM3N2JDbHNZTlhpYkFlRXMwZGNMUUFwcTM4U0c4UWg1Wklh?=
 =?utf-8?B?MVFDdE85R0ZFUUVsLzFGV214YnUyNUNYc3RZRWtoZ0VMMDlPTStIdFNzNG5U?=
 =?utf-8?B?dHFpWllaWCt6RGxFM2lEUjNodzh2MlNmK2FBY0JlS1dNS2ZGTzUzdVNOaUZP?=
 =?utf-8?B?S0pKVHQyS3RhR0YwOUkwYVNwanJuS2VaSFVkdmc1MWFOK1hCQy9MaW1yNGht?=
 =?utf-8?B?VS9jdjNXQy9SajlDS1Q0dWQ0WWJ3dWZJMWZNNFYvQXpvRTU5TWVQTFVGeEpS?=
 =?utf-8?B?NFd2SjNzKzVBT0ZmTHdzR3hzdkJHZG1sQnd0SndlaGVJU09qWUVIZ2laTEVX?=
 =?utf-8?B?KzIzbFk5M1JNNHcrRi90ZWYrZWZWWmUyZ3NYdEdUelkraDFDSmtxMGo0Vm9i?=
 =?utf-8?B?UXJZMXErYXVqTTRKTWFjWmNEOUdvT3EyOGF4UDVJeks2a2hYeDl5YWlpdURF?=
 =?utf-8?B?cjYrSkh4V3pFQitCZnJxQ0VPSXJUNkNxbHVCam1ybHVkVlVNLzJhT3VPemZQ?=
 =?utf-8?B?VDJhS1k3RjFoOWNycjlXcVBBS3d2Z0pmeEVJZzc5eGltenk0VSthbktaZUJj?=
 =?utf-8?B?U2U1WkVMM1dBMFk5bkRkSTJxSXpKdEU0aUNidUNLM01yYTl1ZFNNaXg4S0dt?=
 =?utf-8?B?V2Y5T3JOOFJqUndKVE9UL3RLaUN2RUVvNDl1WUVwb3hKKzd1alJ0N25PdFNX?=
 =?utf-8?B?S0FaTHVseXM1RG1UQzZNaGtLblMyY0w5VTZZT2Z4RnRvVzZqa1NUMHVjOWtZ?=
 =?utf-8?B?dDJtZ0hNRG1hOW43aUFqeWdHbWpuTVFhNHg4ak9wOUQ3OG5BbGM5Mk90cURi?=
 =?utf-8?B?WXh5NlV5N282ZVo0NGFaWkk4d0VuWTVYbitHb1MxWlpHY3dUTUtEU0FSMHhT?=
 =?utf-8?B?SVVjZzltdFg3clg0NnVSTURKU042TDB5aGFzdDdvcGZCNDBmdEcyanpyY3Vh?=
 =?utf-8?B?b0lSbjR1cGdFdjltTnROMWRJNThLZ0FjVnBvNmExekVxY3dsY3VjQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bce5cb3-b3f3-4bda-dd03-08df2b3163f0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 02:58:44.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wjy0NR99hz6vUVpdW98djjImjxCHEqBWHb+gtOLbkTFNyPgeqVSv7yYWFWmag1QnPi1rBDo0YmNR/eRe/8o8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6331

On Thu, Oct 15, 2026 at 01:20:15AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Does this file explicitly include <stdio.h>?
> 
> This isn't a runtime bug, but relying on implicit inclusion via other headers
> for POSIX stdio streams and functions (like stdout, fprintf, fflush, and
> ferror) violates the perf subsystem guidelines for musl compatibility.
> 
> Explicitly including <stdio.h> ensures the code doesn't cause build breakages
> on libc implementations that strictly separate declarations, like musl.

Acknowledged. This will be resolved in the next iteration.

-- 
Aaron Tomlin
