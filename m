Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E365C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jul 2022 22:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiGSWmb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jul 2022 18:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbiGSWma (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jul 2022 18:42:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFC55D0CC
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jul 2022 15:42:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so226555wmo.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jul 2022 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Xp4OEUi6R+aBFLPRkw9TiBXnBGJkUzRpG9JK7ttIaI=;
        b=r96jTHk5U7oIXsKC84CqWsfrUB696Ew4eLHpBMO/3N8Ny+QF0YneBpuYIr3/UhculI
         RD5JBm/ErIqRRjgrv2pGwReXfRm/uJbKP/I411c3q9Eah7nVr/4QldKH0CzqjYMirJrP
         KzU6X0gG2FbvV6rpe/WgsveopCv7bdNcoBUmsUgj73NJK6w9qHxvJe6GJXV80vOJXR72
         aZQ4lBxzsReNWFANO2hkbFWn4b0CKGfAH4ksG2EpbeiI6Oey8p6RatHpsO4nRM+W7ji2
         GfCau+1yCdm1mbyU0L8eDgHRQnfaeWthdCxQqnTAHJBxdpmRt+dBCLXSh3Fl8sf5Mej5
         26eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Xp4OEUi6R+aBFLPRkw9TiBXnBGJkUzRpG9JK7ttIaI=;
        b=plmI+ZU7iSFDYk/8z/UEwIUdIeO48MMBwZyFKOOk9FP5XJOtnE30iPOTgMBycdChEm
         fqoSe4gMifV/19UP1RPlDTMdO0/f4azZQZ5bB5nArVg6XXAvzAvarO7FBn5262/Amy0o
         X9hDmGq3+Np7nfVbXb0zSCNmc1KTOW4Hh+ILahZoRqhSbkQkZOEoYI6/azd7htbAcvNv
         N9YsZazkp+Wq/Wr99TzKEHF5NcfACjFkGQdlRNsyH0DeeobEGhqZrXEkPyTXv2BkFHok
         qa63bFsDDEQewJ6OLUjxKEBn+IyQqWEmn393CWTe+wftmTJSTGZ4Vm4AUX0Taw9rZdvM
         G17g==
X-Gm-Message-State: AJIora9ocUYYtm5DCrNkMZ4VKEvEStINqRYvh9sFui0M2SHbqyNk+nPF
        yN2/NjlisErncyVuFJVT5Cz9QnzbACqdWBD54KzTHg==
X-Google-Smtp-Source: AGRyM1scEk8b9w3eYMRGaUdyL5UIua5Qs4J0Us1KQfm+WEB55Q2KObULqqTntjvb2g2RthbkXC6HgXy40vLN7Gi3EFo=
X-Received: by 2002:a7b:ce13:0:b0:3a3:102c:23d3 with SMTP id
 m19-20020a7bce13000000b003a3102c23d3mr1116893wmc.67.1658270548139; Tue, 19
 Jul 2022 15:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220609052355.1300162-1-irogers@google.com> <20220609052355.1300162-3-irogers@google.com>
 <CAL_Jsq+RSv2_VLdH2bum31cwM3pJuySi4_FhqB4=2vDOHqCdMA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+RSv2_VLdH2bum31cwM3pJuySi4_FhqB4=2vDOHqCdMA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 15:42:15 -0700
Message-ID: <CAP-5=fXmbS1PY4=1CY+RB7wtjfTuW8oq8Jc=eLtTxaLE=gZJdg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf: Align user space counter reading with code
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 19, 2022 at 10:45 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 8, 2022 at 11:24 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Align the user space counter reading documentation with the code in
> > perf_mmap__read_self. Previously the documentation was based on the perf
> > rdpmc test, but now general purpose code is provided by libperf.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/uapi/linux/perf_event.h       | 32 ++++++++++++++++-----------
> >  tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++-----------
> >  2 files changed, 38 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index d37629dbad72..3b84e0ad0723 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
> >          *
> >          *     if (pc->cap_usr_time && enabled != running) {
> >          *       cyc = rdtsc();
> > -        *       time_offset = pc->time_offset;
> >          *       time_mult   = pc->time_mult;
> >          *       time_shift  = pc->time_shift;
> > +        *       time_offset = pc->time_offset;
> > +        *       if (pc->cap_user_time_short) {
> > +        *         time_cycles = pc->time_cycles;
> > +        *         time_mask = pc->time_mask;
> > +        *       }
> >          *     }
> >          *
> >          *     index = pc->index;
> > @@ -548,6 +552,9 @@ struct perf_event_mmap_page {
> >          *     if (pc->cap_user_rdpmc && index) {
> >          *       width = pc->pmc_width;
> >          *       pmc = rdpmc(index - 1);
> > +        *       pmc <<= 64 - width;
> > +        *       pmc >>= 64 - width;
> > +        *       count += pmc;
> >          *     }
> >          *
> >          *     barrier();
> > @@ -590,25 +597,24 @@ struct perf_event_mmap_page {
> >          * If cap_usr_time the below fields can be used to compute the time
> >          * delta since time_enabled (in ns) using rdtsc or similar.
> >          *
> > -        *   u64 quot, rem;
> > -        *   u64 delta;
> > -        *
> > -        *   quot = (cyc >> time_shift);
> > -        *   rem = cyc & (((u64)1 << time_shift) - 1);
> > -        *   delta = time_offset + quot * time_mult +
> > -        *              ((rem * time_mult) >> time_shift);
> > +        *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> > +        *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
>
> I still think this chunk should stay as-is because mul_u64_u32_shr
> isn't defined here. At least a comment as to what the C version does:
>
> /* time_offset + (u64)(((unsigned __int128)cyc * time_mult) >> time_shift) */
>
> >          *
> >          * Where time_offset,time_mult,time_shift and cyc are read in the
> >          * seqcount loop described above. This delta can then be added to
> > -        * enabled and possible running (if index), improving the scaling:
> > +        * enabled and possible running (if index) to improve the scaling. Due
> > +        * to event multiplexing, running maybe zero and so care is needed to
>
> s/maybe/may be/
>
> > +        * avoid division by zero.
> >          *
> >          *   enabled += delta;
> > -        *   if (index)
> > +        *   if (idx)
>
> This should remain 'index'.

Thanks, I've tried to incorporate all of this into v3:
https://lore.kernel.org/lkml/20220719223946.176299-1-irogers@google.com/

Ian

> >          *     running += delta;
> >          *
> > -        *   quot = count / running;
> > -        *   rem  = count % running;
> > -        *   count = quot * enabled + (rem * enabled) / running;
> > +        *   if (running != 0) {
> > +        *     quot = count / running;
> > +        *     rem  = count % running;
> > +        *     count = quot * enabled + (rem * enabled) / running;
> > +        *   }
> >          */
> >         __u16   time_shift;
> >         __u32   time_mult;
