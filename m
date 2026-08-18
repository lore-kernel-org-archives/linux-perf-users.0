Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3A36493F
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094161; cv=none; b=tij18/NU22+jqh++pug37UPSskm4BJC5QUzVZM3yhyskDPwjdMxXUok8VbBaQEjj+40ocXkKH1J5I62vEFSKSBMWbALEFiaGNBVXu879pJOuunuihEMUriMGwSPL96t9V+ZNyswffTXk7RwDMJrs8Qn5PVzXr+9sDQx3yh5DAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094161; c=relaxed/simple;
	bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkdJjCNbU4YRMJAZgxR9nNqep+vnuqOnr4NX73+fTRg8sbh3ik+ArOH05AI5ntInhVwAJWaIm+EAk1iB/CHEyH7eWTrX8XAORIoZuf7PWvd6xwODKOdpXOxIeMxsmAAAQ7EwqmXee89jrPGg4B+8ofGpP6xwnBwHvsAGLBoOPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atZAkZRk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atZAkZRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787094159; x=1818630159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
  b=atZAkZRkoPkxFoVuHO6JLpx45uIS6Kszb6kPEPfMToxEle+drgsJoLJv
   G7oeaUEcSFOXLvxHW3AINUdhL4oFCxXhm/VhCgTT5xXexXZskITpalvOd
   m0+DNNYqPrKBRIpWgHWKz0zZ5ue7IAp5Vf61DH3wbrNVr49s/ZP8oSGlS
   9NcwgV9UtplUE7YztN8Fz/2x9P6FbDjtsZN3b5gcmb5DQVGk0RmiU+D5F
   Vy4IMKo46zBpOZDLXGIH55w16eRXPgfNMaDi3SBLNVGW2vCOhr7Jal9qf
   H8ikXzlAYnoWSrXtZbhRtCPcH2e+SZrCPvGI6etChXSpCQdYv2u/NYSIY
   A==;
X-CSE-ConnectionGUID: /L4nBzWDRhanSAeEiQoTTA==
X-CSE-MsgGUID: SFTnDu2WQfWmSC8QoKCzlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91409645"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91409645"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:02:34 -0700
X-CSE-ConnectionGUID: n6MiHNIsS+eDBzG6Z+m70A==
X-CSE-MsgGUID: brGvwFKQSReFx238zhQFyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264060586"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:02:34 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 2/4] perf tools top: Add --weight option
Date: Tue, 18 Aug 2026 16:01:06 -0700
Message-ID: <20260818230229.1491871-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818230229.1491871-1-ak@linux.intel.com>
References: <20260818230229.1491871-1-ak@linux.intel.com>
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

