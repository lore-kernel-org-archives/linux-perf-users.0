Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D4C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0A4615A4
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 13:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhKRNVo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 08:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhKRNVo (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 08:21:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4820F61547;
        Thu, 18 Nov 2021 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637241524;
        bh=DnR/tAzcFkj7GhF6oyoCXGjTfQAoF5HPfUG1t4dCATE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZqCXswX+VTDySPGrnKMdOK6IZHxekqSWvsR+NgLPDja/yBLg5YL3ZYc/2fbJm0mY
         5vgsf9TW357jHz2m/bS7y5y8c6k6IfEJ0hqCU9WhTvBWDISfsuyh7kTnVFHJOeHQFV
         UFv9SwRmRjqyeKr4it+rzTZbuSWXBiTuIqx64VDAmag6yQjDzVvqSy7r0BM9r+AAQi
         +9lBLdlA04UEI63H4lyfxjv5zJnm+bPO2TYvPLwQKEqyUOs1EAkMKH8Q+emb0PB94m
         n8Y+bKv9Q6CCWA7Kv2MmWu611twq8QrTu6Q/SQBdjLd/WU5VeV001OgOmEQJtCZWro
         hfSMke/OlXb0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74CF44088E; Thu, 18 Nov 2021 10:18:41 -0300 (-03)
Date:   Thu, 18 Nov 2021 10:18:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Fix memory leaks around perf_tip
Message-ID: <YZZSsaPLcsIH2oKi@kernel.org>
References: <20211118073804.2149974-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118073804.2149974-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Nov 17, 2021 at 11:38:04PM -0800, Ian Rogers escreveu:
> perf_tip may allocate memory or use a literal, this means memory wasn't
> freed if allocated. Change the API so that literals aren't used. At the
> same time add missing frees for system_path. These issues were spotted
> using leak sanitizer.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-report.c | 15 +++++++++------
>  tools/perf/util/util.c      | 14 +++++++-------
>  tools/perf/util/util.h      |  2 +-
>  3 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 8167ebfe776a..8ae400429870 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -619,14 +619,17 @@ static int report__browse_hists(struct report *rep)
>  	int ret;
>  	struct perf_session *session = rep->session;
>  	struct evlist *evlist = session->evlist;
> -	const char *help = perf_tip(system_path(TIPDIR));
> +	char *help = NULL, *path = NULL;
>  
> -	if (help == NULL) {
> +	path = system_path(TIPDIR);
> +	if (perf_tip(&help, path) || help == NULL) {
>  		/* fallback for people who don't install perf ;-) */
> -		help = perf_tip(DOCDIR);
> -		if (help == NULL)
> -			help = "Cannot load tips.txt file, please install perf!";
> +		free(path);
> +		path = system_path(DOCDIR);
> +		if (perf_tip(&help, path) || help == NULL)
> +			help = strdup("Cannot load tips.txt file, please install perf!");
>  	}
> +	free(path);
>  
>  	switch (use_browser) {
>  	case 1:
> @@ -651,7 +654,7 @@ static int report__browse_hists(struct report *rep)
>  		ret = evlist__tty_browse_hists(evlist, rep, help);
>  		break;
>  	}
> -
> +	free(help);
>  	return ret;
>  }
>  
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 37a9492edb3e..df3c4671be72 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -379,32 +379,32 @@ fetch_kernel_version(unsigned int *puint, char *str,
>  	return 0;
>  }
>  
> -const char *perf_tip(const char *dirpath)
> +int perf_tip(char **strp, const char *dirpath)
>  {
>  	struct strlist *tips;
>  	struct str_node *node;
> -	char *tip = NULL;
>  	struct strlist_config conf = {
>  		.dirname = dirpath,
>  		.file_only = true,
>  	};
> +	int ret = 0;
>  
> +	*strp = NULL;
>  	tips = strlist__new("tips.txt", &conf);
>  	if (tips == NULL)
> -		return errno == ENOENT ? NULL :
> -			"Tip: check path of tips.txt or get more memory! ;-p";
> +		return -errno;
>  
>  	if (strlist__nr_entries(tips) == 0)
>  		goto out;
>  
>  	node = strlist__entry(tips, random() % strlist__nr_entries(tips));
> -	if (asprintf(&tip, "Tip: %s", node->s) < 0)
> -		tip = (char *)"Tip: get more memory! ;-)";
> +	if (asprintf(strp, "Tip: %s", node->s) < 0)
> +		ret = -ENOMEM;
>  
>  out:
>  	strlist__delete(tips);
>  
> -	return tip;
> +	return ret;
>  }
>  
>  char *perf_exe(char *buf, int len)
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index ad737052e597..9f0d36ba77f2 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -39,7 +39,7 @@ int fetch_kernel_version(unsigned int *puint,
>  #define KVER_FMT	"%d.%d.%d"
>  #define KVER_PARAM(x)	KVER_VERSION(x), KVER_PATCHLEVEL(x), KVER_SUBLEVEL(x)
>  
> -const char *perf_tip(const char *dirpath);
> +int perf_tip(char **strp, const char *dirpath);
>  
>  #ifndef HAVE_SCHED_GETCPU_SUPPORT
>  int sched_getcpu(void);
> -- 
> 2.34.0.rc1.387.gb447b232ab-goog

-- 

- Arnaldo
