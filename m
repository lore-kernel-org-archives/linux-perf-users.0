Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EBD381C4;
	Tue,  6 Aug 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959824; cv=none; b=LRLjY6SML3bwetzrVqDFu24XHTNg5kS0dkyO4dlEHBpHwU9BsyaVyoQ3pTI3eNsA7TXjkKdqXRK+eGHLQh3aEuk+KrxS5ZqY2vre+4bvOhZcXnjfxpHDVuUJjAO1ln8/oZEkpV16m2+/yDb28TsI8S+eeqEpBhZfp+yhknN3AXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959824; c=relaxed/simple;
	bh=AS5PfC6by2nm7spHtlLT7YHpaxQkrSqjN6YHAGpTVQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NHqhI7pu6Kg5KXiTGtNJWZc8I1/EC45Gj7WJWN19SVBGVGkakgrWcBFEjzcToG6DPDdaLAt/ShKsmszTh7tD59z2PThH/zcgefADNb4QTVMcC37X24pzrPxaU+KhI8TLfYP8z23oWXb4gPGW/gAoXIa/plXU9C8o4gmcp0Fn0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7S3h3uC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7S3h3uC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722959823; x=1754495823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AS5PfC6by2nm7spHtlLT7YHpaxQkrSqjN6YHAGpTVQE=;
  b=X7S3h3uC9Oq1Q3g3y9Hl/r11v4xTg/nMrWXcoVI0JTJ7Iqbz+HEL8CEW
   1RGrRb/1IkiW/cp89DYzdmmkRF/Kxqvy4SJyXEirPg0Apg8/Tv0ZckgS+
   lQ8UUBZU0wovPEwmf+SYqgjrzqXncdjGjjEnOwRV/gzacCq/Y0eYfe8zy
   odpxXiCNqFLJ3nvNZjW7rsOMwAwkwhKrwdfQi0LN3hgBtj7/M1oSp9s5X
   2Qdxcsg65u0MTiuym4PtHNGfWmOGT6Svsfm/Zj1GBi/+ymn/Mxmey06gH
   3zIcSWXqXtIk1DIgjQbu5ozJEPO6rJqIcgjnQ9B+YPzHBkUDzLBCwP6pg
   Q==;
X-CSE-ConnectionGUID: 1GYuL+t8ROGGHjEPm+8ieQ==
X-CSE-MsgGUID: Nk3m5FQdR0OtN1M4r7O0xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="43514049"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="43514049"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:55:34 -0700
X-CSE-ConnectionGUID: cmfVOcvZTraHDGemzaHcLg==
X-CSE-MsgGUID: 9fqnnbmsShKYw1UgKumG4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56631058"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.248.17])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:55:28 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V11 00/10] perf/core: Add ability for an event to "pause" or "resume" AUX area tracing
Date: Tue,  6 Aug 2024 18:55:04 +0300
Message-Id: <20240806155514.17900-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi

Note for V11:
	Moving aux_paused into a union within struct hw_perf_event caused
	a regression because aux_paused was being written unconditionally
	even though it is valid only for AUX (e.g. Intel PT) PMUs.
	That is fixed in V11.

Hardware traces, such as instruction traces, can produce a vast amount of
trace data, so being able to reduce tracing to more specific circumstances
can be useful.

The ability to pause or resume tracing when another event happens, can do
that.

These patches add such a facilty and show how it would work for Intel
Processor Trace.

Maintainers of other AUX area tracing implementations are requested to
consider if this is something they might employ and then whether or not
the ABI would work for them.  Note, thank you to James Clark (ARM) for
evaluating the API for Coresight.  Suzuki K Poulose (ARM) also responded
positively to the RFC.

Changes to perf tools are now (since V4) fleshed out.

Please note, Intel® Architecture Instruction Set Extensions and Future
Features Programming Reference March 2024 319433-052, currently:

	https://cdrdv2.intel.com/v1/dl/getContent/671368

introduces hardware pause / resume for Intel PT in a feature named
Intel PT Trigger Tracing.

For that more fields in perf_event_attr will be necessary.  The main
differences are:
	- it can be applied not just to overflows, but optionally to
	every event
	- a packet is emitted into the trace, optionally with IP
	information
	- no PMI
	- works with PMC and DR (breakpoint) events only

Here are the proposed additions to perf_event_attr, please comment:

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 0c557f0a17b3..05dcc43f11bb 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -369,6 +369,22 @@ enum perf_event_read_format {
 	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
+enum {
+	PERF_AUX_ACTION_START_PAUSED		=   1U << 0,
+	PERF_AUX_ACTION_PAUSE			=   1U << 1,
+	PERF_AUX_ACTION_RESUME			=   1U << 2,
+	PERF_AUX_ACTION_EMIT			=   1U << 3,
+	PERF_AUX_ACTION_NR			= 0x1f << 4,
+	PERF_AUX_ACTION_NO_IP			=   1U << 9,
+	PERF_AUX_ACTION_PAUSE_ON_EVT		=   1U << 10,
+	PERF_AUX_ACTION_RESUME_ON_EVT		=   1U << 11,
+	PERF_AUX_ACTION_EMIT_ON_EVT		=   1U << 12,
+	PERF_AUX_ACTION_NR_ON_EVT		= 0x1f << 13,
+	PERF_AUX_ACTION_NO_IP_ON_EVT		=   1U << 18,
+	PERF_AUX_ACTION_MASK			= ~PERF_AUX_ACTION_START_PAUSED,
+	PERF_AUX_PAUSE_RESUME_MASK		= PERF_AUX_ACTION_PAUSE | PERF_AUX_ACTION_RESUME,
+};
+
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
 #define PERF_ATTR_SIZE_VER1	72	/* add: config2 */
 #define PERF_ATTR_SIZE_VER2	80	/* add: branch_sample_type */
@@ -515,10 +531,19 @@ struct perf_event_attr {
 	union {
 		__u32	aux_action;
 		struct {
-			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
-				aux_pause        :  1, /* on overflow, pause AUX area tracing */
-				aux_resume       :  1, /* on overflow, resume AUX area tracing */
-				__reserved_3     : 29;
+			__u32	aux_start_paused  :  1, /* start AUX area tracing paused */
+				aux_pause         :  1, /* on overflow, pause AUX area tracing */
+				aux_resume        :  1, /* on overflow, resume AUX area tracing */
+				aux_emit          :  1, /* generate AUX records instead of events */
+				aux_nr            :  5, /* AUX area tracing reference number */
+				aux_no_ip         :  1, /* suppress IP in AUX records */
+				/* Following apply to event occurrence not overflows */
+				aux_pause_on_evt  :  1, /* on event, pause AUX area tracing */
+				aux_resume_on_evt :  1, /* on event, resume AUX area tracing */
+				aux_emit_on_evt   :  1, /* generate AUX records instead of events */
+				aux_nr_on_evt     :  5, /* AUX area tracing reference number */
+				aux_no_ip_on_evt  :  1, /* suppress IP in AUX records */
+				__reserved_3      : 13;
 		};
 	};


Changes in V11:
      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Make assignment to event->hw.aux_paused conditional on
	(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE).

      perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
	Remove definition of has_aux_action() because it has
	already been added as an inline function.

      perf/x86/intel/pt: Fix sampling synchronization
      perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
      perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
	Dropped because they have already been applied

Changes in V10:
      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Move aux_paused into a union within struct hw_perf_event.
	Additional comment wrt PERF_EF_PAUSE/PERF_EF_RESUME.
	Factor out has_aux_action() as an inline function.
	Use scoped_guard for irqsave.
	Move calls of perf_event_aux_pause() from __perf_event_output()
	to __perf_event_overflow().

Changes in V9:
      perf/x86/intel/pt: Fix sampling synchronization
	New patch

      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Move aux_paused to struct hw_perf_event

      perf/x86/intel/pt: Add support for pause / resume
	Add more comments and barriers for resume_allowed and
	pause_allowed
	Always use WRITE_ONCE with resume_allowed


Changes in V8:

      perf tools: Parse aux-action
	Fix clang warning:
	     util/auxtrace.c:821:7: error: missing field 'aux_action' initializer [-Werror,-Wmissing-field-initializers]
	     821 |         {NULL},
	         |              ^

Changes in V7:

	Add Andi's Reviewed-by for patches 2-12
	Re-base

Changes in V6:

      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Removed READ/WRITE_ONCE from __perf_event_aux_pause()
	Expanded comment about guarding against NMI

Changes in V5:

    perf/core: Add aux_pause, aux_resume, aux_start_paused
	Added James' Ack

    perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
	New patch

    perf tools
	Added Ian's Ack

Changes in V4:

    perf/core: Add aux_pause, aux_resume, aux_start_paused
	Rename aux_output_cfg -> aux_action
	Reorder aux_action bits from:
		aux_pause, aux_resume, aux_start_paused
	to:
		aux_start_paused, aux_pause, aux_resume
	Fix aux_action bits __u64 -> __u32

    coresight: Have a stab at support for pause / resume
	Dropped

    perf tools
	All new patches

Changes in RFC V3:

    coresight: Have a stab at support for pause / resume
	'mode' -> 'flags' so it at least compiles

Changes in RFC V2:

	Use ->stop() / ->start() instead of ->pause_resume()
	Move aux_start_paused bit into aux_output_cfg
	Tighten up when Intel PT pause / resume is allowed
	Add an example of how it might work for CoreSight


Adrian Hunter (10):
      perf/core: Add aux_pause, aux_resume, aux_start_paused
      perf/x86/intel/pt: Add support for pause / resume
      perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
      perf tools: Add aux_start_paused, aux_pause and aux_resume
      perf tools: Add aux-action config term
      perf tools: Parse aux-action
      perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
      perf intel-pt: Improve man page format
      perf intel-pt: Add documentation for pause / resume
      perf intel-pt: Add a test for pause / resume

 arch/x86/events/intel/core.c               |   4 +-
 arch/x86/events/intel/pt.c                 |  69 +++-
 arch/x86/events/intel/pt.h                 |   4 +
 include/linux/perf_event.h                 |  28 ++
 include/uapi/linux/perf_event.h            |  11 +-
 kernel/events/core.c                       |  72 +++-
 kernel/events/internal.h                   |   1 +
 tools/include/uapi/linux/perf_event.h      |  11 +-
 tools/perf/Documentation/perf-intel-pt.txt | 596 ++++++++++++++++++-----------
 tools/perf/Documentation/perf-record.txt   |   4 +
 tools/perf/builtin-record.c                |   4 +-
 tools/perf/tests/shell/test_intel_pt.sh    |  28 ++
 tools/perf/util/auxtrace.c                 |  67 +++-
 tools/perf/util/auxtrace.h                 |   6 +-
 tools/perf/util/evsel.c                    |  13 +-
 tools/perf/util/evsel.h                    |   1 +
 tools/perf/util/evsel_config.h             |   1 +
 tools/perf/util/parse-events.c             |  10 +
 tools/perf/util/parse-events.h             |   1 +
 tools/perf/util/parse-events.l             |   1 +
 tools/perf/util/perf_event_attr_fprintf.c  |   3 +
 tools/perf/util/pmu.c                      |   1 +
 22 files changed, 698 insertions(+), 238 deletions(-)


Regards
Adrian
