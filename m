Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB573130E4B
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206901; cv=none; b=kXhZ47Pp+9VhH3zoldPvBRYPWT9tQgXUM77M9vhAawgvB8aXsTWLue6igJlBQNLJgrcgLkdA3m6DiHsbeST7IeBM07rU8zM1fT+ARZXnUyvspr+/DV64UD3cEbNdQZYACjc02jDiUTbGQCu7Ci4VrxwNcsBZJIF0PEg4+z7BOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206901; c=relaxed/simple;
	bh=H2KpMhF80GIGETn3XX8kZjXNq85AgpVFekFuevqybDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBWnApknxqFdmgUoxgw91EndivWeulqcWTFduymUx3YbfykTxX4lp20x/2jrXDpBrgV1V6d6xbKOgAO/vI12BIBQ+tppFoFKo/VxCRbcDtX+P5KycWoC5nfpyZd87K7a4aOwXCc7OAYL85IzMGJkxx+MGflahyiBIAA0H21f/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o88AmM+n; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o88AmM+n"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-439b1c72676so75161cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715206899; x=1715811699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CZ8vZSqgAjCulOPtJoC15yQK8wcTC6SOc5DNSet9Hk=;
        b=o88AmM+nPogjuzR6qb+SMbV0lUkJDuI9ARaAY8FxxLJdnpCTI/fReZO00vwACJGpOw
         crhwvDOtj82SUagN1JZE7H7tanyXENmS0N+BZ1vCaZZGKjKfR50aIN9vO6dfCmkAGweG
         kdzNEdrwdv+DHcJHvUjw9j/RuK9zkEoM7SaT/Z1l3sKbnKdLpeM7210NjdFq923msi07
         XgD3pnFdpwOqZbSr9yXsemVmbfuI4Yvt72ijT0xBzIP0J4Jwgl6ebkAW/L3IsOC5A6wI
         MKOoo0KC/q+rL4cFlaXOjZgr7n5zWSg8reafzmmGpgFLm7sDQyTRfpdCCWk5HwkNFhsE
         WWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715206899; x=1715811699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CZ8vZSqgAjCulOPtJoC15yQK8wcTC6SOc5DNSet9Hk=;
        b=h7Njbfmwyxasgu0kAOfd8ehKN+AN1XSowDAzkBzhIY69Yur16+b5SeFfGhqGsjtGAE
         eRxdB9jr5+6TtxkTPXqhuXbNmgibkE93ni4GxeCogkpuDYP5v54xFjh38SZFSp8K/YKB
         8I1Iusjw4lVn7n8Ad2wqf8azGagHyr60KK+pwjiVqRe/JjU7SQecuG2UC3qrgN3pG4nT
         aGKq5sPeaguaCH2NQuvrIxTC2JWPxSnZ42ItWXHm7L6Id10JooAFHVL6bx8nCGfXpI2I
         z+ibAJnLG7yAYvlFHlJVCZr0pXvitniGszHdSbct6k+7+PtkPQh8C4gnfkHpo2+DzqUb
         0StA==
X-Forwarded-Encrypted: i=1; AJvYcCUBcJ84232rBxXuWyDqYtQJ3/sTIZAtDjsnNloT++ieXjrUv1KzW6NMUEUjFy/77uIDZP2v5PHR+0axN7I3syqPK1GJL/Via74HL3WeYGxBwA==
X-Gm-Message-State: AOJu0Yyw7Pd3jMHzhMVMC76nnghsclFomEiiUlgCgv05SA4sOQCyHmFJ
	v/u5YHGKfb+G5kZ6rah4DHy4mV+FDYUMhzl+PK8TARHae0iRkJ0oJ6HZQXP3RFIoz0KfIWfRKxk
	JBSB9Ohymw2UOPzIfC3OaN7zledfVe21Sie9s
X-Google-Smtp-Source: AGHT+IHBhR+8rgW59oTMLsGWV9Mn9APAFjXnNiOMjJVs/omAB0Bu+jyHOJsiYuTm093WyjuDHkh7l5VFYybN9e4fXog=
X-Received: by 2002:a05:622a:4a0d:b0:43a:db8d:4a22 with SMTP id
 d75a77b69052e-43df44dcbdemr499461cf.11.1715206898434; Wed, 08 May 2024
 15:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508060427.417-1-ravi.bangoria@amd.com>
In-Reply-To: <20240508060427.417-1-ravi.bangoria@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 15:21:27 -0700
Message-ID: <CAP-5=fX1r2RA1=2Bs4DmMGjrV0VD-kYGMCtt+E530rVihK+MxQ@mail.gmail.com>
Subject: Re: [RFC 0/4] perf sched: Introduce schedstat tool
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, swapnil.sapkal@amd.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com, 
	james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:05=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> MOTIVATION
> ----------
>
> Existing `perf sched` is quite exhaustive and provides lot of insights
> into scheduler behavior but it quickly becomes impractical to use for
> long running or scheduler intensive workload. For ex, `perf sched record`
> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> generates huge 56G perf.data for which perf takes ~137 mins to prepare
> and write it to disk [1].
>
> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
> and generates samples on a tracepoint hit, `perf sched schedstat record`
> takes snapshot of the /proc/schedstat file before and after the workload,
> i.e. there is zero interference on workload run. Also, it takes very
> minimal time to parse /proc/schedstat, convert it into perf samples and
> save those samples into perf.data file. Result perf.data file is much
> smaller. So, overall `perf sched schedstat record` is much more light-
> weight compare to `perf sched record`.
>
> We, internally at AMD, have been using this (a variant of this, known as
> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> of any scheduler code changes[3][4].
>
> Please note that, this is not a replacement of perf sched record/report.
> The intended users of the new tool are scheduler developers, not regular
> users.
>
> USAGE
> -----
>
>   # perf sched schedstat record
>   # perf sched schedstat report
>
> Note: Although perf schedstat tool supports workload profiling syntax
> (i.e. -- <workload> ), the recorded profile is still systemwide since
> the /proc/schedstat is a systemwide file.
>
> HOW TO INTERPRET THE REPORT
> ---------------------------
>
> The schedstat report starts with total time profiling was active in
> terms of jiffies:
>
>   -----------------------------------------------------------------------=
-----------------------------
>   Time elapsed (in jiffies)                                  :       2453=
7
>   -----------------------------------------------------------------------=
-----------------------------
>
> Next is cpu scheduling statistics. These are simple diffs of
> /proc/schedstat cpu lines along with description. The report also
> prints % relative to base stat.
>
> In the example below, schedule() left the cpu0 idle 98.19% of the time.
> 16.54% of total try_to_wake_up() was to wakeup local cpu. And, the total
> waittime by tasks on cpu0 is 0.49% of the total runtime by tasks on the
> same cpu.
>
>   -----------------------------------------------------------------------=
-----------------------------
>   cpu:  cpu0
>   -----------------------------------------------------------------------=
-----------------------------
>   sched_yield() count                                         :          =
 0
>   Legacy counter can be ignored                               :          =
 0
>   schedule() called                                           :       171=
38
>   schedule() left the processor idle                          :       168=
27 ( 98.19% )
>   try_to_wake_up() was called                                 :         5=
08
>   try_to_wake_up() was called to wake up the local cpu        :          =
84 ( 16.54% )
>   total runtime by tasks on this processor (in jiffies)       :  24089592=
43
>   total waittime by tasks on this processor (in jiffies)      :    117318=
25 ( 0.49% )
>   total timeslices run on this cpu                            :         3=
11
>   -----------------------------------------------------------------------=
-----------------------------
>
> Next is load balancing statistics. For each of the sched domains
> (eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
> the following three categories:
>
>   1) Idle Load Balance: Load balancing performed on behalf of a long
>                         idling cpu by some other cpu.
>   2) Busy Load Balance: Load balancing performed when the cpu was busy.
>   3) New Idle Balance : Load balancing performed when a cpu just became
>                         idle.
>
> Under each of these three categories, schedstat report provides
> different load balancing statistics. Along with direct stats, the
> report also contains derived metrics prefixed with *. Example:
>
>   -----------------------------------------------------------------------=
-----------------------------
>   CPU 0 DOMAIN 0
>   -----------------------------------------------------------------------=
-----------------------------
>   ------------------------------------------<Category idle>--------------=
-----------------------------
>   load_balance() count on cpu idle                                 :     =
     50   $      490.74 $
>   load_balance() found balanced on cpu idle                        :     =
     42   $      584.21 $
>   load_balance() move task failed on cpu idle                      :     =
      8   $     3067.12 $
>   imbalance sum on cpu idle                                        :     =
      8
>   pull_task() count on cpu idle                                    :     =
      0
>   pull_task() when target task was cache-hot on cpu idle           :     =
      0
>   load_balance() failed to find busier queue on cpu idle           :     =
      0   $        0.00 $
>   load_balance() failed to find busier group on cpu idle           :     =
     42   $      584.21 $
>   *load_balance() success count on cpu idle                        :     =
      0
>   *avg task pulled per successful lb attempt (cpu idle)            :     =
   0.00
>   ------------------------------------------<Category busy>--------------=
-----------------------------
>   load_balance() count on cpu busy                                 :     =
      2   $    12268.50 $
>   load_balance() found balanced on cpu busy                        :     =
      2   $    12268.50 $
>   load_balance() move task failed on cpu busy                      :     =
      0   $        0.00 $
>   imbalance sum on cpu busy                                        :     =
      0
>   pull_task() count on cpu busy                                    :     =
      0
>   pull_task() when target task was cache-hot on cpu busy           :     =
      0
>   load_balance() failed to find busier queue on cpu busy           :     =
      0   $        0.00 $
>   load_balance() failed to find busier group on cpu busy           :     =
      1   $    24537.00 $
>   *load_balance() success count on cpu busy                        :     =
      0
>   *avg task pulled per successful lb attempt (cpu busy)            :     =
   0.00
>   -----------------------------------------<Category newidle>------------=
-----------------------------
>   load_balance() count on cpu newly idle                           :     =
    427   $       57.46 $
>   load_balance() found balanced on cpu newly idle                  :     =
    382   $       64.23 $
>   load_balance() move task failed on cpu newly idle                :     =
     45   $      545.27 $
>   imbalance sum on cpu newly idle                                  :     =
     48
>   pull_task() count on cpu newly idle                              :     =
      0
>   pull_task() when target task was cache-hot on cpu newly idle     :     =
      0
>   load_balance() failed to find busier queue on cpu newly idle     :     =
      0   $        0.00 $
>   load_balance() failed to find busier group on cpu newly idle     :     =
    382   $       64.23 $
>   *load_balance() success count on cpu newly idle                  :     =
      0
>   *avg task pulled per successful lb attempt (cpu newly idle)      :     =
   0.00
>   -----------------------------------------------------------------------=
-----------------------------
>
> Consider following line:
>
>   load_balance() found balanced on cpu newly idle                  :     =
    382    $      64.23 $
>
> While profiling was active, the load-balancer found 382 times the load
> needs to be balanced on a newly idle CPU 0. Following value encapsulated
> inside $ is average jiffies between two events (24537 / 382 =3D 64.23).
>
> Next is active_load_balance() stats. alb did not trigger while I ran
> a workload so it's all 0s.
>
>   ----------------------------------<Category active_load_balance()>-----=
-----------------------------
>   active_load_balance() count                                      :     =
      0
>   active_load_balance() move task failed                           :     =
      0
>   active_load_balance() successfully moved a task                  :     =
      0
>   -----------------------------------------------------------------------=
-----------------------------
>
> Next are sched_balance_exec() and sched_balance_fork() stats. They are
> not used but we kept it in RFC just for legacy purpose. Unless opposed,
> we plan to remove them in next revision.
>
> Next is wakeup statistics. For every domain, the report also shows
> task-wakeup statistics. Example:
>
>   --------------------------------------------<Wakeup Info>--------------=
-----------------------------
>   try_to_wake_up() awoke a task that last ran on a diff cpu       :      =
 12070
>   try_to_wake_up() moved task because cache-cold on own cpu       :      =
  3324
>   try_to_wake_up() started passive balancing                      :      =
     0
>   -----------------------------------------------------------------------=
-----------------------------
>
> Same set of stats are reported for each cpu and each domain level.
>
>
> TODO:
>  - This RFC series supports v15 layout of /proc/schedstat but v16 layout
>    is already being pushed upstream. We are planning to include v16 as
>    well in the next revision.
>  - Currently schedstat tool provides statistics of only one run but we
>    are planning to add `perf sched schedstat diff` which can compare
>    the data of two different runs (possibly good and bad) and highlight
>    where scheduler decisions are impacting workload performance.
>  - perf sched schedstat records /proc/schedstat which is a cpu and domain
>    level scheduler statistic. We are planning to add taskstat tool which
>    reads task stats from procfs and generate scheduler statistic report
>    at task granularity. this will probably a standalone tool, something
>    like `perf sched taskstat record/report`.
>  - /proc/schedstat shows cpumask in domain line to indicate a group of
>    cpus that belong to the domain. Since we are not using domain<->cpumas=
k
>    data anywhere, we are not capturing it as part of perf sample. But we
>    are planning to include it in the next revision.
>  - We have tested the patch only on AMD machines, not on other platforms.

This is great! Is it possible to add some basic shell script testing:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell?h=3Dperf-tools-next
for the sake of coverage, other platform testing, etc. ?

Thanks,
Ian

>  - Some of the perf related features can be added to the schedstat sub-
>    command as well: for ex, pipemode, -p <pid> option to profile running
>    process etc. We are not planning to add TUI support however.
>  - Code changes are for RFC and thus not optimal. Some of the places
>    where code changes are not required for RFC are marked as /* FIXME */.
>  - Documenting details about schedstat tool in perf-sched man page will
>    also be done in next revision.
>  - Checkpatch warnings are ignored for now.
>
> Patches are prepared on perf-tools-next/perf-tools-next (37862d6fdced).
> Although all changes are in tools/perf/, kernel is important since it's
> using v15 of /proc/schedstat.
>
> [1] https://youtu.be/lg-9aG2ajA0?t=3D283
> [2] https://github.com/AMDESE/sched-scoreboard
> [3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd=
.com/
> [4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd=
.com/
>
> Ravi Bangoria (2):
>   perf sched: Make `struct perf_sched sched` a global variable
>   perf sched: Add template code for schedstat subcommand
>
> Swapnil Sapkal (2):
>   perf sched schedstat: Add record and rawdump support
>   perf sched schedstat: Add support for report subcommand
>
>  tools/lib/perf/Documentation/libperf.txt      |   2 +
>  tools/lib/perf/Makefile                       |   2 +-
>  tools/lib/perf/include/perf/event.h           |  37 ++
>  .../lib/perf/include/perf/schedstat-cpu-v15.h |  22 +
>  .../perf/include/perf/schedstat-domain-v15.h  | 121 ++++
>  tools/perf/builtin-inject.c                   |   2 +
>  tools/perf/builtin-sched.c                    | 558 ++++++++++++++++--
>  tools/perf/util/event.c                       |  54 ++
>  tools/perf/util/event.h                       |   2 +
>  tools/perf/util/session.c                     |  44 ++
>  tools/perf/util/synthetic-events.c            | 170 ++++++
>  tools/perf/util/synthetic-events.h            |   4 +
>  tools/perf/util/tool.h                        |   4 +-
>  13 files changed, 965 insertions(+), 57 deletions(-)
>  create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v15.h
>  create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v15.h
>
> --
> 2.44.0
>
