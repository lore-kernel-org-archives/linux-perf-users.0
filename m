Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020109.outbound.protection.outlook.com [52.101.196.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6283B3859FC;
	Fri,  2 Oct 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971423; cv=fail; b=N8Fy+6o0oeZW3tQ0dYYfYgwLiDGbELlKWALjLUBrpV6II0SYWotB1wkGZemr0s5zRSMf/2KN/gxiDd/CL/sVhKP9NKz4IgWc7w0oQMdii6JbauNtDjvLS/sWUi6PsQb/QChprpkn+x0Fn1M1GNzeu3t+2iFtJdcPi+NRVKpXAs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971423; c=relaxed/simple;
	bh=e2oMV5xJ/5DKg0nGu6mWTMp1hL8o+k+2e+VtqBGLgRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WEkuSwK1iZAIG5+BO8pX+q0J4gPU/3FFPJv3qxLOhS/z0ztfTZVk7sW6EKDQ7fpgLeIZL66QHRoZEEM5xDvMVgROCOGKE2KCD4Zc7ZeWCxzvon2kVnVXMZTn91fohHujjyDjwvqNUwGlwo+gwRhSZtZio+kaV3cTZ3ps9KT2cdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=othLR7ZhyNDPahraDYObLxBop9yU/xFtBKYQ6r3aUQ7mHF1zrqy2mWu0y8ifEuEOYM1nHP9v2lhh22DsLQF7eb3EaFtXPmHANZf5ZfvrCow/HXEgEJpW5A/Sx/zlIQw20Xw3Xxpp+NrceJyIVqDK/HGdfB32u94tGSFG0fm+aHs3CTiE0Mv0/saWtazcwTvNNj9QDP4ZzD9K3ojc7SgtPtHxCeYNS61EEC9RrTkDl8a/kKnxdkpBKIFen4kS9rwY6CmkmcgONLEg+9TL7zsvJp8kc+FD7OGCKQ5x5WUMVBoaHCKRKrFKexBlVy67Kpyb9zYL+pXOFWfk05JyEArnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=HY9e215s3Ol9khgS52zciG0k7Jvo9qAav5QsudpMyp0=;
 b=o1DQIe5wRp87BCBdwVVHh3DkBZ/E424WUnozjjGxB7edfw6AKHZx5m6Dfd147UG9H86ZjyMtwcxBJ/8s8kMHiHSomz+9Q9+k+YavCu1BOlZw+yJErJkXmKYnJ9M2+EnK8oRwddhWPYWzNwxOCbAysRGN62naz81WDmsTK9u2i02+e5gTw8OAPV1VW5/pJ3nfb5qdWaTQxO3B+XepBMcbNlQk4DemjG/ik9gMlYR+Wh25NZ8+dTeXSk0+BJ5iDMceMhMOEpEOlT9TDycbUppDImMChxnAIOzbR2SDeS6Hrmo8Ly/6G8LjD5kUZlDa85SCl2vOB1pTqRJCzRP8BH9t/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LODP123MB039761.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 20:03:38 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 20:03:36 +0000
Date: Fri, 2 Oct 2026 16:03:32 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jbrnak@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/2] perf trace: Only call bpf_get_current_pid_tgid()
 when filtering tasks
Message-ID: <jtev5gxqwp5jpd236lpdfacoltgrcvyzwgocinbxwer6fv6xzc@ajng2aiuca65>
References: <ar6nzTSj17IxCy0j@x2>
 <20261002065440.2781176-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002065440.2781176-1-irogers@google.com>
X-ClientProxiedBy: BN1PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:408:e1::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LODP123MB039761:EE_
X-MS-Office365-Filtering-Correlation-Id: c658ea37-9e61-4e0c-53d1-08df20c03e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4CxfbNHu5sSQngstX1hRS+dcK28ZgdfUbpCs+WsqVDngG7PI0pfe66uo2jlM9oPACsGGE+tnyvE626HQZvuubUsNIrbpFDhJGz3+FRu/kL/yVVf+8Hb++NZiQjwyYRhPkdlAOKKQ6LLTenm7wq0e9aaSotBchlsM2zam+9yK2+lDeQwHXvDO+Lo4yWD5kjjNSNCDlbCkrOTdNt3tDgjwM4fFD8hNuNcdJyjl8HbmDFTfWU9QvzQgXK8267dQW1qnzSxodPrd6Iqhhs15Qccd7BmFTyZEoGfMIDq9EmtB7dpI6Q6hzhDF5STbNJLmbcfIihrRPJQz0v8wm1VFastqwV3uHVnhrKyqfnzowu21GDzel1QMELFy5IxO/t2NjgQNND8p+AidvqBV9FUSPeqJWhxR9ozJ1ngP9YOk5frmXJLK7Zm9Mtt9CcVcv4T4MoBQEVHZXLKJrxuf96vVunO9kMQxpKuVjdWijRrQHsqBvxINg25ycubq3q8cSC8vFypIKu4EbN64s1qwxzU0nnUmh3JTz0lGSIA5xlNjwJ+jnd8xR6ajLEPdhZV6B67NVQa5Sgb5p2TZGfJJzwa8X7KQhObkjXT/ZnqALXYDFcyopoV3j1kiysg5A3NAbkaIC6X41jb3X9T9Ykc9JYGwMIotlqQ8shlojmLpdu2ETdziIyA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGFFckVSd0FuUlBFRVVzRElTWmZaeUVrTXpoZ0hVUzBWajJ0OUpsNFJEbnQw?=
 =?utf-8?B?UUNaTExPVUV1d0cvZlVRWlcwSW5xdS94QkVNZFJ2M1duY01qbFlZS0RRelhI?=
 =?utf-8?B?MlMxdk5Oc2tmdHJwQS9PVm1LYlF2Snk5T2F2a2lRU0UrT2NQcllxWFFTOURR?=
 =?utf-8?B?bU1kTFhrUUZWWDhwUWwxWFZPUmNKekcydVF3Q0p6dFg3ci83OENJUFVNUnZ1?=
 =?utf-8?B?NythK2JTQ1N0VGM3UHk1SXUzUFdJYkU1eks5NGlZYXBqZ2ViM2lSanBnNFRn?=
 =?utf-8?B?QXhhNlRiczVDNlcvMHBJUXdpLy9UQzNWbjJzcHM0MmlSa000UTJkY0NpTnFO?=
 =?utf-8?B?TzhqVE9TZldMM2NQSlZ5c2YzQlRFbW83RW5MViszc05IdFlDTmEzUHRKN0dm?=
 =?utf-8?B?SFRIemRreHBwemxsWm9DZVA3SnlwTmdSNHRUVm1xQnljWFJadHhDRDlnNDIy?=
 =?utf-8?B?NjFoQ3dFalJsek5oRDRUWDZtMFFETHUrZmZTY2d4UlVLTE90WXVlSHpINFpJ?=
 =?utf-8?B?WXpKbzFJVHM3VzlNd1dQVmtJKy9aaFE0RTI2N0pRc0I0NFp4N2NhcWhwMC9I?=
 =?utf-8?B?TmM2VlZHVXhzL2FHVmdmU0ZIZkJxWExmTzdEU2ZUVng2VXkwSGtka05nNGdh?=
 =?utf-8?B?enR0S2h6S0dsRmVnVUJ3R3dycW1ReVNEOSt5bnNHeW4vVlJqL0k1ZlBDcU9T?=
 =?utf-8?B?S3VkbjFjSHBUUjd5bkRHU21WVFdlaXNSeDFMOFBGOTd5YXhXcGtFMU5hanpz?=
 =?utf-8?B?QnVkUmc5bXhHYlcrRFlLc3QzQnR3bFRQL3U0NUtaM3JJbmMyQnJCam9HMEZs?=
 =?utf-8?B?RlhUZmlRUWNNQm1kYTRsMWI0Ymg5cHI5d25URlJHMXVGcUhXRWorQlUyTjZU?=
 =?utf-8?B?cUh0eHFwaDRTbUNjZW9zcU5SSHFhY1M1dWZIcEUwL1lDK3M3TTZXQjg1c3lj?=
 =?utf-8?B?eUx2WVhPc2FrNlJGWGp2Tk9PVUg5N3dFTThOMlhzeTN3YXJ0YVB2d24xUmIv?=
 =?utf-8?B?cjEyd3plQ1RscTFEVXFDWTlpYjJFckNRNVFPWWFoUFBMS1I1aWt5VXZFSFVh?=
 =?utf-8?B?cXl0dHJ0aVpLdXdQNjlBUnZzRjFvNzIrMU9CT0MvSGphMUpJZ1RwcGFHcEhG?=
 =?utf-8?B?V0p1VGRrQ25FeWFXVDhzaU5PVG00SVRZWXZzRmlCWWVWZ0N2VHU1ZllnS05Z?=
 =?utf-8?B?d1hEbEVrM0FqWmdPWW5yemZ6cVVDcTNya1k1OTY5RlBWLzhXUng4dVdKbk5L?=
 =?utf-8?B?NUlaOXFzVFRIL3QrTnJ4ZGM0Qy9MZFpMVkZVSUVRUW41dThMSUxvQlhSNXUz?=
 =?utf-8?B?U2hGNHd4QVVCTDF2cTVNdnBIYnV4RVRUTlhwa1pDZmhSSFFLMDVVZW8xTWlN?=
 =?utf-8?B?V2xzcWpIT1BBa3BvT0w4dEgzZ0dwdjIwelE5RHNVNnZXbE0rekY3UWRrWkUy?=
 =?utf-8?B?Y2NNbERUdFJnYXJRWlpsK0tyc1Y3ZGxtV3lhOVB2QlNkRkU3YzEwcHUwLzU1?=
 =?utf-8?B?YmNEMjFaM3NFSW9tQ2sweHdOc1MyZERRRkp2NGdzUzc2YnVsKzE2dWZhTUpn?=
 =?utf-8?B?Y0NoZHZzdHRzUDlTdVV3WERqaTEvNEhRWExURmJ6RVF3QThsQzMxWEFEc005?=
 =?utf-8?B?d25TY2c0YlBKbXlzbzRWOE1tc2p2NE1RSnNucjhXaFdMQnRDNHNNZ0g1NUg2?=
 =?utf-8?B?VS9DQVJkTUZPY1BCeEk3SmRSWU14T09QYXFQVVkxM2NkYVBzTXpNOE5JOXJn?=
 =?utf-8?B?OWpvQ3A2VXRVcDdiSlVYTjF4OE43bW0yMkloY0dLek80U0Fyc1crNXJvVDBZ?=
 =?utf-8?B?NFpGbFgvWXo1dDFvTnhWZ0hXM1BhZmp1VFZTM1NzdzhTZ25qUVFqWDBra3VG?=
 =?utf-8?B?cy8waDZGWEVBams4VjVnWTZEUjRnbGNrdXdoWjgxWFlkdTFwSitkaXBuRVZF?=
 =?utf-8?B?dk11VXRpVDczRkxWWHU4Mksyanhqd3ZoemkxR1BIMnV2U2RsYThWblZiUnlY?=
 =?utf-8?B?SzgyMDdLUndIeVA4LzFsdHcwOFNXKzlZUXJPTlBWWVNvYVQwTzErcW1wUDU1?=
 =?utf-8?B?RFA5NnZsSm02YkFUUTRTZVV1b2c4VzQ2YkJua1ZVYUJPcy9xMU9oeHQxaExh?=
 =?utf-8?B?SjVoejh1MW8xaDBVQkM1ZllBRWp3S0lrYkFWYlVja0t4VzRQeHdEU1ZzYTRS?=
 =?utf-8?B?WUxHbFlVaUZjdGhXU0NEYU5Ib0MyZ1BWWHhIM2VudXFTdnRuaHlGSHhXWm8v?=
 =?utf-8?B?eTNsTVdyUkdxaFBJbDJjZXBaSDFtb3UraTFPNGR1amR5TzhMVnVsZEJEKzRO?=
 =?utf-8?B?VDFlN0VMMW4rMjZWQjlwODdGaXRQZWpWOFBjMDJZcWQxbklqRFNhQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c658ea37-9e61-4e0c-53d1-08df20c03e93
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 20:03:36.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMZZEaKDKm1Zi3Ex2ZRNfaPzsijTBP8CtUns9k0C8hlp9Ghi/dvuuLPUQ9AqYlk0W0MzVfpWJziPD1cueTVOdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP123MB039761

On Thu, Oct 01, 2026 at 11:54:39PM -0700, Ian Rogers wrote:
> In task_traced(), bpf_get_current_pid_tgid() was called before checking
> has_pids_to_trace. Because BPF helper calls are not marked pure, the
> compiler cannot sink the call past the has_pids_to_trace check, so the
> helper was called on every syscall enter and exit even when tracing
> system-wide.
> 
> Check has_pids_to_trace before calling bpf_get_current_pid_tgid().
> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index d16e55706335..0b2ef9541f84 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -494,13 +494,15 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>  
>  static bool task_traced(void)
>  {
> -	u64 pid_tgid = bpf_get_current_pid_tgid();
> -	pid_t pid = uses_tgid ? pid_tgid >> 32 : (pid_t)pid_tgid;
> +	u64 pid_tgid;
> +	pid_t pid;
>  	bool *traced;
>  
>  	if (!has_pids_to_trace)
>  		return true;
>  
> +	pid_tgid = bpf_get_current_pid_tgid();
> +	pid = uses_tgid ? pid_tgid >> 32 : (pid_t)pid_tgid;
>  	traced = bpf_map_lookup_elem(&pids_to_trace, &pid);
>  	return traced && *traced;
>  }
> 
> base-commit: 148cd3adf2df9e53fd9b3070ae1178d4876f8c67
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
