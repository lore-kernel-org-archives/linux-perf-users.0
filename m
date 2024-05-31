Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C65249F5;
	Fri, 31 May 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137453; cv=none; b=AUlOGt9hiqAmsG2UBcpwsmLPe8RB/BpgDKa7bl9EcRt4sEa/lTJ4h7tUzsn26LTK9A22GGsCfe3pV/vNX1eBLeRdFCNt0WRf9B0v7CixPGrROrRYDQFxNd6FFZm43gjSvy+t2k/1OMwkeBYm0EVhykWVbGaoZqXR4Fsn8m0wMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137453; c=relaxed/simple;
	bh=5+EZ5b4CVGE3sIrvCueoYrAxsgkytZO9Tsy8WDi8GmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxHUNVNVPU5TGanJekaaeHjk1CV0WOTcoNquXVPCRqBypBNxOo0iWI1ou7jKvRDW3U5oVOoD9bNNk10ZtgN5a8ouExoQpyWk5YEXDeT2DmHnqBOEdqfML15ZHyNtx9s9HZkktEJwzasVI9C2vxn4Xykp3gz9ucphlN1OcnUq2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7024cd9dd3dso66821b3a.3;
        Thu, 30 May 2024 23:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717137451; x=1717742251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzN5+wZmlw1nr+Jsr8l9KCMyI10A+3vv5EJ3TRPO91M=;
        b=pvNX/Rk7NXJKVZqAI5Tpkg8o8usauGJ8vaeDMkCaJo1Ykt0iEJCYh+wVxHZtox7FMD
         8Qm2mTmt6W7i4OhIW5P+PR81U3VctXc8ex6stzrjHjv66uC5PZg4vFfTp51trOYHx7UJ
         d9eemISFp0Q5A2056Wbnlk7IQN6ccBw1V3KUS9qzho1/RYt3zAqpHmZmC96NLqdOKPGU
         zWQdK5vnmDE6wvW6YGszCeHqMmSmf3yKT83guYZ4AxX8KgpKAkVTuG3FMAxRVw7MYOZS
         KuQ/rPiqvsMn8NRWfaAt2ofMCcWdVYzqnRnDG53GT4W3GnmsLejiVUbSNT58MpLAeF+y
         wglw==
X-Forwarded-Encrypted: i=1; AJvYcCVpglX0vm3KAs5h2/2o9j35Xd5wRNyM3DZqyW8Fa1YeDGcAkxGZX/aej9exS5Fg8udkjFjyqH3M1OkJDHo90mEkqqPEe3LuvokxMUH8NsGl3vFfMa2P6+KHjMxddJYuLiPbkf3C3OQ39h2a8fUzqg==
X-Gm-Message-State: AOJu0YwzMyTGXbY3GqkbCyWeZFMgWmHFXhUVqRjjlWF7/Az6R0cBVClx
	CJpdHDQOMNiWpxYxD/e+NuK4Wmp7y02IJ9uIDs3Rx7GsSlkZiRied+WVzPz3QV9jGN15UWmQf2I
	hHtAYZx4qdmhXKCV2AjxUwv1Onsd56g==
X-Google-Smtp-Source: AGHT+IEnu5iYe4NwYWuqX7YVruF+o0veY+ZNSEKd8kM0nmte1vnSZJGpShHxb2J4iRY8JBME6bJALVFn/6fZwS4ir+E=
X-Received: by 2002:a05:6a20:9184:b0:1af:db2d:d36b with SMTP id
 adf61e73a8af0-1b26f137451mr1327820637.15.1717137450941; Thu, 30 May 2024
 23:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529064327.4080674-1-weilin.wang@intel.com>
In-Reply-To: <20240529064327.4080674-1-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 30 May 2024 23:37:19 -0700
Message-ID: <CAM9d7cj676sty01zqJVyk9DVesVYNFgVTZ329X=UP3xgV2aDfA@mail.gmail.com>
Subject: Re: [RFC PATCH v10 0/8] TPEBS counting mode support
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

Hello,

On Tue, May 28, 2024 at 11:43=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> I have tried not to count retire_latency events but did not succeed.
> In particular, I tried the following methods:
>  - Convert retire_latency event to dummy event in event parser.
>  - Early bail out in evsel__open_cpu() and store_evsel_ids().
>
> The first method fails and causes non-retire_latency events with the same=
 event
> name return 0 count.
>
> The second method fails and causes all the events in the same group retur=
ning
> "<not counted>" results.

Can you please describe where it fails?  Is it failing on other events
because the tpebs event is a leader of the group?  I think you wanted
to avoid having it in the leader position.  If we can skip any actual
operations (open/close/enable/disable/read) for the tpebs events, then
it could be fine..

Thanks,
Namhyung

>
> Because of above, the retire_latency event will still run in counting mod=
e.
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
> - In this revision, the code is updated to base on Ian's patch on R modif=
ier
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
> - Move TPEBS specific code out from main perf stat code to separate files=
 in
> util/intel-tpebs.c and util/intel-tpebs.h. [Namhyung]
> - Use --control:fifo to ack perf stat from forked perf record instead of =
sleep(2) [Namhyung]
> - Add introductions about TPEBS and R modifier in Documents. [Namhyung]
>
>
> Changes in v7:
> - Update code and comments for better code quality [Namhyung]
> - Add a separate commit for perf data [Namhyung]
> - Update retire latency print function to improve alignment [Namhyung]
>
> Changes in v6:
> - Update code and add comments for better code quality [Namhyung]
> - Remove the added fd var and directly pass the opened fd to data.file.fd=
 [Namhyung]
> - Add kill() to stop perf record when perf stat exists early [Namhyung]
> - Add command opt check to ensure only start perf record when -a/-C given=
 [Namhyung]
> - Squash commits [Namhyung]
>
> Changes in v5:
> - Update code and add comments for better code quality [Ian]
>
> Changes in v4:
> - Remove uncessary debug print and update code and comments for better
> readability and quality [Namhyung]
> - Update mtl metric json file with consistent TmaL1 and TopdownL1 metricg=
roup
>
> Changes in v3:
> - Remove ':' when event name has '@' [Ian]
> - Use 'R' as the modifier instead of "retire_latency" [Ian]
>
> Changes in v2:
> - Add MTL metric file
> - Add more descriptions and example to the patch [Arnaldo]
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
>
>  tools/perf/Documentation/perf-list.txt        |    1 +
>  tools/perf/Documentation/topdown.txt          |   30 +
>  tools/perf/arch/x86/util/evlist.c             |    6 +
>  tools/perf/builtin-stat.c                     |    8 +
>  .../arch/x86/meteorlake/metricgroups.json     |  140 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2595 +++++++++++++++++
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |   19 +
>  tools/perf/util/Build                         |    1 +
>  tools/perf/util/data.c                        |    7 +-
>  tools/perf/util/evsel.c                       |   26 +
>  tools/perf/util/evsel.h                       |    6 +
>  tools/perf/util/intel-tpebs.c                 |  397 +++
>  tools/perf/util/intel-tpebs.h                 |   48 +
>  tools/perf/util/parse-events.c                |    2 +
>  tools/perf/util/parse-events.h                |    1 +
>  tools/perf/util/parse-events.l                |    3 +-
>  16 files changed, 3288 insertions(+), 2 deletions(-)
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
