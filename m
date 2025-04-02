Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6023098D;
	Wed,  2 Apr 2025 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743566294; cv=none; b=TKYIIBFvehf9JDAQ1GnzKpN7LzS9y+k7H712Mwb1EBRWV0dLZmlKM5v6U9Zc0QotIut5psRjF4a1+X0JguSLABPxkHSoEIhge40uzxeiGfp2BRw4PxgdyjpFbcNOGEVNglLkXbjxQYR+W21ZsRculMEtpedErnCixnv96YyiZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743566294; c=relaxed/simple;
	bh=eBve3m1+iXUenIvEryfD971S58qgsjLVqfWCGwmSnfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ppWXp117A9GB0/Wzjt9jdFhRlhcgmec6sEGG7My6HMN/8N8yUGQ+OO8MwG83i0efbbqROsOpjxFTqwsQ0pKN5C2Mr+7VansD9e19quDoX+xPXn8Ab1YPFPJNY8J8APedQfQWEGYIaydt707dS2MedUwHB1kNF4+qKzyqze3my4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0hvL+fQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0hvL+fQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743566293; x=1775102293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eBve3m1+iXUenIvEryfD971S58qgsjLVqfWCGwmSnfc=;
  b=S0hvL+fQPjz/J+p4Lt/Z7iEQUltrlau0Fb9Yf6PtAflCbK/cFsUosfDj
   9i+4mv487R21r7xcGsdV7k6gOLsqbRT/bZI/sxjQ/YvWnN4WGk07kjrLP
   x4dGx1PYuPlrvwemDsGv+nhY+o1AzibrMPZuUF02o7m9TG5BCcul5nDm9
   XWNgdtrsZZ8UnyAYD2l0Xn2HZXU80PWpOgkGEM433XMiiY3BDrvGnx9Hd
   Ba4iYC9s+DvwkLMm9iMX0iNZ04nnPz/nYJLdBuvIXq8bIPGGowv0cPlox
   AXunGCEdNI4IxvisAPgopSOsTL7iimNB3KMQKfTv0lLpnlXFqC++k8gUi
   w==;
X-CSE-ConnectionGUID: NxizW64aRZ6dSQczr56PjA==
X-CSE-MsgGUID: Wnrqs27LTJWCtD12MhpSyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44804415"
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="44804415"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 20:58:12 -0700
X-CSE-ConnectionGUID: S5M2XaKtQEy1CoamwyhxOw==
X-CSE-MsgGUID: P6RCeMuaSACoQ7jLgC3LPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,295,1736841600"; 
   d="scan'208";a="126464354"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa010.jf.intel.com with ESMTP; 01 Apr 2025 20:58:09 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH] perf tools: Fix incorrect --user-regs comments
Date: Wed,  2 Apr 2025 08:21:06 +0000
Message-Id: <20250402082106.103318-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment of "--user-regs" option is not correct, fix it.

"on interrupt," -> "on user space,"

Fixes: 84c417422798 ("perf record: Support direct --user-regs arguments")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..f21b133691d7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3480,7 +3480,7 @@ static struct option __record_options[] = {
 		    "sample selected machine registers on interrupt,"
 		    " use '-I?' to list register names", parse_intr_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
-		    "sample selected machine registers on interrupt,"
+		    "sample selected machine registers on user space,"
 		    " use '--user-regs=?' to list register names", parse_user_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),

base-commit: 35d13f841a3d8159ef20d5e32a9ed3faa27875bc
-- 
2.40.1

