Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B903C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Oct 2022 14:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiJZOBZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiJZOBW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Oct 2022 10:01:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9F663F0C;
        Wed, 26 Oct 2022 07:01:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30811B82259;
        Wed, 26 Oct 2022 14:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC2EC433D6;
        Wed, 26 Oct 2022 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666792877;
        bh=R9119p0kzZ/XHUY574VzzBeSg9UAtdALLoAXCoeLt4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7rF2UUx7t03UEeEUm13B/I0WcLJy3Kb1R4Jw6c5p/HZs/+AdeZnU7rqg8CIcvPUn
         ycen2pyThzKLgjCHqGW2kyBjQ9HdNccN19qApROSh3xEw6leSE26g+4ikvza8jdDiT
         YhnRctqdfPkNRx43QX6OFrZRtYgGvW0f3GnCVFAm1/gcKugAk9C0tGPS/H2IzSKVau
         XEFxyrZzAooFFcS/HzQZxme1iVv3AwIJYnHwBuNAYQkaGdlErYiDsJCvuQeGN+QseM
         eOsCYTdtCDkaE4dIEuiRLgAA3pqOuqwG+aWbdynNcyhE52AAmxclC+6zaRJkvx7bYc
         P7hLGfAWREgbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20294404BE; Wed, 26 Oct 2022 11:01:15 -0300 (-03)
Date:   Wed, 26 Oct 2022 11:01:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Fix address filter symbol name match for
 modules
Message-ID: <Y1k9qwNKy/fJVjn1@kernel.org>
References: <20221026072736.2982-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026072736.2982-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 26, 2022 at 10:27:36AM +0300, Adrian Hunter escreveu:
> For modules, names from kallsyms__parse() contain the module name which
> meant that module symbols did not match exactly by name.
> 
> Fix by matching the name string up to the separating tab character.

Thanks, applied.

- Arnaldo

 
> Fixes: 1b36c03e3569 ("perf record: Add support for using symbols in address filters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index b59c278fe9ed..c50eb2bfc518 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -2321,11 +2321,19 @@ struct sym_args {
>  	bool		near;
>  };
>  
> +static bool kern_sym_name_match(const char *kname, const char *name)
> +{
> +	size_t n = strlen(name);
> +
> +	return !strcmp(kname, name) ||
> +	       (!strncmp(kname, name, n) && kname[n] == '\t');
> +}
> +
>  static bool kern_sym_match(struct sym_args *args, const char *name, char type)
>  {
>  	/* A function with the same name, and global or the n'th found or any */
>  	return kallsyms__is_function(type) &&
> -	       !strcmp(name, args->name) &&
> +	       kern_sym_name_match(name, args->name) &&
>  	       ((args->global && isupper(type)) ||
>  		(args->selected && ++(args->cnt) == args->idx) ||
>  		(!args->global && !args->selected));
> -- 
> 2.34.1

-- 

- Arnaldo
