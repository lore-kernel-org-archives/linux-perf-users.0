Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83B13C9A2
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721080151; cv=none; b=EubdobyO8q8cQzIWnFAcb8RVLtcu53a15slTXyKvzbKjXfOoZ/ZodccFjkHO/5E6oihLZAZ9jY2nVb33K2wlHn+4m9pgEnTmbgTIIh7AW3PZ9PhbY7Qq+dBIZ+ynCYLIEtY5t5FWhKK4OpVFyFMAKGrGzUW4kDJ66ME7f6eLsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721080151; c=relaxed/simple;
	bh=icsIhjbqGJ97qDRODTRFkfubplAMzBZVyLddHlJMxkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQv+dd5pnDJurai96DCt7QJ2xeMl5JpnYc/B9JRzGuG77+csyEdOMZqXzpdratjwMrb3R3CDvR304AfVs46CkDn4UPiqsxh6b94FviYptlRSaX8Ahk0vFSBwJi3qydwhkncNTM8Q4pTmM/vq1HyB2eRsKG3/ixTX6dUDAIuj8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+0Wbscx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+0Wbscx"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44e534a1fbeso46801cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721080147; x=1721684947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB6SC4uGgu6orZ7uUyB+Wip/qnu3DTiRnxdXUaHY4wE=;
        b=u+0WbscxdBvO+mB3/sQHb9lgX+f/6YAEOaY+ft2eEzjDeRJaGJXAuKFgji/mot4g3J
         aooLP5dshcd0Rpp/HfLQMXZ4zUb6I1uoP97AktC37iVQhzQHhyvs6AeqL4nPwJsbD/p0
         pWaDXpAo4XccvyVbD0eI3eMmBm92mvhNGNamQyWVSC+4zAoD6TJQQP5Pgtblx1y7oGRB
         8ZIiBzA3uc9quTTvTgfflkpjYKvEgToJaHgTnRqsmUHCO11tQCr3lYHhRMKbCFjt1cEL
         F8xf7ZaYtNQkOBHC/Cce5MIgIuWiYEpD2GLpDg4vrUpWDcljE2FiwHVHEc8qV9iH4rFN
         LXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721080147; x=1721684947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wB6SC4uGgu6orZ7uUyB+Wip/qnu3DTiRnxdXUaHY4wE=;
        b=auTBPyqw89v6KXIXTvtdJQjzLZXjGchxjaJB1G9SDP1v5SFahH5JIFpvGjxWCfVHgj
         WqW4NLqXDNNbTTfIhUPUwp0Jr9VZsm8Ph+EJ6S5VB8Wsn7fZuQ4B0QlOwNT/0yFRHT9F
         10Iuz++yXovdj9oQnPQ5EMglP7N5eAG+MXsO6sq3A8LlKoVvcGquh/5l4SfzP72sX5R+
         jptePcUZFMLAWQRkUMMdGx9ahiwUPrazZlnokAJRDC8wi/v5u/K13jXi19YCT2dFGDHN
         P++jK81wtcyr1m+EhCOFmSbLoQs7T0PrlStE6oM1jZYk5D3cPObeO5Myx2WFOmv/2Z+p
         KQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdH0K3btOwGCTXzy2mSX1nFZFPk+oG0iQAGvZ+ZrdE0GelPJ+1EuDYB8J+ZaRZrgSw+DchcpR4wMElCTmNjJaq1asOOelnTSf0OQwrQQ9ccg==
X-Gm-Message-State: AOJu0YzO2+cVfp1LLt9n1lmiAXVJoCoxhTvANVhIR/HSUViujWUhSLAW
	4hH7Bab3mUBlQ6F3gvoi0sXB6mi+zTuHzwDSnVkTL2Rn38tSkMKv805JXyd63vvpO3JgdcD3ykN
	mJUgSvyZ2IWVUpry8cp6XYhQZYd7Sa0/ksr/e
X-Google-Smtp-Source: AGHT+IGhwTiqL6/IuPxIfPGI2o8M8T5jSY2UEJVTwdFThGzYdC8Wi2wU6umxV/eEeTZynx4KCQZgI14aR/KG4ZKDSW0=
X-Received: by 2002:a05:622a:6113:b0:447:e153:66e0 with SMTP id
 d75a77b69052e-44f7a64d44bmr943591cf.2.1721080147286; Mon, 15 Jul 2024
 14:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407101021.2c8baddb-oliver.sang@intel.com> <ec744c86-b73e-417a-8e3a-c07142bf37d1@linux.intel.com>
 <CAP-5=fUqGcnGvB71jHHTecLqcky6+TrFo+hWb=eBxZjxfe_m-g@mail.gmail.com> <48b4bfb0-d0c7-4d1f-9e52-06e873646366@linux.intel.com>
In-Reply-To: <48b4bfb0-d0c7-4d1f-9e52-06e873646366@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 14:48:55 -0700
Message-ID: <CAP-5=fV2YTD5ZWcZgYN+cX7atdoiM2G2=xN=c_q5UmXyQzEkRQ@mail.gmail.com>
Subject: Re: [linux-next:master] [perf vendor events] e2641db83f: perf-sanity-tests.perf_all_PMU_test.fail
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Namhyung Kim <namhyung@kernel.org>, 
	Weilin Wang <weilin.wang@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 2:41=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-07-15 4:11 p.m., Ian Rogers wrote:
> > On Mon, Jul 15, 2024 at 1:05=E2=80=AFPM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >> Hi Ian,
> >>
> >> On 2024-07-10 12:59 a.m., kernel test robot wrote:
> >>>
> >>>
> >>> Hello,
> >>>
> >>> kernel test robot noticed "perf-sanity-tests.perf_all_PMU_test.fail" =
on:
> >>>
> >>> commit: e2641db83f18782f57a0e107c50d2d1731960fb8 ("perf vendor events=
: Add/update skylake events/metrics")
> >>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> >>>
> >>> [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b043=
84257]
> >>>
> >>> in testcase: perf-sanity-tests
> >>> version:
> >>> with following parameters:
> >>>
> >>>       perf_compiler: gcc
> >>>
> >>>
> >>>
> >>> compiler: gcc-13
> >>> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.4=
0GHz (Coffee Lake) with 32G memory
> >>>
> >>> (please refer to attached dmesg/kmsg for entire log/backtrace)
> >>>
> >>>
> >>> we also observed two cases which also failed on parent can pass on th=
is commit.
> >>> FYI.
> >>>
> >>>
> >>> caccae3ce7b988b6 e2641db83f18782f57a0e107c50
> >>> ---------------- ---------------------------
> >>>        fail:runs  %reproduction    fail:runs
> >>>            |             |             |
> >>>            :6          100%           6:6     perf-sanity-tests.perf_=
all_PMU_test.fail
> >>>            :6          100%           6:6     perf-sanity-tests.perf_=
all_metricgroups_test.pass
> >>>            :6          100%           6:6     perf-sanity-tests.perf_=
all_metrics_test.pass
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> >>> the same patch/commit), kindly add following tags
> >>> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-lkp/202407101021.2c8baddb-oliver=
.sang@intel.com
> >>>
> >>>
> >>>
> >>> 2024-07-09 07:09:53 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e264=
1db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 105
> >>> 105: perf all metricgroups test                                      =
: Ok
> >>> 2024-07-09 07:10:11 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e264=
1db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 106
> >>> 106: perf all metrics test                                           =
: Ok
> >>> 2024-07-09 07:10:23 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e264=
1db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 107
> >>> 107: perf all libpfm4 events test                                    =
: Ok
> >>> 2024-07-09 07:10:47 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e264=
1db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 108
> >>> 108: perf all PMU test                                               =
: FAILED!
> >>>
> >>
> >> The failure is caused by the below change in the e2641db83f18.
> >>
> >> +    {
> >> +        "BriefDescription": "This 48-bit fixed counter counts the UCL=
K
> >> cycles",
> >> +        "Counter": "FIXED",
> >> +        "EventCode": "0xff",
> >> +        "EventName": "UNC_CLOCK.SOCKET",
> >> +        "PerPkg": "1",
> >> +        "PublicDescription": "This 48-bit fixed counter counts the UC=
LK
> >> cycles.",
> >> +        "Unit": "cbox_0"
> >>      }
> >>
> >> The other cbox events have the unit name "CBOX", while the fixed count=
er
> >> has a unit name "cbox_0". So the events_table will maintain separate
> >> entries for cbox and cbox_0.
> >>
> >> The perf_pmus__print_pmu_events() calculate the total number of events=
,
> >> allocate an aliases buffer, store all the events into the buffer, sort=
,
> >> and print all the aliases one by one.
> >>
> >> The problem is that the calculated total number of events doesn't matc=
h
> >> the stored events on the SKL machine.
> >>
> >> The perf_pmu__num_events() is used to calculate the number of events. =
It
> >> invokes the pmu_events_table__num_events() to go through the entire
> >> events_table to find all events. Because of the
> >> pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
> >> the events for cbox and cbox_0 are all counted.
> >>
> >> When storing events into the aliases buffer, the
> >> perf_pmu__for_each_event() only process the events for cbox.
> >>
> >> Since a bigger buffer was allocated, the last entry are all 0.
> >> When printing all the aliases, null will be outputed.
> >>
> >> $ perf list pmu
> >>
> >> List of pre-defined events (to be used in -e or -M):
> >>
> >>   (null)                                             [Kernel PMU event=
]
> >>   branch-instructions OR cpu/branch-instructions/    [Kernel PMU event=
]
> >>   branch-misses OR cpu/branch-misses/                [Kernel PMU event=
]
> >>
> >>
> >> I'm thinking of two ways to address it.
> >> One is to only print all the stored events. The below patch can fix it=
.
> >>
> >> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> >> index 3fcabfd8fca1..2b2f5117ff84 100644
> >> --- a/tools/perf/util/pmus.c
> >> +++ b/tools/perf/util/pmus.c
> >> @@ -485,6 +485,7 @@ void perf_pmus__print_pmu_events(const struct
> >> print_callbacks *print_cb, void *p
> >>                 perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &st=
ate,
> >>                                         perf_pmus__print_pmu_events__c=
allback);
> >>         }
> >> +       len =3D state.index;
> >>         qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
> >>         for (int j =3D 0; j < len; j++) {
> >>                 /* Skip duplicates */
> >>
> >> The only drawback is that perf list will not show the new cbox_0 event=
.
> >> (But the event name still works. Users can still apply perf stat -e
> >> unc_clock.socket.)
> >>
> >> Since the cbox_0 event is only available on old machines (SKL and
> >> earlier), people should already use the equivalent kernel event. It
> >> doesn't sounds a big issue for me. I prefer this simple fix.
> >>
> >> I think the other way would be to modify the perf_pmu__for_each_event(=
)
> >> to go through all the possible PMUs.
> >> It seems complicated and may impact others ARCHs (e.g., S390). I haven=
't
> >> tried it yet.
> >>
> >> What do you think?
> >> Do you see any other ways to address the issue?
> >
> > Ugh. It seems the sizing and then iterating approach is just prone to
> > keep breaking. Perhaps we can switch to realloc-ed arrays to avoid the
> > need for perf_pmu__num_events, which seems to be the source of the
> > problems.
> >
>
> I think a realloc-ed array should have the same drawback as the first
> way, but bad performance.
> Because the pmu_add_cpu_aliases() in the perf_pmu__for_each_event() only
> add the events from the first matched PMU. If we don't fix it, the
> UNC_CLOCK.SOCKET of cbox_0 will never be displayed.

Ok, but I don't think we need to optimize `perf list` for speed. Fwiw,
I think this was the fix for the last bug in this code:
https://lore.kernel.org/r/20240511003601.2666907-1-irogers@google.com

Thanks,
Ian
