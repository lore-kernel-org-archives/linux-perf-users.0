Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D2C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 21:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiCVVYc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiCVVYb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 17:24:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F35FB5;
        Tue, 22 Mar 2022 14:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95411B81DAB;
        Tue, 22 Mar 2022 21:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A57C340EC;
        Tue, 22 Mar 2022 21:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647984180;
        bh=pAxaAjiOATnI3aq030AAYwb4rIWiunNXamUdWhLkd0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilGgppdDJ4vkZi/f50evxgFzBi3rTaB45EufvNNotS1XQEnpKk1rOIsgSMRmyr+sF
         j+5LfuCpy8XCl7KUaMrY2fDpTY2UlfhwjYur34T+r8sec6HkVHVa2vGZZy9nkhrkxM
         qx8e0CbAotyTKq147GSb2OhY1Iai1KLU+OuFLaHQs17Yh9/w1Tf/iu3JKtsdzDRzv5
         wnJ/9AzkGNqTke3TRiG/24tnhMXthQP4wF7DNlZxc3VDQOwvQGLNvhdf0T3K6o+bBi
         6WG8nki19xQnYMvbljMMp7p0M79rCLVAyaLCIaEjwUPSQlc7177GaccIdK1/tpWcun
         YfVR9qQlGrQRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31D6240407; Tue, 22 Mar 2022 18:22:57 -0300 (-03)
Date:   Tue, 22 Mar 2022 18:22:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH RESEND 1/2] perf string: Add strcmp_prefix()
Message-ID: <Yjo+MdJaauraN6eX@kernel.org>
References: <20220318092245.2700489-1-liwei391@huawei.com>
 <20220318092245.2700489-2-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318092245.2700489-2-liwei391@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Mar 18, 2022 at 05:22:44PM +0800, Wei Li escreveu:
> Add a helper to check whether a string has the given prefix.
> This function is stolen from fs/xattr.c

Can't you use strstarts()? See tools/include/linux/string.h.

- Arnaldo
 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/util/string.c  | 17 +++++++++++++++++
>  tools/perf/util/string2.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
> index f6d90cdd9225..0ed3e2d0b70f 100644
> --- a/tools/perf/util/string.c
> +++ b/tools/perf/util/string.c
> @@ -209,6 +209,23 @@ int strtailcmp(const char *s1, const char *s2)
>  	return 0;
>  }
>  
> +/**
> + * strcmp_prefix - check string for given prefix
> + * @str: the target string to check
> + * @prefix: the given prefix to match
> + *
> + * Return the rest string in @str if @str has the given @prefix, return NULL
> + * otherwise.
> + */
> +const char *strcmp_prefix(const char *str, const char *prefix)
> +{
> +	while (*prefix && *str == *prefix) {
> +		str++;
> +		prefix++;
> +	}
> +	return *prefix ? NULL : str;
> +}
> +
>  char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
>  {
>  	/*
> diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
> index 56c30fef9682..58929ad928f7 100644
> --- a/tools/perf/util/string2.h
> +++ b/tools/perf/util/string2.h
> @@ -20,6 +20,7 @@ static inline bool strisglob(const char *str)
>  	return strpbrk(str, "*?[") != NULL;
>  }
>  int strtailcmp(const char *s1, const char *s2);
> +const char *strcmp_prefix(const char *str, const char *prefix);
>  
>  char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
>  
> -- 
> 2.25.1

-- 

- Arnaldo
