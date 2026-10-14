Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020088.outbound.protection.outlook.com [52.101.195.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66396374A02
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989475; cv=fail; b=ee2aOEJvqixIqZc5Lcl5QJAAlReKSH0ayQruqm8p55HqVZQPkl1R+c7Au4WM12Zuz5imS42J0r6WPrND+xYyNn5+mi5RWoZOIXH3OsGh+7cYzsfiwrhE/easnszkFYeLCsgnE0OEttORgyw67b52Hpn5Uorqyrq2xfgibXy3Jcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989475; c=relaxed/simple;
	bh=Jk3JNMLr3k816eCtmFQXCFMyjI2kKlydJeqPfAd28N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qYa1mJ/2lxJ0jAK+038lec8W4IP57TOD++tmNVFJYcZOCph3WnY3s9ODWJbo0qb1kSqSVA5Cza3B5JHNz/zpuZkdU7WOYdlj73oK6DaLTm1+zyby6lVLVTd63U4aZpYsLOOZHO64qedHg9gSqW/Dm92j3zptFz+UitDSrugbL8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUqfJQmFemVfL04vRu/SYmFL4tRWC5jmkN1xeytS8xTEYruBLbSS65AwcDsTgoEiPo3xPbLE3YtvxxYW/uexCnGltKmcEaJCpvDEr4cHFQ2mZu9kAb7EkVKS8esrIeWtgsdQTCp1dyjF/IolXdSo5baAU1b7dqjzark5UfgXrwyJ2uAVyOHSGpJoSeUwrs5LIpGyIKiu520gnicUMcS8IQtsPgQnKkZXReLyHJ2YTbtqagSa0oHlbiMrZMVwHLSrQK6ACUws2S5+1TWQwiQ6cfV/Nx1dl/0KOPRdk0kezcWO9Kl5wuGRKASAxOoa9CUcnywHfGGjdsY15w3ZmKDaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Lrx9N0fgT9sgevq8jYHQFzhbh7uaADpoMB45f3xnGFs=;
 b=heYPzmqNHwHRk0ipDSJBiZjFhLp82UEiyHX+7wbkwtcQw08JoW1bjUnWhpWDowFL59LHvx1iRNwq0DCZHO3QQ3mIh6vucHghbju6UwSeiKr/rgMUIjOb53n8nPYfw5mf6ok/gHvz4oZ1swVAIAJwCr0/7tvV+Evlmv7RUnDP7XmFeiR8oWlyEvzgi9xSxki4tuqHc4Mp2Pq4GJcPp+05GYT2kya5nwHRP9qMcxvWXT+TzHC4oYQH3heKxCgJ4RIYRYcAaVGX5Z01TJFFl1w2R6KTlqNWRNr0zr/2u7kCmT+aQvv5Tv+rzikHbHa5bXi8d+3HTSEWC4QYuf6OuFeCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8606.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:51:11 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 14:51:10 +0000
Date: Wed, 14 Oct 2026 10:51:06 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v3 4/5] perf ftrace: Support omitting
 execution duration in function graph tracer
Message-ID: <rv2vdvtfvydg6q6fc3tu4yfqzlp34hbglmseiwjctpwqd6gten@ttubaenj5llq>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-5-atomlin@atomlin.com>
 <sashiko-outbox-167528@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-167528@kernel.org>
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 65585c86-7b06-4f94-363d-08df2a0295bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|10067099003|3023799007|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XQ27KSB2AQqnsz1l96cHSTirV3RbbygWfiPzmJM6DSshbqvnA+OQRm9etWJLR7e+oq9RykxAnPnQjdFTyiwgP/gLRFTvdVAZ3ITDetnd46fkBxlXWeQjCgzuXa29Me+4tE+dXHw7cN/+xxjIL6ZIwm+/aANeqgFuBLjPv8e1+Z5fW9BPghhOLAs4t6icBT4xwpVszTeCH/ZhsD8WU1icELNlxD/Bckn5fKUo0RxMURyFp28AnPFmSJbSZadCw+aVP9r7cIPZIwu5PLTh9T8DYv4sKe9mpArWS1DW5ylT/Pq2DlJSwsSoNOjaO8I9V7CPaggQwi2blKKLBjyEYBUWfS8BP+AnIOefc2BiQrjvGL3WJontXzxF0oTjlRaHdl6HHg0VktBzhF+EGqpkrMxhXxKxY3NWAXXgfaZENd0kHpyo+HxnTel+o688W0XRG6UUEZy3kYZdeFvXiogv1sHnqnHb/sDAKalp2Wfc2A+fgCXSd8s/L7z/QhP/TLWMPxM/iT/ly8D8ACcoKv8IMVe9htkQK/bVl9rd78Vf9e7IzYcd9T8SFZm5By00Rgik8xnO4jKG6plf04h9er+K0jZ+KMes8ns0QBSED2dNEVKtPeegIXCqmtkDB7wRa0Zm1wvTK6skIKls1B9yP+SBS1n1r9mBLO15S57NObJcOKPRr9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUVUc0tOZllhckRrVzlSSVBJcjdIYXppa0Z1OEN6eGNvZ3dUaDE4bi9zdGQ4?=
 =?utf-8?B?SE9qUWVpUFc2UmZFbW1wQU5xVDhlempuYmcraENyOG1IU255VHdBNHdUdEZ0?=
 =?utf-8?B?ZGlWeTZkanBVejlXYzhUSU5xOWRtNXJLSi9IS3l4cmxYams3YXJ1WVU1K28w?=
 =?utf-8?B?eENlNTJoekhDM3RMSkV6SEtrVEJmbnBUVDFXbVpTeldIZXJQazR0VTcyQlU3?=
 =?utf-8?B?SmJLMmJBQkR5U1NEbithckVGVDExVGdiSWVxRUdhSFFpeW5OYUgrYTR4MGpG?=
 =?utf-8?B?QWNtdDRwc3dkSm5lUVpTcGh6M1lBVGhGRENSTG50WUwyUTUrUGRKS1R1VW1l?=
 =?utf-8?B?b0hBNHpYMHJVa09sS3pxbVZlbmJzS2FEQlhMNzFZb0xWcWwwNVM2VmF6RWp4?=
 =?utf-8?B?UFRhb29xR0s5dHhPSi8vZ2lnaFlkYjRyYXg0alIwOGdDSnpReTJDZ0ZTQWhn?=
 =?utf-8?B?ai9nSlk1cmQ1bjFXUXB3bFQvMW1VTlRBYVEyVkdLUHBsRzdTTGF1WW9LZTU4?=
 =?utf-8?B?N2JYRzVpM0JGaTlpb3BzbU10QVVYVzFlYWtsd2NIWTJ1NGRqenVKK29tT3BY?=
 =?utf-8?B?QnA3OWhPZnRubTdUOHJ3QWN2UkVUQlMxMjR1SFJhTVJTdjNzdVVEc3lXeGdi?=
 =?utf-8?B?KzhzckVWVTNJUlFjUFFwcnd0Uk9KQ051TkxITUNtenBHYld3VVVRMm4rWC8r?=
 =?utf-8?B?ZmxLN0JXTHFISEpjaG92Y0JjZnMyWmltS1FkU3JabzdPM254N3ZRZXA5aDFB?=
 =?utf-8?B?cXRMcGtWRXlQbDJKa2tjZUtRL21XQjVOeVowRG9aWGx0TWlwc1FpRjEvZkZs?=
 =?utf-8?B?eE96RVBNTU1vMnR5bGxuRjRnYm9YNzR5YXRRNDhrQmw2S0c1cmtYaG5VTS9D?=
 =?utf-8?B?TEtIMFJtWC9iNGppbWlPOG5nRjN1TjNJSW9HQUxJR0Y0Mm1tckxEbXptZjdU?=
 =?utf-8?B?dWh1Z3E0K2lYYzNLbkpad3ZocGdXQlo3Q1UvNnE1clhVZHpVRktFMVk3REpi?=
 =?utf-8?B?d3E4Y0lJK0dpMldOTEltbERubi84RDAxcU5Nb20yaVJyblBOczdobEpScmhR?=
 =?utf-8?B?c0g0aTBJcVJmSnpvRitEVWdQZnAwV0t6MkVtS2MrSkhxSEIrSWpkQ0VGTWt6?=
 =?utf-8?B?RkVwZUhqeDM1TDhlUlM3ODJNcG5uam9HSlpYd2h4aG8yaXIwMzVXOXd1SFNH?=
 =?utf-8?B?ZGhKbE1iN0JINmVJUnowakxYR1Ztb1lUTHpkVHVpRUZHcE1RT1pmZnl0UnI4?=
 =?utf-8?B?QkVld0tDL1hvclhUMWYxeExhOG9SQm1zTGFJMzM5eGc2WHhsMnVBemRGd3Za?=
 =?utf-8?B?c09EQzZLZUplQUJYOFc4b0p5MmFsNWRUMndDNHJDdm9KZVNzUkhYbUZwM2hJ?=
 =?utf-8?B?VXNHMndjR1dvazdlSE1RckIyOWNOc3Q1MmVuVkxyNDFrNk0ySnNSYWNNVU0w?=
 =?utf-8?B?U293NTJvanlTRm9zUzFNbVc5ekhaSFFjV0QwMHBOeUxtdGRWam1WY2owckhi?=
 =?utf-8?B?aVhlWS9zd2F5TVNzSDl5bEVWaE82YXBiNkptY2IxVm9XWlI1VGdrbTMvUXV5?=
 =?utf-8?B?SXFHSmRoQ3BrV1FvZzR2SjdZeEtxdHBsME5kcC9uTnBDK2NTcFh3YnlMeDYz?=
 =?utf-8?B?ck9QUjBNZzIyWHpLaDNNNzQ3dFBmUHpESGhGaUtaakMyanJUeWpMRFUxY0VF?=
 =?utf-8?B?dmJ2bHFGZE1YK0JvTFk2dXdpT2M1M3dzUE9DVUlpU0hDY0dwTExRdkZwRUpR?=
 =?utf-8?B?M2p0VStsdW9vMFIwZ3FqR1lSWDlvdi9YTEZ2VVFyendGVW1DSFhja3llR3Uy?=
 =?utf-8?B?cXI2TU1NQUt0anlYMEtGQjNUcXlZVlQ0dFRpN0xsYjR4VVhqRmRWRDViT0R0?=
 =?utf-8?B?QTFtaDd4RDY2YVZSbzZ6dHRWVmI5ZTBEMlkxRzAraFlSRDRleWNnaWR5WjZr?=
 =?utf-8?B?ZERHN2UxYmorOVdVcloxQjJOTmVEZDJTUWVDMHNlcGtkOFBPcjY1SDdTdHZ1?=
 =?utf-8?B?THQzWTB6aWNoSFJQTmQwczRjWlp2MDlhUTRCZGNEdmh2Z0hJdldNSkpwK2M5?=
 =?utf-8?B?eVdMNDhaVFREamhZNDFRRGZFOEpEYkxHUTFqTjU2Z2QwWFNhbUt0YzByVHBa?=
 =?utf-8?B?M2d5OXhUNWVqUVhoY0c2L1hiNVFYc2tReE9mVXNXbnpmUlEvdUU4RUluVXFz?=
 =?utf-8?B?ZUNiSTBnUDhZYnVFOTFLVkRDaFZLNFMzOFpETWU2V21jdGU0UEF5cDV0S0Ez?=
 =?utf-8?B?RDFNQmd6aTN2VG1QZ0xWL2NhbzZNYnBVU1p2VTFDUmE2VmhDakE0a3NDNllF?=
 =?utf-8?B?czFjRkRBcjVXUnRock92Zyt4d25iTXNkNGpRTFgrVEtKMWF6MlY0QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65585c86-7b06-4f94-363d-08df2a0295bf
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:51:10.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXM6ccR+1YC3z9ycAR6U4XCcIIxm8l9Q60o29VEcu/JKt373iNw9a261yPXqrws8ms9E+cIPRybc6Clkn7HnUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8606

On Mon, Oct 12, 2026 at 12:39:20AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Does adding noduration here allow it to be used with the profile subcommand?
> 
> The profile subcommand inherently requires function duration to compute
> statistics. When the duration column is omitted, parse_func_duration()
> sees no " us" suffix and silently drops the record:
> 
> tools/perf/builtin-ftrace.c:parse_func_duration() {
>     ...
> 	if (strncmp(p, " us", 3)) {
> 		pr_debug("non-usec time found.. ignoring\n");
> 		return 0;
> 	}
>     ...
> }
> 
> This results in an empty output instead of rejecting the invalid option
> combination. Should the option be rejected when used with profile?


Yes. Since profiling requires execution duration to compute min/max/average
statistics and call counts, combining --graph-opts noduration with the
profile subcommand is nonsensical and produces empty results.

In the next iteration, I have updated cmd_ftrace() in
tools/perf/builtin-ftrace.c to explicitly reject this combination:

    case PERF_FTRACE_PROFILE:
        if (ftrace.graph_noduration) {
            pr_err("Error: 'noduration' option cannot be used with profile\n");
            ret = -EINVAL;
            goto out_delete_filters;
        }
        cmd_func = __cmd_profile;
        break;

> [Severity: Low]
> Will this corrupt the comm-pid column when verbose is enabled alongside
> noduration?
> 
> When both verbose and noduration are enabled, find_func_column() returns
> the CPU ')' or the separator after it. make_blank_prefix() uses the final
> pipe_char and overwrites everything after the ')' with spaces:
> 
> tools/perf/util/ftrace.c:make_blank_prefix() {
>     ...
> 	/* Replace duration between ')' and '|' with spaces */
> 	if (paren && paren < line + len) {
> 		char *end = buf + (pipe_char - line);
>     ...
> 		for (c = buf + (paren - line) + 1; c < end; c++)
> 			*c = ' ';
> 	}
>     ...
> }
> 
> Since there is no duration field, does this blindly overwrite the comm-pid
> column and its trailing separator?

In the initial implementation, make_blank_prefix() did indeed assume the
duration column followed CPU ")" and would have clobbered comm-pid.

This has been resolved in the next iteration:
    1.  In make_blank_prefix(), we now return immediately when
        graph_noduration is set:

           memcpy(buf, line, len);
           buf[len] = '\0';

           if (ftrace->graph_noduration)
               return;

        Because no duration column is present, no characters need to be
        blanked, leaving comm-pid untouched.

    2.  In verbose mode with duration enabled, make_blank_prefix() scans
        backwards from pipe_char for the preceding "|" delimiter, blanking
        only between the comm-pid delimiter and the final delimiter.

    3.  Unit test coverage has been added to tools/perf/tests/ftrace.c
        verifying that comm-pid is preserved in both verbose and
        verbose-noduration modes.

-- 
Aaron Tomlin
