Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44440F73A;
	Fri, 21 Aug 2026 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291367; cv=none; b=RKy+RBEZohXuGjhnPgO1LXUbC2GWDofknWu10FuKkgRbGtTMGlM5akkqgH4aQSSs7nVxF3Um/XHbfDuDWtLsehbYpGBv0OQVjb1qrHDWmAip2G21VghI2kbO+DQJJtR35Gnno9wX928vXGDOSlh1DqahXNdvV7gmQUKtdHCwCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291367; c=relaxed/simple;
	bh=oX/8+86+vsLtFdyfjC5kn7Rey0KOuQDFmdEPdCWiYjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8EC39aqZUOaE9rFqV+d5gqzrRZjoq+6nQrd1ThvPMn5uP3yihrGm7EA4ZNyAw/dHSlnnmX13SPKePwULs5Xsl6hlFC8eyASSyXRo8iOqIvN8uO0WtER20ZSLiSaohTHE9ng7ArfuP8xS5fCcElBvcnNB4/80zrIHRqwMYGep58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BH7kdtXI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BH7kdtXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787291366; x=1818827366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oX/8+86+vsLtFdyfjC5kn7Rey0KOuQDFmdEPdCWiYjk=;
  b=BH7kdtXIQm7cqmrjg2fQCblq2a7KCwFXszLFc+gvLxfmHQlb8VHJ2DNS
   eyV1okABDBQj8J1QjUR/FS7QR+PI4lqTsPjRonTn9J6EYtjg28SX/Gq5m
   HcQTiepaitrrIcfrdMHdUYLBAwRhnPfjsC1ERbWCR+vRsbcLrZu7ruWha
   BsJ2lDUMVk3zvxjm1+YnGLHsinqdrhgVnS7TRJEB1AJAv4bbKrQhnG8Zp
   JR7/+dqPOzTL9tuVpZqNfr/CNtmnBRrXHJwJv1tQVFJHheKQ7lMHR9gnt
   wtCAE2nne7YKkLI4X037RBQOJBoZecJ+IuuNfMjk3yg0cJhp18FzlbQ62
   g==;
X-CSE-ConnectionGUID: IJUsqfTKTtaGWS57Afqj5A==
X-CSE-MsgGUID: STuzuPpYTwKOO+Qshq2szQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87691961"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87691961"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 22:49:25 -0700
X-CSE-ConnectionGUID: RT87H+5QQfOzXEO6eQZpRw==
X-CSE-MsgGUID: fFHl7zGzSoSyTkRDeOCSng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="270476164"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa005.jf.intel.com with ESMTP; 20 Aug 2026 22:49:22 -0700
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
Subject: [PATCH 2/4] perf tests c2c: Report skip when the workload fails
Date: Fri, 21 Aug 2026 13:56:09 +0800
Message-ID: <7d472dc1b51dbdbf68254535d608c4fb24b75274.1787283281.git.jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787283281.git.jiebin.sun@intel.com>
References: <cover.1787283281.git.jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The workload path leaves err at 0 and returns, so the test exits 0 and is
reported as a pass even though nothing was recorded and neither report
invocation ran. The check_c2c_support() path above it already sets err=2.

Set err=2 there as well so a failing workload is reported as a skip.

Fixes: ac881007c4bf ("perf tests c2c: Add a basic c2c")
Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/tests/shell/c2c.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/c2c.sh b/tools/perf/tests/shell/c2c.sh
index 2471d44595c3..f5f223cbf9cc 100755
--- a/tools/perf/tests/shell/c2c.sh
+++ b/tools/perf/tests/shell/c2c.sh
@@ -39,6 +39,7 @@ test_c2c_record_report() {
 	# Run a workload that does some memory operations.
 	if ! perf c2c record -o "${perfdata}" -- perf test -w datasym 1 > /dev/null 2>&1 ; then
 		echo "c2c record and report test [Skipped: perf c2c record failed during workload]"
+		err=2
 		return
 	fi
 
-- 
2.52.0

