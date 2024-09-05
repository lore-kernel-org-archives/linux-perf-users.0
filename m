Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD31A256C;
	Thu,  5 Sep 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556030; cv=none; b=oACIdIcIooqsaeTIZydQXqWE2ItK2udCEfhADOctNqZtCpCqP9bEXomuYajrv0cuwvsK6efw92o4hKggQ1EpP4qKwluhKuKSMREJUaHJ0v0sqi3JMjuMaeozQbIOzYbucTjb02KYStYLDoLvHJjOUHoX1WDfNJip99ypRayH5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556030; c=relaxed/simple;
	bh=4UT5AInsQW1sS/qN2j6pwHHHMLjkNlvDk41wgNg4MRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYrOiwgGSL6tbrfraUwD0Z8coixw4c7CxhPKScpjQ9M5Xtooo+rFg2wDLrTyw7GakfRSTNUktdGnWUFoS/3eH7x6fA0sKI04+H+bc8RR63ClfyZywfHDLqlIlSyw/pv6+uEke/dx9c409LTKUJgehNCbwlHBGOHbe48qX9443G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgTT5AAB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgTT5AAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725556030; x=1757092030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4UT5AInsQW1sS/qN2j6pwHHHMLjkNlvDk41wgNg4MRM=;
  b=YgTT5AABxJDrg01jcycDmlVy0Y9jSAgWF9Y5s4sDT3wWkoy6FXDiOLxj
   1Hthv7XAAvmdt9lyi2/J1z7mv1tk712Y/rvX01K76lyEHdHu2QY8XZh81
   bSWHUfKkuVkziU9Hs4YEdJJH/w50ktY3AU0ZB3VyEQRUloKljoslNivNE
   kk/omxAAzxUdyq0JdCcyIUlruEPEYlcodrBcMW54x4/z4NusRyurFiKKc
   g2otkCzhj7LAGtDLj7obRhehObfaX6SWFp2zqK2ku5HiRa58IjVr4ihA/
   mKVkp4o/Soo0g9I+hCAWEbVtF6BjSYEXQpuPzQ3UH0cOoVaoDCoiQHq9Q
   g==;
X-CSE-ConnectionGUID: bKbjp/7OSkOR6rPDTtXojw==
X-CSE-MsgGUID: wVHYBrgYRqy61Wolz86HqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="41769174"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="41769174"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:07:07 -0700
X-CSE-ConnectionGUID: +yZC9biNT++pQU8shpOSgQ==
X-CSE-MsgGUID: luS6SBb+QPi2J9RPgNZwNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70480528"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 05 Sep 2024 10:07:07 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org
Cc: irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/3] perf mem: Fix the wrong reference in parse_record_events
Date: Thu,  5 Sep 2024 10:07:37 -0700
Message-Id: <20240905170737.4070743-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240905170737.4070743-1-kan.liang@linux.intel.com>
References: <20240905170737.4070743-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

A segmentation fault can be triggered when running
perf mem record -e ldlat-loads

The commit 35b38a71c92f ("perf mem: Rework command option handling")
moves the OPT_CALLBACK of event from __cmd_record() to cmd_mem().
When invoking the __cmd_record(), the 'mem' has been referenced (&).
So the &mem passed into the parse_record_events() is a double
reference (&&) of the original struct perf_mem mem.
But in the cmd_mem(), the &mem is the single reference (&) of the
original struct perf_mem mem.

Fixes: 35b38a71c92f ("perf mem: Rework command option handling")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index ba1d37bfb916..2b28e356f963 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -47,7 +47,7 @@ struct perf_mem {
 static int parse_record_events(const struct option *opt,
 			       const char *str, int unset __maybe_unused)
 {
-	struct perf_mem *mem = *(struct perf_mem **)opt->value;
+	struct perf_mem *mem = (struct perf_mem *)opt->value;
 	struct perf_pmu *pmu;
 
 	pmu = perf_mem_events_find_pmu();
-- 
2.38.1

