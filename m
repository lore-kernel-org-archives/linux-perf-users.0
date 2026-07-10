Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99C3E8321;
	Fri, 10 Jul 2026 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783726906; cv=none; b=IsKNdGGX3Wo6GGGwjO4NMR/kAESGntQFCecyD2jDrScmWGiXMEDMZCEBsSdvgtFIyOKjVVW+oCEeS6Ql7hXUvklLIHysw1Tnh4HtUfd9J7XmuKVs9+SlpP8r9Z9dyDev5QzlQ2Tl5Ho0k/iL2Zhg34iUpXdNd5CYG569C7eqbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783726906; c=relaxed/simple;
	bh=pvBSbpLHqBKef8QZsgUUQYp6P8cKq9Z6AGpNn7MP2w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbSecc3gFKX9NP4XdGW6wO3aLSNZD2b+TsZeAZDc+KQd/as7wbfqxWgCQaOWSGX3/QqrZUWTUuyRTOlu/KiL1+VrnbXfJJtaMh6XM15EEFpxeYJGLIzZ0pfoBy465V6ZjxySnNVWWrpgDf1U+wi9ocB/t2EkIs5gMWB9FXTpg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A46Yg8sv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A46Yg8sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE651F00A3E;
	Fri, 10 Jul 2026 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783726905;
	bh=w7HMG3k/s6Z8qfvHuvs7uJmMoFaA9lLeqD69kcOO8hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A46Yg8svY6oF4hNoEqiKa06rE6w1n76bFgIE764JwxC3fk+40+BzrEsLSrY5AoA7G
	 Om0ytlv0RkMoa04q2mjW9WUnTQGnscbblue4nvLBVUJCDlalMt18Y9I4h8EG+lzHO8
	 xwvt8UmnSbNX5mBMMVe1ibdCRuaYZxKa1zEaU73xp5ALa4H/TL4s1dHrS4zkZ5fpFX
	 lB3wtItIFWn2NiMNtct0Wrw/JNTPCYgXCU7SNQYsspsgNbizqIh0Hb6SHchUuL9iHk
	 Jdxt3kQdIa4HDNsHGseXpVS/qp4QkLK0pWcHqBAYmzWv16rJ/RwAkbZ5oh6dpfvZfn
	 pPypbswje6U4Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 4/4] perf test: Update test for --for-each-cgroup option
Date: Fri, 10 Jul 2026 16:41:43 -0700
Message-ID: <20260710234143.1934263-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260710234143.1934263-1-namhyung@kernel.org>
References: <20260710234143.1934263-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To simply check the number of output lines with and without the option.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index ff2e06c408bc6be1..17b17b112169c8ba 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -58,9 +58,24 @@ check_system_wide_counted()
 	fi
 }
 
+# Missing flags in evlist__clone() resulted in different output.
+# Just check the number of output lines for simple verification.
+check_evlist_expand()
+{
+	normal_output=$(perf stat -a -e cpu-clock -x, true 2>&1 | wc -l)
+	expand_output=$(perf stat -a -e cpu-clock -x, --bpf-counters --for-each-cgroup / true 2>&1 | wc -l)
+	if [ "${normal_output}" != "${expand_output}" ]; then
+		if [ "${verbose}" = "1" ]; then
+			echo "Normal output has ${normal_output} lines, but it now has ${expand_output}"
+		fi
+		exit 1
+	fi
+}
+
 check_bpf_counter
 find_cgroups
 
 check_system_wide_counted
+check_evlist_expand
 
 exit 0
-- 
2.55.0.795.g602f6c329a-goog

