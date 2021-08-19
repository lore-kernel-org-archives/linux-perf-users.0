Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124EBC4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 22:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABAD61028
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 22:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhHSW37 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 18:29:59 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36414 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHSW36 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Aug 2021 18:29:58 -0400
Received: by mail-lf1-f51.google.com with SMTP id r9so16200665lfn.3;
        Thu, 19 Aug 2021 15:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LcUiMbIvgGkkeAl+Eqsq1dY0jYkDrhF+OapOZ3xHjc=;
        b=YrNWLHUxJJvHmQCdwos1Ab0Cb1m6J0bPsmmAo24zX0APJ0Ge5UiWmfxZty4r3yBr1q
         Yn9VoDGJy0grgvrOvGnH5mYXrtr6EqE8nx3ldAsj6yqGlhwT20xskQ/SAPIpcu+daejK
         VZ9q0NVArSj6pwTb+lZ3Fgp32+Qb/FnQSVBluju33aoGEx0piBi1EgbjUImbRDa9LKmp
         HU1OJG41lIjQFI7IRoNv3aW2lEVYSsbIO92Leso9qwlNhXOmGZV176kBFA35JPS78W0I
         OBRS6izKGwqF+/kNfoBRss2PDUcHDGwzO2CH8XFfsFIvLHdT0+/HSow4QGgh6s+CrKn4
         Gfaw==
X-Gm-Message-State: AOAM530fVUFALAPBIxjAdwLQyDY7F1bC1VQVpWxpkFH4EO3gLhoS301r
        5YLIpbnrW5LM5UowwzfJdEtHE8xspE2aDbxDcmU=
X-Google-Smtp-Source: ABdhPJwEsRB2LoN/B7vpY5DPzHe41r/JwzQhZ/5FOou+VRZA3SFmfePyGJOqR6zKaPyLw5Q+AYU5HXRc82934Hjt7aM=
X-Received: by 2002:a05:6512:ac9:: with SMTP id n9mr12041252lfu.635.1629412160767;
 Thu, 19 Aug 2021 15:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210817221048.88063-1-kim.phillips@amd.com> <20210817221048.88063-3-kim.phillips@amd.com>
In-Reply-To: <20210817221048.88063-3-kim.phillips@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 19 Aug 2021 15:29:09 -0700
Message-ID: <CAM9d7ciafJnNFF4O_zq92YN_JKwSeAq51uZOvbHbfV7fP2Me6g@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf/x86/amd/ibs: Add workaround for erratum #1,197
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Tue, Aug 17, 2021 at 3:11 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> Erratum #1197 "IBS (Instruction Based Sampling) Register State May be
> Incorrect After Restore From CC6" is published in a document available
> at the link tag below:
>
> "Revision Guide for AMD Family 19h Models 00h-0Fh Processors"
> 56683 Rev. 1.04 July 2021
>
> Implement the erratum's suggested workaround and ignore IBS samples
> if MSRC001_1031 == 0.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Robert Richter <robert.richter@amd.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: x86@kernel.org
> ---
>  arch/x86/events/amd/ibs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 8c25fbd5142e..222c890527a2 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -90,6 +90,7 @@ struct perf_ibs {
>         unsigned long                   offset_mask[1];
>         int                             offset_max;
>         unsigned int                    fetch_count_reset_broken : 1;
> +       unsigned int                    fetch_ignore_if_zero_rip : 1;
>         struct cpu_perf_ibs __percpu    *pcpu;
>
>         struct attribute                **format_attrs;
> @@ -673,6 +674,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>         if (check_rip && (ibs_data.regs[2] & IBS_RIP_INVALID)) {
>                 regs.flags &= ~PERF_EFLAGS_EXACT;
>         } else {
> +               /* Workaround for erratum #1,197 */
> +               if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
> +                       goto out;

Can we just use the iregs.ip instead of dropping the sample?
Users might care about the accurate number of samples..

Thanks,
Namhyung


> +
>                 set_linear_ip(&regs, ibs_data.regs[1]);
>                 regs.flags |= PERF_EFLAGS_EXACT;
>         }
> @@ -770,6 +775,9 @@ static __init void perf_event_ibs_init(void)
>         if (boot_cpu_data.x86 >= 0x16 && boot_cpu_data.x86 <= 0x18)
>                 perf_ibs_fetch.fetch_count_reset_broken = 1;
>
> +       if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
> +               perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
> +
>         perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
>
>         if (ibs_caps & IBS_CAPS_OPCNT) {
> --
> 2.31.1
>
