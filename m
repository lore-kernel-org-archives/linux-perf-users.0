Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A432C31C;
	Mon, 18 Aug 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537250; cv=none; b=WVe9XA2HJEnixOvbu6OmoDNZQ+pnwo7JaW777lXuqiOPEQJORJ1nF3IHCNRcTYuFKd3yAZEZNTmabkr5rApVwp12BTilAwL8d/B0GFvMNzhz6zT33+w246iAfJvlTTyoS8fBzLWx9KmNebjXWNddFDhosdpjhaje7buXQREjrgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537250; c=relaxed/simple;
	bh=3gFsUEU4Xg6d5vQrEOsWIkbWaaUZWsSenDNCYqPYVT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HaP5N1UNoXwPfkzxTEDDCl1EG6WYbR1t9fTwmc5xq3ixGsn0C9DBUiJD7dF/JAMRHx6mSOOravkJYIsXj2WlyjQ7MqFcDqHoGvfAbInyNDpaHRCFUp1qh6SH/m+2ucaDI7UgWrVIZrEFlecWxfuGjphv1XxtMzmY8Jc6smviq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLkCK1XA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLkCK1XA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755537248; x=1787073248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3gFsUEU4Xg6d5vQrEOsWIkbWaaUZWsSenDNCYqPYVT0=;
  b=NLkCK1XAHmrs+0V8CLEP2Z66YDwlwPZC37Q+2vBiqC/KW1aX6VO9s/kX
   lpB42nIRoOgV5vzKFzQw4LZOi4ZkevJ3uvXYbQXyQ1fB2oSkl1LI1lV+5
   urS+6Rzg8ZJOFRoX9yxUh/LsSupfhZdSgOilziBk9vNSxEuY5WKVi56jY
   zc88vAAFZQx3ypF0nA1tkMdFneUylDb1tF2N4DyA6enCKcMFpH+KNvF95
   pSr4cPJ+u+5PDAmAR4KA02KdYDdB+esLqZ0ixcQ5G3D4J8yKCRYakLv16
   dx6Z92RiiWyt5sjDYUfdw5rar1SDKTkadD+q/gYfAPG79591klLhc+tst
   A==;
X-CSE-ConnectionGUID: yXDH3U5bRM2oFuIxt/urIg==
X-CSE-MsgGUID: 7pIGm8IeRQaYbnm+tHfPQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="80350256"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="80350256"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:14:07 -0700
X-CSE-ConnectionGUID: C/Zab/TGSXOcxCABzElzAg==
X-CSE-MsgGUID: V/73e2sBSqGKpNOsAy5U9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167137036"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.125.108.14])
  by fmviesa007.fm.intel.com with ESMTP; 18 Aug 2025 10:14:06 -0700
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
	ak@linux.intel.com,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH v2 0/2] perf record: ratio-to-prev event term for auto counter reload
Date: Mon, 18 Aug 2025 12:13:53 -0500
Message-ID: <20250818171358.332331-1-thomas.falcon@intel.com>
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

