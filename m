Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99B9460;
	Tue, 10 Jun 2025 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749525152; cv=none; b=KTnzUc4hvKy5drfQE6iwCtC30OeDi7vqunvvl+0AFoKN85M6yrcKMqFksG0ELLeuFFAax8ViqtkPqY6b2Vc2O8hi06pJYBZfG9n7f8Psobk8O7S62dBI5n14GSUQu1GxdqVz5qasiFLqxoOb0SvcYO8mSqI3EGxZVDzYbDB8gtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749525152; c=relaxed/simple;
	bh=xHnU2CjunxIorLr6QXlY9QsZp21/qxWCAUjRaaR4xio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw2lOB3QtSEo/XpAQvyQGI8uBiQ+TvxqI7yfej3PiJgVB+8x+V7pVqaCMf6xbAuZf3Ko2gNeb+8CsddtZLKdrvOWp5zTWtsUNEkJgrivnmRX31MZVMu9Ez2Vdvjo+UmMCOs5lblUC8RvkSjBkznLia9d6Uur8HZEIMtmrj25ntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixiuxG5R; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixiuxG5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749525150; x=1781061150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xHnU2CjunxIorLr6QXlY9QsZp21/qxWCAUjRaaR4xio=;
  b=ixiuxG5Rlaud3udaOvXLSgEj1aFfAHHL82Mm0Ssud11LQrPkO1680TOd
   CeOskRRxq9NZxBTrisdhJ1yPsikiSiFd2KZw7GDQuQYLf70eCHKG96LYJ
   Axq5wfqa9HlcN3TwpNrLwkpM8qD6BngAuaw9XKzUjFfqYQBbnOgBintYt
   7wkULE6BcX4NW+RvUtfDOuc1kSdBMg3HESvOkP1ZLSI/lqPd/+FZNz2TI
   jOO65meuarX1v6m0gdcR9P0xVwVx2TdNZyLcRbKYHI1ABvworX5MSOxnG
   V2WGAws/ZnCfg0R94UZtpD8WkXVuYHEVViI7qdKYOlZoGWCO2wjXu8Me/
   Q==;
X-CSE-ConnectionGUID: 5qvoswDtQBKuCCHHeAsRcg==
X-CSE-MsgGUID: y79okzAaT0qLpjwVCQ4j+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62275086"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="62275086"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 20:12:29 -0700
X-CSE-ConnectionGUID: 0LY57rL4R0C+evgn+KxhLg==
X-CSE-MsgGUID: KLvAYz5FT6Oecl0q1iNoQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146612169"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jun 2025 20:12:22 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Read perf data file header from the file user specified with -i option for perf script flamegraph
Date: Tue, 10 Jun 2025 12:04:22 +0800
Message-ID: <20250610040536.2390060-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aEeIN_u4KpLZXDBx () google ! com>
References: <aEeIN_u4KpLZXDBx () google ! com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If specify the perf data file with -i option, the script will try to read the header information
regardless of the file name specified, instead it will try to access the perf.data. This simple
patch use the file name from -i option for command perf report --header-only to read the header.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 tools/perf/scripts/python/flamegraph.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index cf7ce8229a6c..4f82dfea0a70 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -123,7 +123,13 @@ class FlameGraphCLI:
             return ""
 
         try:
-            output = subprocess.check_output(["perf", "report", "--header-only"])
+            # if the file name other than perf.data is given,
+            # we read the header of that file
+            if self.args.input:
+                output = subprocess.check_output(["perf", "report", "--header-only", "-i", self.args.input])
+            else:
+                output = subprocess.check_output(["perf", "report", "--header-only"])
+
             return output.decode("utf-8")
         except Exception as err:  # pylint: disable=broad-except
             print("Error reading report header: {}".format(err), file=sys.stderr)
-- 
2.47.1

