Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0A0C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 15:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbhKXPpE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344914AbhKXPpD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Nov 2021 10:45:03 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C1C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Nov 2021 07:41:53 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id j21so2908291ila.5
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Nov 2021 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rayr/Ta3skw4nHGq7Cjbx5KeQztTWRrECFJXOMRV5CU=;
        b=Uu8EOkQOmJx6uYnwHna6/f9g95Cyo+dNifA5T6ZESd4i9V0kAMuf0dcxNF4vinUkHg
         RRpHnHaTr7PYIe8Pl5hqNbWiM6mX+X7cPmY+XA/L5AmtozYBZCQNz1gSo+rFrpbnXi98
         y3vkUr51JoYQfPV2OJUiodNKclJeX20esaTIrV09nT3SwQZnhUzYoVOUKPVHMKk6+ZkA
         w+o+PBw0mPkluA+lQLx9/t+a5UdlUMFNMPXdfN8MLpnKcrK+gz7HahaQ8shsfvyXb1Tt
         enw9BSe+O8e9UducNAJsnf+lPRCFe++TWx3Ry/ErEfCnhYRYhL+RxPZ/emFCyTk6NMz2
         2/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rayr/Ta3skw4nHGq7Cjbx5KeQztTWRrECFJXOMRV5CU=;
        b=F6jtEffLz3moebS5g8HFqM3ZIYZHMFD1Aj7ypCcHoMloeVYnSzr7T8wyvNuOVuQmSG
         W9J58gTUb+EREjA89Rqchrqu8rowLIsOTZGOXc5o+thbSGs4gl5G9StDRxRJh0YqHZ7U
         FLbFnp4QHCudLzrga7WKDy0uQdK6jTPsS72kkE0JgONUuDa2+bS9bT52P30XzkVif5TQ
         axbzzivf8p/jtfDnrNFij3YiQQgROtEepUBGwQ66oKXE8hK7ejAv7MINTQhqgS0eClEW
         c/k8G0Q8+S5QRlVF9PDXVQPWawknZChIru4Pzc56mME3CCCFRyCICh/ldWG9Kk9LyMOg
         ZAXQ==
X-Gm-Message-State: AOAM533VfrtoCe+07mm7jH/lImBIMngLhYkXSe4nZMmH1pOKsGbp6E0U
        ss68Ojl1fWGJunrAEZsLBqJM7gEmGEu161C5L7cIng==
X-Google-Smtp-Source: ABdhPJxyNQ6t96LtxnQP7D8WfNiMYSBBHq4d3TUsQf3F1+DIaGodncIEBAmHU63X067/VNTPPOD6VyxIUsP2bO4sgi0=
X-Received: by 2002:a05:6e02:f51:: with SMTP id y17mr418208ilj.2.1637768512611;
 Wed, 24 Nov 2021 07:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20211124090343.9436-1-tmricht@linux.ibm.com>
In-Reply-To: <20211124090343.9436-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Nov 2021 07:41:40 -0800
Message-ID: <CAP-5=fXdOQUNDTXvt7GHRvu_7jyTPp_53f8_5DzDCXWCpWLtEQ@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix perf test 7 Simple expression parser on s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 24, 2021 at 1:04 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> Commit fdf1e29b6118 ("perf expr: Add metric literals for topology.")
> fails on s390:
>  # ./perf test -Fv 7
>    ...
>  # FAILED tests/expr.c:173 #num_dies >= #num_packages
>    ---- end ----
>    Simple expression parser: FAILED!
>  #
>
> Investigating this issue leads to these functions:
>  build_cpu_topology()
>    +--> has_die_topology(void)
>         {
>            struct utsname uts;
>
>            if (uname(&uts) < 0)
>                   return false;
>            if (strncmp(uts.machine, "x86_64", 6))
>                   return false;
>            ....
>         }
>
> which always returns false on s390. The caller build_cpu_topology()
> checks has_die_topology() return value. On false the
> the struct cpu_topology::die_cpu_list is not contructed and has zero
> entries. This leads to the failing comparison: #num_dies >= #num_packages.
> s390 of course has a positive number of packages.
>
> Fix this by adding s390 architecture to support CPU die list.
>
> Output after:
>  # ./perf test -Fv 7
>   7: Simple expression parser                                        :
>   --- start ---
>   division by zero
>   syntax error
>   ---- end ----
>   Simple expression parser: Ok
>  #
> Cc: Ian Rogers <irogers@google.com>
> Fixes: fdf1e29b6118 ("perf expr: Add metric literals for topology.")
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/cputopo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> index 51b429c86f98..aad7a9e6e31b 100644
> --- a/tools/perf/util/cputopo.c
> +++ b/tools/perf/util/cputopo.c
> @@ -165,7 +165,8 @@ static bool has_die_topology(void)
>         if (uname(&uts) < 0)
>                 return false;
>
> -       if (strncmp(uts.machine, "x86_64", 6))
> +       if (strncmp(uts.machine, "x86_64", 6) &&
> +           strncmp(uts.machine, "s390x", 5))
>                 return false;
>
>         scnprintf(filename, MAXPATHLEN, DIE_CPUS_FMT,
> --
> 2.31.1
>
