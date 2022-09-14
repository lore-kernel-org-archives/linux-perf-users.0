Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB88EECAAD8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 13:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiINNMn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiINNMm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 09:12:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B014F3A7
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Sep 2022 06:12:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u9so34670457ejy.5
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Sep 2022 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ib5mswjR1x7cIBGgOeaYy3ofTlgkjtf1YQmH317wwYc=;
        b=EyGvls+PPR5gSq51ImovQ9Aykw+f1UwYvKrRnvXUiUMLmdsoj3OZKautZPAbv6yI4S
         c05fPCDH/izs82miJZsc7xYU6USh/RTsgrfHyuphN64PJYH3IwytNrBNkVgofyZ4MDix
         +DVuyNg81rdHSCkfrAzOD4MJbUQ6lT2C4FvAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ib5mswjR1x7cIBGgOeaYy3ofTlgkjtf1YQmH317wwYc=;
        b=XeEhZpatYTAFdweV5FPQkGkhcWbrve8i7nsn/X3OKhkmPEkw+X4veYVgyR7e24aCJk
         Zo3Mm+3PppQBscC5YkGu4LTSoAPFLejkWOjir4JYngF92B+bo8Ft1JggIj2HBCRKawre
         dGhofZjf/deDk1IgT18I8RKIBpOeZJqh7FTHd4sjcnRLza8sp4WPKTeF+LKNGkte7XHB
         2+GlZ8fsx8tUbxOYvIDSpg27z95uoZGAcOctYL6jRSoCc7KJ001jaY4qGyQql0A0cxYa
         OnSzaq1zb02ZDUYJkWCd0DTHmQQNaNNPTn1W14Y7Ezv987i3FjJxasAk+7SmoXyIxfAU
         kKPw==
X-Gm-Message-State: ACgBeo0FXh5OVFng4R6lCH3EmjEwG+drLdeWV0AhDw33SU9kn/tnHHXD
        3wscCL4a2S1b1dYWHQZ+PbGZSIfXL8x/0N+Zb6vVJawTrcsnvg==
X-Google-Smtp-Source: AA6agR7HbQRqYLgqzMyg41PD/aaS4tbp5xqGmUix+XS3s2ihXKF7L99Xf7M2vZLQ4r9NymjcYSMHaJ+RBBpZ6aWhRRE=
X-Received: by 2002:a17:907:c23:b0:779:237a:4218 with SMTP id
 ga35-20020a1709070c2300b00779237a4218mr19917347ejc.277.1663161159807; Wed, 14
 Sep 2022 06:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220914122429.8770-1-adrian.hunter@intel.com>
In-Reply-To: <20220914122429.8770-1-adrian.hunter@intel.com>
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Wed, 14 Sep 2022 14:12:29 +0100
Message-ID: <CA+wXwBRN3kJLVxVupLLXTBC_GbSzvmDch4ry2jWW2aqZXJgp2w@mail.gmail.com>
Subject: Re: [PATCH] perf kcore_copy: Do not check /proc/modules is unchanged
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 14, 2022 at 1:24 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> /proc/kallsyms and /proc/modules are compared before and after the copy
> in order to ensure no changes during the copy. However /proc/modules
> also might change due to reference counts changing even though that
> does not make any difference. Any modules loaded or unloaded should be
> visible in changes to kallsyms, so it is not necessary to check
> /proc/modules also anyway.
>
> Remove the comparison checking that /proc/modules is unchanged.
>
> Reported-by: Daniel Dao <dqminh@cloudflare.com>
> Fixes: fc1b691d7651 ("perf buildid-cache: Add ability to add kcore to the cache")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/symbol-elf.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 75bec32d4f57..647b7dff8ef3 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -2102,8 +2102,8 @@ static int kcore_copy__compare_file(const char *from_dir, const char *to_dir,
>   * unusual.  One significant peculiarity is that the mapping (start -> pgoff)
>   * is not the same for the kernel map and the modules map.  That happens because
>   * the data is copied adjacently whereas the original kcore has gaps.  Finally,
> - * kallsyms and modules files are compared with their copies to check that
> - * modules have not been loaded or unloaded while the copies were taking place.
> + * kallsyms file is compared with its copy to check that modules have not been
> + * loaded or unloaded while the copies were taking place.
>   *
>   * Return: %0 on success, %-1 on failure.
>   */
> @@ -2166,9 +2166,6 @@ int kcore_copy(const char *from_dir, const char *to_dir)
>                         goto out_extract_close;
>         }
>
> -       if (kcore_copy__compare_file(from_dir, to_dir, "modules"))
> -               goto out_extract_close;
> -
>         if (kcore_copy__compare_file(from_dir, to_dir, "kallsyms"))
>                 goto out_extract_close;
>
> --
> 2.25.1
>
Thanks Adrian,

Tested-by: Daniel Dao <dqminh@cloudflare.com>
