Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9B1258CD9;
	Fri, 13 Mar 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408095; cv=none; b=hHgMG5JoCQMijxre+4CPC+OwhUK6wOmu//q61roJd7D5/mfpa/LcvMfxQFO/raiwheWS5D6o+iKQltQMj66ld98/7DNXdHT65gUlb0e2SMuaeqF2TqX8V2E9MDM7yJEQZLxPLO5DAtmpBspEkr7G94KBYVWv07gmHVTeksWQ9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408095; c=relaxed/simple;
	bh=MI7PE3e7BiVGaw+ciIjjuK4WMYr1KDQSMRz/me7DxzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8utyBPaYyhzWNH+yV6xf/AsAyS+W89VwJ3CxsRK0UEf8cZRhdZ2mmQAtWO5PbXltGp9OzZMLFaoP0bkJvY1kI80d1izNlK42Ia+sSaf1BQ5+0jQynVWHZnSdLLCyaHh7ZDK8/dS8CT9TFFbCgL/Ams3ufdntM1QbGGZEOPyhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78D47497;
	Fri, 13 Mar 2026 06:21:27 -0700 (PDT)
Received: from e142892.manchester.arm.com (e142892.arm.com [10.33.8.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0E583F73B;
	Fri, 13 Mar 2026 06:21:31 -0700 (PDT)
From: Mike Leach <mike.leach@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	acme@kernel.org
Cc: suzuki.poulose@arm.com,
	leo.yan@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@redhat.com,
	namhyung@kernel.org,
	Mike Leach <mike.leach@arm.com>
Subject: [PATCH 0/2] perf: tools: cs-etm: Fixes for CoreSight debug dump
Date: Fri, 13 Mar 2026 13:21:27 +0000
Message-ID: <20260313132129.2743468-1-mike.leach@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf will output additional CoreSight debug information, from the
'perf report --dump' command, when the build option CSTRACE_RAW=1
is added to the usual CORESIGHT=1 at build time.

This additional information consists of raw trace data in the form of
CoreSight formatted trace frames. This is intended to be used to
investigate possible issues relating to trace data corruption,
trace hardware issues or problems with decode.

The CoreSight formatted trace frames are used when multiple ETMs trace
into an ETR, and not present when a single ETE traces into the TRBE.

When the build option is used and perf is used to dump an ETE/TRBE
generated buffer a segfault will occur in the OpenCSD library.

Patch 1 of this set removes the unnecessary call to print the raw trace
frames when not needed, and fixes the segfault where older versions
of OpenCSD are in use.

Patch 2 enhances the debug output to associate raw data with individual
packets, which means that raw data is now present for ETE and extended
for ETM.

OpenCSD is being fixed independently.

Mike Leach (2):
  perf: tools: cs-etm: Fix print issue for Coresight debug in ETE/TRBE
    trace
  perf: tools: cs-etm: Enhance raw Coresight trace debug display

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0

