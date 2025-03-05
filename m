Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB421481DD
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154890; cv=none; b=P+UjABoC7boZ+fTMO2BFaXFDg94EJXSTHKaFsi9KI1OdhA0iF8/LZDm0Ll5+7CoStbsgoS0KRrVlT5YSk5VrOdawN8RcMGfjhWf8QusiQSk9ThshwYHcm+ZXUl1nMy4nvugXDz34+MezA4HrxF/F7bor0s8Xk5ufaWOp5sznJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154890; c=relaxed/simple;
	bh=s3ud3Y+ScuXsVTzEroH3kFGx9+grJuXYH7NPUMC7aHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2TUDVtPJjF2mrx1v7D04lf9xmnq2xlH56IT9ibrDsYUcUxYJBmiiiBwOkK68wP9iT/NB3Py5gIgdGUxsSvDcichkXJUReRSpOaq7SWmCauBsJYCzPqX9zzQp28gWskaW2rZOpgIrHp+ZErgYrNCXVeRTwZSamyy/dw6y4lf1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDA8w3Rx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDA8w3Rx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223a0da61easo104275ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Mar 2025 22:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741154888; x=1741759688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LYnmGJhD3ThC0z0sYVwXyEIlK6aeYSx7OrcDKXjaz4=;
        b=UDA8w3RxVXl3ozppC2203Sposn/uHkPQ2AeVUZhZm9MqrhhKdGtK9HXA5K/Id27uTf
         hkFb/tblEKSXhPX7LA4+Qw7TF0WdPGeTq5U62Nyv337oeWbJT2t57qoBOWHDnxs1aWmd
         0VZmbYKUTnKleT/B7YYiZBYaFyXTKDeZDhQCO1Rd/sDPyb9ihMW6CybAhrwXnv7s4s9s
         K7F85hy7HSedj5QAdj7eKRPyckHxfaGtEXJlIi8LpaZXVbN2ghzj3b/soanwrgjhCMHu
         dCBB6pckD82rDXNtQZDuK4V797btovNwvgUW+3blX8aExYJhNfg3YVJsm4xJSg1Tv8fu
         fp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741154888; x=1741759688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LYnmGJhD3ThC0z0sYVwXyEIlK6aeYSx7OrcDKXjaz4=;
        b=DlzRyghtRhZy80spy0YBAhbMpYL7PjnC18qaJNVmPTvO/JiaFJu3M6soBrbzAh4zOF
         itLcqHDPbSm6mc6jlgHqJ3+mOGBKFlHAFfrJ1H/SWCNUF1Jir2+/Z+P9A8azGxE2oQjE
         icBo09ZYGPu1FqjMKXYNoH2jZtLYU0ICeSaczV3dLJ8nziksACmbzfVEaVKtP+QgRJRQ
         7OWa0Dj/O6st1kZ888GZ6niaMI54n00Pjr87sWDE607cL75JPSDQt0v8WCojfwz7nH16
         eV6SRxXMb1hf8LnIQf1Mg2o9SNhGJeeMeKCZ3ShdarHCru39ygQ+fbdONgF2E25OeKH9
         hKvA==
X-Forwarded-Encrypted: i=1; AJvYcCVgY9c2WyqvRB9b6axOwKfIyghN/L6W6F+u2Z1M/UKNW2+AayeWz0ugIVAbZdGPboMy9l88r5qeWY08aaEw0NsO@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9Q8R5818XKNDuVkiDl36JxEeGY+l8foqK40drMeyNh+2CfhC
	NEUgOkA2JRLTnJCJaVHME1l6a348qoljIkpcUrp3bnImHmyxq/h5qQPEX3J/AbDKjnEsBimGBl9
	voGcdBDmyuwCAWyApIvW0Wpt1GiRoS0MfNHBazme05dccjd4sWaEx
X-Gm-Gg: ASbGnct9ym5kd87C/O3sARKuaPg4NcQcfl9uZ+Bxa7MTuAeU/L4Nlg3KHi1KAz+nOn0
	41WGBUOW/bZ0i3NYWz1bWnpDmoPIVsamQ3gmdrercovzKxLyKS1Qt1hcsQtd6qNWlEn8OazQjwS
	WZc3caF4yXULlf5SnP9uBzNFr3qHI=
X-Google-Smtp-Source: AGHT+IGibuxRH/JgUABVriDEZRFD1J+CEb3Wn6ZKI6FIixe2tQnliHTP4o70eBJS9zR2npTbZn9rM4ibZ1QZhVOMe/I=
X-Received: by 2002:a17:902:f811:b0:21f:2828:dc82 with SMTP id
 d9443c01a7336-223f2680131mr1904635ad.2.1741154887874; Tue, 04 Mar 2025
 22:08:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224083306.71813-1-dapeng1.mi@linux.intel.com> <20250224083306.71813-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20250224083306.71813-2-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Mar 2025 22:07:56 -0800
X-Gm-Features: AQ5f1JqwDLiV6gbJS2Oi8yE1LrUGz8hBNteGcUGkOBI9GtAX0GUpTw7OhKf8hZM
Message-ID: <CAP-5=fW4QQk6fFMUyr+KFekA+sfkzsg-vKeCvaQYk0Srwsr4bQ@mail.gmail.com>
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

On Sun, Feb 23, 2025 at 5:43=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> When running topdown groups test on hybrid platforms like LNL/ARL, we
> see the following 2 commands fail.
>
> perf stat $cputype -e '{instructions,slots},topdown-retiring' true
> perf stat $cputype -e '{instructions,slots},{topdown-retiring}' true
>
> Take the 1st command as an example, 5 events are created on hybrid
> platform. They are cpu_atom/instructions/, cpu_core/instructions/,
> cpu_core/slots/, cpu_atom/topdown-retiring/ and
> cpu_core/topdown-retiring/ events. The former 3 events are in a group
> and the latter 2 topdown-retiring events are independent events.
>
> As the limitation of current implementation, the
> cpu_core/topdown-retiring/ event can't be moved into previous group as
> long as there are other events before it. That's the reason why we see
> the failure.
>
> Thus add "--cputype core" option to limit only P-core events are tested.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 26 +++++++++++++++++++++++---
>  tools/perf/tests/shell/stat.sh    | 20 ++++++++++++++++++--
>  2 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util=
/evlist.c
> index 447a734e591c..0a71ba975871 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -9,7 +9,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const struc=
t evsel *rhs)
>  {
>         /*
>          * Currently the following topdown events sequence are supported =
to
> -        * move and regroup correctly.
> +        * move and regroup correctly on non-hybrid platforms.
>          *
>          * a. all events in a group
>          *    perf stat -e "{instructions,topdown-retiring,slots}" -C0 sl=
eep 1
> @@ -44,7 +44,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const str=
uct evsel *rhs)
>          * topdown metrics events must be first event after the slots eve=
nt group,
>          * otherwise topdown metrics events can't be regrouped correctly,=
 e.g.
>          *
> -        * a. perf stat -e "{instructions,slots},cycles,topdown-retiring"=
 -C0 sleep 1
> +        * e. perf stat -e "{instructions,slots},cycles,topdown-retiring"=
 -C0 sleep 1
>          *    WARNING: events were regrouped to match PMUs
>          *     Performance counter stats for 'CPU(s) 0':
>          *         17,923,134      slots
> @@ -56,11 +56,31 @@ int arch_evlist__cmp(const struct evsel *lhs, const s=
truct evsel *rhs)
>          * has topdown metrics events must contain only the topdown metri=
cs event,
>          * otherwise topdown metrics event can't be regrouped correctly a=
s well, e.g.
>          *
> -        * a. perf stat -e "{instructions,slots},{topdown-retiring,cycles=
}" -C0 sleep 1
> +        * f. perf stat -e "{instructions,slots},{topdown-retiring,cycles=
}" -C0 sleep 1
>          *    WARNING: events were regrouped to match PMUs
>          *    Error:
>          *    The sys_perf_event_open() syscall returned with 22 (Invalid=
 argument) for
>          *    event (topdown-retiring)
> +        *
> +        * For hybrid platforms, the sequences 'c' and 'd' are not suppor=
ted as well
> +        * besides above sequences 'e' and 'f'.
> +        *
> +        *    perf stat -e "{instructions,slots},topdown-retiring" -C0 sl=
eep 1
> +        *    perf stat -e "{instructions,slots},{topdown-retiring}" -C0 =
sleep 1
> +        *
> +        * On hybrid platforms each event would create an instance on all=
 types of PMU
> +        * if the event can be supported by the PMU, i.e., the "topdown-r=
etiring" event
> +        * would create two instances on hybrid platforms with P-cores an=
d E-cores,
> +        * "cpu_core/topdown-retiring/" and "cpu_atom/topdown_retiring".
> +        *
> +        * Take the first command as an example, the events list would be=
 converted to
> +        * below list in fact.
> +        *
> +        * "{cpu_atom/instructions/,cpu_core/instructions/,cpu_core/slots=
/},
> +        *  cpu_atom/topdown-retiring/,cpu_core/topdown-retiring/"
> +        *
> +        * This is actually same with event list in case 'e', "cpu_core/t=
opdown-retiring/"
> +        * event can't be moved into previous events group.
>          */
>         if (topdown_sys_has_perf_metrics() &&
>             (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_=
group(rhs))) {
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat=
.sh
> index 68323d636fb7..cdfe27c25528 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -5,6 +5,16 @@
>  set -e
>
>  err=3D0
> +is_hybrid=3Dfalse
> +
> +check_hybrid_platform() {
> +  pmus=3D$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
> +  if [ "$pmus" -gt 1 ]
> +  then
> +    is_hybrid=3Dtrue
> +  fi
> +}
> +
>  test_default_stat() {
>    echo "Basic stat command test"
>    if ! perf stat true 2>&1 | grep -E -q "Performance counter stats for '=
true':"
> @@ -62,6 +72,11 @@ test_topdown_groups() {
>    # Topdown events must be grouped with the slots event first. Test that
>    # parse-events reorders this.
>    echo "Topdown event group test"
> +  cputype=3D""
> +  if $is_hybrid
> +  then
> +    cputype=3D"--cputype core"
> +  fi
>    if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
>    then
>      echo "Topdown event group test [Skipped event parsing failed]"
> @@ -85,13 +100,13 @@ test_topdown_groups() {
>      err=3D1
>      return
>    fi
> -  if perf stat -e '{instructions,slots},topdown-retiring' true 2>&1 | gr=
ep -E -q "<not supported>"
> +  if perf stat $cputype -e '{instructions,slots},topdown-retiring' true =
2>&1 | grep -E -q "<not supported>"

So I can make this test fail on non-hybrid with:
```
$ perf stat -e '{instructions,slots},faults,topdown-retiring' true
WARNING: events were regrouped to match PMUs

Performance counter stats for 'true':

        5,312,770      slots
        1,078,401      instructions
               56      faults
  <not supported>      topdown-retiring
```
The issue is that the slots isn't a group leader, so the "force group
index" we try to insert must be grouped events into is miscalculated
to be topdown-retiring. The following fixes this:
```
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index 35e48fe56dfa..68ddc335cde4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2056,8 +2056,7 @@ static int
parse_events__sort_events_and_fix_groups(struct list_head *list)
                pos->core.idx =3D idx++;

                /* Remember an index to sort all forced grouped events
together to. */
-               if (force_grouped_idx =3D=3D -1 && pos =3D=3D pos_leader &&
pos->core.nr_members < 2 &&
-                   arch_evsel__must_be_in_group(pos))
+               if (force_grouped_idx =3D=3D -1 &&
arch_evsel__must_be_in_group(pos))
                        force_grouped_idx =3D pos->core.idx;
        }
```

>    then
>      echo "Topdown event group test [Failed topdown metrics event not mov=
e into slots group]"
>      err=3D1
>      return
>    fi
> -  if perf stat -e '{instructions,slots},{topdown-retiring}' true 2>&1 | =
grep -E -q "<not supported>"
> +  if perf stat $cputype -e '{instructions,slots},{topdown-retiring}' tru=
e 2>&1 | grep -E -q "<not supported>"

So this is trickier as '{topdown-retiring}' ends up looking as a 2
event group. I'll post a proposed fix.

Thanks,
Ian

>    then
>      echo "Topdown event group test [Failed topdown metrics group not mer=
ge into slots group]"
>      err=3D1
> @@ -200,6 +215,7 @@ test_hybrid() {
>    echo "hybrid test [Success]"
>  }
>
> +check_hybrid_platform
>  test_default_stat
>  test_stat_record_report
>  test_stat_record_script
> --
> 2.40.1
>
