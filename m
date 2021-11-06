Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAABC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 04:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2113861139
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 04:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhKFEWE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Nov 2021 00:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhKFEWE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Nov 2021 00:22:04 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A5EC061714
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Nov 2021 21:19:23 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w1so40082368edd.10
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Nov 2021 21:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8vFlpUznbXMyx/59K4Fs8dfFLIaAOhDqtSTgtxLO4w=;
        b=CLUgto1Uw5PhScFMNxlMg+mLFoH2oJyTUpx9ZKIOtsBEQGHFkf+nYNv55tY7RJwDXB
         mWhd1dXidWDEysPTUk7lxitXbu76Xe9UJTqn61J71kT/RSZ7c0/2HdqBOzddZc0UoR+O
         juAMJwNTaRwcCAvasleIVeXRiaX1hZb41E2UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8vFlpUznbXMyx/59K4Fs8dfFLIaAOhDqtSTgtxLO4w=;
        b=oVGkrWDMiI3RCZhiFxg5qceDaamj227+2Cc8XBMI9L3fXsoRdlPxi9abbKa2x+HU6R
         DJBHV+3eAUSOrFOY0ztJWaTOsBWkUoIjn1+IvID0J3KUS+ouXyg+GqSW22X9t1tZznPi
         t9zbhjyOhvswygMrOAp9Cnv7nDq0HPZSYFUpzeEC2S6FEJ1HRrGbIuRSyOjPyBPIBlcO
         U+1kK9q+TzC90wpgt0m5iCdxV1GlB8LdVRA20Fbez3hRGHFnwSRyasnqSZOMSyR0KJg5
         OlX+F9yMa1rtdzmXbvgc3TitDBsYXwobQ4jsgLx/AI/hQ1IonD9DL8btLdDNOTiG9TQs
         msQQ==
X-Gm-Message-State: AOAM533Th2mpn6L1EbE27XhaTcAXFjdGItjLTDMG2ABPgUJWukNNLxyM
        mvnO8oRVBKMjT4FjbyLDf66lajtGZ3ZANB0JfCirx7JjrmsNcg==
X-Google-Smtp-Source: ABdhPJw5rtGG36uqtmsMWu916/Zpgaf0BqWezUaq8zx1ZP9rpY6kRTHC8FlIXzRblPppyMa5gH12t3vu9qhjendEnxc=
X-Received: by 2002:a17:907:94c6:: with SMTP id dn6mr9990929ejc.490.1636172361775;
 Fri, 05 Nov 2021 21:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211018134844.2627174-1-james.clark@arm.com> <20211018134844.2627174-4-james.clark@arm.com>
In-Reply-To: <20211018134844.2627174-4-james.clark@arm.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Fri, 5 Nov 2021 21:19:10 -0700
Message-ID: <CADDJ8CWoHb28JDjxq+ZtFVTUXQjhtFTszjeeXKx1WMue8zBp2A@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf inject: Add vmlinux and ignore-vmlinux arguments
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 18, 2021 at 6:49 AM James Clark <james.clark@arm.com> wrote:
>
> Other perf tools allow specifying the path to vmlinux. Perf inject
> didn't have this argument which made some auxtrace workflows difficult.
>
> Also add ignore-vmlinux for consistency with other tools.
>
> Suggested-by: Denis Nitikin <denik@chromium.org>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/builtin-inject.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6ad191e731fc..4261ad89730f 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -938,6 +938,10 @@ int cmd_inject(int argc, const char **argv)
>  #endif
>                 OPT_INCR('v', "verbose", &verbose,
>                          "be more verbose (show build ids, etc)"),
> +               OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
> +                          "file", "vmlinux pathname"),
> +               OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> +                           "don't load vmlinux even if found"),

I think we also need to update documentation at Documentation/perf-inject.txt

>                 OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name, "file",
>                            "kallsyms pathname"),
>                 OPT_BOOLEAN('f', "force", &data.force, "don't complain, do it"),
> @@ -972,6 +976,9 @@ int cmd_inject(int argc, const char **argv)
>                 return -1;
>         }
>
> +       if (symbol__validate_sym_arguments())
> +               return -1;
> +
>         if (inject.in_place_update) {
>                 if (!strcmp(inject.input_name, "-")) {
>                         pr_err("Input file name required for in-place updating\n");
> --
> 2.28.0
>

Tested-by: Denis Nikitin <denik@chromium.org>
