Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECDCC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D11A60F51
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 14:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhHBOos (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233925AbhHBOos (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 10:44:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EA1760E97;
        Mon,  2 Aug 2021 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627915478;
        bh=sJWwqysH7JYnXzYI5IZmt2yWUBjHmLLt/xg7tbEgjqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6uQQVAvHrpTIo5AXQD5rIZEeujsT5rHIHVcNYc6K2eFrVtdIn5Uyv6nqM4/vxOgI
         82v/ZLG7ts4TdmvB0dukNgIaZbJbZ4KP+6/maoz9RA9rGRhVxY0GdnAgK0Lfkd/NA8
         CjuIZsoumxVB/XToSGAuoUXKIvWFdPukJvBW6Uwh5JRIC9Xao56pvQF+s9gdkIAKJU
         SUOEjJLdbG5EdnS6fdevAJ9DNkZk5Uu8Ar0HtDySmkt9pCtQMfzt4L5vFAUXvcdidk
         tY2bnk7SmITJbYgCfmwOIiB0kdkZd/K0s1sbsM6NevDn50pokFKT67rdSzA9jrBI9a
         K6U7Vtubi3mjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A967403F2; Mon,  2 Aug 2021 11:44:36 -0300 (-03)
Date:   Mon, 2 Aug 2021 11:44:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/6] perf tools: Add WARN_ONCE equivalent for UI
 warnings
Message-ID: <YQgE1CBje091cL3t@kernel.org>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729155805.2830-2-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 29, 2021 at 04:58:00PM +0100, James Clark escreveu:
> Currently WARN_ONCE prints to stderr and corrupts the TUI. Add
> equivalent methods for UI warnings.

This one and the the next 3 seem clean and useful, applying and then
waiting for people to comment on the coresight specific ones.

- Arnaldo
 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/debug.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
> index 48f631966067..f99468a7f681 100644
> --- a/tools/perf/util/debug.h
> +++ b/tools/perf/util/debug.h
> @@ -22,6 +22,13 @@ extern int debug_data_convert;
>  	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
>  #define pr_warning(fmt, ...) \
>  	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
> +#define pr_warning_once(fmt, ...) ({		\
> +	static int __warned;			\
> +	if (unlikely(!__warned)) {		\
> +		pr_warning(fmt, ##__VA_ARGS__); \
> +		__warned = 1;			\
> +	}					\
> +})
>  #define pr_info(fmt, ...) \
>  	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
>  #define pr_debug(fmt, ...) \
> @@ -55,6 +62,13 @@ void trace_event(union perf_event *event);
>  
>  int ui__error(const char *format, ...) __printf(1, 2);
>  int ui__warning(const char *format, ...) __printf(1, 2);
> +#define ui__warning_once(format, ...) ({		\
> +	static int __warned;				\
> +	if (unlikely(!__warned)) {			\
> +		ui__warning(format, ##__VA_ARGS__);	\
> +		__warned = 1;				\
> +	}						\
> +})
>  
>  void pr_stat(const char *fmt, ...);
>  
> -- 
> 2.28.0
> 

-- 

- Arnaldo
