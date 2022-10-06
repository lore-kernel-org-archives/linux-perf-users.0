Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5894C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJFSoH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiJFSoF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 14:44:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787BA4B9A
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 11:44:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u10so4042904wrq.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Oct 2022 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U6U9qKSs+tlBnC+Tv5A8FqfXvXIIt7ASE6ecI1CauRs=;
        b=ixDRCu9mpvel96Rv0lVJu3QCSQ0U2vdA2dTH4WfQpdRh5Fe979UT/QCDvGehJBhVov
         CbBH6DkH5xFMnn0INj/c1df4mfOr4AUtDNtyzZffvAzAvfLa62bR3aDaQpyk5rUoNJ7T
         pE7HsxAb1XkEo/6V1yyn8chyA47AVFkZM6YlZl/q8bGWeeZ+ma/CGatquBcr6bc40WHz
         QDbgl6y1X+Ux3s0cQp0DNLjfAGAM6F7l2gp2dD4QH3zc+0x/FoInUKuUSt9Z3n6WpAe0
         QP+PXLlLKbjMlu3gKGzYisgzh1XfDl2/zGV7U1HmlUwCt8D6VPHO/3gz5nW528bBsZgs
         0P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6U9qKSs+tlBnC+Tv5A8FqfXvXIIt7ASE6ecI1CauRs=;
        b=2B+xKQYEZKaim9ecpBmvnFHUKOQpnvs98Fk2kJ4TOE/vH5oIWNS64ogs7QJXvIkEF8
         EGP+WUivHSERsjpy+RUChvE7AsLqHk6/n7hWjPNsjOklJpVOCa3rIC4t+1XVeeIKdySE
         BhGBIfFhEPIFSk5H/jWFgAoxViLZLi8SR8rZdeYbNtG5pMzZQnCe5dNNTLYuZst7ddIu
         oNqkcsyi1VUlp1X5hpZmyHD93DQAn6uLh4ZmmO9g3duVIlkjxW1Afb48idhtOVAdP08C
         mIqQw5K6wSSL1i1JWudkbH07FFT03dAqcmEZfLWaO8qZ1jWcsgcMusWSBLYcpNed5ue+
         vE0g==
X-Gm-Message-State: ACrzQf1gF9OlYzSp6Uo6vUshKLPZwjUQSo8pC7qV5WHK/tpEpSMzXWOM
        gWkild+2wXbLkpFqjUuZHFSDVoIJkV9kKtF9ypNGrQ==
X-Google-Smtp-Source: AMsMyM4gTDjHYDYnhhnXFHki1arVtgwnWw02kP8Q4er8GzGmVy5Br66rlCFu+A1Cq0RTi4XOp0rtDVBfUq2zw2ycab8=
X-Received: by 2002:a5d:47a9:0:b0:22e:3beb:dc3a with SMTP id
 9-20020a5d47a9000000b0022e3bebdc3amr887092wrb.654.1665081843023; Thu, 06 Oct
 2022 11:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221003204647.1481128-1-namhyung@kernel.org> <20221003204647.1481128-2-namhyung@kernel.org>
In-Reply-To: <20221003204647.1481128-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Oct 2022 11:43:49 -0700
Message-ID: <CAP-5=fU6yqFKS+dYZ9VcoPftEGh3+oebLsZSOgEaG-XdNFZ7pQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] libperf: Populate system-wide evsel maps
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 3, 2022 at 1:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Setting proper cpu and thread maps for system wide evsels regardless of
> user requested cpu in __perf_evlist__propagate_maps().  Those evsels
> need to be active on all cpus always.  Do it in the libperf so that we
> can guarantee it has proper maps.
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/evlist.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 6b1bafe267a4..187129652ab6 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -40,11 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>          * We already have cpus for evsel (via PMU sysfs) so
>          * keep it, if there's no target cpu list defined.
>          */

This comment is for the 'else if' case and so is a little out of place
before the system wide test.

> -       if (!evsel->own_cpus ||
> -           (!evsel->system_wide && evlist->has_user_cpus) ||
> -           (!evsel->system_wide &&
> -            !evsel->requires_cpu &&
> -            perf_cpu_map__empty(evlist->user_requested_cpus))) {
> +       if (evsel->system_wide) {
> +               perf_cpu_map__put(evsel->cpus);
> +               evsel->cpus = perf_cpu_map__new(NULL);

Looking at perf_cpu_map__new, will this mean that in system wide mode
every event/evsel will now read /sys/devices/system/cpu/online here?
We may want to cache the cpumap to avoid this.

Thanks,
Ian

> +       } else if (!evsel->own_cpus || evlist->has_user_cpus ||
> +                  (!evsel->requires_cpu && perf_cpu_map__empty(evlist->user_requested_cpus))) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>         } else if (evsel->cpus != evsel->own_cpus) {
> @@ -52,7 +52,10 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
>         }
>
> -       if (!evsel->system_wide) {
> +       if (evsel->system_wide) {
> +               perf_thread_map__put(evsel->threads);
> +               evsel->threads = perf_thread_map__new_dummy();
> +       } else {
>                 perf_thread_map__put(evsel->threads);
>                 evsel->threads = perf_thread_map__get(evlist->threads);
>         }
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
