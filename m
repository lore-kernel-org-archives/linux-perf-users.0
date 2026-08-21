Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61853EB11E;
	Fri, 21 Aug 2026 05:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291361; cv=none; b=V4QheI7tR+CJ+C7O1suoUuAwaaB9F88NK3WOLLGVzB1fV5SNYIVzZ5GjxDSvkVgIeCpjFIVCx/MpR0UV3xeKGLC5vAw3oFHsiOVinGzDdIHe6Tjwest0mtxKNlm2wBNY1FSk1Wpcxqra7jDzKRuEB0T2aY8TztzhjMNgAuwdZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291361; c=relaxed/simple;
	bh=nYPxjXPhHn6lktYsyJPspPwHds7w40xj6GN61WG5GuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDuNwDkRGH1xvlfkqyREu6SQALPjTmkOmHibws7J5yzo9YUjLfPThq4SAReQXNIuPZICCeR36Z9tycnm/Bb2Zpz94nhLG2r621W5Ugq9lowsKL8IYl77VHpATmjgAsxQOLf09SeEMhR/W0flagArM/uTV3Y8w2Ct4Cvyu1LQekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eP8sur+y; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eP8sur+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787291359; x=1818827359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nYPxjXPhHn6lktYsyJPspPwHds7w40xj6GN61WG5GuI=;
  b=eP8sur+yf9BssAkUwAXTqYJeJW274I1xeHGHL+WsMwITJMQr9gpDSTNB
   zcWEG6Tlzo+Q/h5AcaTtJT3PMJItIbivrCoEZ/0W7RqUilQZUfjHS0ySD
   xs6yv+fM0vwvQ+6li9CoKJ5b8ptoh7ln/tc+bXto6fbvM9WYT64+Z4hUy
   nBNrHFioXESODX0kFCs1Ci7ig8LRZPO5WWBSc+mPSHNFdhjA6dQvNvp6J
   Z++IT80fNEmtu44T5kehZsU6nfaeO9J2VK9rx9H+dET1eSBihqwfg57np
   eu4V6ArDhu28aSunuIayycTqPh/5+vqEzI79QuMBjleh1I5dpOsHsOac3
   Q==;
X-CSE-ConnectionGUID: bX6i2Uc1SE6WM8nQl9hEqQ==
X-CSE-MsgGUID: FmsV3bs7Q9S0M9OrGvdzlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87691945"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87691945"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 22:49:18 -0700
X-CSE-ConnectionGUID: DiawSgRmQn22UYyNnwp7vw==
X-CSE-MsgGUID: ybX/s1EyR4qEGKDPJ5lkmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="270476126"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa005.jf.intel.com with ESMTP; 20 Aug 2026 22:49:15 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	jiebin.sun@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] perf c2c: Add function-view stdio support and coverage
Date: Fri, 21 Aug 2026 13:56:07 +0800
Message-ID: <cover.1787283281.git.jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recently merged function-view series added an interactive TUI for
examining the c2c data as:

  read-side function -> contending writer -> shared cacheline

This follow-up makes the same view available to builds without SLANG and
to pipes and scripts. `perf c2c report --function` now implies stdio and
prints the three-level hierarchy fully expanded. It requires `iaddr` in
the coalescing fields and is rejected together with `--stats`.

The first two patches fix adjacent pre-existing issues: the documented
default coalesce fields are stale, and a workload recording failure in
the existing c2c shell test is incorrectly reported as a pass. The third
patch adds the stdio function view, and the final patch adds automated
coverage using a separate contended futex workload. Systems that record
no contended samples report a skip for the hierarchy checks rather than a
spurious failure.

This series follows the function-view work merged from:

  https://lore.kernel.org/linux-perf-users/20260817094623.3288456-1-jiebin.sun@intel.com/

The series is based on perf-tools-next commit 9453bc6a69ef ("perf vendor
events arm64: Fix Tegra410 Olympus event 0x0197").

Tested with:

  - SLANG and NO_SLANG=1 builds
  - perf test c2c
  - perf test 'import perf'
  - checkpatch.pl --strict on each patch
  - unresolved-symbol checks on the Python perf module

Jiebin Sun (4):
  perf c2c: Fix documented default coalesce fields
  perf tests c2c: Report skip when the workload fails
  perf c2c: Add stdio support for the function view
  perf tests c2c: Add function view stdio coverage

 tools/perf/Documentation/perf-c2c.txt |  14 +++-
 tools/perf/builtin-c2c.c              |  85 +++++++++++++++++--
 tools/perf/tests/shell/c2c.sh         | 114 ++++++++++++++++++++++++++
 tools/perf/util/c2c-function.c        |   9 +-
 tools/perf/util/c2c.h                 |   1 +
 5 files changed, 205 insertions(+), 18 deletions(-)


base-commit: 9453bc6a69ef43755f1c28d5688cacdd69fa16bd
-- 
2.52.0
