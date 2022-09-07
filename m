Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE6C38145
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Sep 2022 15:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiIGPsS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIGPsO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Sep 2022 11:48:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F1B99DD
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Sep 2022 08:48:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bq9so8164377wrb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Sep 2022 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JTKHE/mFfLQpKZtovEaQfx9ypT3LHElNlUe4JnUW+14=;
        b=WAsZiFgX+fq4TgLbLKr1C2FPzy0zzLEBiLGhl7S10aI8B0ejD7vbYjtqDhvYDJa+pq
         PwrI9N/oSp4hcM4LN9fCMzDwBq1+dkcniJuvhnsFiZarDf7DC8bcF7vuSWsy39sjh90O
         Dfn8uE41jAcGdO3HapuR782JId+uUmYm+6U2vbqg2YK8/9G2QCzVS1kV8HQfswKKfUlw
         1wG4my2b8huUlHI/VocGop8xusQkcOI1r9jhAqLUCsEcFWRv/sXpPknUrY0ckyNsdK9M
         9e9+/nkcCXAa69f4f4O0HmDmNaUGk0IeyrWptGlPZkzGxun3nJ9/gaQEbMI0xqfh4qfV
         2ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JTKHE/mFfLQpKZtovEaQfx9ypT3LHElNlUe4JnUW+14=;
        b=MolV6vKC/MltVg6WpyvHrQDrjIyGqN4qmUHICeW0VXlYjNvZrhtcG0xGJI8T1ntQNp
         LCXyYho1/siYom7A9/SkqTPLHh8Y3MFABVAiwp6MUNNLJUkicN01cAZkVFZrpxUS5xRl
         7aci1i2U8HDm6vE9KFqi3uIBYAnyDcqeoxZXhnoKxj3sIEKeMT/t2qcGkXvc6LWlXefM
         a7OT4H5vfcq2QevtV8ObLX0GSitk7el4BOs5R2edWr2liktvSkLghd0jAAOqkR6E84tn
         NRsVlZZ0s1lnAwAQCZnhHlFogHbbX9N+2fyvGlMqSUCch1imbMlDY1kOd2ZDYdOSlflC
         5QfA==
X-Gm-Message-State: ACgBeo0GbNEi5Vaqi4Dy4beG3I73jpakyf0x+mgtaMcAP+IxLs9KzNqi
        U5jm2bw0jOk63BEeHKr2vZJffVEnhRnQCj6srrKteQ==
X-Google-Smtp-Source: AA6agR6svjr5kCW9JMi5qqKrWFsmgmj9cfash5uryDYATh7wRkTgMyGmvfsaiACCUup2oI4IwUoDACFRH5ioOWAE1r0=
X-Received: by 2002:a5d:64a8:0:b0:226:f3f3:9914 with SMTP id
 m8-20020a5d64a8000000b00226f3f39914mr2416185wrp.343.1662565689640; Wed, 07
 Sep 2022 08:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220907071203.2729746-1-namhyung@kernel.org>
In-Reply-To: <20220907071203.2729746-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Sep 2022 08:47:57 -0700
Message-ID: <CAP-5=fXyY_aGYW4R-PZvzG3FiTtHvLfS+s9bp_oCQUaRCGrcwg@mail.gmail.com>
Subject: Re: [PATCH v3] perf test: Skip sigtrap test on old kernels
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Marco Elver <elver@google.com>,
        Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 7, 2022 at 12:12 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> If it runs on an old kernel, perf_event_open would fail because of the
> new fields sigtrap and sig_data.  Just skipping the test could miss an
> actual bug in the kernel.
>
> Let's check BTF if it has the perf_event_attr.sigtrap field.
>
> Cc: Marco Elver <elver@google.com>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> * move #include under #ifdef
> * return true when BPF is not supported
> * update comment
>
>  tools/perf/tests/sigtrap.c | 50 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index e32ece90e164..cdf75eab6a8a 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -54,6 +54,48 @@ static struct perf_event_attr make_event_attr(void)
>         return attr;
>  }
>
> +#ifdef HAVE_BPF_SKEL
> +#include <bpf/btf.h>
> +
> +static bool attr_has_sigtrap(void)
> +{
> +       bool ret = false;
> +       struct btf *btf;
> +       const struct btf_type *t;
> +       const struct btf_member *m;
> +       const char *name;
> +       int i, id;
> +
> +       btf = btf__load_vmlinux_btf();
> +       if (btf == NULL) {
> +               /* should be an old kernel */
> +               return false;
> +       }
> +
> +       id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
> +       if (id < 0)
> +               goto out;
> +
> +       t = btf__type_by_id(btf, id);
> +       for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
> +               name = btf__name_by_offset(btf, m->name_off);
> +               if (!strcmp(name, "sigtrap")) {
> +                       ret = true;
> +                       break;
> +               }
> +       }
> +out:
> +       btf__free(btf);
> +       return ret;
> +}
> +#else  /* !HAVE_BPF_SKEL */
> +static bool attr_has_sigtrap(void)
> +{
> +       /* to maintain current behavior */

nit: I don't think this comment will age well and the behavior of the
function is a bit counterintuitive. Perhaps:

/* If we don't have libbpf then guess we're on a newer kernel with
sigtrap support. This will mean the test will fail on older kernels.
*/

> +       return true;
> +}
> +#endif  /* HAVE_BPF_SKEL */
> +
>  static void
>  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
>  {
> @@ -139,7 +181,13 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>
>         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
>         if (fd < 0) {
> -               pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> +               if (attr_has_sigtrap()) {
> +                       pr_debug("FAILED sys_perf_event_open(): %s\n",
> +                                str_error_r(errno, sbuf, sizeof(sbuf)));
> +               } else {
> +                       pr_debug("perf_event_attr doesn't have sigtrap\n");
> +                       ret = TEST_SKIP;
> +               }
>                 goto out_restore_sigaction;
>         }
>
> --
> 2.37.2.789.g6183377224-goog
>
