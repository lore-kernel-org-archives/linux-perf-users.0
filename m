Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27839C636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BFB8613C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbhGOUSh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242943AbhGOUSE (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:18:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A72A613C4;
        Thu, 15 Jul 2021 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626380110;
        bh=Zp6r+KKce1IAM9OCmrlQzhCa/foaXmbrdVJoieCFVVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EvgPd0v7+LgkbdRdR8KCuil+lB177MJpFdy3gruYN7XupQ8HIaoQO+B2/SPvAjVQ0
         kpcVX/r6Y4XoGW4tca2ET730bpz1ca/Nvhu43DcmCex5fPfn0kOMuR786cf9OCBrQ7
         Y/el5cmtDPLOto0raljwyMYqUq0X9Z4xyCsaCBki570cOUC5yFhrO72RMQnnMvehxo
         keO1tWcAym5clREMrTiTEVbwONFIjE3cCIzYXnJ5iEcUWb5bKpwvWVGlz/wqsLFeEJ
         ImsVexSivL9YRg6FEGJycqsHQbiPd67GzkGsBKKfDTNf/L7AYADC2JAZHhFdkdxHUu
         ec22abOgK3L7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BFCD6403F2; Thu, 15 Jul 2021 17:15:07 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:15:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 09/20] perf report: free generated help strings for sort
 option
Message-ID: <YPCXSxlMBMOCJu5J@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <a38b13f02812a8a6759200b9063c6191337f44d4.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a38b13f02812a8a6759200b9063c6191337f44d4.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:14PM +0200, Riccardo Mancini escreveu:
> ASan reports the memory leak of the strings allocated by sort_help when
> running perf report.
> 
> This patch changes the returned pointer to char* (instead of const char*),
> saves it in a temporary variable, and finally deallocates it at function
> exit.

Fixes: 702fb9b415e7c99b ("perf report: Show all sort keys in help output")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-report.c | 33 ++++++++++++++++++++++-----------
>  tools/perf/util/sort.c      |  2 +-
>  tools/perf/util/sort.h      |  2 +-
>  3 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 6386af6a2612367c..dc0364f671b97d26 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1175,6 +1175,8 @@ int cmd_report(int argc, const char **argv)
>  		.annotation_opts	 = annotation__default_options,
>  		.skip_empty		 = true,
>  	};
> +	char *sort_order_help = sort_help("sort by key(s):");
> +	char *field_order_help = sort_help("output field(s): overhead period sample ");
>  	const struct option options[] = {
>  	OPT_STRING('i', "input", &input_name, "file",
>  		    "input file name"),
> @@ -1209,9 +1211,9 @@ int cmd_report(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "header-only", &report.header_only,
>  		    "Show only data header."),
>  	OPT_STRING('s', "sort", &sort_order, "key[,key2...]",
> -		   sort_help("sort by key(s):")),
> +		   sort_order_help),
>  	OPT_STRING('F', "fields", &field_order, "key[,keys...]",
> -		   sort_help("output field(s): overhead period sample ")),
> +		   field_order_help),
>  	OPT_BOOLEAN(0, "show-cpu-utilization", &symbol_conf.show_cpu_utilization,
>  		    "Show sample percentage for different cpu modes"),
>  	OPT_BOOLEAN_FLAG(0, "showcpuutilization", &symbol_conf.show_cpu_utilization,
> @@ -1344,11 +1346,11 @@ int cmd_report(int argc, const char **argv)
>  	char sort_tmp[128];
>  
>  	if (ret < 0)
> -		return ret;
> +		goto exit;
>  
>  	ret = perf_config(report__config, &report);
>  	if (ret)
> -		return ret;
> +		goto exit;
>  
>  	argc = parse_options(argc, argv, options, report_usage, 0);
>  	if (argc) {
> @@ -1362,8 +1364,10 @@ int cmd_report(int argc, const char **argv)
>  		report.symbol_filter_str = argv[0];
>  	}
>  
> -	if (annotate_check_args(&report.annotation_opts) < 0)
> -		return -EINVAL;
> +	if (annotate_check_args(&report.annotation_opts) < 0) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
>  
>  	if (report.mmaps_mode)
>  		report.tasks_mode = true;
> @@ -1377,12 +1381,14 @@ int cmd_report(int argc, const char **argv)
>  	if (symbol_conf.vmlinux_name &&
>  	    access(symbol_conf.vmlinux_name, R_OK)) {
>  		pr_err("Invalid file: %s\n", symbol_conf.vmlinux_name);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto exit;
>  	}
>  	if (symbol_conf.kallsyms_name &&
>  	    access(symbol_conf.kallsyms_name, R_OK)) {
>  		pr_err("Invalid file: %s\n", symbol_conf.kallsyms_name);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto exit;
>  	}
>  
>  	if (report.inverted_callchain)
> @@ -1406,12 +1412,14 @@ int cmd_report(int argc, const char **argv)
>  
>  repeat:
>  	session = perf_session__new(&data, false, &report.tool);
> -	if (IS_ERR(session))
> -		return PTR_ERR(session);
> +	if (IS_ERR(session)) {
> +		ret = PTR_ERR(session);
> +		goto exit;
> +	}
>  
>  	ret = evswitch__init(&report.evswitch, session->evlist, stderr);
>  	if (ret)
> -		return ret;
> +		goto exit;
>  
>  	if (zstd_init(&(session->zstd_data), 0) < 0)
>  		pr_warning("Decompression initialization failed. Reported data may be incomplete.\n");
> @@ -1646,5 +1654,8 @@ int cmd_report(int argc, const char **argv)
>  
>  	zstd_fini(&(session->zstd_data));
>  	perf_session__delete(session);
> +exit:
> +	free(sort_order_help);
> +	free(field_order_help);
>  	return ret;
>  }
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 88ce47f2547e3558..568a88c001c6cb5a 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -3370,7 +3370,7 @@ static void add_hpp_sort_string(struct strbuf *sb, struct hpp_dimension *s, int
>  		add_key(sb, s[i].name, llen);
>  }
>  
> -const char *sort_help(const char *prefix)
> +char *sort_help(const char *prefix)
>  {
>  	struct strbuf sb;
>  	char *s;
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 87a092645aa72e41..b67c469aba79587f 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -302,7 +302,7 @@ void reset_output_field(void);
>  void sort__setup_elide(FILE *fp);
>  void perf_hpp__set_elide(int idx, bool elide);
>  
> -const char *sort_help(const char *prefix);
> +char *sort_help(const char *prefix);
>  
>  int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, int unset);
>  
> -- 
> 2.31.1
> 

-- 

- Arnaldo
