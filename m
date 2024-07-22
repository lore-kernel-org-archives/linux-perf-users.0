Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755916E89E;
	Mon, 22 Jul 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669890; cv=none; b=lhVzWps2zFRAYvKFcMH/j7mp6/ZGtFbxu3NHwsxgz+3YqyxI2Laqf0mQYypzePFwb+aKM8ibYccCoDCYvF+mtQdd/qC7wXDTz1IloWBvyuQXrX5XYJP/C5B+GAt0e/8OMCqb3m6z8psdxhyeSCvbpUirE1i64RCmyV0N0emfWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669890; c=relaxed/simple;
	bh=hn6LDNdD6TFi0eO2iuWNgAUOFX+eSAfI4VrQlmxn/RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FabNlAEi4lnJblxqDNWuYcxbSZgU7e4MhckmVoJKGFx+mIC3F0sbaZFryF/R+6I5zpli6IRpDSrzL0JMhB9945Ebbn5ve49mulqLgSjHqjEFYGeVm0/KHsoQ3JHizwU9JeDthP+FtdAW6qgtDCgRMNoY0IwE/j+pcFYCGshxFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cd1661174cso1395614a91.0;
        Mon, 22 Jul 2024 10:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721669888; x=1722274688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wKoNtQ4SQPJd7Ia32SRDxIuuiefLWdxy7tDAUoZVzA=;
        b=Uzh7GDYagFTPXTc4fLMAlz+4dY9SGzBjByzxfKo1iQrA/Co7qXjDtleQGlZ+N7ikz0
         d6qMGi+5Wv7JYJfmrBbOsIlfK+nS3aSolDZVtYMSSSXHyfY0fZ/Gry9tHZY3/qCz+ZsI
         FBikVi051h85ciZe8P9ooQPPIM6aLNy1ihe9uG98L7uOOesAUcRRvD2bwcrTECvLVMDK
         /dFxMMAM7xJOxXI6GY7FpoReNW4t3wKIgE+PnrMUMOpImDuBc6MQfY1ODQ7YTMRmsLSB
         9aL8kbG2eqfd4v8zxmyxBX5IqAMlQ9pDSlQdAEQtpp6I4DMFYt+B10aNrD+7ZUVu56Ve
         4xqw==
X-Forwarded-Encrypted: i=1; AJvYcCX+NrpY4Ct+8zdAtaHrdA1QZVsm9cpgaUvQsdMQb9kjz4GnXpAICcLEqAYPP6eELfHAB6AHOlxjjro2S0qNycoyBv8yk1DadNZbYh0hWQwahEX4rvMiEJR8M+QntcNBZQDxXy9r2Oppwr5TCeD5OA==
X-Gm-Message-State: AOJu0Yxe+Mli35FyP9+G0IbBRCSvAA2eZLe6bNUUoS9JzulWXliqmm/W
	xuL8Mwe1CYK9pK6MDpjmqwi3Fv+mS662VDnYZXrqOvTA18gtedicROTkswj1IhxTYEBqGxRDjmS
	lMjips+hBm7wDt/HHogEqhXc2/Hk=
X-Google-Smtp-Source: AGHT+IFdx8kV8E2EOeHEFp2FjvFxqhCrQShnTq2yuKklYeJ5xdUvw4bU3PVYk+yYYJMLAWDU+h5SBWIIT820CQQjT/g=
X-Received: by 2002:a17:90a:c70b:b0:2c8:7330:68b3 with SMTP id
 98e67ed59e1d1-2cd274d5c5amr4195964a91.39.1721669887461; Mon, 22 Jul 2024
 10:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720062102.444578-1-weilin.wang@intel.com>
In-Reply-To: <20240720062102.444578-1-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Jul 2024 10:37:56 -0700
Message-ID: <CAM9d7cgoTyf3Zjt=+2yZi5Pat4UrxKxN=rkLHmyUWZqwZk8_Kw@mail.gmail.com>
Subject: Re: [RFC PATCH v18 0/8] TPEBS counting mode support
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Weilin,

On Fri, Jul 19, 2024 at 11:21=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Change in v18:
>  - Update to exit 2 in TPEBS shell test when not on Intel platform.
>  - Several updates to use EVLIST_CTL_CMD_ENABLE_TAG, EVLIST_CTL_CMD_ACK_T=
AG, and
>  etc.
>
> Changes in v17:
>  - Add a poll on control fifo ack_fd to ensure program returns successful=
ly when
>  perf record failed for any reason.
>  - Add a check in the tpebs test to only run on Intel platforms.
>
> Changes in v16:
>  - Update tpebs bash test code and variable name.
>  - Add a check to ensure only use "-C" option when cpumap is not "-1" whe=
n
>  forking "perf record".
>
> Changes in v15:
>  - Revert changes added for python import test failure in v14 because the=
 code
>  works correctly with the new python build code.
>  - Update the command line option to --record-tpebs.
>
> Changes in v14:
>  - Fix the python import test failure. We cannot support PYTHON_PERF beca=
use it
>  will trigger a chain of dependency issues if we add intel-tpebs.c to it.=
 So,
>  only enable tpebs functions in evsel and evlist when PYTHON_PERF is not
>  defined.
>  - Fix shellcheck warning for the tpebs test.
>
> Changes in v13:
>  - Add document for the command line option and fix build error in non-x8=
6_64.
>  - Update example with non-zero retire_latency value when tpebs recording=
 is
>  enabled.
>  - Add tpebs_stop() back to tpebs_set_evsel() because in hybrid platform,=
 when
>  the forked perf record is not killed, the reader thread does not get any
>  sampled data from the PIPE. As a result, tpebs_set_evesel() will always =
return
>  zero on retire_latency values. This does not happen on my test GNR machi=
ne.
>  Since -I is not supported yet, I think we should add tpebs_stop() to ens=
ure
>  correctness for now. More investigation is required here when we work on
>  supporting -I mode.
>  - Rebase code on top of perf-tools-next.
>
> Changes in v12:
>  - Update MTL metric JSON file to include E-Core TMA3.6 changes.
>  - Update comments and code for better code quality. Keep tpebs_start() a=
nd
>  tpebs_delete() at evsel level for now and add comments on these function=
s with
>  more details about potential future changes. Remove tpebs_stop() call fr=
om
>  tpebs_set_evsel(). Simplify the tpebs_start() and tpebs_stop()/tpebs_del=
ete()
>  interfaces. Also fixed the bugs on not freed "new" pointer and the incor=
rect
>  variable value assignment to val instead of counter->val.
>
> Changes in v11:
>  - Make retire_latency evsels not opened for counting. This works correct=
ly now
>  with the code Namhyung suggested that adjusting group read size when
>  retire_latency evsels included in the group.
>  - Update retire_latency value assignment using rint() to reduce precisio=
n loss
>  while keeping code generic.
>  - Fix the build error caused by not used variable in the test.
>
> Other changes in v10:
>  - Change perf record fork from perf stat to evsel. All the major operati=
ons
>  like tpebs start, stop, read_evsel should directly work through evsel.
>  - Make intel-tpebs x86_64 only. This change is cross-compiled to arm64.
>  - Put tpebs code to intel-tepbs and simplify intel-tpebs APIs to minimum=
 number
> of functions and variables. Update funtion name and variable names to use
> consistent prefix. Also improve error handling.
>  - Integrate code patch from Ian for the :R parser.
>  - Update MTL metrics to TMA 4.8.
>
> V9: https://lore.kernel.org/all/20240521173952.3397644-1-weilin.wang@inte=
l.com/
>
> Changes in v9:
>  - Update the retire_latency result print and metric calculation method. =
Plugin
> the value to evsel so that no special code is required.
>  - Update --control:fifo to use pipe instead of named pipe.
>  - Add test for TPEBS counting mode.
>  - Update Document with more details.
>
> Changes in v8:
>  - In this revision, the code is updated to base on Ian's patch on R modi=
fier
> parser https://lore.kernel.org/lkml/20240428053616.1125891-3-irogers@goog=
le.com/
> After this change, there is no special code required for R modifier in
> metricgroup.c and metricgroup.h files.
>
> Caveat of this change:
>   Ideally, we will need to add special handling to skip counting events w=
ith R
> modifier in evsel. Currently, this is not implemented so the event with :=
R will
> be both counted and sampled. Usually, in a metric formula that uses retir=
e_latency,
> it would already require to count the event. As a result, we will endup c=
ount the
> same event twice. This should be able to be handled properly when we fina=
lize our
> design on evsel R modifier support.
>
>  - Move TPEBS specific code out from main perf stat code to separate file=
s in
> util/intel-tpebs.c and util/intel-tpebs.h. [Namhyung]
>  - Use --control:fifo to ack perf stat from forked perf record instead of=
 sleep(2) [Namhyung]
>  - Add introductions about TPEBS and R modifier in Documents. [Namhyung]
>
>
> Changes in v7:
>  - Update code and comments for better code quality [Namhyung]
>  - Add a separate commit for perf data [Namhyung]
>  - Update retire latency print function to improve alignment [Namhyung]
>
> Changes in v6:
>  - Update code and add comments for better code quality [Namhyung]
>  - Remove the added fd var and directly pass the opened fd to data.file.f=
d [Namhyung]
>  - Add kill() to stop perf record when perf stat exists early [Namhyung]
>  - Add command opt check to ensure only start perf record when -a/-C give=
n [Namhyung]
>  - Squash commits [Namhyung]
>
> Changes in v5:
>  - Update code and add comments for better code quality [Ian]
>
> Changes in v4:
>  - Remove uncessary debug print and update code and comments for better
> readability and quality [Namhyung]
>  - Update mtl metric json file with consistent TmaL1 and TopdownL1 metric=
group
>
> Changes in v3:
>  - Remove ':' when event name has '@' [Ian]
>  - Use 'R' as the modifier instead of "retire_latency" [Ian]
>
> Changes in v2:
>  - Add MTL metric file
>  - Add more descriptions and example to the patch [Arnaldo]
>
> Here is an example of running perf stat to collect a metric that uses
> retire_latency value of event MEM_INST_RETIRED.STLB_HIT_STORES on a MTL s=
ystem.
>
> In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES samp=
le.
> Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p count and retire_latenc=
y value
> are all 0.
>
> ./perf stat -M tma_dtlb_store -a -- sleep 1
>
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.000 MB - ]
>
>  Performance counter stats for 'system wide':
>
>        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tm=
a_dtlb_store
>          3,195,608      cpu_core/topdown-retiring/
>         40,156,649      cpu_core/topdown-mem-bound/
>          3,550,925      cpu_core/topdown-bad-spec/
>        117,571,818      cpu_core/topdown-fe-bound/
>         57,118,087      cpu_core/topdown-be-bound/
>             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
>              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
>         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
>         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
>            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
>               0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        0
>
>        1.003105924 seconds time elapsed
>
> v1:
> TPEBS is one of the features provided by the next generation of Intel PMU=
.
> Please refer to Section 8.4.1 of "Intel=C2=AE Architecture Instruction Se=
t Extensions
> Programming Reference" [1] for more details about this feature.
>
> This set of patches supports TPEBS in counting mode. The code works in th=
e
> following way: it forks a perf record process from perf stat when retire_=
latency
> of one or more events are used in a metric formula. Perf stat would send =
a
> SIGTERM signal to perf record before it needs the retire latency value fo=
r
> metric calculation. Perf stat will then process sample data to extract th=
e
> retire latency data for metric calculations. Currently, the code uses the
> arithmetic average of retire latency values.
>
> [1] https://www.intel.com/content/www/us/en/content-details/812218/intel-=
architecture-instruction-set-extensions-programming-reference.html?wapkw=3D=
future%20features
>
>
>
>
> Ian Rogers (1):
>   perf parse-events: Add a retirement latency modifier
>
> Weilin Wang (7):
>   perf data: Allow to use given fd in data->file.fd
>   perf stat: Fork and launch perf record when perf stat needs to get
>     retire latency value for a metric.
>   perf stat: Plugin retire_lat value from sampled data to evsel
>   perf vendor events intel: Add MTL metric json files
>   perf stat: Add command line option for enabling tpebs recording
>   perf Document: Add TPEBS to Documents
>   perf test: Add test for Intel TPEBS counting mode

Thanks for your persistence!

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/Documentation/perf-list.txt        |    1 +
>  tools/perf/Documentation/perf-stat.txt        |    8 +
>  tools/perf/Documentation/topdown.txt          |   30 +
>  tools/perf/arch/x86/util/evlist.c             |    6 +
>  tools/perf/builtin-stat.c                     |    8 +
>  .../arch/x86/meteorlake/metricgroups.json     |  142 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2535 +++++++++++++++++
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |   19 +
>  tools/perf/util/Build                         |    1 +
>  tools/perf/util/data.c                        |    7 +-
>  tools/perf/util/evlist.c                      |    2 +
>  tools/perf/util/evsel.c                       |   81 +-
>  tools/perf/util/evsel.h                       |    6 +
>  tools/perf/util/intel-tpebs.c                 |  431 +++
>  tools/perf/util/intel-tpebs.h                 |   35 +
>  tools/perf/util/parse-events.c                |    2 +
>  tools/perf/util/parse-events.h                |    1 +
>  tools/perf/util/parse-events.l                |    3 +-
>  18 files changed, 3314 insertions(+), 4 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroup=
s.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics=
.json
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
>  create mode 100644 tools/perf/util/intel-tpebs.c
>  create mode 100644 tools/perf/util/intel-tpebs.h
>
> --
> 2.43.0
>
