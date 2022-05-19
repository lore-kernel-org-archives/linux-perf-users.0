Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837BCC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 22:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbiESWOx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 May 2022 18:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiESWOu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 May 2022 18:14:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332AEC320
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 15:14:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so3419655wms.5
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/MSQ1m41Fcw6b6LA0uBbiZWj73238xZ0rlQmlu3bpo=;
        b=AS3A2qhaIRHTp/74NqQnh4nanXMk3OYDGxETNNvTD2ew6YKGHNxR/33WC9NyczDZ2f
         MEQ+/Zkrwd57zMvKmF8lXBhCYsqo6vrx0UBZ1YTw11zv4g7DK22tLXh0pjWt/skOwwek
         lRIDHUA1hs1Nx0xWlMTAo544vIOQLKhEYaHRwRFboOEZ3yKU8mY1vBTz+DCs3J/LD2EP
         WnYwUPPEu7G8M4Fd8MYKLtDmmm3hZ90EYAess4uMuqJbDHY5pCl9xpHaFMHGZg3bZ7Al
         ++rKsGVhiXs0jP4I+IsQZg8dQayQuFIomb0UFMVlDUfEtuytsWZDCCw7G2EZhWFc+KDt
         MzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/MSQ1m41Fcw6b6LA0uBbiZWj73238xZ0rlQmlu3bpo=;
        b=onaJa/AmPyHZG+QO2lohi6A1jOwzkSt7RWLoBmdjHZWfChBVKlaeIiztKV1q46cJuT
         2FJQGXgmzjQVddpizZlY3LzDLbBR7rPjv0lUnOAcECYWZrd6HN0XZ4BtFt/X2+BC1ifn
         USpTxxLRcyi1OnLHxXuoFdqYrDehlP2vGp2HuwUUzP2EP26KM9Kiqx0m4Ky1yThs0qMm
         UCCs42lXlqrh3gtvjWCfjzelk+zToHy75NM8wc6Uh2AjYRNscF/s/364pcopJ/eFUk5M
         DznIOqSbqNvih/wDiyNO4v9HSRv62+w48gqrs35O2HvCfXJGok+XzhUBnAfvg1HhtyJq
         HsMQ==
X-Gm-Message-State: AOAM530HeU6fzhxqTuo5ZbDKm0LnVvd/sMBaMnPHP7SZFIiJsTuUCQIF
        Ppmh6/XSMGeX1QduAevxMRAQHQeER3PI6kcb4ZLweQ==
X-Google-Smtp-Source: ABdhPJykzkUa8O4Vou9BOyWKPn8TL6eskwSbBCcJGbLGhbRJ2NENTNSbeD/hZNYbfUhE1nv+wxIAnCi2FJncSXFiFPg=
X-Received: by 2002:a05:600c:19cc:b0:394:8dc2:a23b with SMTP id
 u12-20020a05600c19cc00b003948dc2a23bmr6169950wmq.182.1652998485374; Thu, 19
 May 2022 15:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220519054355.477-1-ravi.bangoria@amd.com> <20220519054355.477-2-ravi.bangoria@amd.com>
In-Reply-To: <20220519054355.477-2-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 15:14:32 -0700
Message-ID: <CAP-5=fU_=v8CXNg5ovK2XcFv4e4KSXNLaP-7k9y1yqQ_NhzgSg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] perf record ibs: Warn about sampling period skew
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 18, 2022 at 10:44 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Samples without an L3 miss are discarded and counter is reset with
> random value (between 1-15 for fetch pmu and 1-127 for op pmu) when
> IBS L3 miss filtering is enabled. This causes a sampling period skew
> but there is no way to reconstruct aggregated sampling period. So
> print a warning at perf record if user sets l3missonly=1.
>
> Ex:
>   # perf record -c 10000 -C 0 -e ibs_op/l3missonly=1/
>   WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled
>   and tagged operation does not cause L3 Miss. This causes sampling period skew.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/evsel.c | 50 ++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.c          |  7 +++++
>  tools/perf/util/evsel.h          |  1 +
>  3 files changed, 58 insertions(+)
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index ac2899a25b7a..e8ff4ddb53c9 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -4,6 +4,8 @@
>  #include "util/evsel.h"
>  #include "util/env.h"
>  #include "linux/string.h"
> +#include "util/pmu.h"
> +#include "util/debug.h"
>
>  void arch_evsel__set_sample_weight(struct evsel *evsel)
>  {
> @@ -29,3 +31,51 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>
>         free(env.cpuid);
>  }
> +
> +static void ibs_l3miss_warn(void)
> +{
> +       pr_warning(
> +"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
> +"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
> +}
> +
> +void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
> +{
> +       struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
> +       static int warned_once;
> +       /* 0: Uninitialized, 1: Yes, -1: No */
> +       static int is_amd;
> +
> +       if (warned_once || is_amd == -1)
> +               return;
> +
> +       if (!is_amd) {
> +               struct perf_env *env = evsel__env(evsel);
> +
> +               if (!perf_env__cpuid(env) || !env->cpuid ||
> +                   !strstarts(env->cpuid, "AuthenticAMD")) {
> +                       is_amd = -1;
> +                       return;
> +               }
> +               is_amd = 1;
> +       }
> +
> +       evsel_pmu = evsel__find_pmu(evsel);
> +       if (!evsel_pmu)
> +               return;
> +
> +       ibs_fetch_pmu = perf_pmu__find("ibs_fetch");
> +       ibs_op_pmu = perf_pmu__find("ibs_op");
> +
> +       if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
> +               if (attr->config & (1ULL << 59)) {
> +                       ibs_l3miss_warn();
> +                       warned_once = 1;
> +               }
> +       } else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
> +               if (attr->config & (1ULL << 16)) {
> +                       ibs_l3miss_warn();
> +                       warned_once = 1;
> +               }
> +       }
> +}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2a1729e7aee4..e9be9b94a062 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1064,6 +1064,11 @@ void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_un
>  {
>  }
>
> +void __weak arch__post_evsel_config(struct evsel *evsel __maybe_unused,
> +                                   struct perf_event_attr *attr __maybe_unused)
> +{
> +}
> +
>  static void evsel__set_default_freq_period(struct record_opts *opts,
>                                            struct perf_event_attr *attr)
>  {
> @@ -1339,6 +1344,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>          */
>         if (evsel__is_dummy_event(evsel))
>                 evsel__reset_sample_bit(evsel, BRANCH_STACK);
> +
> +       arch__post_evsel_config(evsel, attr);
>  }
>
>  int evsel__set_filter(struct evsel *evsel, const char *filter)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 041b42d33bf5..207de5082ee9 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -281,6 +281,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
>
>  void arch_evsel__set_sample_weight(struct evsel *evsel);
>  void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
> +void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
>
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
> --
> 2.27.0
>
