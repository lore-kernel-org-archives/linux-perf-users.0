Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022076.outbound.protection.outlook.com [52.101.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465251AFF9;
	Wed, 30 Sep 2026 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792563; cv=fail; b=B1AUCYuLtYcuvG2hhH8MO4VOg7ci4KV6cwy2iPhTbif9joAX2T1cKGTWg2A6Cm6caxpjh3TqOBw2Zvc5Sp/cC8TfNdB8AofgjGDfSYZpKhTeBM3BZFxBOGqQVIbFaJnGxkjY8JygZXnKt3Rf9Ifp2Tag2fwlfkRcFvKhd3dpBTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792563; c=relaxed/simple;
	bh=JNJ3PVEuftB0p/djmJS4DbLyQXCKpv5tI3Jz+iyH9hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m8EtOT+z0gzGCfI/t7OVsXLBFT70hXlUe1Qn3rGQp95hVXroO4ADgFVmlZP6DKbcJ3D7BVeFn2k9Ejf+KNZMfgW0NnsjnoYoWZOeejAx2fwV+3EeTFn4eiwNpAWvP3wK/qd36/fltGj+kNIlnbckXPnl08WXJM6vpgLKAxUFbeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzkFSomsXK39Hhbqe5EQLnVm99qMOaBZBwUw/CuLRxQXPB4Xkib+s8dU5SU7g4SzXCQbP6MH/XBDk2hQQl4KTdrFfmefam7oNjZFWk8PE5mOm5yQaLmf8peOxMB5asbi/5oQOnWWXXZLWxpJYfo8E0zrc1Y5QQbIiM2qn2SkxCsWUtdWyiT22GUA+AEXt1n2AOfT5w5JGAaBOilShEEKJQW1c6zih0l/UEIWL8PC1hOi7i6fV+VkndjMjmhNsVnZY7ZhgbrpU1nR7QlEDdXoqVFbLRZx4yqu1Hz/wIydURILSjK8oFrjLxDeFj0TTK5gH3zxb3Rw0Sm5YBq1Sni/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=AdhSIpD0x+VrRxR2Y4T8iizFwzovyXP7EAy3hTW8d60=;
 b=jLSB/l2FfTk2406p2R/W9CEZ0S4iMEuQRjKrNans/+WHYEkoCbVM9ei5yYkIiRGI1dq1Xz+EaC2gWqp+r7korvfY+q+MlvJWB8Etvixope+WBg/C3UqJolT09ZxztJCCMVZ3+6aNgROAkZW7lOjwKxCuW5SB2+2p6mpm0DG/D/W46v0viY7i3apbpZ4pPBTD+SW2esJKHIOZbgAKf4gOaJUoYIFBEyjhM3WTmVPx9QNMD1uZg6xgQqmorMaaJ6HFs6GD6p0HMnD3u0ZOw0kJ2Jjh36uaHN5tWqeudBc4D15XUOk6+2znrBLwRVBcio2uGRVYxpB186bX9MkLWuC2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB6998.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:343::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Wed, 30 Sep
 2026 18:22:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 18:22:37 +0000
Date: Wed, 30 Sep 2026 14:22:34 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Jakub Brnak <jbrnak@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/26] perf trace: Bound the fixed size augmented
 argument beautifiers
Message-ID: <r4uzrbjmhlwogshwlzz2346fbgehlpgise6rqhzeibgelqedkg@ezlubngls5pw>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-6-irogers@google.com>
X-ClientProxiedBy: BL1PR13CA0283.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6766be84-a3a1-4c86-1f7d-08df1f1fce31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|22082099003|18002099003|4143699003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bSdLF7g6GygOlMtmP405YJsEWEwpKtO0c7KUXvS38IjQndGx2GaNJ1LlBU6OEAtnuz3EGipSJDpkMJmprJ380XACeKxZ7NbbZMKD93mWPzJmxewoBMxhwCyFcl1BbnDcEsSur2PPR8iHsPIkfaKS29YT6YBpwvQTxCDd+RQXBRCZBGLQez7s3jAFZbDgtUQ5dv+y4A984w3yMWU+Hz6oVFo+zdXv8eONkEoV/hgpaOGHRXsJ1aAwht/mWmGNT3neiR9nLQZA/e1M18yfj5tWAd+wjnbhHKcFayHjQ+Bkd+cyK9dGrlcVB0rxt7o5yCZirJh7zV1S071GlRYbt3au2tiQL6K+DZPiAcBjOaJlly2P7NVxvTKR+XlOSFgx5BOuU0KXWt9X2yITMZ8nloD7YGzwQsYxGh2uMDEeo98ED9Ox7S1K65tTatPQ74SwFl+hqvebDj8nKxQXVTHLbGqZxcn05XIoFw63ekAdMDB6Q231SlkExDO8aDnUfPCEtp2KhLHqC5m0WopkN2Tb32SR+T5bp46Fiadj5E5+YDAO26d+FCr3N0JhwsU34YzALzBPJb/+4Bz9vgTn2MJaPIBS/5C9J8gNJv+xuGDbzS55FoO0KZaZQpreDeh5Ss2EGdzYVC6u8fAZzkICPSyu5wkjbh7aR/UXYNg6BeO3kMngUgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(4143699003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE9DNHNhR0xHYzI3M0hzVDRQSmZwNWJiTEh4SU9KelcyTHpkc2szNTlKbWtz?=
 =?utf-8?B?UXhDNDY4aDlWL0wraTBJUjBFN3R2VmIwQy9Kbmd5MnFpd04zRm5pdW0zdkly?=
 =?utf-8?B?cHQxajJEdllFSG9IMnphS1YxMHBVZjJYdjI5Qy9oMW9TdWI2cWZxU3M3OXNF?=
 =?utf-8?B?TmpjRDhOYUtDOFlOT1VrRUwwS3IvVlJpZWcrczM3cUpkSFpiVXJyQW9wOG9T?=
 =?utf-8?B?MUY0TThoVC9LVWhMZWZtVzdDaTRtS091UUV1dk1vNU0yM0pkU2huVHZ5Tm1E?=
 =?utf-8?B?K3NCQ1B2aFlRSXRHeHN6QXhyUUtVTlRKUVJmZ1h6OGx3VjdEYTVMTWZ0ZWlm?=
 =?utf-8?B?RFQzTnkxTGh1cnAxRWFUN0h6M2JrUWw0RVBwc3hKaGxTcVFobm9uNGhsRkdD?=
 =?utf-8?B?bFJVTnZ0SDdRU29aRkZUSGVuaStRaU53TTlxOTdGT05xQzJ6cDhaWmIrUlI5?=
 =?utf-8?B?R2xVSUpUTkl4RnNiZG1LakNoRmpaNjlpTk9QZ1p3MDdpcHhNT1BzWExwOUZH?=
 =?utf-8?B?cUtFNE5BR2dXeDZxUkVTcTB3VmE2QmRaZkpVOG40azl1NU9ocE9WQ0tTYnkv?=
 =?utf-8?B?ckhYcE54aTF2WFdmQklpbExVZ0VkUHNmY1lTS1BHcCt3WS9CelVLQ1REYm9X?=
 =?utf-8?B?T2FXTVNBZnl5YUhZYURhTWhyTzltVGFiOWtuV0FOY0hRSGFCeFpHYVJlVHhx?=
 =?utf-8?B?VVdMa1hxUXJCSUlSV25vOTBoNnpsRkJnN1hNYkd6K2tnVmRDaHRIQ0lQbVVW?=
 =?utf-8?B?UTBxZTFZMmloWlpMb01uaWtEUzdYQ1NZUEdjY1FadlhSeTdJbDNCdVFCWS9M?=
 =?utf-8?B?STFGaHByRXJpMWZqVW1LcXk3S1ZpZ0FqYVJJU1pUZW93aEpEQjBnc0M0dWhP?=
 =?utf-8?B?SHlnVGYwbFlIVTBBcnRGbEdxd1pPSDZLQlNVNGJmU2tQMWFtS1hkUTgyQ1dq?=
 =?utf-8?B?ZmErTktGQ2FlOVAxUFBWekxIZGVsWFJhdFlPNUpRa3cvT1BDQ3IyWjY2QmtL?=
 =?utf-8?B?Zm53YXlUNHowTEY0MENpcllpSDRtM2gvaS82bTdkdWdiTy9kTnRpdEc0WU5s?=
 =?utf-8?B?TDZjbWxlK3lLZlVWMFkzcjlBbjY2R0g2VE5qOCsvNkZob1YxWUtBRjM1YkNr?=
 =?utf-8?B?WjZuVnVpTkUvR3BreDVtS0xkcWRNakl3NzFxWXFJTURpbXVITEQ0VEFxM3lr?=
 =?utf-8?B?c0lvNEhERGpMQUlNM01vdmQ4TGdhUFlkNFJqRWtGZU1wNGk0Ump6aTJNL1Fz?=
 =?utf-8?B?UCtTNGRJYjB4OW16YlFOclVNZVk2NXNTaWs5ejZ5M0E5MS9XdDZScm9ud01y?=
 =?utf-8?B?dFJKS1k0ancrL21QRnZXbjVhWUI4aVIzTjZ4c2t1ZGVscW5LblZrRU5iSS85?=
 =?utf-8?B?RGxZSmljYjdMcXJjc211L1VvSEJyc2ZBSEU4d2RVaG9qNVVVNmxUZzROY200?=
 =?utf-8?B?ZEV2SFU0K2hZMU5ZNm42UVMvNHlVNTA3NTJFaW1YUEhmTXNvTm95V0RIY3ZC?=
 =?utf-8?B?QTRVODJzYUxjUlgzdWJ0ZlpSVWNSeWZaUE9OSUd3YUd6NDRvVFNGNmZNUDJx?=
 =?utf-8?B?aGdpTVBiMit1b2NuaW5ROGhEdHFoT0RZUHBkaXVXNW8rNnZDVzgxSElNRW9w?=
 =?utf-8?B?TUQ4OU1TSkR0VTFCRWs1cjhYSHdOMnJRMVJIbXUwVEhXcmpQVWlsK1E5OVZ6?=
 =?utf-8?B?bHpSSFJ5WTFBalRpZlRFbkdBa1l1NU5tcWgvblhTZ1ZEN20xOTFSeUZCMnE1?=
 =?utf-8?B?YmFoZXJOSk84VGl3WVdhb3hMNUlsTmVvK0Z4aC9qdmZtSEFVY2JPb3FkdDZh?=
 =?utf-8?B?VHNLd3J4MlI5eVVnNTBHOVZMMnFOckxMTVYxN3hsRW0yc21DMGEybXYzSnlI?=
 =?utf-8?B?Y3gway9Oa1hMWlk1dGVJWDgyTG9PSEdFSjVmdHRKR2pUWFM3NjRHdHdPWUxL?=
 =?utf-8?B?ZnRsc21rMHJuZzR6Y1V4QndYcldUdnFLb3hYaWloNUU5UGJOaFViQkxQRTMy?=
 =?utf-8?B?ekUybktVMHFQOFl6ZEdrNmdVbkZzYWNqNlpCVFJjN0hLMXN6Zk9DVWRwMXFx?=
 =?utf-8?B?a29Jd0dPVUFsSzJPNlFCc2ZzUU5IY1pWQURRT1hvZkFHUzNEaG14ZUI1TzFa?=
 =?utf-8?B?M1d0UDhuY0pkVXBGMUJkMSszSTFaUTZLUlNRMS9HTEZwekU1Y3puOUs1MjRC?=
 =?utf-8?B?VUliMzUzOUd0c0VPd29BNFVUS0MxQy85WVVLSy8vTkVtSkllLzFBMnJqb21D?=
 =?utf-8?B?UUgrRGtkZkNCU1JmbjRYb2p0ZDJycm53S3Vvb1hQbTlZalhZU09ua2pycHZl?=
 =?utf-8?B?WU5VYUxmajVCWlgxZ2F5R011SjFlakRTUlJmNjFNRFFGdEtFeHJJUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6766be84-a3a1-4c86-1f7d-08df1f1fce31
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 18:22:37.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNLjqAR2IbM+IJ8BmvSTWdCXwrM4Woran1sMDz91ZplgVBPlCyQZ4TsthC67FzttmI9juNDgFk2KTLkeGJHYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6998

On Mon, Sep 28, 2026 at 11:25:44AM -0700, Ian Rogers wrote:
> The timespec, sockaddr and perf_event_attr beautifiers read a fixed size
> type from the payload without checking its size. The sockaddr payload is
> addrlen bytes and the perf_event_attr payload is attr.size bytes, both
> chosen by the tracee.
> 
> Check the payload with syscall_arg__augmented_args_valid(). Pass its size
> to the address family printers, which also bounds the AF_LOCAL path that
> needn't be NUL terminated. Like the kernel, accept an AF_INET6 address
> without sin6_scope_id, RFC 2133's 24 bytes. Copy the perf_event_attr into
> a zero padded local, as perf_event_attr___scnprintf() reads a whole
> struct.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/trace/beauty/perf_event_open.c | 31 ++++++--------
>  tools/perf/trace/beauty/sockaddr.c        | 49 +++++++++++++++++------
>  tools/perf/trace/beauty/timespec.c        |  2 +-
>  3 files changed, 51 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
> index 6315b46bcdf0..bfdf322c6ede 100644
> --- a/tools/perf/trace/beauty/perf_event_open.c
> +++ b/tools/perf/trace/beauty/perf_event_open.c
> @@ -81,33 +81,28 @@ static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf
>  
>  static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_arg *arg, char *bf, size_t size)
>  {
> -	struct perf_event_attr *attr = (void *)arg->augmented.args->value;
> +	const struct augmented_arg *augmented_arg = arg->augmented.args;
>  	struct perf_event_attr local_attr;
> +	size_t copied = (size_t)augmented_arg->size;
>  
> -	/*
> -	 * augmented_raw_syscalls.bpf.c (shipped with perf) copies
> -	 * PERF_ATTR_SIZE_VER0 bytes when the tracee passes size=0,
> -	 * but leaves the size field as 0.  The payload size is
> -	 * guaranteed by perf's own BPF program, not externally
> -	 * controllable.  Copy to a local so we can fix up size
> -	 * without writing to the potentially read-only augmented
> -	 * args buffer.
> -	 */
> -	if (!attr->size) {
> -		memcpy(&local_attr, attr, PERF_ATTR_SIZE_VER0);
> -		memset((void *)&local_attr + PERF_ATTR_SIZE_VER0, 0,
> -		       sizeof(local_attr) - PERF_ATTR_SIZE_VER0);
> +	/* Zero pad, as the tracee's attr may be smaller than perf's. */
> +	if (copied > sizeof(local_attr))
> +		copied = sizeof(local_attr);
> +
> +	memcpy(&local_attr, augmented_arg->value, copied);
> +	memset((void *)&local_attr + copied, 0, sizeof(local_attr) - copied);
> +
> +	/* The BPF program copies PERF_ATTR_SIZE_VER0 bytes for size 0. */
> +	if (!local_attr.size)
>  		local_attr.size = PERF_ATTR_SIZE_VER0;
> -		attr = &local_attr;
> -	}
>  
> -	return perf_event_attr___scnprintf(attr, bf, size,
> +	return perf_event_attr___scnprintf(&local_attr, bf, size,
>  					   trace__show_zeros(arg->trace));
>  }
>  
>  size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t size, struct syscall_arg *arg)
>  {
> -	if (arg->augmented.args)
> +	if (syscall_arg__augmented_args_valid(arg, PERF_ATTR_SIZE_VER0))
>  		return syscall_arg__scnprintf_augmented_perf_event_attr(arg, bf, size);
>  
>  	return scnprintf(bf, size, "%#lx", arg->val);
> diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
> index a17a27ac2a6f..b4b188879598 100644
> --- a/tools/perf/trace/beauty/sockaddr.c
> +++ b/tools/perf/trace/beauty/sockaddr.c
> @@ -2,6 +2,7 @@
>  // Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
>  
>  #include "trace/beauty/beauty.h"
> +#include <stddef.h>
>  #include <sys/socket.h>
>  #include <sys/types.h>
>  #include <sys/un.h>
> @@ -10,36 +11,57 @@
>  #include "trace/beauty/generated/sockaddr.c"
>  DEFINE_STRARRAY(socket_families, "PF_");
>  
> -static size_t af_inet__scnprintf(struct sockaddr *sa, char *bf, size_t size)
> +static size_t af_inet__scnprintf(struct sockaddr *sa, size_t sa_size, char *bf, size_t size)
>  {
>  	struct sockaddr_in *sin = (struct sockaddr_in *)sa;
>  	char tmp[16];
> +
> +	if (sa_size < sizeof(*sin))
> +		return 0;
> +
>  	return scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin->sin_port),
>  			 inet_ntop(sin->sin_family, &sin->sin_addr, tmp, sizeof(tmp)));
>  }
>  
> -static size_t af_inet6__scnprintf(struct sockaddr *sa, char *bf, size_t size)
> +static size_t af_inet6__scnprintf(struct sockaddr *sa, size_t sa_size, char *bf, size_t size)
>  {
>  	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sa;
> -	u32 flowinfo = ntohl(sin6->sin6_flowinfo);
> +	u32 flowinfo;
>  	char tmp[512];
> -	size_t printed = scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin6->sin6_port),
> -				   inet_ntop(sin6->sin6_family, &sin6->sin6_addr, tmp, sizeof(tmp)));
> +	size_t printed;
> +
> +	/* RFC 2133's version, which the kernel accepts, lacks sin6_scope_id. */
> +	if (sa_size < offsetof(struct sockaddr_in6, sin6_scope_id))
> +		return 0;
> +
> +	flowinfo = ntohl(sin6->sin6_flowinfo);
> +	printed = scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin6->sin6_port),
> +			    inet_ntop(sin6->sin6_family, &sin6->sin6_addr, tmp, sizeof(tmp)));
>  	if (flowinfo != 0)
>  		printed += scnprintf(bf + printed, size - printed, ", flowinfo: %lu", flowinfo);
> -	if (sin6->sin6_scope_id != 0)
> +	if (sa_size >= sizeof(*sin6) && sin6->sin6_scope_id != 0)
>  		printed += scnprintf(bf + printed, size - printed, ", scope_id: %lu", sin6->sin6_scope_id);
>  
>  	return printed;
>  }
>  
> -static size_t af_local__scnprintf(struct sockaddr *sa, char *bf, size_t size)
> +static size_t af_local__scnprintf(struct sockaddr *sa, size_t sa_size, char *bf, size_t size)
>  {
>  	struct sockaddr_un *sun = (struct sockaddr_un *)sa;
> -	return scnprintf(bf, size, ", path: %s", sun->sun_path);
> +	size_t path_size;
> +
> +	if (sa_size <= offsetof(struct sockaddr_un, sun_path))
> +		return 0;
> +
> +	/* The path needn't be NUL terminated. */
> +	path_size = sa_size - offsetof(struct sockaddr_un, sun_path);
> +	if (path_size > sizeof(sun->sun_path))
> +		path_size = sizeof(sun->sun_path);
> +
> +	return scnprintf(bf, size, ", path: %.*s", (int)path_size, sun->sun_path);
>  }
>  
> -static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
> +static size_t (*af_scnprintfs[])(struct sockaddr *sa, size_t sa_size, char *bf, size_t size) = {
>  	[AF_LOCAL] = af_local__scnprintf,
>  	[AF_INET]  = af_inet__scnprintf,
>  	[AF_INET6] = af_inet6__scnprintf,
> @@ -47,7 +69,9 @@ static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
>  
>  static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg, char *bf, size_t size)
>  {
> -	struct sockaddr *sa = (struct sockaddr *)&arg->augmented.args->value;
> +	const struct augmented_arg *augmented_arg = arg->augmented.args;
> +	struct sockaddr *sa = (struct sockaddr *)&augmented_arg->value;
> +	size_t sa_size = (size_t)augmented_arg->size;
>  	char family[32];
>  	size_t printed;
>  
> @@ -55,14 +79,15 @@ static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg,
>  	printed = scnprintf(bf, size, "{ .family: %s", family);
>  
>  	if (sa->sa_family < ARRAY_SIZE(af_scnprintfs) && af_scnprintfs[sa->sa_family])
> -		printed += af_scnprintfs[sa->sa_family](sa, bf + printed, size - printed);
> +		printed += af_scnprintfs[sa->sa_family](sa, sa_size, bf + printed, size - printed);
>  
>  	return printed + scnprintf(bf + printed, size - printed, " }");
>  }
>  
>  size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg *arg)
>  {
> -	if (arg->augmented.args)
> +	/* The family printers check the rest of the payload. */
> +	if (syscall_arg__augmented_args_valid(arg, sizeof(sa_family_t)))
>  		return syscall_arg__scnprintf_augmented_sockaddr(arg, bf, size);
>  
>  	return scnprintf(bf, size, "%#lx", arg->val);
> diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beauty/timespec.c
> index b14ab72a2738..8da0b28be0af 100644
> --- a/tools/perf/trace/beauty/timespec.c
> +++ b/tools/perf/trace/beauty/timespec.c
> @@ -14,7 +14,7 @@ static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall_arg *arg,
>  
>  size_t syscall_arg__scnprintf_timespec(char *bf, size_t size, struct syscall_arg *arg)
>  {
> -	if (arg->augmented.args)
> +	if (syscall_arg__augmented_args_valid(arg, sizeof(struct timespec)))
>  		return syscall_arg__scnprintf_augmented_timespec(arg, bf, size);
>  
>  	return scnprintf(bf, size, "%#lx", arg->val);
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Tested-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
