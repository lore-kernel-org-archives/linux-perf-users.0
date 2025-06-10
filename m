Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3736325C6E8;
	Tue, 10 Jun 2025 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749525154; cv=none; b=qq82OE9OJ5pWTaFbifPQZH4sZ0GjtH+AKizhIHoGqEtr2elPYakeH7S7vYwvZNy81S8cwrrkfNnDQwFbPpWVoo1oOuJl/MeSAp22jT4qOQ1uVqKhJrTXUSIYgtNtQibZ835GXs8//XwF6IxEbFWjMTQSf+4galZSgaiM5r3DPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749525154; c=relaxed/simple;
	bh=hdEOJ9xi2xPuUT61F+wjrk4pZZfYYi3asu9cjdOajF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwJX+A66LuAOf67INZd/2wCAqBPD9nlLcpGoG63NOecRL0nct+eLE2FjRGAQkkCYSBWLiJ672xzY6QKY30OCnqiyAcsweEueNFmdUZD0Aidp3vy5NajOJSQUz9iFzu+8TRio+UyQ/VH0+b1Px4qhOvyWyucnfhSbjxoikQwIxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cj8TJMA1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cj8TJMA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749525153; x=1781061153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hdEOJ9xi2xPuUT61F+wjrk4pZZfYYi3asu9cjdOajF0=;
  b=cj8TJMA1Zp3vrYa9A0z5vV6r63V0vVzfZYrph+haM0mkjTuCxLZcaLfF
   yA5WICk/i14u4aTUwzWx8oOH6lHVIBtskd+nMuiLkLoZCuS+Ku0oNS4On
   VukpCTcU0JDXalPQFdtwAsTgK+tNDDKd7DOA8nyC56qZhSs4NtC3lf+dP
   InIEZRwwN7aulaOaJfR9e71ABfzrDZ45VvgVRtcqSjI2oSMhqzUv6lOwU
   UoLaG70fP5UuaWwgDvLen/lf8FHx45j9NV5O+XigmWZCaCJM5fqrZ5j8O
   tE68WAQb6qV1rNmoJHGHZxqPdA8xJZ4euXWZFqGtpNHoamLKGjG8MAlsN
   A==;
X-CSE-ConnectionGUID: EVO8n6FrRdSPS//x9AxMcQ==
X-CSE-MsgGUID: EW2eS5N+RsGlI2yQI4xhIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62275092"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="62275092"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 20:12:33 -0700
X-CSE-ConnectionGUID: q/p6AlUcS6uWsyztOrLUvA==
X-CSE-MsgGUID: RBEVEFfCQsmd7eiF+35XIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146612178"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jun 2025 20:12:30 -0700
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
Subject: [PATCH 2/2] Add -e option to focus on the specific event for generating the flamegraph
Date: Tue, 10 Jun 2025 12:04:23 +0800
Message-ID: <20250610040536.2390060-2-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610040536.2390060-1-tianyou.li@intel.com>
References: <aEeIN_u4KpLZXDBx () google ! com>
 <20250610040536.2390060-1-tianyou.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing the perf data file generated with multiple events,
the flamegraph script will count all the events regardless of
different event names.

This patch tries to add a -e option to specify the event name that
the flamegraph will be generated accordingly. If the -e option omitted,
the behavior remains unchanged.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 tools/perf/scripts/python/flamegraph.py | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index 4f82dfea0a70..e49ff242b779 100755
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
@@ -130,7 +135,10 @@ class FlameGraphCLI:
             else:
                 output = subprocess.check_output(["perf", "report", "--header-only"])
 
-            return output.decode("utf-8")
+            result = output.decode("utf-8")
+            if self.args.event_name:
+                result += "\nFocused event: " + self.args.event_name
+            return result
         except Exception as err:  # pylint: disable=broad-except
             print("Error reading report header: {}".format(err), file=sys.stderr)
             return ""
@@ -241,6 +249,11 @@ if __name__ == "__main__":
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
2.47.1

