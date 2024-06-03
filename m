Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EBD320D
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Jun 2024 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429624; cv=none; b=dzq5tmxymjtNddMEEFRNA8uK+th7SW4kqg6WWQ+4abSHBrToxJdA9E0IwBmGTMsZlrVCK65sKbgD8d8555LFXXDeuyvywrCtfUKvhUadMhC4XJf77NdLtwHuAuEgT5Zo+/2JB/5mp14qP4L3GKvylI7SUb9PPrvsziNNcDtiaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429624; c=relaxed/simple;
	bh=Mg80o7H5UIDnH0+H3rB9+Jub8DUPORLjLI+9sQNkiek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsJdAzK97ifn2kXdA4pIiRXqxBZA1hHwbyRhuL8q06JO3ZKKlc6Aj8rze4bP+W/STFxzKNRhK4W+qc7W/ajrJIJhfYLmqYk2NtRGrJRWCCYUfK6tVgzK/pLmnBPYGEuSq9PvkjYbki/TkZRG2XyuY+QInDjrHedn/dnfCKx9Sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVzTm802; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVzTm802"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f61bbb1dfcso372065ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jun 2024 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717429623; x=1718034423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzGMCbAEFz7sST5Tw3h9EtKJ91Jm/r9MvFW6MwnVD2I=;
        b=vVzTm802sCGYA6gcZHO68UhSPIwosbadIYFom3u4ILFP47Ltpf3jWp5WHqB/TsPe4C
         mY18wt6f3JrmV4T73zwI1HDDEUiCy86C6hj0XPiO8dX7rsNRYr4e3Q+1Ns5iCWQ2AW/W
         9jHMsJg35+AWA3r3NL37DbkSkrFfCATnUDPMS+bEjUlJvJZAvErnEoBAcdUMGe3KP4kr
         LesPMtbHyjYgNYW4yZyJJOYZkHvgWlmIPbfGL+nUMW1UusbwISexCoRy+ifCEGvF4sih
         3FGetF1H3d7V5VCug/Gm9Y9/COvYhz7n2n9USwGom1/VsdHo2Mt3E5YHf+UYKB80UhTD
         yXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717429623; x=1718034423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzGMCbAEFz7sST5Tw3h9EtKJ91Jm/r9MvFW6MwnVD2I=;
        b=tRD9VdXNITGijoIP2VUw50nokYjy9tbId/v6s7W0UD11okluTQmPzjfKt0uxnZSsiF
         WTXLo14229ZFIsTmwJRCaWj9Y8Iox1jH8Tmh/fWKO9gOKafxw2Us719xZZTEBmI+I95u
         L2farP+MwuflC6gxWp8CwstAy9S9SGUjcefdUuwaW6HXaf3ycs0ku9kbxLRXMsgeW2rr
         ZSOHmLszw+vjrccmGQMsFhEBe1i3ZEgn4N8MaJ2hb7RLbZfmJPGuQkRO/evNJt4lMF3p
         tjYH/oLwGPM0/kayKUKM3KE7eUTLZf9D/kQi7DuH0UQCmuCVuehuG5TcNVW/Fwexudz3
         ccHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7tL4eX1NgDEpYDHYFZvCi3EauWg4B1YZ6pOBlMTWc8awjthgPbBEtrqMPUkCbv1lTVOEAH3MGgK2HYHDymQJsZLlbCBz9lqlnr3Zm3lTtlQ==
X-Gm-Message-State: AOJu0YzdBMD86zLbwfJ8AqySnSDJcjd0rPGHSnviT7idG/+zMkRdtyCx
	UIez1jiFpNtYplPvWDuWfcdkgXtfXsR5l/3/qpjorm8spdlks5+q3RokAb+61ijIeE2C5vfO0Fk
	RL56GaY6Nb4flTsfekMdYOs0V6AEdf4yTXk/n
X-Google-Smtp-Source: AGHT+IGiaIqxFOuAXfvlbUeMJ3aKV5pmlWuVLlqoe9vC8Z08hp5YfriujSTu0Z3xC8eUVOOrEjdr4z5zKMjLC//6ixs=
X-Received: by 2002:a17:903:24a:b0:1f4:95dc:bc61 with SMTP id
 d9443c01a7336-1f64f3a6e94mr3735205ad.15.1717429622232; Mon, 03 Jun 2024
 08:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525013021.436430-2-irogers@google.com> <202405311548.1e881dea-oliver.sang@intel.com>
 <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com> <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020>
In-Reply-To: <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 08:46:49 -0700
Message-ID: <CAP-5=fU=UPpZTULuyZm=Ep0Ri6SdTciL5kqpciUfnWyDvz6HZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Weilin Wang <weilin.wang@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 7:19=E2=80=AFAM Oliver Sang <oliver.sang@intel.com> =
wrote:
>
> hi, Ian,
>
> On Fri, May 31, 2024 at 09:38:01AM -0700, Ian Rogers wrote:
> > On Fri, May 31, 2024 at 1:16=E2=80=AFAM kernel test robot <oliver.sang@=
intel.com> wrote:
> > >
> > >
> > > hi, Ian Rogers,
> > >
> > > we actually want to seek your advice. in our env, there is no problem=
 to build
> > > parent.
> > >
> > > * 3249f8b84526d (linux-review/Ian-Rogers/perf-jevents-Autogenerate-em=
pty-pmu-events-c/20240525-093240) perf jevents: Autogenerate empty-pmu-even=
ts.c
> > > * 7d88bd0d22746 perf jevents: Use name for special find value   <--- =
parent
> > >
> > > however, failed to build perf upon 3249f8b84526d. but there is not ma=
ny useful
> > > information in below detail log.
> > >
> > > is there any dependency or env setting for us to build this commit? T=
hanks!
> >
> > Hi Oliver,
> >
> > Thanks for the report and the work testing! Seeing the output:
> >
> > [..snip..]
> > > --- pmu-events/empty-pmu-events.c       2024-05-30 08:20:10.000000000=
 +0000
> > > +++ pmu-events/test-empty-pmu-events.c  2024-05-30 15:55:37.332495538=
 +0000
> > > @@ -136,7 +136,7 @@
> > >  { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > >  { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache=
_miss_cycles\000\000\000\000\000\000\000\00000 */
> > >  { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_reti=
red.any\000\000\000\000\000\000\000\00000 */
> > > -{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_r=
etiredany\000\000\000\000\000\000\000\00000 */
> > > +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_r=
etired.any\000\000\000\000\000\000\000\00000 */
> > >
> > >  };
> > >
> > > @@ -373,7 +373,7 @@
> > [..snip..]
> >
> > It appears the version of empty-pmu-events.c the patch adds and the
> > version generated in your test configuration are differing because of
> > whitespace. Perhaps a hex editor will show what the exact difference
> > is, it must relate to locales or something. Like you mention this
> > could be resolved by an env change.
> >
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20240531/202405311548.1e881de=
a-oliver.sang@intel.com
> >
> > I didn't see the generated test-empty-pmu-events.c there and so
> > couldn't follow up on the locale/env exploration. I wonder that a
> > suitable workaround is to change from the patch:
> >
> > +$(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_E=
VENTS_C)
> > +       $(call rule_mkdir)
> > +       $(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
> >
> > to instead of invoking "diff -u" to invoke "diff -w -u", that is to
> > ignore whitespace. I can send a v3 with this.
>
> I tried below patch
>
> commit a79a41133a41adc2d69c8f603c7d880b3796cbf7
> Author: 0day robot <lkp@intel.com>
> Date:   Mon Jun 3 16:35:45 2024 +0800
>
>     fix from Ian Rogers: invoke "diff -w -u" instead of "diff -u"
>
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index c3fa43c497069..54d19b492db5c 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -39,7 +39,7 @@ $(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVE=
NTS_PY) $(METRIC_PY) $(ME
>
>  $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVE=
NTS_C)
>         $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
> +       $(Q)$(call echo-cmd,test)diff -w -u $? 2> $@ || (cat $@ && false)
>
>  $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRI=
C_TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
>         $(call rule_mkdir)
>
>
> but make still failed. I still saw below in our build log
>
> --- pmu-events/empty-pmu-events.c       2024-06-03 08:41:16.000000000 +00=
00
> +++ pmu-events/test-empty-pmu-events.c  2024-06-03 13:47:19.522463482 +00=
00
> @@ -136,7 +136,7 @@
>  { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
>  { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\00000 */
>  { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\00000 */
> -{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
edany\000\000\000\000\000\000\000\00000 */
> +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\00000 */
>
>  };
>
>
> I will try to get generated test-empty-pmu-events.c tomorrow.

Thanks Oliver, if you could get the environment variables that would
probably also be useful.

Ian

> >
> > Thanks,
> > Ian
