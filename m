Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB0189F43
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780635; cv=pass; b=uBLv/fY7xKhDIprXbM8rafQA3hqLtvYWhZtSMHC7857qBl/Lxb7drnWY2+IFAG9k3+VppedTAVq7wDDrkmae8VhloISHDAqf4kNwBX7sS6g4EkfJbcFkOy9StDY4dvvmtZenWIS4GR5pQDXoVqhadCBCNJrZDuKw4GzeMyt/Koc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780635; c=relaxed/simple;
	bh=NkN6y4adGdCG8eMKQ8Kfl6bO9af0k7um1wKxzBlLXek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlVezYGYurN4uTbqPvILUYy+U3Ou9med3sv6IlCfWdcTln1GfzTL/78kELJjPnDaL7MeAWmVNfpN3o9oN4wcNdPf/b/SCb1JK1LKVhu18W2Fgc2BGvuyi0+YAfYKurB5L7Tod2GFLmo9y6JZ7JVab5Eu8EpgoADMdNiQ3gsnFQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DP4Zanmj; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DP4Zanmj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aeab6ff148so9135ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 13:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773780634; cv=none;
        d=google.com; s=arc-20240605;
        b=NsRYeW9vjYheyuWeBf5Htr6wOcv2qzvILGl6hi4b4dqCg23vHzd0A72p0lRRZBRBi1
         B/sgpScCruRubCfGT/SU5WK5Lgrn+cT0F6GZ2vfRVHCDz3jTyC22RC6tX1Nl9UVerNaQ
         yVYavMKLxyS4a8mCHt1X+1jgQ+qWgsptc8AAysRqSIBzYHXRV7S5Fi6+YhwJ0P1JJJV6
         9pvZqD+sJb5h7+pFgStIDtc1vsy+DOTZfWRmBh6/oj7taXYRyS7ktmCRwVm4jmIkO7PB
         m95KJY9NzzSGFhd9vOjCFrZ/fGQgprtuERymQCQxN3dvNdlU5sUkutde4mDw7odfDImN
         glpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GSAZRSv8vrhLuAB6M+SDjBmglK9nKGjvVdk0JuPAwlU=;
        fh=b7ygAltG3O6Jd4ceNH9pqKHdVv7ipCnMS54YpOoHrqo=;
        b=FKnSTnshhOPRnGLlW/XQkIIwha4fKk76k7pOWoqbYUKqwi1NVEzFJYBQ/CtxmFC5SW
         uFXnUgyyyB8OQM5T6aOqjMKZvTRoJqRSg7IXgzcG7VhXDD5t1PcXIrSTKA0pmBtscnVx
         06hruPgObWJtfGJdpMVGJ4DyI5GGQAei77PgrA8aQjH4+GDbZJe2eIe7t2sfEUFjyQuX
         padHB7BD9gK7qGeRSKGykwY1DmqXJAaD6Kj2nZ1Ssa7SWNWRGrAbCc0BLjSY6PY/ntCe
         GbcoBM/atqQaTJ1Exo7c2UI8Zy10VM2+NkbpsPJbmuYPu6K7XnbC9d+a6bdOgHFsdQIe
         qqow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773780634; x=1774385434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSAZRSv8vrhLuAB6M+SDjBmglK9nKGjvVdk0JuPAwlU=;
        b=DP4Zanmj4ScfulJSPSZtuXP2e5Mq3V3yBJHGTLtHqdfUiD4HJBYSboLrKljaWX8StK
         aLpVelNL2ir9rBgEUBvobm+q1fDL1PzBaeosMNNosuH7rHD9+JJEu/J9IP5TT8BsjoTe
         dE5YLwIIIaFob27/ZLHGwNjmtSvs5XIdk/cvC9OQyBAP3J/stihmKk6kCvbjCo3eyEBT
         eDFOE41DU0lJQKTGnIbZ2hS3VqG0yO4Mk8QUEedq8Zu4EiArBoZzCrisaJUE2w3xbnC2
         cx4io0czw8zG8xB70HGZ2dZE3KTHoAKTbTRmbP+m4gVTG9i76wodo1ZoCO+HbjEL93HY
         2ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773780634; x=1774385434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSAZRSv8vrhLuAB6M+SDjBmglK9nKGjvVdk0JuPAwlU=;
        b=OFNqOUqELdAKyT62ptFNocqGpSqSMMaLms3cDZ3djJtjh9y+Vs2i3JfJ1op0FHAcsp
         eyHwdRE+VInMLLBAj/6NnQd77me20orjhjJmsLWvQsyjBZVzfAyjoBybovzkjx03zsG4
         wL/StYDgG0IhbFcQ2Sm10Dc9err8A899rxK+bJrp1VhWghZmhgJeGRWufdjHJOryl5No
         sJlWvHXoZjXkrc8uJFIevg9067kSsSi5H7Z1Iqpokh9eZ2LmxMyvZqplrjXdJdaG0ROK
         s6hMsdfN23RyQu3WT4umU2ebgLEoXv86bvcAi5wRPZT0ebe/Sh6NyRST+SAvBkDYBpUe
         exbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmjgfd3GnMixO12vvl5hSjLr4zhhTrjmZ24cWc77FMW1mK1BcQT5fzBIEjLZLI1CJg+GB/HjdK2Mrnyb7qthra@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4IraDaUmPJdwWOO5Ac2Nvg3/a8/rIPhiA6gEOYxuXxfEAqhh
	3D44ySeZsPY4B8nh9KTDzlBLtFkBqCAbRWatMAeMhficr5w3NF5lo7wphqRbnSci6YtzyjL5JzF
	k6SxGHblxerWmkiSFpn6XOXZ4cB+ob/hIksDiOUC8
X-Gm-Gg: ATEYQzxJo3fJfxbPUsIqCRGVIqslvepVCtGD2BNa5Rq3kTVD5vaLCWP/yb1UiL+7Hpc
	bnpgzQ47fMeWhiHveAjyaUEm3bkXAKLzXKhzdC8LK0ugP4enpV4SIlf8uij3RdmPoBPtzafTi6o
	MeEIXh5anIU8i4VSbZk0EKliBEjRudJFGtmxoFyN/243k2s/jzjwDkTZiu7MQglLF9+EQHnKuYC
	nSOK1YRXE+GgpQseo+/KrTdFMayOMEqv79SBXPsrqBXUykp15PO+I/yM5OW93QnG5Nl3IpZHc+u
	oH9XXui9
X-Received: by 2002:a17:902:e947:b0:2b0:5cc5:9405 with SMTP id
 d9443c01a7336-2b06f7ba317mr298095ad.1.1773780633245; Tue, 17 Mar 2026
 13:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1> <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
 <abmt6FhLfWrzWGwU@x1> <abmyA5q9nXjagJIL@x1> <abm1nR-2xjOUBroD@x1>
In-Reply-To: <abm1nR-2xjOUBroD@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 13:50:21 -0700
X-Gm-Features: AaiRm52PNy5Jfux9cT4cye36zthH2RT2KKYMA685Yi7FNOpnc7o8xpzZtfR9UE8
Message-ID: <CAP-5=fU76bLLgorJJ0CVXwTanaZTbjtV=EWA2evy8UjGE8Sw4Q@mail.gmail.com>
Subject: Re: perf stat issue with 7.0.0rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	Jan Polensky <japo@linux.ibm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 1:12=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Mar 17, 2026 at 04:56:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > It is not trying PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, is asking for
> > PERF_COUNT_HW_STALLED_CYCLES_BACKEND instead...
>
> If I instead ask just for stalled-cycles-frontend and
> stalled-cycles-backend:
>
> root@number:~# strace -e perf_event_open perf stat -e stalled-cycles-fron=
tend,stalled-cycles-backend sleep 1

I think you intend for this to be system wide '-a'.

> perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, config=
=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_form=
at=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disable=
d=3D1, inherit=3D1, enable_on_exec=3D1, precise_ip=3D0 /* arbitrary skid */=
, ...}, 250619, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 3
> perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VER9, c=
onfig=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=3D0, sample_typ=
e=3DPERF_SAMPLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PE=
RF_FORMAT_TOTAL_TIME_RUNNING, disabled=3D1, inherit=3D1, enable_on_exec=3D1=
, precise_ip=3D0 /* arbitrary skid */, ...}, 250619, -1, -1, PERF_FLAG_FD_C=
LOEXEC) =3D -1 ENOENT (No such file or directory)
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D250619, s=
i_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>
>  Performance counter stats for 'sleep 1':
>
>            409,276      stalled-cycles-frontend
>    <not supported>      stalled-cycles-backend
>
>        1.000428804 seconds time elapsed
>
>        0.000439000 seconds user
>        0.000000000 seconds sys
>
>
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D250618, si_u=
id=3D0} ---
> +++ exited with 0 +++
> root@number:~#
>
> It used type=3DPERF_TYPE_RAW, config=3D0xa9 for  stalled-cycles-frontend =
but
> type=3DPERF_TYPE_HARDWARE, config=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND.
>
> =E2=AC=A2 [acme@toolbx perf-tools]$ git grep stalled-cycles-frontend tool=
s
> tools/bpf/bpftool/link.c:       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
=3D "stalled-cycles-frontend",
> tools/perf/builtin-stat.c:     3,856,436,920 stalled-cycles-frontend   # =
  74.09% frontend cycles idle
> tools/perf/pmu-events/arch/common/common/legacy-hardware.json:    "EventN=
ame": "stalled-cycles-frontend",
> tools/perf/pmu-events/empty-pmu-events.c:/* offset=3D122795 */ "stalled-c=
ycles-frontend\000legacy hardware\000Stalled cycles during issue [This even=
t is an alias of idle-cycles-frontend]\000legacy-hardware-config=3D7\000\00=
000\000\000\000\000\000"
> tools/perf/pmu-events/empty-pmu-events.c:/* offset=3D122945 */ "idle-cycl=
es-frontend\000legacy hardware\000Stalled cycles during issue [This event i=
s an alias of stalled-cycles-frontend]\000legacy-hardware-config=3D7\000\00=
000\000\000\000\000\000"
> tools/perf/pmu-events/empty-pmu-events.c:{ 122795 }, /* stalled-cycles-fr=
ontend\000legacy hardware\000Stalled cycles during issue [This event is an =
alias of idle-cycles-frontend]\000legacy-hardware-config=3D7\000\00000\000\=
000\000\000\000 */
> tools/perf/tests/shell/stat+std_output.sh:event_name=3D(cpu-clock task-cl=
ock context-switches cpu-migrations page-faults stalled-cycles-frontend sta=
lled-cycles-backend cycles instructions branches branch-misses)
> tools/perf/util/evsel.c:        "stalled-cycles-frontend",
> =E2=AC=A2 [acme@toolbx perf-tools]$
>
> This machine is:
>
> =E2=AC=A2 [acme@toolbx perf-tools]$ grep -m1 "model name" /proc/cpuinfo
> model name      : AMD Ryzen 9 9950X3D 16-Core Processor

Lots of missing legacy events on AMD. The problem is worse with -dd and -dd=
d.

> =E2=AC=A2 [acme@toolbx perf-tools]
>
> And doesn't have PERF_COUNT_HW_STALLED_CYCLES_BACKEND, but has
> PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, that gets configured using
> PERF_TYPE_RAW and 0xa9 because:
>
> root@number:~# cat /sys/devices/cpu/events/stalled-cycles-frontend
> event=3D0xa9
> root@number:~#
>
> But I couldn't so far explain why in the default case it is asking for
> PERF_COUNT_HW_STALLED_CYCLES_BACKEND, when it should be asking for
> PERF_COUNT_HW_STALLED_CYCLES_FRONTEND or PERF_TYPE_RAW+config=3D0xa9...

So the default events/metrics are now in json:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=3Dperf-tools=
-next
Relating to the stalls there are:
```
    {
        "BriefDescription": "Max front or backend stalls per instruction",
        "MetricExpr": "max(stalled\\-cycles\\-frontend,
stalled\\-cycles\\-backend) / instructions",
        "MetricGroup": "Default",
        "MetricName": "stalled_cycles_per_instruction",
        "DefaultShowEvents": "1"
    },
    {
        "BriefDescription": "Frontend stalls per cycle",
        "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
        "MetricGroup": "Default",
        "MetricName": "frontend_cycles_idle",
        "MetricThreshold": "frontend_cycles_idle > 0.1",
        "DefaultShowEvents": "1"
    },
    {
        "BriefDescription": "Backend stalls per cycle",
        "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
        "MetricGroup": "Default",
        "MetricName": "backend_cycles_idle",
        "MetricThreshold": "backend_cycles_idle > 0.2",
        "DefaultShowEvents": "1"
    },
```
The stalled_cycles_per_instruction and backed_cycles_idle should fail
as the stalled-cycles-backend event is missing. frontend_cycles_idle
should work, I wonder if the 0 counts relate to trouble scheduling
groups of events. I'll need more verbose output to understand. Perhaps
for stalled_cycles_per_instruction, we should modify the metric to
tolerate missing events:

max(stalled\\-cycles\\-frontend if
have_event(stalled\\-cycles\\-frontend) else 0,
stalled\\-cycles\\-backend if have_event(stalled\\-cycles\\-backend)
else 0) / instructions

Thanks,
Ian

> - Arnaldo
