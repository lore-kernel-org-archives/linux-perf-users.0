Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB03183CC4;
	Mon, 12 Aug 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470817; cv=none; b=n6u1BN4NxvCHh555QHXHwWW/zKN2M00MrS8v+Qfuif4Z4DR0EjNNulXWUuCBqZnL/LCa92R4pM+lqjDLuDpUeA83WPtjVPHpx0qT++tJAbz9pb1Ol+11tevSGtV8DqTUido1Drs1hvfb8Wwru9ETvtPION6iZfzJnVwQLBicuJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470817; c=relaxed/simple;
	bh=ijKQeoW1MoOBpXzF9QLNNelhDZlm4eAZ4KAnbLksRcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJhBQxNU3gmJPYT81dXawp51mVGDrdYNdLlizujgL/Rzwamycfv3qxZbHfEg/B8Tjn4T/b6wsSHdIKQdLdsxinJ9Kuf4j8dmI8FyZRvi9kTFkKVJRWxs0YS8O9xtePpCxAPJeA4RPl8Is3gLEFkVv5RB71qigJ4VsWqcRq9AmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNVIw6qa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNVIw6qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857C0C4AF09;
	Mon, 12 Aug 2024 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723470817;
	bh=ijKQeoW1MoOBpXzF9QLNNelhDZlm4eAZ4KAnbLksRcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNVIw6qaWsPrwPdwsnlRLRy1Z7Fjir1TR4KRG4ENDZUWNp/yUOuCTIW9Gk+Z9BEEB
	 gkl7U6mBvfFSoKys049kUToIRtf+0Z0oitaVWGAGsnchUh5Ny0CBD1PM/Ki185m24o
	 uitF3wagx67wxMvpph3C327UYjWmyWOfze69QhK6F8tYGVa03hPbJHvyy2Vus1Arpq
	 TtmBRQ5gOfceQHkufwylMvEjATJ7kZhHCCmM+aiynuIVzLox6CxxVJf1FCQLW4iDhW
	 gUK2BVhkBDYc1K4zWIFFFfh+Y5j8BNeuu7YIOdWbGp+D11sLoKgrjNQq0CC0tw+KBl
	 jXDbNnJh2cORA==
Date: Mon, 12 Aug 2024 10:53:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nick Terrell <terrelln@fb.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Constify tool pointers
Message-ID: <ZroT3Xut5omFg7ud@x1>
References: <20240718010023.1495687-1-irogers@google.com>
 <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
 <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>

On Fri, Jul 19, 2024 at 09:26:57AM -0700, Ian Rogers wrote:
> On Fri, Jul 19, 2024 at 1:51 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 18/07/24 03:59, Ian Rogers wrote:
> > > struct perf_tool provides a set of function pointers that are called
> > > through when processing perf data. To make filling the pointers less
> > > cumbersome, if they are NULL perf_tools__fill_defaults will add
> > > default do nothing implementations.
> > >
> > > This change refactors struct perf_tool to have an init function that
> > > provides the default implementation. The special use of NULL and
> > > perf_tools__fill_defaults are removed. As a consequence the tool
> > > pointers can then all be made const, which better reflects the
> > > behavior a particular perf command would expect of the tool and to
> > > some extent can reduce the cognitive load on someone working on a
> > > command.
> > >
> > > v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-by.
> >
> > The tags were really meant only for patch 1, the email that was replied to.
> >
> > But now for patches 2 and 3:
> >
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Applied 1-3, 4 is not applying, I'll look at it later.

- Arnaldo

> 
> Sorry for that, you'd mentioned that pt and bts testing which is
> impacted by more than just patch 1.
> 
> > Looking at patches 4 to 25, they do not seem to offer any benefit.
> >
> > Instead of patch 26, presumably perf_tool__fill_defaults() could
> > be moved to __perf_session__new(), which perhaps would allow
> > patch 27 as it is.
> 
> What I'm trying to do in the series is make it so that the tool isn't
> mutated during its use by session. Ideally we'd be passing a const
> tool to session_new, that's not possible because there's a hack to fix
> ordered events and pipe mode in session__new:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/session.c?h=perf-tools-next#n275
> Imo, it isn't great to pass a tool to session__new where you say you
> want ordered events and then session just goes to change that for you.
> Altering that behavior was beyond the scope of this clean up, so tool
> is only const after session__new.
> 
> The reason for doing this is to make it so that when I have a tool I
> can reason that nobody is doing things to change it under my feet. My
> builtin_cmd is in charge of what the tool is rather than some code
> buried in util that thought it was going to do me a favor. The code is
> a refactor and so the benefit is intended to be for the developer and
> how they reason about the use of tool. We generally use _init
> functions rather than having _fill_defaults, so there is a consistency
> argument. I don't expect any impact in terms of performance... Moving
> perf_tool__fill_defaults to __perf_session__new had issues with the
> existing code where NULL would be written over a function pointer
> expecting the later fill_defaults to fix it up, doesn't address coding
> consistency where _init is the norm, and adds another reason the tool
> passed to session__new can't be const.
> 
> Thanks,
> Ian
> 
> > > v5: Rebase dropping asan fix merged by Namhyung.
> > > v4: Simplify perf_session__deliver_synth_attr_event following Adrian's
> > >     suggestions.
> > > v3: Just remove auxtrace dummy tools [Adrian] and make s390-cpumsf
> > >     struct removal its own patch [Adrian].
> > > v2: Remove dummy tool initialization [Adrian] and make zero sized. Add
> > >     cs-etm fix for address sanitizer build, found necessary when
> > >     testing dummy tool change.
> > >
> > > Ian Rogers (27):
> > >   perf auxtrace: Remove dummy tools
> > >   perf s390-cpumsf: Remove unused struct
> > >   perf tool: Constify tool pointers
> > >   perf tool: Move fill defaults into tool.c
> > >   perf tool: Add perf_tool__init
> > >   perf kmem: Use perf_tool__init
> > >   perf buildid-list: Use perf_tool__init
> > >   perf kvm: Use perf_tool__init
> > >   perf lock: Use perf_tool__init
> > >   perf evlist: Use perf_tool__init
> > >   perf record: Use perf_tool__init
> > >   perf c2c: Use perf_tool__init
> > >   perf script: Use perf_tool__init
> > >   perf inject: Use perf_tool__init
> > >   perf report: Use perf_tool__init
> > >   perf stat: Use perf_tool__init
> > >   perf annotate: Use perf_tool__init
> > >   perf sched: Use perf_tool__init
> > >   perf mem: Use perf_tool__init
> > >   perf timechart: Use perf_tool__init
> > >   perf diff: Use perf_tool__init
> > >   perf data convert json: Use perf_tool__init
> > >   perf data convert ctf: Use perf_tool__init
> > >   perf test event_update: Ensure tools is initialized
> > >   perf kwork: Use perf_tool__init
> > >   perf tool: Remove perf_tool__fill_defaults
> > >   perf session: Constify tool
> > >
> > >  tools/perf/arch/x86/util/event.c    |   4 +-
> > >  tools/perf/bench/synthesize.c       |   2 +-
> > >  tools/perf/builtin-annotate.c       |  44 ++--
> > >  tools/perf/builtin-buildid-list.c   |  10 +
> > >  tools/perf/builtin-c2c.c            |  33 ++-
> > >  tools/perf/builtin-diff.c           |  30 ++-
> > >  tools/perf/builtin-evlist.c         |  10 +-
> > >  tools/perf/builtin-inject.c         | 159 ++++++------
> > >  tools/perf/builtin-kmem.c           |  20 +-
> > >  tools/perf/builtin-kvm.c            |  19 +-
> > >  tools/perf/builtin-kwork.c          |  33 ++-
> > >  tools/perf/builtin-lock.c           |  41 ++--
> > >  tools/perf/builtin-mem.c            |  37 +--
> > >  tools/perf/builtin-record.c         |  47 ++--
> > >  tools/perf/builtin-report.c         |  67 +++--
> > >  tools/perf/builtin-sched.c          |  50 ++--
> > >  tools/perf/builtin-script.c         | 106 ++++----
> > >  tools/perf/builtin-stat.c           |  26 +-
> > >  tools/perf/builtin-timechart.c      |  25 +-
> > >  tools/perf/builtin-top.c            |   2 +-
> > >  tools/perf/builtin-trace.c          |   4 +-
> > >  tools/perf/tests/cpumap.c           |   6 +-
> > >  tools/perf/tests/dlfilter-test.c    |   2 +-
> > >  tools/perf/tests/dwarf-unwind.c     |   2 +-
> > >  tools/perf/tests/event_update.c     |   9 +-
> > >  tools/perf/tests/stat.c             |   6 +-
> > >  tools/perf/tests/thread-map.c       |   2 +-
> > >  tools/perf/util/Build               |   1 +
> > >  tools/perf/util/arm-spe.c           |  55 +----
> > >  tools/perf/util/auxtrace.c          |  12 +-
> > >  tools/perf/util/auxtrace.h          |  20 +-
> > >  tools/perf/util/bpf-event.c         |   4 +-
> > >  tools/perf/util/build-id.c          |  34 +--
> > >  tools/perf/util/build-id.h          |   8 +-
> > >  tools/perf/util/cs-etm.c            |  39 +--
> > >  tools/perf/util/data-convert-bt.c   |  34 ++-
> > >  tools/perf/util/data-convert-json.c |  47 ++--
> > >  tools/perf/util/event.c             |  54 ++--
> > >  tools/perf/util/event.h             |  38 +--
> > >  tools/perf/util/header.c            |   6 +-
> > >  tools/perf/util/header.h            |   4 +-
> > >  tools/perf/util/hisi-ptt.c          |   6 +-
> > >  tools/perf/util/intel-bts.c         |  37 +--
> > >  tools/perf/util/intel-pt.c          |  30 +--
> > >  tools/perf/util/jitdump.c           |   4 +-
> > >  tools/perf/util/s390-cpumsf.c       |  11 +-
> > >  tools/perf/util/session.c           | 366 +++-------------------------
> > >  tools/perf/util/session.h           |   9 +-
> > >  tools/perf/util/synthetic-events.c  |  80 +++---
> > >  tools/perf/util/synthetic-events.h  |  70 +++---
> > >  tools/perf/util/tool.c              | 294 ++++++++++++++++++++++
> > >  tools/perf/util/tool.h              |  18 +-
> > >  tools/perf/util/tsc.c               |   2 +-
> > >  53 files changed, 977 insertions(+), 1102 deletions(-)
> > >  create mode 100644 tools/perf/util/tool.c
> > >
> >
