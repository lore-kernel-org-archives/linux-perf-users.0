Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCA1B95B;
	Wed, 22 Jan 2025 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505062; cv=none; b=lReiIGIY43wURRl+4k14xF3JTI+0hXUBWQ3Pyke3ufJTK9K9+9VkOP6LdH6mPJNtNI+bs2SN2D76uko7KFNG3DQGq7/honQcn48zBqqDZKyzCxfMip1YlSJESgybdO7nflDcNDedO9+1toq1i0YHX+g4x+Z8QhU2zrnOOJ+N7EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505062; c=relaxed/simple;
	bh=TQ07PIExU3iiZfKn4brrCXBfRyxCIVxUhYcO5E0mZZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcV2AjuL6WhELYofhGaPZJ2pQu5Fn55CNHI5ADQvNK/kH1B2QDN+R6vXBuodqyiO8ZD4h7yxkt2MVyAZ+YtAO72qj5sfBmfINXJgdTaNsPd8ebdZ7r6H3lBCepKSJ3lJ5YE/7EoX/5DMKDsQkEUy13blU0MjBtMKg0guoHN5OTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1tYvhWR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1tYvhWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEE4C4CEDF;
	Wed, 22 Jan 2025 00:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737505062;
	bh=TQ07PIExU3iiZfKn4brrCXBfRyxCIVxUhYcO5E0mZZs=;
	h=From:To:Cc:Subject:Date:From;
	b=Z1tYvhWRLMf6AAr4bcmYg+MQJtodwHeLf9vqNBgfq6D/uqvrT2fqnCsM/xNK6tgti
	 Ni5FdNctTUfJmQ/COn5RAYkHceF/9hDut7fe6i2Lv3x/8WA5/Fdb/ADUTtvpg1T59k
	 aIOy54WPoye0bZgw0T0f37eUTJ5+PvhA0IS3Lhh6PX8M3Q19WexXOo0ZwJosFvwbJ3
	 C9hRNfLlZ82Htf6PkTIdgGszbP9H+NCgq7btSnfRkEL5143k3Uw4d1Wovn99AuE160
	 wCeFY/X5PX4uMdGFfcTQubh0ZpMctdWEkEqs6b6pUkPytFlMu4bGX6FRGPSyiVNxTe
	 zMNVR2e3e9WDg==
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
Subject: [PATCH] perf test: Skip syscall enum test if no landlock syscall
Date: Tue, 21 Jan 2025 16:17:41 -0800
Message-ID: <20250122001741.714400-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
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
Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 5a3b8a5a9b5cf296..e57ad6913f3e9316 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -27,7 +27,11 @@ trace_landlock() {
   echo "Tracing syscall ${syscall}"
 
   # test flight just to see if landlock_add_rule and libbpf are available
-  $TESTPROG
+  if ! perf trace $TESTPROG 2>&1 | grep -q landlock
+  then
+    echo "No landlock system call found. Fallback to non-syscall tracing."
+    return
+  fi
 
   if perf trace -e $syscall $TESTPROG 2>&1 | \
      grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
-- 
2.48.0.rc2.279.g1de40edade-goog

