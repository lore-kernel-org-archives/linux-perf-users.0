Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15316FBF;
	Fri, 19 Jul 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721379055; cv=none; b=Ll5kPZoUaYXB8LQ9Y416mMkNuPKvxJMEJsnEH2kUfQmDqUjq60WNk2M7Ztgufh+WF/IBRgOEb6mlTNgkZXHCDvvNAWuav8vcWjqbv8JDU2VFNW2PAxJ6QC+lPW6QC1JHUCJFcXPRJ8Hn2eXxMb8q3GOq6D8CEC13askE/NTSgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721379055; c=relaxed/simple;
	bh=zqQUg0+uNUgCQyJmJ83wdgSF0KBJvUEKbNvxTLhc0No=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bAM/9QNRNhasZljWZx+x5F/UIbmZlFquX6uvDjVajYeEpOcQjGRZNDiTK/dIj8pMqeKV/vPdGws4if1TBLLY2jtK1gsBn9MiC5ZPKTusGtXATeZRTFeluFH2eLWLH84TF1ic8h0770mNR9gfyIbqpq9SUtNCw1k6+7ZIYkQW8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PP6F6uxa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PP6F6uxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721379053; x=1752915053;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=zqQUg0+uNUgCQyJmJ83wdgSF0KBJvUEKbNvxTLhc0No=;
  b=PP6F6uxaSXMo7mUmcbrpaDIIRM71slv+/HdyMYGAXVi8SZu7R22H+Yov
   mSPaOMaOqTK28Hx4p1XqO5yim7r9jS2jNEQNG/GSqg5uNat0sya77jYIX
   4htG0iQM/EpomoR6xCxQT0dRJPESoykQY3KbsHkpEGmU6Lg/YU95V4fVb
   99r8Ztuc+k0TJRdiAOiB7RiL0eGJqoX3CaeHVFXorUA4XF18tR8rduoUK
   G8BoGRXiCxN2v+Rh6tMYRJFdK88D3wrx8RUItxgcMppENv1KDfSHsy55V
   1s0wX1T5xBxIy+EomLhObT0ySl98drZwkgK0UQIVe/tFsyJQT2VjEtlys
   g==;
X-CSE-ConnectionGUID: Wn96mDWbS1Or80MEJu1uqA==
X-CSE-MsgGUID: 1Founh7pTx+LcvS9LBMjLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19095990"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="19095990"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 01:50:52 -0700
X-CSE-ConnectionGUID: m7JyBtYcT/6trfM+YkRC/Q==
X-CSE-MsgGUID: PpCBaH70SvShgrttKMSp+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="51640021"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 01:50:42 -0700
Message-ID: <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
Date: Fri, 19 Jul 2024 11:50:34 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/27] Constify tool pointers
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Nick Terrell <terrelln@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240718010023.1495687-1-irogers@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/24 03:59, Ian Rogers wrote:
> struct perf_tool provides a set of function pointers that are called
> through when processing perf data. To make filling the pointers less
> cumbersome, if they are NULL perf_tools__fill_defaults will add
> default do nothing implementations.
> 
> This change refactors struct perf_tool to have an init function that
> provides the default implementation. The special use of NULL and
> perf_tools__fill_defaults are removed. As a consequence the tool
> pointers can then all be made const, which better reflects the
> behavior a particular perf command would expect of the tool and to
> some extent can reduce the cognitive load on someone working on a
> command.
> 
> v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-by.

The tags were really meant only for patch 1, the email that was replied to.

But now for patches 2 and 3:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Looking at patches 4 to 25, they do not seem to offer any benefit.

Instead of patch 26, presumably perf_tool__fill_defaults() could
be moved to __perf_session__new(), which perhaps would allow
patch 27 as it is.


> v5: Rebase dropping asan fix merged by Namhyung.
> v4: Simplify perf_session__deliver_synth_attr_event following Adrian's
>     suggestions.
> v3: Just remove auxtrace dummy tools [Adrian] and make s390-cpumsf
>     struct removal its own patch [Adrian].
> v2: Remove dummy tool initialization [Adrian] and make zero sized. Add
>     cs-etm fix for address sanitizer build, found necessary when
>     testing dummy tool change.
> 
> Ian Rogers (27):
>   perf auxtrace: Remove dummy tools
>   perf s390-cpumsf: Remove unused struct
>   perf tool: Constify tool pointers
>   perf tool: Move fill defaults into tool.c
>   perf tool: Add perf_tool__init
>   perf kmem: Use perf_tool__init
>   perf buildid-list: Use perf_tool__init
>   perf kvm: Use perf_tool__init
>   perf lock: Use perf_tool__init
>   perf evlist: Use perf_tool__init
>   perf record: Use perf_tool__init
>   perf c2c: Use perf_tool__init
>   perf script: Use perf_tool__init
>   perf inject: Use perf_tool__init
>   perf report: Use perf_tool__init
>   perf stat: Use perf_tool__init
>   perf annotate: Use perf_tool__init
>   perf sched: Use perf_tool__init
>   perf mem: Use perf_tool__init
>   perf timechart: Use perf_tool__init
>   perf diff: Use perf_tool__init
>   perf data convert json: Use perf_tool__init
>   perf data convert ctf: Use perf_tool__init
>   perf test event_update: Ensure tools is initialized
>   perf kwork: Use perf_tool__init
>   perf tool: Remove perf_tool__fill_defaults
>   perf session: Constify tool
> 
>  tools/perf/arch/x86/util/event.c    |   4 +-
>  tools/perf/bench/synthesize.c       |   2 +-
>  tools/perf/builtin-annotate.c       |  44 ++--
>  tools/perf/builtin-buildid-list.c   |  10 +
>  tools/perf/builtin-c2c.c            |  33 ++-
>  tools/perf/builtin-diff.c           |  30 ++-
>  tools/perf/builtin-evlist.c         |  10 +-
>  tools/perf/builtin-inject.c         | 159 ++++++------
>  tools/perf/builtin-kmem.c           |  20 +-
>  tools/perf/builtin-kvm.c            |  19 +-
>  tools/perf/builtin-kwork.c          |  33 ++-
>  tools/perf/builtin-lock.c           |  41 ++--
>  tools/perf/builtin-mem.c            |  37 +--
>  tools/perf/builtin-record.c         |  47 ++--
>  tools/perf/builtin-report.c         |  67 +++--
>  tools/perf/builtin-sched.c          |  50 ++--
>  tools/perf/builtin-script.c         | 106 ++++----
>  tools/perf/builtin-stat.c           |  26 +-
>  tools/perf/builtin-timechart.c      |  25 +-
>  tools/perf/builtin-top.c            |   2 +-
>  tools/perf/builtin-trace.c          |   4 +-
>  tools/perf/tests/cpumap.c           |   6 +-
>  tools/perf/tests/dlfilter-test.c    |   2 +-
>  tools/perf/tests/dwarf-unwind.c     |   2 +-
>  tools/perf/tests/event_update.c     |   9 +-
>  tools/perf/tests/stat.c             |   6 +-
>  tools/perf/tests/thread-map.c       |   2 +-
>  tools/perf/util/Build               |   1 +
>  tools/perf/util/arm-spe.c           |  55 +----
>  tools/perf/util/auxtrace.c          |  12 +-
>  tools/perf/util/auxtrace.h          |  20 +-
>  tools/perf/util/bpf-event.c         |   4 +-
>  tools/perf/util/build-id.c          |  34 +--
>  tools/perf/util/build-id.h          |   8 +-
>  tools/perf/util/cs-etm.c            |  39 +--
>  tools/perf/util/data-convert-bt.c   |  34 ++-
>  tools/perf/util/data-convert-json.c |  47 ++--
>  tools/perf/util/event.c             |  54 ++--
>  tools/perf/util/event.h             |  38 +--
>  tools/perf/util/header.c            |   6 +-
>  tools/perf/util/header.h            |   4 +-
>  tools/perf/util/hisi-ptt.c          |   6 +-
>  tools/perf/util/intel-bts.c         |  37 +--
>  tools/perf/util/intel-pt.c          |  30 +--
>  tools/perf/util/jitdump.c           |   4 +-
>  tools/perf/util/s390-cpumsf.c       |  11 +-
>  tools/perf/util/session.c           | 366 +++-------------------------
>  tools/perf/util/session.h           |   9 +-
>  tools/perf/util/synthetic-events.c  |  80 +++---
>  tools/perf/util/synthetic-events.h  |  70 +++---
>  tools/perf/util/tool.c              | 294 ++++++++++++++++++++++
>  tools/perf/util/tool.h              |  18 +-
>  tools/perf/util/tsc.c               |   2 +-
>  53 files changed, 977 insertions(+), 1102 deletions(-)
>  create mode 100644 tools/perf/util/tool.c
> 

