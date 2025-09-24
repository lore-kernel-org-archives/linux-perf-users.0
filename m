Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F679DDAB
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749864; cv=none; b=Uld91qB+rPnXDtZTdTYumJROuTeYaKKZQMLA+Z6wonR8bVjPMgzddMFVnEhM4pWBgLOrg1r/GanxupElvGE6RX1AWQ0hjuTJkuYiEOg9fka0KBVuIix7KReEl4sjJJhGJw6PqVKcBRFvDdp3oVzOXpqHiJiUVPcMH+oWVeqc7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749864; c=relaxed/simple;
	bh=17LYgmK4JvAjD0FWBvNDDKALY5W7uV5JzIgkjLPf5b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/puxipRflxfU/l2I9g86A8C3y811TyZrLB22avlIYKjMH2migm9zH0PiBhoH97bMvdw9VxnZTZUE6DkBYjl1n4I6ZES4xkJ8Aj/9ZqsQkTlGzdC8TvGmlv6jIBakzvrv5s3CbuJgEmqaZV3sXrGmmzkBtHxUD0aq12EevmvvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jln7KOvf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jln7KOvf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2731ff54949so250735ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758749862; x=1759354662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFvbZZiAHF2Hk61HgOAi5XcHq2TyNVsro7/7CQ3zI1s=;
        b=Jln7KOvfUzgXJmUtJRaM5MipVIlUD3IRO0AsTr9rXfVaYu65JMnJPWu+j2b8ogJsDq
         h5VPUZcd2ff+Qvgi6KSBTLWqKQ0SZeOktyngzsy7teLyPA/03jEdcm73jnM+5/X6fKnH
         9TQ2/LM0zS8px/FBA5MOZkMBb2fYmlhDlzbLY3qJ8xnr7j66DjPXa49S4zoizayfab8x
         htNvxJN4S519fBbzD59L/pmWNRfYEGtvJYJXS1lxkyAcKhzU1HzxHm17uzsXFpcpOUGD
         U0u87blphpFGDf/ASMi5Hj0ZoJuN+IAkfPwI1KyCGPHbB0K9wVHtybpAt+kNF7YBAMZT
         PFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749862; x=1759354662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFvbZZiAHF2Hk61HgOAi5XcHq2TyNVsro7/7CQ3zI1s=;
        b=vQmlcHSQ+c/OwOmAnXTiZV6/8TSCGPLpBgFnMpDUmMiR9NqZZVjk6ndVLE0q3ZxVpC
         PJFwzCKZyx9zdFZpP9mT58UHlpPx7OO1Y544EfNiDZSQOQwOYAvexFeQG2UngFBszYb/
         KlFAONLgKf5ojsd3jkb6QZSYYpKsnZsbZ8aRXMCFYsuLxrPF8AefqoA0HmVaev2DAqeF
         4PAkSxwTVRMQF8nk5LojfHKc94BVW1D8wkhuW4VekQ7O2UC3pnpQG4UEnuj545GnJaKs
         15PbwJkEIoikpHXXZb1JQ3o4alsSTYaq61X+MdKEskNBZ1YIQ85FxNjA7XVs7ZWwdGRO
         1RXw==
X-Forwarded-Encrypted: i=1; AJvYcCV/+oGWIYvIHYQmDzW3yXeDHlIh6CeZJ92quPD+iWTyDMPXElCRizMvxCbq82fDtBC0fKcjEP+czxDypTat96qP@vger.kernel.org
X-Gm-Message-State: AOJu0YxxEvGixs6uGN1OuwvSNlS+0mUsthhFmrWu+h6hKYQ3bGi9ht4c
	Ox5H2B50RfsB2LC5nQDIVSEPBId7LHpwnqQd/RyItQ1dzsUb0IHEv+NVyvcs6JiEfTktevMXWaT
	IerbjbRzsd1w+D4hcGmLH6pEJxhNxnZgpy+cOGHeV
X-Gm-Gg: ASbGncvwCqA1PeVloWq24x6drrexit98cvj8PheFofwtr4G7wdcGcxuqrTymX78BByP
	aqVpwm1jOVjBfwjuAoCvXgKmOL9HtbLb9X4GwQ2t/aP4S4Rq4F3+vDdel1Il4cXufGkH1UX/KXF
	DTLaNNFEsONxerIgcoFrRhdIOp1GP10a5kL0TVrvgDljg93qCYLjLVywDeBn65Qrp/aZL/P2KXN
	NlnEG3wUZkxo6L6tbURWz5N5lfhr91jYc7WFL/SbMzJ
X-Google-Smtp-Source: AGHT+IGAEIeKjkscs0uRVhkvamqoIxBxFi2uiE1a4G4rjGw0HfEbtPzxOAGloNEEhE1F78dSNls8KNgFKyo6hmJFIXo=
X-Received: by 2002:a17:903:22d1:b0:248:dce7:40e1 with SMTP id
 d9443c01a7336-27ed402c086mr2509505ad.9.1758749861748; Wed, 24 Sep 2025
 14:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902164047.64261-1-thomas.falcon@intel.com> <20250902164047.64261-3-thomas.falcon@intel.com>
In-Reply-To: <20250902164047.64261-3-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Sep 2025 14:37:30 -0700
X-Gm-Features: AS18NWC-PhAQczsB5BOwmUV8XTXM7bOBfpibujvxjLT6HBUuQLd-vRLMIrPaG38
Message-ID: <CAP-5=fU27BLudDDBGTWxG42oiAXEEC0qy63S7zvBUiS07PxazQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2 2/2] perf record: Add auto counter reload parse
 and regression tests
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:41=E2=80=AFAM Thomas Falcon <thomas.falcon@intel.c=
om> wrote:
>
> Include event parsing and regression tests for auto counter reload
> and ratio-to-prev event term.
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

There will be conflicts with:
https://lore.kernel.org/linux-perf-users/20250923223312.238185-1-irogers@go=
ogle.com/
as I refactored parts of the parse-events test. I wouldn't be holding
my breath waiting for those patches to land, so I guess I'll deal with
the issues when they pop up.

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c  | 54 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/shell/record.sh | 40 +++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index bb8004397650..67550cc60555 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -1736,6 +1736,53 @@ static int test__intel_pt(struct evlist *evlist)
>         return TEST_OK;
>  }
>
> +static bool test__acr_valid(void)
> +{
> +       struct perf_pmu *pmu =3D NULL;
> +
> +       while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> +               if (perf_pmu__has_format(pmu, "acr_mask"))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static int test__ratio_to_prev(struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +       int ret;
> +
> +       TEST_ASSERT_VAL("wrong number of entries", 2 * perf_pmus__num_cor=
e_pmus() =3D=3D evlist->core.nr_entries);
> +
> +        evlist__for_each_entry(evlist, evsel) {
> +               if (!perf_pmu__has_format(evsel->pmu, "acr_mask"))
> +                       return TEST_OK;
> +
> +               if (evsel =3D=3D evlist__first(evlist)) {
> +                       TEST_ASSERT_VAL("wrong config2", 0 =3D=3D evsel->=
core.attr.config2);
> +                       TEST_ASSERT_VAL("wrong leader", evsel__is_group_l=
eader(evsel));
> +                       TEST_ASSERT_VAL("wrong core.nr_members", evsel->c=
ore.nr_members =3D=3D 2);
> +                       TEST_ASSERT_VAL("wrong group_idx", evsel__group_i=
dx(evsel) =3D=3D 0);
> +                       ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU=
_CYCLES, "cycles");
> +               } else {
> +                       TEST_ASSERT_VAL("wrong config2", 0 =3D=3D evsel->=
core.attr.config2);
> +                       TEST_ASSERT_VAL("wrong leader", !evsel__is_group_=
leader(evsel));
> +                       TEST_ASSERT_VAL("wrong core.nr_members", evsel->c=
ore.nr_members =3D=3D 0);
> +                       TEST_ASSERT_VAL("wrong group_idx", evsel__group_i=
dx(evsel) =3D=3D 1);
> +                       ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_INS=
TRUCTIONS, "instructions");
> +               }
> +               if (ret)
> +                       return ret;
> +               /*
> +                * The period value gets configured within evlist__config=
,
> +                * while this test executes only parse events method.
> +                */
> +               TEST_ASSERT_VAL("wrong period", 0 =3D=3D evsel->core.attr=
.sample_period);
> +       }
> +       return TEST_OK;
> +}
> +
>  static int test__checkevent_complex_name(struct evlist *evlist)
>  {
>         struct evsel *evsel =3D evlist__first(evlist);
> @@ -2249,6 +2296,13 @@ static const struct evlist_test test__events[] =3D=
 {
>                 .check =3D test__checkevent_tracepoint,
>                 /* 4 */
>         },
> +       {
> +               .name  =3D "{cycles,instructions/period=3D200000,ratio-to=
-prev=3D2.0/}",
> +               .valid =3D test__acr_valid,
> +               .check =3D test__ratio_to_prev,
> +               /* 5 */
> +       },
> +
>  };
>
>  static const struct evlist_test test__events_pmu[] =3D {
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index b1ad24fb3b33..0f5841c479e7 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -388,6 +388,45 @@ test_callgraph() {
>    echo "Callgraph test [Success]"
>  }
>
> +test_ratio_to_prev() {
> +  echo "ratio-to-prev test"
> +  if ! perf record -o /dev/null -e "{instructions, cycles/period=3D10000=
0,ratio-to-prev=3D0.5/}" \
> +     true 2> /dev/null
> +  then
> +    echo "ratio-to-prev [Skipped not supported]"
> +    return
> +  fi
> +  if ! perf record -o /dev/null -e "instructions, cycles/period=3D100000=
,ratio-to-prev=3D0.5/" \
> +     true |& grep -q 'Invalid use of ratio-to-prev term without precedin=
g element in group'
> +  then
> +    echo "ratio-to-prev test [Failed elements must be in same group]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf record -o /dev/null -e "{instructions,dummy,cycles/period=3D=
100000,ratio-to-prev=3D0.5/}" \
> +     true |& grep -q 'must have same PMU'
> +  then
> +    echo "ratio-to-prev test [Failed elements must have same PMU]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf record -o /dev/null -e "{instructions,cycles/ratio-to-prev=
=3D0.5/}" \
> +     true |& grep -q 'Event period term or count (-c) must be set when u=
sing ratio-to-prev term.'
> +  then
> +    echo "ratio-to-prev test [Failed period must be set]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf record -o /dev/null -e "{cycles/ratio-to-prev=3D0.5/}" \
> +     true |& grep -q 'Invalid use of ratio-to-prev term without precedin=
g element in group'
> +  then
> +    echo "ratio-to-prev test [Failed need 2+ events]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Basic ratio-to-prev record test [Success]"
> +}
> +
>  # raise the limit of file descriptors to minimum
>  if [[ $default_fd_limit -lt $min_fd_limit ]]; then
>         ulimit -Sn $min_fd_limit
> @@ -404,6 +443,7 @@ test_leader_sampling
>  test_topdown_leader_sampling
>  test_precise_max
>  test_callgraph
> +test_ratio_to_prev
>
>  # restore the default value
>  ulimit -Sn $default_fd_limit
> --
> 2.50.1
>
