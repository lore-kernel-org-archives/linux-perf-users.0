Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252211DE3DD;
	Tue, 28 Jan 2025 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083992; cv=none; b=S7aMm4AqwpPjaDcjjpuJ4pY7ZzgxndfFiFxecbSI0zr8oHz/R006AiYfufubBMLV3xN+Unv0UzwHVaZwB6EcPiPKWHb3tsvy/dhaTGJXMvOiPuoHy7wdCDEpO+Aw+c4yzNQ3HIxmOF/fQPEk1wEXc57lf/47yqRmbNSwYLEi2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083992; c=relaxed/simple;
	bh=YchOz+H4/2AYyopMRRy4/gs6+z2crgPtng6f+8x0F24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WidRXJxsiCoJJUWMl7qk6UwSsB1zrDZL8D/nUyxYKH/IHvfGZULO7Et5SJULWIBtZhMUE5lONxHW5O/kNmex01eDcWzSzc90I25obCclm0Ih0mZJ0O04qXgx4cDs3p6UNfCarS6gnm7+e4zsBGCblXg4zaQL0YrThYadtDhDRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn3bdxet; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn3bdxet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE00C4CEE1;
	Tue, 28 Jan 2025 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738083992;
	bh=YchOz+H4/2AYyopMRRy4/gs6+z2crgPtng6f+8x0F24=;
	h=From:To:Cc:Subject:Date:From;
	b=Vn3bdxet7x/O2aWUWjdIQNwDBmuNomUh4dj7j/DF1YuExWbsJ+GbLW6/vxQgsZiNl
	 7dIUMRMCegkpWxhW6vyUniOz7JhpuLG81+smNgOdS/UiaIL6betb8rZ0cgSKt+61Ga
	 cvyR/ERTbrcHdVpPsbRxh0h9pOWmakMnPhui5Z13vv6RcqF5IfgJK8c6ghf44/1cwH
	 qY72cjoiAMHdY24FhPqfP2h0miMZjJ12pZCTHZWglT7PyEuFVdInc53ROGT3KgIdWT
	 NcBEEryvPOHjvG1BAr5YyeW1jwmjupC8cjOvxv7Vm/0Hsla54yecSyP9e0xWpKlmqr
	 9K4sHjo0GniDw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2] perf test: Skip syscall enum test if no landlock syscall
Date: Tue, 28 Jan 2025 09:06:29 -0800
Message-ID: <20250128170629.1251574-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf trace enum augmentation test specifically targets landlock_
add_rule syscall but IIUC it's an optional and can be opt-out by a
kernel config.

Currently trace_landlock() runs `perf test -w landlock` before the
actual testing to check the availability but it's not enough since the
workload always returns 0.  Instead it could check if perf trace output
has 'landlock' string.

Fixes: d66763fed30f0bd8c ("perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'")
Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) update comments according to Howard

 tools/perf/tests/shell/trace_btf_enum.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 5a3b8a5a9b5cf296..8d1e6bbeac906843 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -26,8 +26,12 @@ check_vmlinux() {
 trace_landlock() {
   echo "Tracing syscall ${syscall}"
 
-  # test flight just to see if landlock_add_rule and libbpf are available
-  $TESTPROG
+  # test flight just to see if landlock_add_rule is available
+  if ! perf trace $TESTPROG 2>&1 | grep -q landlock
+  then
+    echo "No landlock system call found, skipping to non-syscall tracing."
+    return
+  fi
 
   if perf trace -e $syscall $TESTPROG 2>&1 | \
      grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
-- 
2.48.1.262.g85cc9f2d1e-goog

