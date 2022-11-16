Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E3EC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 19:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiKPTxN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiKPTw7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 14:52:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D5753EFD
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 11:52:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a14so31744637wru.5
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 11:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=39FrZeC3ldj+FLM9X1uVpeGgui7FIaSFbHe+gmieiBI=;
        b=I7DDyylHlmqNdBztRaCOoZdNNkKXkZU1deI2LZHgYeAwT9ohF8CwLdqnvdpTvHGnAJ
         z6X3TZEO/12NlmnHbtctMhEYC7ke/7TKaRqpWisfbp15Y8Gq2r9dGUIIJ7nIs/A8agUX
         6iNEHx8wAXDL0HlbZsoMCWMpt4kb3MHuKtcOrEU7+Pws5KnkQssBpj3/b77ElFuN//33
         nK7HKn+lVli/J6Bt/aKm1KVu4azjtlTlVeblHiorthWAMS5NURVJTT+rJfYM9VDqat73
         oRwxcZbbcT/20QiEqs86wy+2/pQVLQwj2+nsppCr/2EewHEvBaLMdgGIABKELc7IxX6j
         kRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39FrZeC3ldj+FLM9X1uVpeGgui7FIaSFbHe+gmieiBI=;
        b=d3D1xNdZWYdupO6DrWlztTamgUEDR/PJB4gp8s7F8bLz4EfYmkOnw0EIUToDRBzc+Q
         vA84dz4q2BcRszpyYQvZudZfKO9LDHB3NshVX/BlehujU3/k6xf0s3DBOy7wKUVv7Vy1
         8XWv2M7rJCaK033YecSQgVnfgWM7h0JwvEhQ5zeheKwkWB/xu2ncEX1tqx/8Qn+A7HRG
         TLhGdAMcYk76wh5oHk09NCci2wV845duoYiMfpxy97Bo/IGdrnycvUnuxV5ealW0g2Wl
         Fpa5gVmM5QFEKNyLc1d9kLOFGx/0HLPtlZZ5NKCmq8EKOnYjLRiwAVvqbxz0UB47wlci
         o06g==
X-Gm-Message-State: ANoB5pnQtiTsp0esAh/z3IBkSYBnEPlOVhCFWTqkbC31F0o1Hl4Y65ng
        dQH0HTSOTDkZMDN8gWgZBdd6K1aBDgTd3TzaFG5onQ==
X-Google-Smtp-Source: AA0mqf5BoMWamLtMLOTBSfl9vCb3jBOp5Cgemlel7yfgZXbj7+1Ps46hMiNrTjfbihElPCeoUY7/NtmMkKhFexk5Yt8=
X-Received: by 2002:a05:6000:1241:b0:236:d8f8:b87d with SMTP id
 j1-20020a056000124100b00236d8f8b87dmr14186527wrx.343.1668628372056; Wed, 16
 Nov 2022 11:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com> <20221114210723.2749751-11-irogers@google.com>
 <Y3OX1pcclKCgbpeT@kernel.org> <Y3TIG7BIzltgvCPw@kernel.org>
 <Y3TK/6bBFsHxduPc@kernel.org> <Y3TOwYdhzURKTgyB@kernel.org>
 <Y3Tah5Ocvx6lQ4jP@kernel.org> <Y3ThXYH3SAyEGmQ+@kernel.org> <Y3T/35DcAw+h4R93@kernel.org>
In-Reply-To: <Y3T/35DcAw+h4R93@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Nov 2022 11:52:39 -0800
Message-ID: <CAP-5=fU-tJPdxosVFfbbKtrswom7bnY6Ei3JczRJaQYyOnjcAA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] perf list: Add json output option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 16, 2022 at 7:21 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 16, 2022 at 10:10:53AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Nov 16, 2022 at 09:41:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > But then:
> >
> > > [root@five ~]# perf list syscalls:sys_enter_open* |& grep syscalls:
> > >   syscalls:sys_enter_open                            [Tracepoint event]
> > >   syscalls:sys_enter_open_by_handle_at               [Tracepoint event]
> > >   syscalls:sys_enter_open_tree                       [Tracepoint event]
> > >   syscalls:sys_enter_openat                          [Tracepoint event]
> > >   syscalls:sys_enter_openat2                         [Tracepoint event]
> > > [root@five ~]#
> > >
> > > This stops working, looking into it.
> >
> > Sidetracked with other stuff, please find what I have patched at
> > perf/perf-list-json-output in my tree.
> >
> > I removed the last two patches and I'm testing so that I can push
> > perf/core with your series modulo the last two + Namhyung's 'perf list'
> > kit.
>
> I just saw you sent a patch on top of the previous one, will try and
> combine stuff to remove failures from the bisect history.
>
> - Arnaldo

So the failing test was skipping for me due to a lack of kernel
symbols, sorry for not spotting it. I find that the issue is resolved
with your fixes and:

```
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 30937e1dd82c..ad6cb5d2e1cc 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -107,7 +107,7 @@ static void default_print_event(void *ps, const
char *pmu_name, const char *topi
       if (deprecated && !print_state->deprecated)
               return;

-       if (print_state->pmu_glob && !strglobmatch(pmu_name,
print_state->pmu_glob))
+       if (print_state->pmu_glob && pmu_name &&
!strglobmatch(pmu_name, print_state->pmu_glob))
               return;

       if (print_state->event_glob &&
@@ -534,24 +534,18 @@ int cmd_list(int argc, const char **argv)
                       default_ps.metrics = false;
                       metricgroup__print(&print_cb, ps);
               } else if ((sep = strchr(argv[i], ':')) != NULL) {
-                       int sep_idx;
-
-                       sep_idx = sep - argv[i];
-                       s = strdup(argv[i]);
-                       if (s == NULL) {
+                       default_ps.event_glob = strdup(argv[i]);
+                       if (!default_ps.event_glob) {
                               ret = -1;
                               goto out;
                       }
-
-                       s[sep_idx] = '\0';
-                       default_ps.pmu_glob = s;
-                       default_ps.event_glob = s + sep_idx + 1;
                       print_tracepoint_events(&print_cb, ps);
                       print_sdt_events(&print_cb, ps);
                       default_ps.metrics = true;
                       default_ps.metricgroups = true;
                       metricgroup__print(&print_cb, ps);
-                       free(s);
+                       free(default_ps.event_glob);
+                       default_ps.event_glob = NULL;
```
I think this should be squashed into "perf list: Reorganize to use
callbacks". Some explanation, in porting the : glob case I'd assumed
the before the colon would be the PMU and the after the event. Doing
things caused tracepoint output to differ too much and so for
tracepoints the : is kept in the event name. So we can simplify the
matching to not be pmu and event, just use the event glob.

Thanks,
Ian

               } else {
                       if (asprintf(&s, "*%s*", argv[i]) < 0) {
                               printf("Critical: Not enough memory!
Trying to continue...\n");
