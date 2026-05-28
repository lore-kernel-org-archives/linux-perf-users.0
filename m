Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB00305669;
	Thu, 28 May 2026 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982636; cv=none; b=JlqtLRls/b6Sh2VgoLtEqTlfC3JiZoz3yHJUKcsmWZSEo1uIxFE+BWVF0vELTcug08I5vQrrdFL9Gja5KtpEaxxYQQnzk0jDL0Oldf8L0Ocej0Xvq7Su1M+PKDvJp4UEVdwvHConQkn9MRqNIFo2SxuCaURjPCSrlurDBiowm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982636; c=relaxed/simple;
	bh=8a9ipCzfBHxerJ5WU9uJKon+vOj0S6KlZQBF9c8p2xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgcNbbyC1UA3Tg67N0bSuMTz5t53PbOkwSdSm8IwNxQHcLTDnd1fwrTNjjuMn3EzVeFaQNGhmQJRMVu4b0wy+QkhS3m5HYOmp6ouhg8213hY16uQF4AxkzQrFVhQCYkDtEjZtCjzeWTD+oLfzOxexpnOdZbAvCVnN1lYabWvtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpZwp35d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpZwp35d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779982636; x=1811518636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8a9ipCzfBHxerJ5WU9uJKon+vOj0S6KlZQBF9c8p2xk=;
  b=FpZwp35djWJGVAx1yucesEvV/7ID8hMurFWU+tcOHvm1nH7Od7iMJMvX
   GeNhnuU/IQCttRgBuGKDAe/TJZ89CuH6axk+xvYZXDcbppVUUUvvFquoe
   9bdjsGmAO8KpvQsaMUJjdjTjlI6l4Qu6pTs71Oh/vHo4NBVXwcu63OpPs
   dEZ0wC91SK4Z6pHJrNLcF0c+TR9KEl6K5ImJE349odkOPHT/VKZLk2foM
   AJMeKC4JNS5/+lyCjlrf2DZTHbPS/A8ugAvGUHoU/zwyT5vbPkR40iI3+
   CXqsNjQJ/7STlgQaXr4dClSyxO6Qt7hTED/EwpkNuNOlvBsXDE24MxYNE
   g==;
X-CSE-ConnectionGUID: jvrAyUVJRMykP7BIKVuylQ==
X-CSE-MsgGUID: IBPycOLmRKSPZ08sxhkbbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91396797"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="91396797"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:37:16 -0700
X-CSE-ConnectionGUID: zeaUwLPsSp6cwXh/ouLalA==
X-CSE-MsgGUID: +7e2JNMURHCFBXfZYzfbXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="236226855"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.220.237])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:37:12 -0700
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
Subject: [PATCH v3 0/2] perf: Fix missing branch counter information in script and annotate
Date: Thu, 28 May 2026 10:36:35 -0500
Message-ID: <20260528153637.300213-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues related to branch counter display in perf.

The first patch fixes a missing '+' indicator in 'perf script' output.
The '+' suffix is used to signal that event occurrences may have been
lost due to branch counter overflow.

The second patch fixes a regression in 'perf annotate' TUI mode where
the Branch Count column was never displayed. The check for whether to
enable branch counter display was performed before events were processed
and the counter data were populated, so the condition was never satisfied.
Determine whether to display the branch counter column after processing
events and populating counter data.

v3: For patch 1/2, guarded against printing a spurious '+' if the branch
    counter width is zero, reported by sashiko
v2: Added a cover letter and expanded commit message for patch 1/2.
    Patch 2/2 was missing some conditional checks to enable branch counter
    display, which have been added back.

Dapeng Mi (1):
  perf script: Fix missing '+' indicator when branch counter reaches
    upper limit

Thomas Falcon (1):
  perf/annotate: Fix missing branch counter column in TUI mode

 tools/perf/builtin-annotate.c | 9 +++++----
 tools/perf/builtin-script.c   | 8 ++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.43.0

