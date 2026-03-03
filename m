Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584F2FE044;
	Tue,  3 Mar 2026 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500510; cv=none; b=dpBsrn1YyiMeefG3wQm21JGPRaBBibeJYNwpvQSdTGuoZMtEitQAOuugqVyubmAhIHLyDVitEc62zAW5M+odnfKTUsioWJfGngpoJQbvujSWx4zP5ePrO21+WzFqmy47VRzjvKH249bmh1MnLcc7LgKA855A5HApAfDcPKVD7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500510; c=relaxed/simple;
	bh=QUqGmwefJChNRywdpwU6AAbGz0KFFI2XWCs8ymPBxsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa1MyWZ7NA8CCTzWpfy5EBHk9t1sb5vCzYiy1ij7C+nT78lEMO1OvOI/FByzOFMXHgq0aoa4GS6jkw2rfAmlfj+vRx6JgA5lM8kJA66K0LnByRdUoMCoYlD5UdEWWTQNo9uIItlC+cCV6+tdHxYx90g+2wqaHWqStMkJqoNwKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwVbp8xs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwVbp8xs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B20C19423;
	Tue,  3 Mar 2026 01:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772500510;
	bh=QUqGmwefJChNRywdpwU6AAbGz0KFFI2XWCs8ymPBxsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwVbp8xsyglCRRr9UJBQP4x+QVw0v41N6Hy4iUk+8ZYFyy/lyg2XvXQsOTjSrX0C5
	 RUu+JRt2FCEF65SHv1JFpYZeHgkyM8BzIAfX91PTZ1bQGPgEQeMPqrax8IcIZ9Y4QW
	 gsPsK+faaUFWJ54XQXoP31VXt1DsmzY4PrKGJ3yBmFFGUrcrwyOfjiSHLmUFbvpgJK
	 mDq+nZfpea7cfUZLpT643GLQ1v4Ur6m1EQknQcME0KQ9Aapbg6MmEMRAjOEkT9APxp
	 HWQIaowe/mCzIo2W5m7XwcEoWzhu4vQdxt7Dst6yQs6zO7TOv3JJV3MfKv5WH4BVqH
	 33Pyz2m/X/AiQ==
Date: Mon, 2 Mar 2026 17:15:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	tanze <tanze@kylinos.cn>,
	Hrishikesh Suresh <hrishikesh123s@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/25] perf tool: Add evsel to perf_sample
Message-ID: <aaY2GwW04E5WjVgy@google.com>
References: <20260209174032.4142096-1-irogers@google.com>
 <CAP-5=fVaEfuM0_YXwX4tgFfiPTX1i_BkTKhYvGqnpZ2d_Cb6+w@mail.gmail.com>
 <CAP-5=fXebrVQoGyToo20cuAoFXi65NinbqJhhSdu9EUU0V3ETQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXebrVQoGyToo20cuAoFXi65NinbqJhhSdu9EUU0V3ETQ@mail.gmail.com>

On Mon, Mar 02, 2026 at 09:56:54AM -0800, Ian Rogers wrote:
> On Mon, Feb 23, 2026 at 11:15 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Feb 9, 2026 at 9:40 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Nearly all perf code ends up passing an evsel with the perf_sample,
> > > which is problematic if you want to rewrite the evsel such as with
> > > off-CPU processing - all uses of the evsel need fixing up. Previously
> > > I'd mailed this patch as an RFC with everything combined:
> > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> > > and there was a request to break it up.
> > >
> > > I've started the series by adding documentation to struct
> > > perf_sample. Next I fixed missing perf_sample__init/exit largely from
> > > the recent perf inject callchain rewriting work. The 3rd patch adds
> > > the evsel to struct perf_sample and ensures it is correctly
> > > initialized. The next 22 patches avoid passing the evsel along with
> > > sample for different parts of the perf tool, along with some minor
> > > tweaks like constification and not determining the evsel if it is
> > > present in the sample.
> >
> > Ping.
> 
> Ping.
 
Sorry for the delay.  I'll take a look this week.

Thanks,
Namhyung


> > > Ian Rogers (25):
> > >   perf sample: Document struct perf_sample
> > >   perf sample: Make sure perf_sample__init/exit are used
> > >   perf sample: Add evsel to struct perf_sample
> > >   perf tool: Remove evsel from tool APIs that pass the sample
> > >   perf kvm: Don't pass evsel with sample
> > >   perf evsel: Refactor evsel__intval to perf_sample__intval
> > >   perf trace: Don't pass evsel with sample
> > >   perf callchain: Don't pass evsel and sample
> > >   perf lock: Only pass sample to handlers
> > >   perf lock: Constify trace_lock_handler variables
> > >   perf hist: Remove evsel parameter from inc samples functions
> > >   perf db-export: Remove evsel from struct export_sample
> > >   perf hist: Remove evsel from struct hist_entry_iter
> > >   perf report: Directly use sample->evsel to avoid computing from
> > >     sample->id
> > >   perf annotate: Don't pass evsel to add_sample
> > >   perf inject: Don't pass evsel with sample
> > >   perf kmem: Don't pass evsel with sample
> > >   perf kwork: Don't pass evsel with sample
> > >   perf sched: Don't pass evsel with sample
> > >   perf timechart: Don't pass evsel with sample
> > >   perf trace: Don't pass evsel with sample
> > >   perf evlist: Try to avoid computing evsel from sample
> > >   perf script: Don't pass evsel with sample
> > >   perf s390-sample-raw: Don't pass evsel with sample
> > >   perf evsel: Don't pass evsel with sample
> > >
> > >  tools/perf/builtin-annotate.c                 |  28 ++-
> > >  tools/perf/builtin-c2c.c                      |   6 +-
> > >  tools/perf/builtin-diff.c                     |   5 +-
> > >  tools/perf/builtin-inject.c                   |  81 ++++----
> > >  tools/perf/builtin-kmem.c                     |  58 +++---
> > >  tools/perf/builtin-kvm.c                      |  22 +--
> > >  tools/perf/builtin-kwork.c                    | 104 ++++------
> > >  tools/perf/builtin-lock.c                     | 117 +++++------
> > >  tools/perf/builtin-mem.c                      |   1 -
> > >  tools/perf/builtin-record.c                   |   3 +-
> > >  tools/perf/builtin-report.c                   |  38 ++--
> > >  tools/perf/builtin-sched.c                    | 183 ++++++++----------
> > >  tools/perf/builtin-script.c                   |  26 ++-
> > >  tools/perf/builtin-timechart.c                |  76 +++-----
> > >  tools/perf/builtin-top.c                      |  19 +-
> > >  tools/perf/builtin-trace.c                    | 103 +++++-----
> > >  tools/perf/tests/hists_cumulate.c             |   3 +-
> > >  tools/perf/tests/hists_filter.c               |   2 +-
> > >  tools/perf/tests/hists_output.c               |   3 +-
> > >  tools/perf/tests/mmap-basic.c                 |   4 +-
> > >  tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
> > >  tools/perf/tests/switch-tracking.c            |   9 +-
> > >  tools/perf/util/annotate.c                    |  19 +-
> > >  tools/perf/util/annotate.h                    |   6 +-
> > >  tools/perf/util/build-id.c                    |   3 +-
> > >  tools/perf/util/build-id.h                    |   7 +-
> > >  tools/perf/util/callchain.c                   |   8 +-
> > >  tools/perf/util/callchain.h                   |   5 +-
> > >  tools/perf/util/data-convert-bt.c             |   2 +-
> > >  tools/perf/util/data-convert-json.c           |   5 +-
> > >  tools/perf/util/db-export.c                   |  13 +-
> > >  tools/perf/util/db-export.h                   |   3 +-
> > >  tools/perf/util/evsel.c                       |  60 +++---
> > >  tools/perf/util/evsel.h                       |  12 +-
> > >  tools/perf/util/hist.c                        |  26 +--
> > >  tools/perf/util/hist.h                        |   3 +-
> > >  tools/perf/util/intel-pt.c                    |  12 +-
> > >  tools/perf/util/intel-tpebs.c                 |   3 +-
> > >  tools/perf/util/jitdump.c                     |   2 +-
> > >  .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  19 +-
> > >  .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  17 +-
> > >  .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  17 +-
> > >  .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  17 +-
> > >  tools/perf/util/kvm-stat-arch/kvm-stat-s390.c |  20 +-
> > >  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  70 +++----
> > >  tools/perf/util/kvm-stat.c                    |  19 +-
> > >  tools/perf/util/kvm-stat.h                    |  18 +-
> > >  tools/perf/util/kwork.h                       |   9 +-
> > >  tools/perf/util/machine.c                     |  14 +-
> > >  tools/perf/util/machine.h                     |   3 -
> > >  tools/perf/util/s390-sample-raw.c             |  15 +-
> > >  tools/perf/util/sample.c                      |   8 +-
> > >  tools/perf/util/sample.h                      |  93 ++++++++-
> > >  .../util/scripting-engines/trace-event-perl.c |  23 +--
> > >  .../scripting-engines/trace-event-python.c    |  47 ++---
> > >  tools/perf/util/session.c                     |  74 ++++---
> > >  tools/perf/util/synthetic-events.c            |   9 +-
> > >  tools/perf/util/synthetic-events.h            |   2 -
> > >  tools/perf/util/tool.c                        |   4 +-
> > >  tools/perf/util/tool.h                        |   4 +-
> > >  tools/perf/util/trace-event-scripting.c       |   5 +-
> > >  tools/perf/util/trace-event.h                 |   3 -
> > >  62 files changed, 769 insertions(+), 823 deletions(-)
> > >
> > > --
> > > 2.53.0.239.g8d8fc8a987-goog
> > >
