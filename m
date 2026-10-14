Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021096.outbound.protection.outlook.com [52.101.95.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A753163B
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988767; cv=fail; b=Z4nYA8xfwq+YRjzU78kdRaqpAg51xMbgAwl4dqQPS3S3hC3RoORYEOQMNyQeRuxzjvJtZcNuChqbDN+7DWMVSZmXtWvaWT3MGikAeOzm/J7FdTJBODIiOXMS6ie8pI+PqUwoURr1l+UcCNLB43ZbsTjKR0aMqNNGo4jtOLeW5HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988767; c=relaxed/simple;
	bh=jrQGAj7OQaLE+5SDFQMQ8hRmSuLVyHO62TjA/nC3818=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rYcz1fiZUChmoSp4sRQAt4zmxrW6ZS5sophdoDp6EuEHi4rumBgCdTlJpGpS92diWt39a9KTsYd5xUU7Ng4/GaiMn4vn3WMqs3q7UBkV1OBvyrRc3G9XxXpr37Oy7KrwiEeNyuy7VH2Fd1FrNGgyhQb3hLieQcJVGTTk2j9mnlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOttN/J74ud7g0euMw1+QQkbJCH71ndBMzpCYtPag6j9IJKNjchz0dQMxEwKrpirWNH50bwYe/cXMW6C2HDNF6oRXDLIpDFuEQEt2GMdhPG3cfXfLR0xsek9GJFOBdCzzeW9X9UVdLmhOmrWhLZJa1Fb6GPgOZZ4Yv6XDEpDRWFkjxGcC3RwXdhgJ6hTXZDpLHH8lSeuwpIWjymY/v8/YfOiN74cQ2ysAJL497GnXKRREcL72r2rj72XHGrpmvnur1sX6xEMd11q+iYCgVfyffBImznpxM29Gti7ga4EZaG8yi4VwiMltIOe+aND4DWwWBtPBup5UJrK55EMAPLeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=EJWwkqyf4c//zag0XyndsY5oBoNkA4gQ8b1VXnEyMvQ=;
 b=Q9iQIMfnB0k1vSGyDQAHpFAL/mqE5y2s4dNtGKxt5whI5an7YQ4nMbX8CaDBqQTRYNpBMq1IKnDlUQFx924//CEJG4EbKI8C9YLDXmu9Gt9axAXci9D7bOjea57qtcQ2+E38n5g9gKVN+Uge7bNza53Ll4nxeGSZRdXIo4hhCVvBUYVE5UX6G8cQGNLw0mCjxDPahBQjmAZWWr/NnGa6PIVEx4FyopbZb1muIfR38B3GWhxdsiLAGhCopl4zMRpBhJctdvdbhh2jP+Mih/3EgLPnPY9B4gjLUHtvUGs3AwZP7/RDlaPVF7iXwjWnTJt9FWLJfdjtujle3CxdJ+aXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB4165.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:b2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:39:16 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 14:39:16 +0000
Date: Wed, 14 Oct 2026 10:39:12 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v3 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
Message-ID: <445h66omrc7hxqhafapadhboqgknlzqhcdofugvjj3aklg45ud@i5bkq7ag2rk3>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-4-atomlin@atomlin.com>
 <sashiko-outbox-167530@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-167530@kernel.org>
X-ClientProxiedBy: BN9P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: c4162218-fc60-4382-45e4-08df2a00ec0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|3023799007|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ch/rY3EVrPMot+TDLd8GdGfmMqXeD5EIf2n0X6MQfRy/3XKMKl3yRkReXHlDWgllwA0nnKTY2XjAnu28LJIwYMhI8r00LihxA40y2OQJnLIwTP23tCjzANrjFPh0+KadeTaxgM4XsAdAWP5Pj0dd+D2LmvWtMjjwqFL0Ej3D2w4SXBA2TeYUCHOfHjMILw+ouZy2sleBQHLkdQ3WKi/xgLFaZct9U3WvtLGfH33GCuWXhm8hZWRjuLuM+UOYFvD8TBqFkDxYcw/7fIODx00PvEb6ZaK9v3HH/zqENUY9jGOH7zBcS9/lfu7IgxqgpCHo2kQJivb0d2vBR/pZH0J0JmuUIZrps059AsrQou8J0T+1jzkE4RKCYMPR5XJN0iUrjOOisOyedZrPFvalgjrVd1nkVPy1ybiHUlwKFlqYJ6xX0CJ1qDQo8Y9XVLfLHuv52QC35o+F77MArrwa63ro1l8rVo3dgjQC8PzD9Ao3com0yXTQBp3htoCXFdSH+OP3UvrUSOMaLhHsjYSDmcvhg8/JniSRpPYEnU2usgY2i9h8qXmFhE/Bx4qvNY9lYmKaqFnvBbjpgbOIrfn0bYPudO85RdAtKDitCPNDX1XqD60Tnq7czAiQhVeKUIvdCNgEsna9Ne9NvTZp22iGykYZKKKYg8xorju38wZpflwrcrM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFkwQ0dvK3lFQ0dnNzZwNityUHFxZkUvVjNOQ1pGbm83cEJKMXFBME1kNU81?=
 =?utf-8?B?TmdqQ21Jb3JjUWhYQytDcjlPdEV3Rlpyb05lUDdxeUFRL1RPNWp1MG5KTUFT?=
 =?utf-8?B?SUJSUk5iclVZM1F1eVZjUTV5VGNMNDVuMWU0MXJCRDdMNVJqcEpHdlBpa2VC?=
 =?utf-8?B?eCt2cFRDZDR1QlFndThCMHprWm5qQVBnb21HalZaTXVTazV4WmlBb2pGYjc3?=
 =?utf-8?B?V1FlcUZoVHRYU0Z5MC9JamZBU1ExQ2NQeDY4N0UyY1o3U3FmYzZYT1hZVmV2?=
 =?utf-8?B?azI2UWMrQ01GTHB5bWlpTTlOSTM5QnNyaWNjY3M4cldtc3VSNzBIdWd4NW12?=
 =?utf-8?B?eU5DcDczaUVjYnZpU0E4emMrRWIvTHMyY3Z6emtWb3NYbUFENUlYQ2ozTTZF?=
 =?utf-8?B?N0dzSFdyOHZ0eURzQ09MelIwSEZXTWQrOG1MUUhVeDFjckEzbDFLajdIcktl?=
 =?utf-8?B?d0ZOdzlGT2FvMW5YYVNTZTVkSEVOd2pXU3c3a1hybEZ0VFpvRVJQeGRoUGlE?=
 =?utf-8?B?TEtnUmphQmYxMVdFZ0p4UkE2SXdhaXFGWEVHdUsvMHdaUFl5Ny9nUGJNUDRy?=
 =?utf-8?B?MC9ra2xISmZ4dzAzcklMWWM3clc3ako2WW5JdDU4TElBRUJnOEFSN0UrZ01t?=
 =?utf-8?B?ZWlOVS9mclIwRG9kSHdTQ25kV1RIREJUZEFEOXdUVlhlcGlOS0FRMDE1SzlF?=
 =?utf-8?B?VmlweW5PeEpCR29sQzN3bWFkY3VJQWs0c3BzRjZ6RmJGY1o2dlhyWnJIVVdK?=
 =?utf-8?B?VzFkU2lsQlNhYUQrUHg1eFo3NHZGK0cydDZxVThXUjlQZDJ3V1dpMXo1bDV2?=
 =?utf-8?B?d0pvdDhMMlYvSzhZK2RUbDQvVS9COWhYWHJQQnM0NmFxZVFQSkU2Q1JEbDQv?=
 =?utf-8?B?Y1FodkdyTnA0NU9oWXlNazRNMDQyYjlMYlAwZjUzZ0svbVJtWGkrTEdpdmJF?=
 =?utf-8?B?c2dxNkJhL3IyQWZKRU5EUkZXQncycXFoemZ0bGIzcEszd0NqWC9CNDFYMFps?=
 =?utf-8?B?eHFFTzlydUoyQlVac1ZLNEVHbnozRC9XdG1POFJHams5Zjg5UXJqZkpkc1Vq?=
 =?utf-8?B?L0lIcUtlbDdLSjU4dG1GcEpIaXl1YWZVYTc2emhlTjQ3Q21EeTlTYy9nYy9X?=
 =?utf-8?B?dUtQR3B6R3lsM3pmM0pyQzdpVXlsSWhwZjNsdkhmY1BnU1NVdnJ2QVVVRi82?=
 =?utf-8?B?UVNWdDJsTXA4OE9IaDRvc0NzT0RaaWkrdkhGZTVmaXExVVIvemQ3T0FVKzVW?=
 =?utf-8?B?SmowU1EyNEp3d1dSNFBqdTRKcU5IMFBWcXJKTXB0L3ovVHBlR1NlS2lqSkZJ?=
 =?utf-8?B?YlBKdGVpbzJQcE92T2tIamlQRldmb2lMMVJ1L1ZRRW9yWVk5Y0dpOFU1QmdZ?=
 =?utf-8?B?eEU3MHFKdTY2OU4wNGdYb2VONU5icEE2NHdWT25UWGRDaTJXQ2VWQ2pYQW9C?=
 =?utf-8?B?aTJIdDRqNUJvbjUwZGJFQ0pWOG1qYlhVMmJXRUxRN2s0RkRFV2NqK3Z4Myt5?=
 =?utf-8?B?OFlrVTl2NHFBUFJxR08zbVQzQmdNa2VtV2lCMUdsckVURng4a1dnN3dRU2ly?=
 =?utf-8?B?QnpMTmlheXZVd2xYUStkRVRlbEt5Y2pJczJqN0twWW41ZDkvUlpocFR2bVFY?=
 =?utf-8?B?bzRYMW5QOEsrb2VBaXRKQzFUOHg0QUZrTDB3dFN2dXJHS0grVFpkamllRGJh?=
 =?utf-8?B?MEFMMjdVeVpNeVllS3hOd1pBQ3ZpVWd1MVhINDJOZEtzSFdNcTc1TUtnQ3Jo?=
 =?utf-8?B?dXgxZnVSSXl0WlUxUldHdC9mUkpJVkJGQ3dMRFlzaEJLbjk4MHNONTR1dG1l?=
 =?utf-8?B?VVpuYXBYSWtmRkdsL3AwRFhJWkVCcUpmdVlsU1V2dkZNbmY2MXFoa1BFeUxI?=
 =?utf-8?B?SC94M2grMm9aQnp4OXVhR1VDLzJCYm1wbGNUWUd5VUcwTHBWVFRJNWNZREt3?=
 =?utf-8?B?LzlPK0x5OGV5dEhwWWh3bjFRMTVGenorbFIvRDI2cU1GM0hmRVFPR2dVcVJj?=
 =?utf-8?B?SVRpUC9IWUNoSmRkYTBVZHg3YittSWZtOS9PUnZ0c1l6bmozS2haeVJWdHpE?=
 =?utf-8?B?MWorb3ZXWWl4dkVTR2ZqTytVcjkxSUZPNXozN1daV1lmNUQzQWZEUGJ6V05D?=
 =?utf-8?B?UmhlQ1o1TmErTWlnOXFVOVpzMzFLQ2FlUHJoejhsWDhKRFNuRTdlM3FqTXFy?=
 =?utf-8?B?UERoeXUvRHIvQm9SL0JQZVRZZUdmQXVta2VINEJyN3EwSnRtUDg5WGZrbkUz?=
 =?utf-8?B?WEdjMnJVa3ZHREYwVzhtSGY4eWZXbEZxdU1qSVlVcW5Pb2pnemZzY0ZYVk81?=
 =?utf-8?B?NFR3UFVWNkRvQmN5SEV1WHV1NWVKWmRCMXUxNGVYVDEwZ0w2ZDFkdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4162218-fc60-4382-45e4-08df2a00ec0a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:39:16.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1PJWxqv5u7ChK1GWM17wy0HDTI+md+LKGFD+7E4OH3RtH7BJPPBUH/xb4RjU9Pn7fobKn3eMZRBBSgN16f5HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4165

On Mon, Oct 12, 2026 at 12:43:38AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Is it possible that test_inline_processing() and other functions in this test
> file will fail to compile under musl libc?
> The perf subsystem guidelines require files using POSIX standard libc functions,
> constants, or variables to directly include the corresponding headers. This code
> makes heavy use of string/memory functions like memset() and file streams like
> open_memstream(), but the file does not include <string.h> or <stdio.h>. Could
> these headers be explicitly included to avoid relying on implicit glibc
> namespace pollution?

Both <stdio.h> and <string.h> are already directly included at the top of
tools/perf/tests/ftrace.c (lines 4 and 6):

      #include <stdio.h>
      #include <stdlib.h>
      #include <string.h>
      #include <unistd.h>

They were introduced in patch 2/5 when the test file was created.

> [Severity: Low]
> Does make_blank_prefix() inadvertently erase the comm-pid string when in
> verbose mode?
> In function_graph verbose mode (--graph-opts verbose), the trace output
> includes a comm-pid column and a duration column between the CPU number and
> the function name. This loop overwrites everything between the closing
> parenthesis of the CPU number and the final pipe delimiter before the function
> name with spaces. While this correctly blanks out the duration column, it
> looks like it might unintentionally clobber the task comm-pid string and its
> pipe delimiter as well, breaking visual alignment.
> 
> [ ... ]
> 
> > +void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace)
> > +{
> > +	if (ftrace->machine) {
> > +		machine__delete(ftrace->machine);
> > +		ftrace->machine = NULL;
> > +	}
> > +	ftrace_cpu_states__clear();
> > +}

Yes, it does indeed clobber comm-pid. The loop assumed the duration column
always started immediately after the CPU ")", which is only true in default
layout mode. In verbose mode, that span includes "comm-pid | duration",
wiping out both the process information and its column separator.

This will be addressed in the next iteration by:
    1.  Passing ftrace context to make_blank_prefix().

    2.  In verbose mode, searching backwards from pipe_char for the
        preceding "|" so that only the duration column between the two pipe
        delimiters is blanked out, preserving comm-pid.

    3.  Returning early if graph_noduration is set, as no duration column
        exists to blank out.

> [Severity: Medium]
> Should machine__put() be used here instead of machine__delete()?
> The machine reference is allocated using machine__new_host() earlier in
> perf_ftrace__setup_inlines(). The perf subsystem guidelines mandate strict
> reference count checking, stating that every reference handle allocated via
> _new() must be strictly paired with a matching _put(). Bypassing the refcount
> API by calling machine__delete() directly can lead to memory leaks,
> use-after-free traps, and LSAN failures.

machine__put() does not exist. Using machine__delete() is correct as seen
throughout tools/perf e.g. __cmd_kallsyms() in
tools/perf/builtin-kallsyms.c.

-- 
Aaron Tomlin
