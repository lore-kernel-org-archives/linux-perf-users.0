Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF529422
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848490; cv=none; b=P8EZO5OBaZbpt2FnaJrPjCx8uY2oQbWQYWwW36m3JCnWnFBSPLJScCdBVrY9Wc5ZVvCXlqI/kJqbD82XfuCVTR0Rt5+bKVJFdSkYsZswbXrLAzPxeMF9g7caCr5bPDUxKlDAVKP5h0GCBXGzcCbCznRKss7Aul/ywRhvQ+KHndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848490; c=relaxed/simple;
	bh=kGi5UAb+cjPdyAxrgDl1/Lhz8BR/C4EXu+I+XYY+D0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WttYm7w6AlAlfsBHm3gOpLWIWSTYnoc0x5BZFUJFBvGzVM5wVlh0FbXmQgUSgqOyr1TJoZx2NiOhy90JMsCBMhpagzN7Krg4cFKUEH4h1nHcACZJGGGrlu3NVted/R7iaP9rrwYEZjkcatqkb+4iD1DjhC7hiUsz/5YZKNxePsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Khl1QVpp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Khl1QVpp"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-434b5abbb0dso303981cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712848487; x=1713453287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1asPQiHDC1fW6UbjKKwKMM7KUEzPE4wkrLiFHTi3xc=;
        b=Khl1QVppDUp6qs8C5IHRniQscdaudX2fyQQViRM7BbR74dp8R2NDd8rvYp2Q0eRdA1
         U3jGZWu29nSt69749ztVYnMjERsEAwyvMCltB/PlSUj4j76fVxbYy+VZ5DlqjrpyROd3
         wcXcln69T8h6p+Y76TWd6ONVhiUI3nKvJvW/wCDMMQMcGMErlL3vmJ08SLq+T2viTk0S
         brfXUGzntT2dQ1luWT3SHsy8uCerQKSZvOqF5wccDmThBxuJ9DCijk5aOQAC15uy6ZW9
         DJK6hXCf8vXJN3U7G1nj+YaO4d+GG4FzuJs6UcVtiTV8/K+/tWs2Fct+XuHhr712yajC
         arIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712848487; x=1713453287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1asPQiHDC1fW6UbjKKwKMM7KUEzPE4wkrLiFHTi3xc=;
        b=CiXqzFuD+TNmKFV8pUlqMvZ+OoTPl0+66+35TnyDHJ9y4nM4UjmEneLAP1PeKJX65U
         LbSbXZBfau6HYighp2M/g4cBTszUReA7Ee1IGa58NetB1J/iBGtKYDDYM18RwVx4WPA1
         aM1cN5H06GptGqAH+gJY+w8HF92gbUtRb1l8FD5XdqzKgL9CVlnIeeqowTEqGAPR7u1k
         yGgGhMF//SIQIcfz7pJ2zOI1tjuEYnFCXK4aBk4J4lPRVqqsn6SwhiW2dAWt3/UuwWez
         cI49TuRL48W8i5xRufslYLvxjqeBrxR15MlcQ9FV0zRU5CsdJSvhghubyq9/UYl44Srs
         2YUw==
X-Forwarded-Encrypted: i=1; AJvYcCX/pmrJFQ1J1fnnyIGOqzSwlU8zA3dzppai0l2Ead1OHNkDFuTtnLoQrueu0qKuFFe65c08IIZCi35cZHHc4RlYPmQFmwHKoxv64Sha4+EoQw==
X-Gm-Message-State: AOJu0YxF15FXX4MPzw6yVvssw42baW++BQ+3Q+FGJoTj7xXXj4scsMiO
	vQAq/27wLblIIaRYZHE/iDnjMHQJQquDcgiqQGGq7yMW5l6bjCdApWOFIR9QDaY8td8mCxfYdWY
	yV4NEW4lG4w/z/TTFVFdj+Yo7YMF0zKu9w2Uj
X-Google-Smtp-Source: AGHT+IFzTkgfAXjfhjgY2jgBlJwsDxRcT8DaGJ2dMBmGczc3BbWkjpn6SY2K7EuYuoL2lsiW+gzd5LksXYESS9lnl1w=
X-Received: by 2002:ac8:7342:0:b0:436:5fd1:74b5 with SMTP id
 q2-20020ac87342000000b004365fd174b5mr166915qtp.6.1712848487350; Thu, 11 Apr
 2024 08:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411144852.2507143-1-yanfei.xu@intel.com>
In-Reply-To: <20240411144852.2507143-1-yanfei.xu@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Apr 2024 08:14:36 -0700
Message-ID: <CAP-5=fWaB9c0m3Y5zAAS_4qs-L7n0=mqp7=zwatQOQmTc32YNQ@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Avoid two scenarios involving the
 reordering of topdown events
To: Yanfei Xu <yanfei.xu@intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 7:53=E2=80=AFAM Yanfei Xu <yanfei.xu@intel.com> wro=
te:
>
> We found that even an events group with slots but without topdown events
> will still reroder to place the slots first. It's unnecessary, and may
> break tools expecting the command line order to match the printed order.
> The issue was previously fixed [1], but was later discarded since [2].

The requirements for topdown events is a gift that keeps on giving :-( Plea=
se:
1) provide the tool that is broken,
2) provide a reason why the tool is depending on text output that may
vary over time (intended audience for it is humans) instead of say the
json output that is intended for consumption by tools,
3) provide a test.

> Add an extra check of evsel leader, variable must_be_in_group, to ensure
> the slots event is only moved if the group has non-slots topdown events.
>
> Without the patch:
>
>   $ perf stat  -e '{cpu/cpu-cycles/,slots}'  sleep 1
>   WARNING: events were regrouped to match PMUs
>
>    Performance counter stats for 'sleep 1':
>
>            2,663,256      slots:u
>              443,876      cpu/cpu-cycles/u
>
>          1.001079566 seconds time elapsed
>
>          0.001054000 seconds user
>          0.000000000 seconds sys
>
> With the patch:
>
>   $ perf stat  -e '{cpu/cpu-cycles/,slots}'  sleep 1
>
>    Performance counter stats for 'sleep 1':
>
>             469,039      cpu/cpu-cycles/u
>           2,814,234      slots:u
>
>         1.001148306 seconds time elapsed
>
>         0.001123000 seconds user
>         0.000000000 seconds sys
>
> In cases where both slots and topdown events are present, moving the
> slots event to be the first event is necessary. However there is no
> requirement to move the topdown events to be adjacent to slots event.
> So keep the original order of the topdown events is expected. Further
> more, if a group doesn't have slots event, the topdown events will be
> unexpectedly moved to the head of the group.
>
> Remove the movements regarding topdown events in arch_evlist__cmp()
>
> Without the patch:
>
>   $ perf stat -e '{slots,cpu/cpu-cycles/,cpu/topdown-bad-spec/}' sleep 1
>   WARNING: events were regrouped to match PMUs
>
>    Performance counter stats for 'sleep 1':
>
>           2,681,460      slots:u
>             336,496      cpu/topdown-bad-spec/u
>             446,910      cpu/cpu-cycles/u
>
>         1.001210088 seconds time elapsed
>
>         0.001160000 seconds user
>         0.000000000 seconds sys
>
> With the patch:
>
>   $ perf stat -e '{slots,cpu/cpu-cycles/,cpu/topdown-bad-spec/}' sleep 1
>
>    Performance counter stats for 'sleep 1':
>
>           2,715,486      slots:u
>             452,581      cpu/cpu-cycles/u
>             340,766      cpu/topdown-bad-spec/u
>
>         1.001116709 seconds time elapsed
>
>         0.001111000 seconds user
>         0.000000000 seconds sys
>
> [1] https://lore.kernel.org/lkml/20220321223344.1034479-1-irogers@google.=
com/#/
> [2] https://lore.kernel.org/lkml/20230302041211.852330-10-irogers@google.=
com/#/
>
> Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 13 +++++--------
>  tools/perf/arch/x86/util/evsel.c  |  6 ++++++
>  tools/perf/util/evsel.h           |  2 ++
>  tools/perf/util/parse-events.c    |  9 ++++++---
>  4 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util=
/evlist.c
> index b1ce0c52d88d..eed0a74c561a 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -75,17 +75,14 @@ int arch_evlist__add_default_attrs(struct evlist *evl=
ist,
>
>  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  {
> +       struct evsel *leader;
> +
>         if (topdown_sys_has_perf_metrics() &&
>             (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_=
group(rhs))) {
> +               leader =3D evsel__leader(rhs);

Usually the leader doesn't make sense at this point. For example, a
metric following event parsing may group
{cycles,slots,topdown-fe-bound} and cycles will be the leader. The
leader's properties say nothing about the ordering of slots and
topdown-fe-bound.

>                 /* Ensure the topdown slots comes first. */
> -               if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->na=
me, "uops_retired.slots"))
> -                       return -1;
> -               if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->na=
me, "uops_retired.slots"))
> -                       return 1;
> -               /* Followed by topdown events. */
> -               if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->=
name, "topdown"))
> -                       return -1;
> -               if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->=
name, "topdown"))
> +               if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->na=
me, "uops_retired.slots")
> +                       && leader->must_be_in_group)

Why isn't this symmetric? As in the lhs has a test that will return -1.

>                         return 1;
>         }
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/=
evsel.c
> index 090d0f371891..16f42fcfbe0b 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -44,6 +44,12 @@ bool arch_evsel__must_be_in_group(const struct evsel *=
evsel)
>             strcasestr(evsel->name, "uops_retired.slots"))
>                 return false;
>
> +       if (strcasestr(evsel->name, "topdown")) {
> +               struct evsel *leader =3D evsel__leader(evsel);
> +
> +               leader->must_be_in_group =3D true;
> +       }
> +
>         return strcasestr(evsel->name, "topdown") || strcasestr(evsel->na=
me, "slots");
>  }
>
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 517cff431de2..a7ab266bc915 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -98,6 +98,8 @@ struct evsel {
>                 bool                    bpf_counter;
>                 bool                    use_config_name;
>                 bool                    skippable;
> +               /* any evsels with the flag set must be in a group */
> +               bool            must_be_in_group;

This duplicates arch_evsel__must_be_in_group but one may be true when
the other isn't. This doesn't make sense to me.

I think this patch needs a rethink and the behavior with it looks
broken and more complex than what already exists. I also think the
problem is one that is more to do with the tool using the output than
the reordering.

Thanks,
Ian

>                 int                     bpf_fd;
>                 struct bpf_object       *bpf_obj;
>                 struct list_head        config_terms;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 6f8b0fa17689..37950056a661 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2052,9 +2052,12 @@ static int parse_events__sort_events_and_fix_group=
s(struct list_head *list)
>                  */
>                 pos->core.idx =3D idx++;
>
> -               /* Remember an index to sort all forced grouped events to=
gether to. */
> -               if (force_grouped_idx =3D=3D -1 && pos =3D=3D pos_leader =
&& pos->core.nr_members < 2 &&
> -                   arch_evsel__must_be_in_group(pos))
> +               /*
> +                * Remember an index to sort all forced grouped events to=
gether to,
> +                * and check each evsel for setting must_be_in_group of i=
ts leader.
> +                */
> +               if (arch_evsel__must_be_in_group(pos) && force_grouped_id=
x =3D=3D -1 &&
> +                       pos =3D=3D pos_leader && pos->core.nr_members < 2=
)
>                         force_grouped_idx =3D pos->core.idx;
>         }
>
> --
> 2.40.1
>
