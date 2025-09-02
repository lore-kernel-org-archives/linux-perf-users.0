Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495C2DCF70;
	Tue,  2 Sep 2025 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831291; cv=none; b=Mf9DVWgmwHC0h8BjhX7KPXBLpvl6vMiZU0wyPsIbTyEBhq4qAEnRodXJUMvoE8kuGQPKX4JczbNkM4PmB7DkHFhuOduebNIxccvTtScOq/p8C4hi8JIbQzoYwUfNMH0UfbYxbBawVyoH4+sR4taijMYtzhprvWzgOVlR/hi9W7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831291; c=relaxed/simple;
	bh=3gFsUEU4Xg6d5vQrEOsWIkbWaaUZWsSenDNCYqPYVT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZRxYfR6uVp47ovOzUUGzOTXg876DGPGdjSIk/L8yQC6YD+sHH4VdDof3dGCSLEo75sipkcvphOb2vvPSQmkcbk7o/49BeIWX6/3whNEYsvXtnjZuaEnsV+KB4VXuX3v9moInpZtW8sdSDDRYUro8thOHb9mj1xZrj9OSAg9pauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D517tg33; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D517tg33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756831290; x=1788367290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3gFsUEU4Xg6d5vQrEOsWIkbWaaUZWsSenDNCYqPYVT0=;
  b=D517tg334PDkFPvcavn3qYhctr95hZ7N3UD/koZJXAFzL75QQfuxiIFa
   Tt+0zBl1KdInl/hOBfMYFiFFxnLoRxTIIQFFWx/2ikgwHMlsx8QJY0pzU
   vSOywmLV09YAAzXO1cseeZyATFZm8yHuV6pRPuXcCbIGTtHlo392sgYkd
   lJ40LP70zxu9Q/kF9ci8lEK6TpYvBdIliBx+SpnXI90Q/5bAbH4iG5EY+
   8IIcnm/WHFK9ZnwhIQgJJJgbajUrJH1sL2S8u2Ygm+R87O6TffpGHrtwE
   YIq8+9s5TvlMmIukL1YEz1iFaUNgdQ3h7UqvNsngsqTqEOAAs3s+KjLP6
   Q==;
X-CSE-ConnectionGUID: 5UPo3Ay9Tou9fRyo7ZWaMA==
X-CSE-MsgGUID: DUaCRHddS8GopMlIpbtZoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81701738"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81701738"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:41:29 -0700
X-CSE-ConnectionGUID: rjdJSP3NSD2jg5TP84/8Vg==
X-CSE-MsgGUID: 4+9ExmX/TsuLIuBTo5FHFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="208527161"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.125.109.212])
  by orviesa001.jf.intel.com with ESMTP; 02 Sep 2025 09:41:27 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
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
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for auto counter reload
Date: Tue,  2 Sep 2025 11:40:44 -0500
Message-ID: <20250902164047.64261-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Changes in v2 (mostly suggested by Ian Rogers):

-- Add documentation explaining acr_mask bitmask used by ACR
-- Move ACR specific implementation to arch/x86/
-- Provide test cases for event parsing and perf record tests

Thomas Falcon (2):
  perf record: Add ratio-to-prev term
  perf record: add auto counter reload parse and regression tests

 tools/perf/Documentation/intel-acr.txt | 53 ++++++++++++++++++
 tools/perf/Documentation/perf-list.txt |  2 +
 tools/perf/arch/x86/util/evsel.c       | 53 ++++++++++++++++++
 tools/perf/tests/parse-events.c        | 54 ++++++++++++++++++
 tools/perf/tests/shell/record.sh       | 40 ++++++++++++++
 tools/perf/util/evsel.c                | 76 ++++++++++++++++++++++++++
 tools/perf/util/evsel.h                |  1 +
 tools/perf/util/evsel_config.h         |  1 +
 tools/perf/util/parse-events.c         | 22 ++++++++
 tools/perf/util/parse-events.h         |  3 +-
 tools/perf/util/parse-events.l         |  1 +
 tools/perf/util/pmu.c                  |  3 +-
 12 files changed, 307 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/Documentation/intel-acr.txt

-- 
2.50.1

