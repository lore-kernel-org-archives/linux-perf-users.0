Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022140.outbound.protection.outlook.com [52.101.101.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF7370ACA;
	Sat, 25 Jul 2026 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949291; cv=fail; b=o4dTGqjHtcLUxJpYt2DpX0Oe8pYPDzoRhINDL/mPV1L7AIaSED8tEL5C++4mFwu0zpKYBCCJ5qpHUCdQjXcLpK6XL+m1XqmcnBuoCzu4CeWrI8RhYDiNj4nd4gn015kwab2xrDBZTyrn5i7s+wSEs/VSi6KJeMbeI3MkMT9zL7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949291; c=relaxed/simple;
	bh=b5SaUBlTnN74LsTjTqmwCgzEo9lINQuaLxdbd9mfuNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nAzePv7PMDZbFuyMvzqxsR4Bo5hdGsFggQLVTvwNs1gem/Wnnbm/w6k1jn7zG3GDRCmS/XTZmkVWZxsvzfEcROFZjvh7HYVAoCpDNn3BJSJDLDpp8CV6D8rG4MdsAyKaklbydh+BUHvKaxmR4Ugl6tOQE8jjXv/3CFHuG2NdM/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vE3pMkVUVZHh1Jz7170km/f3VlMJtjKd9ktekYjrYahEJXlk69sq3oYA79+vLuPnbD+3JJqs5ns3fy9MpKlNjfHzqYAx/41qnD5JB1MGAahbYYHY/YKghgv7Og8sa+iRnVZR58eUJvK19WXmRi7lMWKGqghkQg+k3ckTGF/r7FUetzyimeLjbFHY+u24WSv5mdlZHzGBZv444znp/q+fBECj39MNrn8oAoSB1rB1Uwe01lWMkn+CW8R7NhjfObs7qdBXFDh5KLL0SkTyKJWCgo8lcxe7kUmOpg+n8UQzsZ38l4hHt9QU2ElNHXvPtPJiPuN8X9I36bMAKq6uK/5zIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=sKI96TL1CGy5RrYd4c1Jhtzzc/JZScVoH8off1t3qKA=;
 b=BqWyZGUstBWz4fdDKZJb26BkF6qQ83VHwFUIX1Tg5kuXYSnr3AvzCGtf7414Wd5vlby1uL8pH/Yjdcm8Dm5ECLNpxdZ2qMK5jdStx30zC5KK9UVhq/IUk17W3mfcFGYKKTaLGL5bpth8hXFucQG7es6obRg4CIwrsHuyFaNHE6HIHOjI1NuTMvGm2PSiLv+NsgNEtkZPnQ529pJYplNoQIdHu8xfqi/nU4TshVF0RgAo2tOwuD7Sfc32GAfXF0qlX+ivQwL8pIBNUM1Ns1+nui4baeNGcthXEm1/qsq4G5KuVOwhqEYJnPiyNdeTfeTRAmHkTMK3pwaD1eEE5qbX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6857.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 03:14:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 03:14:39 +0000
Date: Fri, 24 Jul 2026 23:14:35 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, 
	sean@ashe.io, steve@abita.co, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched: Suppress latency table output when trace
 samples are missing
Message-ID: <ib7lgcr2k7rd4mr6egtk4yzqhukp4jhc5yutpz5kcymu4ujnns@gorcgl7znqpi>
References: <20260724142901.634761-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724142901.634761-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0754.namprd03.prod.outlook.com
 (2603:10b6:408:13a::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e921f2-750c-483b-eafe-08dee9fadd31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|56012099006|5023799004|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5wKjLVSkTb0wRMTOBHw+0XNJUqe4c9tdJz8NQzCRNSDva4skk58khliXUvkmYmK0e2IOzNOKmjHSk4I8cXeil6jBdLfohGqTyQYpTlptxaAd+CicztUy8eRRohYnApDRVIwY2O09RNatT0zONQHhb1AZ6KhXX6YJ4+/89YpncLuVHY1VY4qybaNPPed8MUQa5z9GTI2Fq6CzcRPPomgsHnkoLhwhcGdXVFw+6ZG7ErQ0L9LfU8H49v246C5mxuR3TqOUv0s8xm+2L6vH++k0KDX9S3KkFqVVpfdlGDkXxMjt7f9zhTeBuQ6fQxRBPZZ4na7xkFRSN55fzwSWys3eJ2a0/3xPGvgbQ0enu3pIqKf0euTkoUuzIkM6vz+YPs92mYdTJOO6ZXov6lsdmOrrm2m+MUpTCOa+MW41stgesjoYQJuxI32GtsqAJMkXByyWqMfh/0sxj+iIqH66FmYK/cVqq9WLh2BHejWmYacXb+rWpm7yylxpS9s0E/H3xdY67Jpdcy2QPjMqsL8K09elkn7ouhCHWNBdCEJXcMihyU0Iir7QgdFu9HC3zQZvkP0HPuAo6qvRg4KzzGAtce1c9RwYX1n6qzA5g25FjIZpdBYUsUfAqbGrBpwbtUU3Jrxi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(56012099006)(5023799004)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0swbHdxNzlDU1hqN2JpRm1WVlhJM29oaVBGTkJrT0Z1cy96Qzl0V1dEWlVh?=
 =?utf-8?B?VjN6dnQvNmhZZWxDWWRlSEhPYm5mT2dNMnFWNVdPcHdha2tOeVF1VnRQcWtG?=
 =?utf-8?B?ZjNndGFXemdNYi9OOFJUMzdRcGNFa3VJNEd2aDM1UFUyd1JmWjdiMVAxVVJn?=
 =?utf-8?B?V0hhdENkNUFxcnFwekhzcm5wL2RCbGY5L2JmYXhJell2Nzc1aTk3OXpSQkhm?=
 =?utf-8?B?WWs5TGw1RnZpK3VCQlRFNXQxTGJ3aUx2Y1lwSXdJNklQWkpNL3pMa2QveWto?=
 =?utf-8?B?eVlFY1gvMGM2S3ZjanMrdzBqVTBXUEw0SjVjcVZ4ZWxZWS9WMTBlbFl1aG5Y?=
 =?utf-8?B?L3VnSWEzUEJkNTdiRzlBQ1l2bkMyV29IUjNnWGtzdEhYMGl0NHBIKzVHMVVV?=
 =?utf-8?B?L2J3bFBEaU9mSjNUcHB3K1dTQmlWTVJ1eUtVcTJUOTJxcnFJQk5XYkRHd3NY?=
 =?utf-8?B?ZVJjaHprOWNwa2crR0h5cnFkMGRCc2pPaHNUdi8vMVZaWmxudHVVVUhDcVk5?=
 =?utf-8?B?SUJzclI3eVlNamZhUUZaRUhwdmFBV3VCMk9uQWJsR3dYb1pRelFYYThQbUtD?=
 =?utf-8?B?LzlIQkhLLzFnbzMrUENVajExRWQ1bFcwQUdkTlpKS1dMODlSZ3FKSUx1UWQ2?=
 =?utf-8?B?OUN4d0taOGdpWkhCSlpOVDgrK2p5ajN6VUQ1ZHVzVnRJMGFFUkxaVHVlQnQr?=
 =?utf-8?B?S3VwbEVPZkJxNGROKzZDYmZJQVoxNkZrZ0FuZkRtdjlieGtPeGhaTmJlMHdt?=
 =?utf-8?B?YnVTcGxLM20yYk42eEFmM1VsbHdqTjZYMW1BNDhuKzc0cUk1bjQvSFVwRFln?=
 =?utf-8?B?YTc5WFdCL3Y5ZjhnUTliWnZCNDExNVNPRVlHSnRkSTFNQWpkcHBtY05DdDN2?=
 =?utf-8?B?V1JiMWtkQU9GRWJLVXNjMm5SSGtxUVJkZW9MZ1JTZ29jWUZ2eVhMdS8xU3ZZ?=
 =?utf-8?B?QlYwZVNSSjJISHo1WWVOZlF4bFZkSU1HL2dPOWEwYnNJNTEwV09LT0NmdnNR?=
 =?utf-8?B?ZUlLSVBhVUVRbVROb2FJKzFady9ibE8xUjhpSzNMR3FvSlBUWG1IMjg0QWMr?=
 =?utf-8?B?RTJYbkd0eVkvdERKUmpjbGh1eWx5aXp1ZE96V2dXQS9ucTZpMmVhdnNZMS9u?=
 =?utf-8?B?eEM1bXJ2dWMwMnBUSjZvVHhaVDhqYk43UE9uL2xac0Z3bHVTWUFJZkRrQlBj?=
 =?utf-8?B?dkxnWGIyQ1Mrd3dkNEtDY1crYkw1eFFEdG93bjRKSlNhd1NRQ2VsZ0llWmF5?=
 =?utf-8?B?a3JhM0ZBbjlTWll3NUUwSUNBRHJTUVJZT3FEc0RsTlpLcTc1Uy9BQlNNYjgz?=
 =?utf-8?B?R29oL1gwOEpLQUF0MVFvZ0lLRDN6Y2NidnN6VjkxVXRjRVBQeTNUL2pwMk1J?=
 =?utf-8?B?bDVWYk9JUW0zcWxRalg2aEdiUXl0Y29rNlpxNkt2UHM4OTJaRStyaU9DQy93?=
 =?utf-8?B?WFJQWjV0eEQzWFQ2c0crZEFFQ21seWJNeWZnWjBmbjV1eC9iaEZKSXJUUFIv?=
 =?utf-8?B?dVhYSVAvTWlkS3RRM0d0UGdiZGp0blNLcWZqWG53YVhwemFMaUtpSWFwZ3Ix?=
 =?utf-8?B?TjNkQk1LdkcvUUZiSlJia0h0QlRYNUNWR0RLd0hGeDlNa2dwaktsdTJ3WG10?=
 =?utf-8?B?YzFlcG9lY1ZCc2V0U0d0ckNHaGlIK0ptREs4cXhuUTN0NUxLanNMeitVcGJH?=
 =?utf-8?B?ZGhmYmZWTkdCMmI3YVlIMkkxVXVkaENGWGVYWWhwVXhUVmZ4bnI5bkxVQmxk?=
 =?utf-8?B?d2RFVzJwSlkwcGpKYUlOKzBVQlJmVWEvK2FyL2ExUVNpTmUxaUt6ZXppZXpt?=
 =?utf-8?B?SmZzVWUyR0FEMTRreFBldUZtUktNRE9wM1FnWjg2NHAxL3MwM3Myc3NLc2VT?=
 =?utf-8?B?c0xsdVdzN252YkthQTFENkp4YzZvSVVQSTNzVW5FdHpiS0NJT1pHdGt0WElR?=
 =?utf-8?B?clF2UVFiMW5BM2lQWWlEaEZERWdCelVTb0xZNkM0S0RJUDlFWUlLWGJ2M2Mr?=
 =?utf-8?B?YVpWdnlFZG80Mm9kNlNQWjRaVVVyWXRsMTdyWVpGQ29xWnE1dlVXSzlydURU?=
 =?utf-8?B?WllXdU9xMGN4M1hzWm54M0RpTUlZa1ZnYndJV1B5STJSRW9MRWFWN1kwSERQ?=
 =?utf-8?B?cGtHQWs5ckhVSS9zVmp4NUNWcUliRG5CVzBvdFZ3bGZtSHRTQjU5V3AycmNp?=
 =?utf-8?B?eGFBWFRxbFdBMlQya2E5YmRadWVQWHFlWW1FTnB6WFdxSzF0cWhhOGdMVC95?=
 =?utf-8?B?SGwrNVlkREE3bFlRdit4aXpDL2s5RXVrZjZTNkptSG84a3RvNzRGMXJyb0NB?=
 =?utf-8?B?RTFDRGpBVVNGb21QQ1czMlpzT2ZhUGdGOTJHYkpKVlc5Tk51R3BKQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e921f2-750c-483b-eafe-08dee9fadd31
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 03:14:39.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQm24kh0DaUg8hwTRfP6UENbR1rkhLo3eSdRbEIxW+Z+RBz5nlWOmL8y6Zt51q0x2BLxYJrzRJV9eXUaQ+mPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6857

On Fri, Jul 24, 2026 at 10:29:01AM -0400, Aaron Tomlin wrote:
> When 'perf sched latency' is executed on a perf.data file that lacks
> tracepoint samples (i.e., a file recorded without the -R flag or
> containing only non-tracepoint events), perf_session__has_traces()
> correctly outputs an error message. However, perf_sched__read_events()
> subsequently falls through and returns 0 (success).
> 
> Consequently, caller functions such as perf_sched__lat() assume event
> processing succeeded and proceed to render empty latency header tables
> and total summary statistics.
> 
> Fix this behaviour by ensuring perf_sched__read_events() aborts early
> and returns a suitable error code when perf_session__has_traces()
> evaluates to false. This prevents superfluous table output from being
> generated when no trace data is available.
> 
> Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-sched.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 7fd63a9db457..b3cf678573e0 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2001,7 +2001,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
>  		.mode  = PERF_DATA_MODE_READ,
>  		.force = sched->force,
>  	};
> -	int rc = -1;
> +	int rc = -1, err;
>  
>  	session = perf_session__new(&data, &sched->tool);
>  	if (IS_ERR(session)) {
> @@ -2018,18 +2018,19 @@ static int perf_sched__read_events(struct perf_sched *sched)
>  	if (perf_session__set_tracepoints_handlers(session, handlers))
>  		goto out_delete;
>  
> -	if (perf_session__has_traces(session, "record -R")) {
> -		int err = perf_session__process_events(session);
> -		if (err) {
> -			pr_err("Failed to process events, error %d", err);
> -			goto out_delete;
> -		}
> +	if (!perf_session__has_traces(session, "record -R"))
> +		goto out_delete;
>  
> -		sched->nr_events      = session->evlist->stats.nr_events[0];
> -		sched->nr_lost_events = session->evlist->stats.total_lost;
> -		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
> +	err = perf_session__process_events(session);
> +	if (err) {
> +		pr_err("Failed to process events, error %d", err);
> +		goto out_delete;
>  	}
>  
> +	sched->nr_events      = session->evlist->stats.nr_events[0];
> +	sched->nr_lost_events = session->evlist->stats.total_lost;
> +	sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
> +
>  	rc = 0;
>  out_delete:
>  	perf_session__delete(session);
> -- 
> 2.54.0
> 

Hi Peter, Ingo, Arnaldo, Namhyung, Ian,

Please ignore this patch.

I will include it as part of a series for '[RFC PATCH] perf sched latency:
Add histogram and time interval options' [1]. Thank you.

[1]: https://lore.kernel.org/lkml/20260724201207.661300-1-atomlin@atomlin.com/

Kind regards,
-- 
Aaron Tomlin
