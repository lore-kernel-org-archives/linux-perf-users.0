Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A213AA41
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074274; cv=none; b=YHJ9+3lbcGq8zHg4Q2B4lec8ECZZSH40kEZ0H3x5o7f/9GTPzmnITnuGHloXBbYwaB4wskcPDE5t8qoYBJ/wKzs0QEGxXkOqeB/lcwK8IvvxoA3hicWtbhGrdzM/ggrl9bXNha7i93VdEGj6/HCgYyNDKjDED3G+gQS2WW+10C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074274; c=relaxed/simple;
	bh=zkh4ohgwJB6SNaHuF24QcMJwhqylbvv+Ul14NFTAd6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtORrOq2SbhqA4sQNcobsnUzn8OP/DsHIigw/04hog9YQo3XyaVtmP/iMA6uXe1GwxvX+VghLGPSzeS/gaPOx88Lys1LRropqwfVqJN/WAOFViYUSQ12KTqj0SwBfgmGgnGUQ4mOe13sL6erlWxH4IiIFiN+R5pvUxBfQuURpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fd/81rvx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fd/81rvx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb67f59805so12165ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721074273; x=1721679073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+8XC+YAYfGY9wu0jexmyV/isIA7xf3gadQwEp3guO4=;
        b=Fd/81rvx0es1WEEgPZKwEW32rGez8fN7/Dre2bmKmdEMOpaiQhQGpWHpO9l5kEkHZm
         kaRbQ7qjLEXP6oSA201CY42eneTEDfHvbSCdRtOOa71TFnvYf5xdhGTCmY9IXs5plxb8
         Mi8/AjevKHzseUCrSrUtzEhf3ma5+bykC9cqTEAKFjUQmDWWLFT3g6f9coJOFQJM2dUt
         s+wFNw1VZOsLIZkAH5pB0CdxESCmkiG2aMgbhMsJ67hbeIfYpQ5C2NcncO2UIMCjkTbC
         byRUSGIcZ/5Zw8a2DIxKzBVrxjbE9BY88uujxgKpx8uTj2VgNw4cDdkkPh2cO7hPyIYI
         JFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074273; x=1721679073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+8XC+YAYfGY9wu0jexmyV/isIA7xf3gadQwEp3guO4=;
        b=SCMfL3ZtGXnVFOnxLAzFxFJDJpLAUfIA+B3qzF5FZ1j7pcl5s+ZDnF7x57aeZfKDol
         fNA4sy/HFlivXGDjYCDex2/xFvWwdZOrrtgBKnmDaYD9vkJK4OpH6AFHAUaY5HqKewDH
         kNEBwXe9xy7JksujTV9HD4Lkkq4j9XsnrruNPqgKkJiLZPdoyaROX/5/t91AXBHvJS2G
         L0OPZYal0gYNm+pPNm5KtKpJdWOuYJ+mEohDuBX4uV9toZYO6E6k/fqRupIS2BkOi+Ug
         loUj2Oi/+M4xBy5SZE9A0Z4QUPYWf1JWl9+CxgwZhNcaOWbI/E69gUjQnG4QzYYHPO0D
         WA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPkU45apwGmehXqvut/uAGF4ffuluem6wjHlLXuFbytIffJH32k7NvApBd1cq4RDVheCtQuVdJL8RqfMgyiEb1WiSh7EhQvK7NxhPFLKfJIw==
X-Gm-Message-State: AOJu0YwsDM9jDS8afVuUY0nndnO16C6fsvGCP95EA8Da7icKPRJiEpxc
	I9yC17YkUscMFL2CG9Hn7ge+cV2/mtjIXjLrNVSgpnV081fe9j5TaO2BDj6T0HBcAbm1smHIwyU
	IF31qRtTAhm/dZlz/Dkg6FBvRcvWbEEsbUJrV
X-Google-Smtp-Source: AGHT+IE9Wtsd5xJe49TAZXmU4vck6FQTGGOiDV4YjFrp/Xf6d3q9s50kG1iMn8QpN2cIYR2RIAnDx3B9rGGi45Fpr7g=
X-Received: by 2002:a17:903:1249:b0:1fb:1006:980f with SMTP id
 d9443c01a7336-1fc3c77dae9mr717425ad.16.1721074272329; Mon, 15 Jul 2024
 13:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407101021.2c8baddb-oliver.sang@intel.com> <ec744c86-b73e-417a-8e3a-c07142bf37d1@linux.intel.com>
In-Reply-To: <ec744c86-b73e-417a-8e3a-c07142bf37d1@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 13:11:01 -0700
Message-ID: <CAP-5=fUqGcnGvB71jHHTecLqcky6+TrFo+hWb=eBxZjxfe_m-g@mail.gmail.com>
Subject: Re: [linux-next:master] [perf vendor events] e2641db83f: perf-sanity-tests.perf_all_PMU_test.fail
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Namhyung Kim <namhyung@kernel.org>, 
	Weilin Wang <weilin.wang@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 1:05=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> Hi Ian,
>
> On 2024-07-10 12:59 a.m., kernel test robot wrote:
> >
> >
> > Hello,
> >
> > kernel test robot noticed "perf-sanity-tests.perf_all_PMU_test.fail" on=
:
> >
> > commit: e2641db83f18782f57a0e107c50d2d1731960fb8 ("perf vendor events: =
Add/update skylake events/metrics")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384=
257]
> >
> > in testcase: perf-sanity-tests
> > version:
> > with following parameters:
> >
> >       perf_compiler: gcc
> >
> >
> >
> > compiler: gcc-13
> > test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40G=
Hz (Coffee Lake) with 32G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > we also observed two cases which also failed on parent can pass on this=
 commit.
> > FYI.
> >
> >
> > caccae3ce7b988b6 e2641db83f18782f57a0e107c50
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :6          100%           6:6     perf-sanity-tests.perf_al=
l_PMU_test.fail
> >            :6          100%           6:6     perf-sanity-tests.perf_al=
l_metricgroups_test.pass
> >            :6          100%           6:6     perf-sanity-tests.perf_al=
l_metrics_test.pass
> >
> >
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202407101021.2c8baddb-oliver.s=
ang@intel.com
> >
> >
> >
> > 2024-07-09 07:09:53 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641d=
b83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 105
> > 105: perf all metricgroups test                                      : =
Ok
> > 2024-07-09 07:10:11 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641d=
b83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 106
> > 106: perf all metrics test                                           : =
Ok
> > 2024-07-09 07:10:23 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641d=
b83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 107
> > 107: perf all libpfm4 events test                                    : =
Ok
> > 2024-07-09 07:10:47 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641d=
b83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 108
> > 108: perf all PMU test                                               : =
FAILED!
> >
>
> The failure is caused by the below change in the e2641db83f18.
>
> +    {
> +        "BriefDescription": "This 48-bit fixed counter counts the UCLK
> cycles",
> +        "Counter": "FIXED",
> +        "EventCode": "0xff",
> +        "EventName": "UNC_CLOCK.SOCKET",
> +        "PerPkg": "1",
> +        "PublicDescription": "This 48-bit fixed counter counts the UCLK
> cycles.",
> +        "Unit": "cbox_0"
>      }
>
> The other cbox events have the unit name "CBOX", while the fixed counter
> has a unit name "cbox_0". So the events_table will maintain separate
> entries for cbox and cbox_0.
>
> The perf_pmus__print_pmu_events() calculate the total number of events,
> allocate an aliases buffer, store all the events into the buffer, sort,
> and print all the aliases one by one.
>
> The problem is that the calculated total number of events doesn't match
> the stored events on the SKL machine.
>
> The perf_pmu__num_events() is used to calculate the number of events. It
> invokes the pmu_events_table__num_events() to go through the entire
> events_table to find all events. Because of the
> pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
> the events for cbox and cbox_0 are all counted.
>
> When storing events into the aliases buffer, the
> perf_pmu__for_each_event() only process the events for cbox.
>
> Since a bigger buffer was allocated, the last entry are all 0.
> When printing all the aliases, null will be outputed.
>
> $ perf list pmu
>
> List of pre-defined events (to be used in -e or -M):
>
>   (null)                                             [Kernel PMU event]
>   branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
>   branch-misses OR cpu/branch-misses/                [Kernel PMU event]
>
>
> I'm thinking of two ways to address it.
> One is to only print all the stored events. The below patch can fix it.
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 3fcabfd8fca1..2b2f5117ff84 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -485,6 +485,7 @@ void perf_pmus__print_pmu_events(const struct
> print_callbacks *print_cb, void *p
>                 perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state=
,
>                                         perf_pmus__print_pmu_events__call=
back);
>         }
> +       len =3D state.index;
>         qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>         for (int j =3D 0; j < len; j++) {
>                 /* Skip duplicates */
>
> The only drawback is that perf list will not show the new cbox_0 event.
> (But the event name still works. Users can still apply perf stat -e
> unc_clock.socket.)
>
> Since the cbox_0 event is only available on old machines (SKL and
> earlier), people should already use the equivalent kernel event. It
> doesn't sounds a big issue for me. I prefer this simple fix.
>
> I think the other way would be to modify the perf_pmu__for_each_event()
> to go through all the possible PMUs.
> It seems complicated and may impact others ARCHs (e.g., S390). I haven't
> tried it yet.
>
> What do you think?
> Do you see any other ways to address the issue?

Ugh. It seems the sizing and then iterating approach is just prone to
keep breaking. Perhaps we can switch to realloc-ed arrays to avoid the
need for perf_pmu__num_events, which seems to be the source of the
problems.

Thanks,
Ian
