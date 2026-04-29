Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C88378D63;
	Wed, 29 Apr 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476567; cv=none; b=qUrccemFOrseYAM3JkJp+oJW2ngnKN7xTmkgd4n+XiRiJyqbv+WlsYygFSYDMjQEjONNU5f1wIFgs0dKo3lLwTbkSp3uCzgNxetc5K9m+duygkNUZm9ipj/s39PLapfatybcRdHW4wxWj8+2HK8rmL+KphifS53pGzcgP3uy3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476567; c=relaxed/simple;
	bh=JF/G830fxLsfhmVVCYFKHCOVvHpCJS410qYpqkz5oiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmhjx4Ja3j+4ZVFsv7xCyV0mkDrAjSY3tVDXt6YeecXoe4y5PvPPgpd8DtLr/cBGraxufXzzCFMX5OunZAGW4uaKX8z9WET232etUwqmK3AnI7h1L25YneXB0/6Ix5uOkORkJP3PKqZjr07NcYABeQ/hGkgCCoxorOwEhIrF9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyAzBy7U; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyAzBy7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777476564; x=1809012564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JF/G830fxLsfhmVVCYFKHCOVvHpCJS410qYpqkz5oiM=;
  b=gyAzBy7URHF+Gqp9zJadYbkTPnCJ0fL7s+U8BTBTSsPqYW15TgVT6DG2
   9p6fpfNaF2Nwfevcci+y3f7asdIET4xazkgEY6BnLq68MLuNVU8JDk0CM
   JWWDVRfXcIOIPeErKLtTkyGuOXk+HXiNbMO86yWpKX+QhlUlcN0uIDOO+
   46CPqIYlvSFAxlPrW+E/mna3eCVGfI9pg8M39b1VPTTFn0uoKkX92jXdE
   SYt5m3Fwg/9+LSO14+sY7eePkHTd39H9QJ9xmOqQGSgWw5dzIDEeyz3s/
   61ivOOanzZAMASXST6D+cUEksdnJpjTPItjYNHQiJff87n1cq1FXoVh+p
   A==;
X-CSE-ConnectionGUID: qCUGiLT8RD+SbGeflPuVNQ==
X-CSE-MsgGUID: JsL7TksFSWasAATZwRoidg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65937589"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="65937589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:29:24 -0700
X-CSE-ConnectionGUID: /UI1qD+XQ0iN+nA48FHpzw==
X-CSE-MsgGUID: E1nPzktpQQCx0adxMVYlcA==
X-ExtLoop1: 1
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.251])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:29:23 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 0/2 v2] perf: Fix missing branch counter information in script and annotate
Date: Wed, 29 Apr 2026 10:29:15 -0500
Message-ID: <20260429152917.178803-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues related to branch counter (br_cntr)
display in perf.

The first patch fixes a missing '+' indicator in 'perf script' output.
The '+' suffix is used to signal that event occurrences may have been
lost due to branch counter overflow.

The second patch fixes a regression in 'perf annotate' TUI mode where
the Branch Count column was never displayed. The check for whether to
enable branch counter display was performed before events were processed
and the counter data was populated, so the condition was never satisfied.
Moving the check to after event processing resolves this.

v2: Added a cover letter and expanded commit message for patch 1/2.
    Patch 2/2 was missing some conditional checks to enable branch counter
    display, which have been added back.
    

Dapeng Mi (1):
  perf script: Fix missing '+' indicator when branch counter reaches
    upper limit

Thomas Falcon (1):
  perf annotate: Fix missing branch counter column in TUI mode

 tools/perf/builtin-annotate.c | 9 +++++----
 tools/perf/builtin-script.c   | 8 ++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.43.0

