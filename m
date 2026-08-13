Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991347B41C
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627767; cv=none; b=i+XrbxcFLHanFyQOh9GNXqgT1+/bxFT2infJ55TXWZHGDlVhOh0fkOn1AoDitM7OaptkN+KcGtkXaqabRCrTeD6IP5KEKotFqzMsazZc5MHf6IYKEPY05qfaml2fFBiNW2MGmx4Lgh11VJy7mWiqGybJdk3PCHSzViwhRA9fMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627767; c=relaxed/simple;
	bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI0Qe3ak2myBYRPFW1hIdpH9hV11z2pM41vxQswBYm+WaDibhswHKEp2tc7dLYzQcrF4zyWmuC1klpkhYeWH5Csoh3D1TWISMd69Hj62QEugluBhMFlMo7ukoRz4TwVsFDSHAluQWb8MRlQsDiFpqxnfWMcQ0YBk7zyp/Ar/xMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmxjPk9j; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmxjPk9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786627766; x=1818163766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
  b=YmxjPk9jMGWFjRWdwk8i5NICLYia7DOq82npyERpm3QQH/xA43LuUeys
   9yadkOwQLji6z8UOVEdHUZtihgV1qSHu8mA5gfX1+zGM15Rbxj1C/WB/R
   Sui5TVH0EhsVqJYYz+lzOE1cPMcu6bXTCRH+aOCFVXT+nhEGEGSKFApLd
   CjZWeAo6KoC0P8QwuUG70U2lUL3YkwedCQqTgpm5JrNJFb8Lzcy2j9vwe
   6RntCP8AfxVfdXOIBQ+QqV+WDCSNWRr43t0aNUJOYNXe6ONbToxy8OpPV
   q1iEDbOmMW7DypBzG14T6Dgiwq+63akVrzxg6BuW1VOoyLo8aeTW85xqV
   A==;
X-CSE-ConnectionGUID: OtDFOcMdRaCdyGbJeHxFXQ==
X-CSE-MsgGUID: Qj/OB7PIRVKFZcP2qaczAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89720107"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="89720107"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 06:29:25 -0700
X-CSE-ConnectionGUID: HEMiLQzRR7m4s7Rr7KMTmw==
X-CSE-MsgGUID: IT8YBJODQ5O+qd+rb1bOAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="267455274"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 06:29:26 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 2/4] perf tools top: Add --weight option
Date: Thu, 13 Aug 2026 06:29:05 -0700
Message-ID: <20260813132907.50738-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813132907.50738-1-ak@linux.intel.com>
References: <20260813132907.50738-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a -W/--weight option to perf top to collect weights too. Useful with
follow on patches.

Assisted-by: omp:GPT-5.6-Luna
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-top.txt | 6 ++++++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index af3e4230c72f..2da2a16bbf26 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -25,6 +25,12 @@ OPTIONS
 --count=<count>::
 	Event period to sample.
 
+-W::
+--weight::
+Enable weighted sampling. One or more additional weights can be recorded per sample
+and can be displayed with the weight, weight2, weight3 and local_weight sort keys.
+Possible uses for weights are memory or instruction retirement latencies.
+
 -C <cpu-list>::
 --cpu=<cpu>::
 Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 570410599f1b..2888ac3b7b92 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1493,6 +1493,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
 		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
+	OPT_BOOLEAN('W', "weight", &opts->sample_weight,
+		    "sample by weight (on special events only)"),
 	OPT_STRING('p', "pid", &target->pid, "pid",
 		    "profile events on existing process id"),
 	OPT_STRING('t', "tid", &target->tid, "tid",
-- 
2.55.0

