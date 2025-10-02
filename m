Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB742C0260;
	Thu,  2 Oct 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448611; cv=none; b=Z++LcNJHM3I9uEhxybtPFHZ+QysjaoqLFL7/RXx6xhiH6IWWBaXb2x1yax63mr6UiGCfBKyUTHKLii+o8mlaXEJ9HguY4NfXeeJfpSFIFv7eqBUgXibrnvAaLlg8LBqXqVTSts+ClnFGX/d1uwGgYKZqvfttBxmc/7X755k+rmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448611; c=relaxed/simple;
	bh=lYv98tEZDeXTfmFmqu18xtcmHIUbV2d/ZskYE0cZT8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JpyvWEhHm6vGwRZTvNEpUymNpGk+YUkQx1vRoxgCruiGCg//5gIQMVvwW8pVSK0AzbdpaL1esux6WA0n7Y9BAUAiEPVElHdVrQSWMYqGrdj35VaDuKE4Kk21YguccNK7ip8trlDfMZHvzWw/vTRxUCMHZL1SoODUMkp8L7+2S0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SD9zg56c; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SD9zg56c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759448609; x=1790984609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lYv98tEZDeXTfmFmqu18xtcmHIUbV2d/ZskYE0cZT8M=;
  b=SD9zg56cnfykZLr9D7q+z08Ik5CeHNLf4NueEXz0ashWMvEWOcXhCbo7
   s0/JMJHHlqqr720uVfeZWY/ZVSnhjIjZysJPQiUEtSwoMlYw47rq0PBaR
   0Vn+2mFhUuw8ZSPE75X40HjW68s8/1FPwuWVQZxIZ8XA/fzrxIrVrgJOV
   /uHxPYSoIR2GZ5FS681eueVgtoXWd+8evn+IGl4WO0bDwiwVdUDsJ7uYW
   G2+3Dhg8CJD7Q6v5Fs1RnwO/B4a4GCTTLh1tIVswUyu9WzS9XCneH1zWo
   qcOenD2Mqd1Ipb2yxeGkyp1qCpEOCCWlWBIZtIvN9CgQ4ZlOm/6g5H85H
   A==;
X-CSE-ConnectionGUID: sbwEHIN4SJ+SP+Xr2EZ2iA==
X-CSE-MsgGUID: DIfR4ZB2S7CTlwvUyKd2zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="60948387"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="60948387"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 16:43:28 -0700
X-CSE-ConnectionGUID: q8NQMeOAQ12a0jSMS8NB5A==
X-CSE-MsgGUID: uYS12Z8iRGKdPHZ+AYx7tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="178444531"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.53])
  by orviesa010.jf.intel.com with ESMTP; 02 Oct 2025 16:43:27 -0700
From: thomas.falcon@intel.com
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [Patch v3 0/2] perf record: ratio-to-prev event term for auto counter reload
Date: Thu,  2 Oct 2025 18:43:04 -0500
Message-ID: <20251002234308.64218-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Falcon <thomas.falcon@intel.com>

The Auto Counter Reload (ACR)[1] feature is used to track the
relative rates of two or more perf events, only sampling
when a given threshold is exceeded. This helps reduce overhead
and unnecessary samples. However, enabling this feature
currently requires setting two parameters:

 -- Event sampling period ("period")
 -- acr_mask, which determines which events get reloaded
    when the sample period is reached.

For example, in the following command:

perf record -e "{cpu_atom/branch-misses,period=200000,\
acr_mask=0x2/ppu,cpu_atom/branch-instructions,period=1000000,\
acr_mask=0x3/u}" -- ./mispredict

The goal is to limit event sampling to cases when the
branch miss rate exceeds 20%. If the branch instructions
sample period is exceeded first, both events are reloaded.
If branch misses exceed their threshold first, only the
second counter is reloaded, and a sample is taken.

To simplify this, provide a new “ratio-to-prev” event term
that works alongside the period event option or -c option.
This would allow users to specify the desired relative rate
between events as a ratio, making configuration more intuitive.

With this enhancement, the equivalent command would be:

perf record -e "{cpu_atom/branch-misses/ppu,\
cpu_atom/branch-instructions,period=1000000,ratio_to_prev=5/u}" \
-- ./mispredict

or

perf record -e "{cpu_atom/branch-misses/ppu,\
cpu_atom/branch-instructions,ratio-to-prev=5/u}" -c 1000000 \
-- ./mispredict

[1] https://lore.kernel.org/lkml/20250327195217.2683619-1-kan.liang@linux.intel.com/

v3: rebase to current perf-tools-next

v2: (changes below suggested by Ian Rogers):

-- Add documentation explaining acr_mask bitmask used by ACR
-- Move ACR specific implementation to arch/x86/
-- Provide test cases for event parsing and perf record tests

Thomas Falcon (2):
  perf record: Add ratio-to-prev term
  perf record: Add auto counter reload parse and regression tests

 tools/perf/Documentation/intel-acr.txt | 53 ++++++++++++++++++
 tools/perf/Documentation/perf-list.txt |  2 +
 tools/perf/arch/x86/util/evsel.c       | 52 ++++++++++++++++++
 tools/perf/tests/parse-events.c        | 54 ++++++++++++++++++
 tools/perf/tests/shell/record.sh       | 40 ++++++++++++++
 tools/perf/util/evsel.c                | 76 ++++++++++++++++++++++++++
 tools/perf/util/evsel.h                |  1 +
 tools/perf/util/evsel_config.h         |  1 +
 tools/perf/util/parse-events.c         | 22 ++++++++
 tools/perf/util/parse-events.h         |  3 +-
 tools/perf/util/parse-events.l         |  1 +
 tools/perf/util/pmu.c                  |  3 +-
 12 files changed, 306 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/Documentation/intel-acr.txt

-- 
2.50.1

