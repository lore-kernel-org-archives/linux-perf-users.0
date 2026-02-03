Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2731D757;
	Tue,  3 Feb 2026 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086877; cv=none; b=ZK19jpusDl8CAwNMZxzhdbsKAOSGThUuwoRNfAMrOVX/feIK5cwrbWoNoCJ8A4yTJZ5WpuSKhvuf6qC/cJ+SqirpTGSt5iqOvu2rmUZiO+jEjGHwIU03fV3ppqPzdclEXnGBl91Uy9FSnS+BnEFNw8Rckn5gB94xkW+Ej8Nblbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086877; c=relaxed/simple;
	bh=ZFP9ftY8bSrq1v5fwO+CjAOG/yHX4OP7LEXkU9+oNBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXauIoKuXY3xE4lb2uKjMeg5U1AxZOP0K4E0NmlDoK/oEEtYTgUMQdoC6T8WCcN5T1W644dCt5FATSEEkLWp8lKZm6PORHtKZEZhz7T7JwU7QWQ75QysPu/uZEaGBt0A3MNhgr5C70v2sAUeEXf5mFOGLt36b/N+8DlHAqdp8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeAWeVU7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeAWeVU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770086876; x=1801622876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZFP9ftY8bSrq1v5fwO+CjAOG/yHX4OP7LEXkU9+oNBc=;
  b=HeAWeVU7mE68yqXLPx/FTfbEr/MCAuDngHt/SQQJOmGsDp+efF+2/oG8
   wX9jYbhMlv5EdhafhV0OpSBQIiAntqcEQwNitxAH6JdtfDPT1ZaN82UmR
   o4101GKT84eTPC/DEeFz3u2uSFmhBhwSDXhpRhV2K9H2mFgQVoK1MeU5H
   Hx6u+mTevJMJJ01v4w+6jMh/xWRa1e4wFpP90IlbmB5jb2LwGM26h0JML
   7GE4Sp4SgTfEraOsO7Ahi7iXGpftdYUxZ3HVWg5eYU36mhmjB6Y7WfhLx
   t4VVHsqbRedLPYigkd6Oxq9UKcZCDtYsc2OF+Y0hh59BPSB65frL5uK6v
   w==;
X-CSE-ConnectionGUID: iDxOXt0VTmaXClnMvWCq+Q==
X-CSE-MsgGUID: 2mKiW9qCTciHvk4FXKdfdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71152132"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71152132"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 18:47:56 -0800
X-CSE-ConnectionGUID: syzJ3XD/Q5We8vUakIh8vA==
X-CSE-MsgGUID: 3WNYg+RBRRe8if1tXYjtIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="208991715"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2026 18:47:50 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 1/4] perf regs: Fix abort for "-I" or "--user-regs" options
Date: Tue,  3 Feb 2026 10:43:53 +0800
Message-Id: <20260203024356.444942-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>
References: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue where the `perf` tool aborts unexpectedly when running the
following command:

```
perf record -e cycles -I -- true

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -I, --intr-regs[=<any register>]
    sample selected machine registers on interrupt, use '-I?' to list register names
```

The usage of the `-I` or `--user-regs` options without specifying any
registers should default to sampling all general-purpose registers.
However, this currently causes an abnormal termination.

The issue was introduced by commit 3d06db9bad1a ("perf regs: Refactor
 use of arch__sample_reg_masks() to perf_reg_name()"). This patch
resolves the problem, ensuring that the `-I` or `--user-regs` options
work as intended without causing an abort.

Fixes: 3d06db9bad1a ("perf regs: Refactor use of arch__sample_reg_masks() to perf_reg_name()")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/util/parse-regs-options.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index 8dd35f50f644..b44b47d9059f 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -66,12 +66,14 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (*mode)
 		return -1;
 
-	/* str may be NULL in case no arg is passed to -I */
-	if (!str)
-		return -1;
-
 	mask = intr ? arch__intr_reg_mask() : arch__user_reg_mask();
 
+	/* str may be NULL in case no arg is passed to -I */
+	if (!str) {
+		*mode = mask;
+		return 0;
+	}
+
 	/* because str is read-only */
 	s = os = strdup(str);
 	if (!s)
@@ -104,9 +106,6 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	}
 	ret = 0;
 
-	/* default to all possible regs */
-	if (*mode == 0)
-		*mode = mask;
 error:
 	free(os);
 	return ret;
-- 
2.34.1

