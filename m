Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50F42AAF
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163964; cv=none; b=CWME/UtnHD1ze2CUAGQlr1qKYbnrQ/zxoIExBeSRrxjWrtAiR9XFQ2GhWWttFj954pHe36AJKt2WvSSN5EVasJctJC5j4nkklqfV7QpOAvHEHbAmuJFRjNYaUow7n4vfsaHXwvY2k5MMGTtbGEwThZ2yB/KcGmAJtaaLq6mPC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163964; c=relaxed/simple;
	bh=T2uzEUAxDb++pE0xa2jPenyN7MzNZe3VrOV1gDygbas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUzU9s1UXjB1I+i0vMQMX5FSU6fNzaIZsk+b/9ztk3tw4b8vddZkF35fdtOQyoOnUskG8O4TeEpLC1v2Rt+euvtX2eXCE/N+2z88tNUhBBEKHNMVK3Xlj2/hhU49ALVoV3BFCimPQGdwpTfUX/TK1Jks7H3b6+1TTA5w5HUSwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkQMG99w; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkQMG99w"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223a0da61easo119295ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741163961; x=1741768761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faXqYYFydBMQa6qJbhlVoXW0EZv6eA+uFvOUudXNaZg=;
        b=AkQMG99woOtqECtiuraoEMF0Pe7sq5qgUCa025vqu+3gamMt32Uh91DrsB4zKgu1k8
         VFD86sxYRoPJSjYlHVAZaZ8Iz43nbI4xYRN63MhegVkWTdCH3JSm9197x+i1y6kyN6a1
         iddM3ppQHZj8jCSAsqrgBGpfuNnfLLtAzrSaOxQ+daHkoNIiaKTrtdE4VOz77XMk7SAG
         cfxAt863NBQmI/9+6yqes+pM6qEvk09k2lQiQd0tqheKMiVa6Iik3H83AnmBAP7rIwOc
         9hxSZ1GrOm+YS1mt21v4+x45eH6PjWuKYITnbzkcOzHE6cCu7nQsi8gstn11FKJ6Szna
         +3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163961; x=1741768761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faXqYYFydBMQa6qJbhlVoXW0EZv6eA+uFvOUudXNaZg=;
        b=T6JRPHOv+Al8e7V6gN8OAKvA4zUWm/Mlp/UucxZ/Pg/dap0YVXrTTbA1d0Wif9o0m4
         ai9Ba7KsJoyeTNJtT05p29tYjT/oq6KsnkPV++iVllunnfplVOs7yzcjqAWoM6k0rZJ2
         Pd7g/JbKs8V6jT9vCEv+vh4Q4yqBZALUv2eBiSlBDM2szFe2L+Pjn/nxWSEm0aRHduCu
         YPLnR05ERJbs760cjFRD9gRvyzLQnGa5W2whDKPPrWkG05uh0DnVLmfIwO0yq5Wk0BfG
         lXtY9/VMq3GD41kTPgSFvIETJGKmt9GTv4pqNbvybjhZkCM82BGMnahXqWgCPaj+5dW1
         Z9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIX4mKjuthTEBuvMiywBhvwog6F1c615zfqwWBi8Pqja5P40K4VWS2BO+RWyR95Tu/OmeEf2evf5A+MNwiilq4@vger.kernel.org
X-Gm-Message-State: AOJu0YzmvmwQNv/Z5qCMyDGahCzOtnXxIZ6OSEatY2y6LWj+ZWDgDHHE
	cPtgg2dP3WhLfKjJp7wyfglXYuM/EEpjyBm5IpOi6kjaXnW00g2XW02270HEgWWK31x2R1O2NCL
	l3jK9rgNNSUgkSLW8fXg9wOlNRDfx6KCnusvZ
X-Gm-Gg: ASbGncsujjVR8wLzys0+mYBopvrHkEK0gWv/3AnSfmZorctifcUlMVZ61SiG8nu2Rg6
	SRi9WWP3cyvel+WDkIE7meJoz1OrV36n7AFeUkwIAD1ySN+9/hJgZcpsk5P4gTWpixDZT97Lg6v
	NoLySzacmkEJdMgBY4+XlCSAa/tiw=
X-Google-Smtp-Source: AGHT+IFTr+mTXGjHME0fA15wPDlvb2+eWputm0PGeq6g9djMSkfkA89JdLu2aJkfgGyTzz8VppJkYb1qjLqZyvheoMY=
X-Received: by 2002:a17:902:f9cb:b0:223:ff93:322f with SMTP id
 d9443c01a7336-223ff93338cmr43755ad.2.1741163960618; Wed, 05 Mar 2025 00:39:20
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224083306.71813-1-dapeng1.mi@linux.intel.com>
 <20250224083306.71813-2-dapeng1.mi@linux.intel.com> <CAP-5=fW4QQk6fFMUyr+KFekA+sfkzsg-vKeCvaQYk0Srwsr4bQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW4QQk6fFMUyr+KFekA+sfkzsg-vKeCvaQYk0Srwsr4bQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 00:39:09 -0800
X-Gm-Features: AQ5f1Jq6OtsJUORQccnOzWeTiMHp0FZDFT4mNjFBCGT1a294wYhts5MczzJGUBg
Message-ID: <CAP-5=fWdKNT2sLXeRj7r-WpsE2Xg7ZTOxVKy6D_Cg_NYA0AXGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tools/tests: Fix topdown groups test on hybrid platforms
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:07=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sun, Feb 23, 2025 at 5:43=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel=
.com> wrote:
> >
> > When running topdown groups test on hybrid platforms like LNL/ARL, we
> > see the following 2 commands fail.
> >
> > perf stat $cputype -e '{instructions,slots},topdown-retiring' true
> > perf stat $cputype -e '{instructions,slots},{topdown-retiring}' true
> >
> > Take the 1st command as an example, 5 events are created on hybrid
> > platform. They are cpu_atom/instructions/, cpu_core/instructions/,
> > cpu_core/slots/, cpu_atom/topdown-retiring/ and
> > cpu_core/topdown-retiring/ events. The former 3 events are in a group
> > and the latter 2 topdown-retiring events are independent events.
> >
> > As the limitation of current implementation, the
> > cpu_core/topdown-retiring/ event can't be moved into previous group as
> > long as there are other events before it. That's the reason why we see
> > the failure.
> >
> > Thus add "--cputype core" option to limit only P-core events are tested=
.
> >
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > ---
> >  tools/perf/arch/x86/util/evlist.c | 26 +++++++++++++++++++++++---
> >  tools/perf/tests/shell/stat.sh    | 20 ++++++++++++++++++--
> >  2 files changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/ut=
il/evlist.c
> > index 447a734e591c..0a71ba975871 100644
> > --- a/tools/perf/arch/x86/util/evlist.c
> > +++ b/tools/perf/arch/x86/util/evlist.c
> > @@ -9,7 +9,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const str=
uct evsel *rhs)
> >  {
> >         /*
> >          * Currently the following topdown events sequence are supporte=
d to
> > -        * move and regroup correctly.
> > +        * move and regroup correctly on non-hybrid platforms.
> >          *
> >          * a. all events in a group
> >          *    perf stat -e "{instructions,topdown-retiring,slots}" -C0 =
sleep 1
> > @@ -44,7 +44,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const s=
truct evsel *rhs)
> >          * topdown metrics events must be first event after the slots e=
vent group,
> >          * otherwise topdown metrics events can't be regrouped correctl=
y, e.g.
> >          *
> > -        * a. perf stat -e "{instructions,slots},cycles,topdown-retirin=
g" -C0 sleep 1
> > +        * e. perf stat -e "{instructions,slots},cycles,topdown-retirin=
g" -C0 sleep 1
> >          *    WARNING: events were regrouped to match PMUs
> >          *     Performance counter stats for 'CPU(s) 0':
> >          *         17,923,134      slots
> > @@ -56,11 +56,31 @@ int arch_evlist__cmp(const struct evsel *lhs, const=
 struct evsel *rhs)
> >          * has topdown metrics events must contain only the topdown met=
rics event,
> >          * otherwise topdown metrics event can't be regrouped correctly=
 as well, e.g.
> >          *
> > -        * a. perf stat -e "{instructions,slots},{topdown-retiring,cycl=
es}" -C0 sleep 1
> > +        * f. perf stat -e "{instructions,slots},{topdown-retiring,cycl=
es}" -C0 sleep 1
> >          *    WARNING: events were regrouped to match PMUs
> >          *    Error:
> >          *    The sys_perf_event_open() syscall returned with 22 (Inval=
id argument) for
> >          *    event (topdown-retiring)
> > +        *
> > +        * For hybrid platforms, the sequences 'c' and 'd' are not supp=
orted as well
> > +        * besides above sequences 'e' and 'f'.
> > +        *
> > +        *    perf stat -e "{instructions,slots},topdown-retiring" -C0 =
sleep 1
> > +        *    perf stat -e "{instructions,slots},{topdown-retiring}" -C=
0 sleep 1
> > +        *
> > +        * On hybrid platforms each event would create an instance on a=
ll types of PMU
> > +        * if the event can be supported by the PMU, i.e., the "topdown=
-retiring" event
> > +        * would create two instances on hybrid platforms with P-cores =
and E-cores,
> > +        * "cpu_core/topdown-retiring/" and "cpu_atom/topdown_retiring"=
.
> > +        *
> > +        * Take the first command as an example, the events list would =
be converted to
> > +        * below list in fact.
> > +        *
> > +        * "{cpu_atom/instructions/,cpu_core/instructions/,cpu_core/slo=
ts/},
> > +        *  cpu_atom/topdown-retiring/,cpu_core/topdown-retiring/"
> > +        *
> > +        * This is actually same with event list in case 'e', "cpu_core=
/topdown-retiring/"
> > +        * event can't be moved into previous events group.
> >          */
> >         if (topdown_sys_has_perf_metrics() &&
> >             (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_i=
n_group(rhs))) {
> > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/st=
at.sh
> > index 68323d636fb7..cdfe27c25528 100755
> > --- a/tools/perf/tests/shell/stat.sh
> > +++ b/tools/perf/tests/shell/stat.sh
> > @@ -5,6 +5,16 @@
> >  set -e
> >
> >  err=3D0
> > +is_hybrid=3Dfalse
> > +
> > +check_hybrid_platform() {
> > +  pmus=3D$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l=
)
> > +  if [ "$pmus" -gt 1 ]
> > +  then
> > +    is_hybrid=3Dtrue
> > +  fi
> > +}
> > +
> >  test_default_stat() {
> >    echo "Basic stat command test"
> >    if ! perf stat true 2>&1 | grep -E -q "Performance counter stats for=
 'true':"
> > @@ -62,6 +72,11 @@ test_topdown_groups() {
> >    # Topdown events must be grouped with the slots event first. Test th=
at
> >    # parse-events reorders this.
> >    echo "Topdown event group test"
> > +  cputype=3D""
> > +  if $is_hybrid
> > +  then
> > +    cputype=3D"--cputype core"
> > +  fi
> >    if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
> >    then
> >      echo "Topdown event group test [Skipped event parsing failed]"
> > @@ -85,13 +100,13 @@ test_topdown_groups() {
> >      err=3D1
> >      return
> >    fi
> > -  if perf stat -e '{instructions,slots},topdown-retiring' true 2>&1 | =
grep -E -q "<not supported>"
> > +  if perf stat $cputype -e '{instructions,slots},topdown-retiring' tru=
e 2>&1 | grep -E -q "<not supported>"
>
> So I can make this test fail on non-hybrid with:
> ```
> $ perf stat -e '{instructions,slots},faults,topdown-retiring' true
> WARNING: events were regrouped to match PMUs
>
> Performance counter stats for 'true':
>
>         5,312,770      slots
>         1,078,401      instructions
>                56      faults
>   <not supported>      topdown-retiring
> ```
> The issue is that the slots isn't a group leader, so the "force group
> index" we try to insert must be grouped events into is miscalculated
> to be topdown-retiring. The following fixes this:
> ```
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 35e48fe56dfa..68ddc335cde4 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2056,8 +2056,7 @@ static int
> parse_events__sort_events_and_fix_groups(struct list_head *list)
>                 pos->core.idx =3D idx++;
>
>                 /* Remember an index to sort all forced grouped events
> together to. */
> -               if (force_grouped_idx =3D=3D -1 && pos =3D=3D pos_leader =
&&
> pos->core.nr_members < 2 &&
> -                   arch_evsel__must_be_in_group(pos))
> +               if (force_grouped_idx =3D=3D -1 &&
> arch_evsel__must_be_in_group(pos))
>                         force_grouped_idx =3D pos->core.idx;
>         }
> ```
>
> >    then
> >      echo "Topdown event group test [Failed topdown metrics event not m=
ove into slots group]"
> >      err=3D1
> >      return
> >    fi
> > -  if perf stat -e '{instructions,slots},{topdown-retiring}' true 2>&1 =
| grep -E -q "<not supported>"
> > +  if perf stat $cputype -e '{instructions,slots},{topdown-retiring}' t=
rue 2>&1 | grep -E -q "<not supported>"
>
> So this is trickier as '{topdown-retiring}' ends up looking as a 2
> event group. I'll post a proposed fix.

Patch here:
https://lore.kernel.org/lkml/20250305083735.393333-2-irogers@google.com/

Thanks,
Ian

>
> >    then
> >      echo "Topdown event group test [Failed topdown metrics group not m=
erge into slots group]"
> >      err=3D1
> > @@ -200,6 +215,7 @@ test_hybrid() {
> >    echo "hybrid test [Success]"
> >  }
> >
> > +check_hybrid_platform
> >  test_default_stat
> >  test_stat_record_report
> >  test_stat_record_script
> > --
> > 2.40.1
> >
