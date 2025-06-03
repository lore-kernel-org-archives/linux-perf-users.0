Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5E26AD9;
	Tue,  3 Jun 2025 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931457; cv=none; b=bg0dBedv4sOYQ7tXn1qj/Lyd3GYhmJ3jRrxqlUDpuqAWr6DkwF/y7kW8mW8G0jG8w4lv02j4uZsyOg8SKnAt11z7s31uAHpZxXD4IhaxVPP5Ukdk1H2/jPsivMWcLkIObqkWLdKEMDvQtDAraopeHMfbTc91B4/9FSJ/EkiwPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931457; c=relaxed/simple;
	bh=ktVyNmKC36IoJfDT1n47jZdc8uH8RN0+HUXL0beA/Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYoA4R2VCsjylzZQ3xL3Y4V4KJGMUCIXyGrAi4Pp7yFvS4rclFX9amFP0pSXvKR9yrikQmNitLFHLZ/B/uzZz3pE4AdWt2ccrCa7qAZjXW8apD/JBl5t/4d3oP89AIaqtPOjLrvvN7FttAlkogUyZ/UxCsFd4VFc6WciU6enE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiSUL1+e; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiSUL1+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748931456; x=1780467456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ktVyNmKC36IoJfDT1n47jZdc8uH8RN0+HUXL0beA/Us=;
  b=fiSUL1+eH4qWlwroz1lYFuMC4xaX2QPXyKfeAHbJVQfA7/Xk3SUdbbi1
   QPJCSb8J/Ihh/JVjy/JdhiebN0nxwM86+QlIUXVgiL+ZKNMW8bBktjD5a
   QGLJRas6XaNKTlgpPmzFrBIk5vBZZBMcEtACVCcDRcQKecjfnMY6ijdSA
   jzJzUbD/g5dS+HlAQpaJEMVz5+6qVr7ujRkoUpvz9xtDT537iAiFGGM9F
   Lt7u/kTV8D9v/iRyxuCkqq24z3cbd0/gHPEWaut6JuhUPulLZLKtxNXgc
   KOLGYa0gGURE3BE5cWwqOKMZ6hR8hz83bEYmr15mwmo8O7pIRtKTNkRkD
   A==;
X-CSE-ConnectionGUID: C39ryNPkSTm1DjihhwnoXg==
X-CSE-MsgGUID: cq0GflALQNq2Gcrm8zkF7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51101230"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="51101230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 23:17:36 -0700
X-CSE-ConnectionGUID: iqjzXgopRDis4cHMswXQlQ==
X-CSE-MsgGUID: HmtBv1OfR6eADbm4x8woXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="144638834"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa006.fm.intel.com with ESMTP; 02 Jun 2025 23:17:31 -0700
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
	pan.deng@intel.com,
	zhiguo.zhou@intel.com,
	tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Minor improvements for perf script flamegraph
Date: Tue,  3 Jun 2025 15:10:48 +0800
Message-ID: <20250603071048.180674-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing the perf data file generated with multiple events,
the flamegraph script will count all the events regardless of
different event names. If specify the perf data file with -i option,
the script will try to read the header information regardless of
the file name specified, instead it will try to access the perf.data.

This patch tries to add a -e option to specify the event name that
the flamegraph will be generated accordingly. If the -e option omitted,
the behavior remains unchanged. If the -i option specified, the header
information will be read from that file.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 tools/perf/scripts/python/flamegraph.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index cf7ce8229a..eb78b93925 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -94,6 +94,11 @@ class FlameGraphCLI:
         return child
 
     def process_event(self, event):
+        # ignore events where the event name does not match
+        # the one specified by the user
+        if self.args.event_name and event.get("ev_name") != self.args.event_name:
+            return
+
         pid = event.get("sample", {}).get("pid", 0)
         # event["dso"] sometimes contains /usr/lib/debug/lib/modules/*/vmlinux
         # for user-space processes; let's use pid for kernel or user-space distinction
@@ -123,8 +128,15 @@ class FlameGraphCLI:
             return ""
 
         try:
-            output = subprocess.check_output(["perf", "report", "--header-only"])
-            return output.decode("utf-8")
+            if self.args.input:
+                output = subprocess.check_output(["perf", "script", "--header-only", "-i", self.args.input])
+            else:
+                output = subprocess.check_output(["perf", "report", "--header-only"])
+
+            result = output.decode("utf-8")
+            if self.args.event_name:
+                result += "\nFocused event: " + self.args.event_name
+            return result
         except Exception as err:  # pylint: disable=broad-except
             print("Error reading report header: {}".format(err), file=sys.stderr)
             return ""
@@ -235,6 +247,11 @@ if __name__ == "__main__":
                         default=False,
                         action="store_true",
                         help="allow unprompted downloading of HTML template")
+    parser.add_argument("-e", "--event",
+                        default="",
+                        dest="event_name",
+                        type=str,
+                        help="specify the event to generate flamegraph for")
 
     cli_args = parser.parse_args()
     cli = FlameGraphCLI(cli_args)
-- 
2.43.5

