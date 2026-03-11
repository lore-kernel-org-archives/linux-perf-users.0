Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF383C7DE0;
	Wed, 11 Mar 2026 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229816; cv=none; b=oHgxpLbglLDhSRqjAUNLMrLsOj9NZaIcYM9dJPKCwk3mjFrE3lcrXLcBGMN7YPKXfWcAq4h5eKK9p54nHRU+suOEvfLtrARiLPhzQdXxJ+YJC5igPbvTNDQBk6/ajiZFZIG9h7AC/dAf2DiHIW9q4Ui1YjmBQiYldjO6sUtjiXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229816; c=relaxed/simple;
	bh=/J/CBbXxfd3nb0fllWLsXppuJaGgG86AQy3giIISFjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwC1LwLpFYLk4Fp5JBSPo9kP5IaBYeKpuXlIzfsSPHhcanDOXvXR5PYAcsbcCiIno+CHj1E6M2YYCgsmyvjnFT8eYYRU0selAyw2Q2lqqRcmKH0It30C7NNIXy/TXIB+XKvKnk9wcNfh9vjiWGgEGv7g9SoU5Tc0sRqkVAVhKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 470BC165C;
	Wed, 11 Mar 2026 04:50:07 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257753F73B;
	Wed, 11 Mar 2026 04:50:13 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:50:11 +0000
From: Leo Yan <leo.yan@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Ian Rogers <irogers@google.com>, acme@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
Message-ID: <20260311115011.GJ4153946@e132581.arm.com>
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
 <20260205173918.GB3529712@e132581.arm.com>
 <20260205175250.GC3529712@e132581.arm.com>
 <CAP-5=fUY8dYzwKu-g3-HER4ji9ZeGmPQo9DeORW0w9ocW1qnMw@mail.gmail.com>
 <abFBoVrlGl9cIg1h@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abFBoVrlGl9cIg1h@gmail.com>

Hi Breno,

On Wed, Mar 11, 2026 at 03:21:00AM -0700, Breno Leitao wrote:
> On Thu, Feb 05, 2026 at 10:22:27AM -0800, Ian Rogers wrote:
> > I think it is a different issue, they have metrics while you don't.
> > Your report does highlight we're missing a NO_JEVENTS=1 build-test,
> > but the build is working for me. I'll send out two patches for these
> > issues.
> 
> Hi Ian, Leo, Acme
> 
> I wanted to follow up on this. Are there any next steps I should take?

Sorry for not tracking this issue.

I can reproduce the issue on my Orion6 with setting a _dummy_ CPUID:

 $ export PERF_CPUID=0x00000000410fd490
 $ perf stat -C 5 -vvv
 ...
 Aborted
 perf: util/evsel.c:2156: get_group_fd: Assertion `!(!leader->core.fd)' failed

Because we are working on different hardwares, I am a bit suspect I
reproduced the issue with difference sequence as yours.  Anyway, I do
see that an event can be opened prior to its leader event, see the log
below.

Thus, your patch seems make sense to me as we need to ensure the leader
event to be opened first.  Ian, how about you think?

I have a side question (maybe this is for James :): why other arch (or
platforms) don't have reproduce the issue?  I am wandering if any error
or special stuffs in Arm CPU's json files.

Thanks,
Leo


---8<---

Opening: BR_MIS_PRED
------------------------------------------------------------
perf_event_attr:
  type                             11 (armv8_pmuv3_1)
  size                             144
  config                           0x10 (br_mis_pred)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  disabled                         1
  inherit                          1
------------------------------------------------------------
evsel=BR_MIS_PRED (supported=1) leader=BR_MIS_PRED
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
Warning:
BR_MIS_PRED event is not supported by the kernel.
The BR_MIS_PRED event is not supported.
Opening: OP_SPEC
------------------------------------------------------------
perf_event_attr:
  type                             11 (armv8_pmuv3_1)
  size                             144
  config                           0x3b (op_spec)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
------------------------------------------------------------
evsel=OP_SPEC (supported=1) leader=BR_MIS_PRED
leader->core.fd=0xaaab19edd950
broken group leader for OP_SPEC
Warning:
skipping event OP_SPEC that kernel failed to open.
The sys_perf_event_open() syscall failed for event (OP_SPEC): Success
"dmesg | grep -i perf" may provide additional information.

Opening: STALL_SLOT
------------------------------------------------------------
perf_event_attr:
  type                             11 (armv8_pmuv3_1)
  size                             144
  config                           0x3f (stall_slot)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
------------------------------------------------------------
evsel=STALL_SLOT (supported=1) leader=BR_MIS_PRED
leader->core.fd=0xaaab19edd950
broken group leader for STALL_SLOT
Warning:
skipping event STALL_SLOT that kernel failed to open.
The sys_perf_event_open() syscall failed for event (STALL_SLOT): Success
"dmesg | grep -i perf" may provide additional information.

Opening: CPU_CYCLES
------------------------------------------------------------
perf_event_attr:
  type                             11 (armv8_pmuv3_1)
  size                             144
  config                           0x11 (cpu_cycles)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
------------------------------------------------------------
evsel=CPU_CYCLES (supported=1) leader=BR_MIS_PRED
leader->core.fd=0xaaab19edd950
broken group leader for CPU_CYCLES
Warning:
skipping event CPU_CYCLES that kernel failed to open.
The sys_perf_event_open() syscall failed for event (CPU_CYCLES): Success
"dmesg | grep -i perf" may provide additional information.

Opening: OP_RETIRED
------------------------------------------------------------
perf_event_attr:
  type                             11 (armv8_pmuv3_1)
  size                             144
  config                           0x3a (op_retired)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
------------------------------------------------------------
evsel=OP_RETIRED (supported=1) leader=BR_MIS_PRED
leader->core.fd=0xaaab19edd950
broken group leader for OP_RETIRED
Warning:
skipping event OP_RETIRED that kernel failed to open.
The sys_perf_event_open() syscall failed for event (OP_RETIRED): Success
"dmesg | grep -i perf" may provide additional information.

Opening: BR_MIS_PRED
------------------------------------------------------------
perf_event_attr:
  type                             11 (armv8_pmuv3_1)
  size                             144
  config                           0x10 (br_mis_pred)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
------------------------------------------------------------
evsel=BR_MIS_PRED (supported=1) leader=STALL_SLOT_BACKEND
leader->core.fd=(nil)
perf: util/evsel.c:2156: get_group_fd: Assertion `!(!leader->core.fd)' failed.
