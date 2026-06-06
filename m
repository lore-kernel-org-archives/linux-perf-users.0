Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754763AA507;
	Sat,  6 Jun 2026 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776411; cv=none; b=kpqllLyvUnQygLmVlU3CUt51be6In2NCyvtDNU/CXwuHZDLNmWPjWlkGkzLsFXZW6rImCmuVy/WG1USgNz3JJGXK7NbpfyWBUqSMZvrf/GyEBf6eL/jZLMJRr0y5D4+4muy2m2+5f7nIuqIOOKloPwEOjT+QG8dwR/TMXyp/P/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776411; c=relaxed/simple;
	bh=otMPZBy/m/mdkpzCRHNeN4v5A2g2PmUSDrzAHJGrzKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SF4pzp+TJdnLn6LX3/Yy/CpsNT1w57k/n8PDOhJ4VkRg4QqYiZ+EDR90RmcEIEit2VGhVP9+LdCn1dg8MzaZ3TkeTRhYexc4c0fZyt6KvAIyzUYFI0xzH/JPCaLb4xWk2gPuvmGIwPDgoK8iGXFPT7yG2OW55SdgS5MJfCHTZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGGcDOc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGGcDOc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B731F00898;
	Sat,  6 Jun 2026 20:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780776410;
	bh=b2uD+J314xoZnLe/CqhsMboKQCzCjaM1jNC4mWctMNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YGGcDOc9KerUTTHKdC9aMpRzZLGBlsRdV6//dbtx+fuTh1VVArNsLWVprnU9nH6J0
	 Tco0IChjiaS8kSqD+HweB8uPrkthZCcF9Lizi2hthD77XTFHo1BgfP6JVjYztiVfbk
	 O76kwPQIDZXR/Xmkgw4E/WnspF+Hyu/7Zkv9TXAfseu15LEXvWOdcMtacdPIsu6ULV
	 qxZeDDcMXrMd9QOPzTtANfBofHo+yfXXkoKNAyPfdsC9ZfIPtD2010bHc09Vb4HruX
	 CNeS3iZgvvjtgt5GuLhhydGh8WDTBvVUL8Pq74rv6sNx1N/CzzTWaPym/gjADL8i+0
	 Rv7n4lCXt3EGA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 7/7] libperf: Document struct perf_cpu int16_t ABI limitation
Date: Sat,  6 Jun 2026 17:05:59 -0300
Message-ID: <20260606200601.1861227-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606200601.1861227-1-acme@kernel.org>
References: <20260606200601.1861227-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

struct perf_cpu.cpu is int16_t, limiting perf to 32767 CPUs.  This is
part of the libperf ABI (returned by value from perf_cpu_map__cpu() and
friends), so widening it requires an ABI bump.

Add a comment on the struct definition noting this, and create a TODO
file to collect future ABI changes so they can be batched into a single
version bump.

Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/TODO                  | 22 ++++++++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h |  8 +++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/perf/TODO

diff --git a/tools/lib/perf/TODO b/tools/lib/perf/TODO
new file mode 100644
index 0000000000000000..486dd95dc57208a8
--- /dev/null
+++ b/tools/lib/perf/TODO
@@ -0,0 +1,22 @@
+Future ABI changes
+==================
+
+This file collects items that require a libperf ABI bump.  Each entry
+should describe the current limitation, the desired end state, and the
+scope of the change so that a future ABI revision can batch them
+together.
+
+1. Widen struct perf_cpu.cpu from int16_t to int
+   - Current limit: 32767 CPUs.  No architecture exceeds this today
+     (x86_64 max is 8192, arm64 is 4096), but NR_CPUS limits keep
+     growing.  perf clamps to INT16_MAX in set_max_cpu_num() as a
+     safety net.
+   - Scope: struct perf_cpu is embedded everywhere — perf_cpu_map__cpu(),
+     perf_cpu_map__min(), perf_cpu_map__max(), perf_cpu_map__has(), the
+     for_each_cpu macros, and all internal callers.  The perf_cpu_map
+     internal array (RC_CHK_ACCESS(map)->map[]) stores struct perf_cpu
+     directly.  Widening changes the struct layout and every function
+     that returns or accepts struct perf_cpu by value.
+   - Migration: bump LIBPERF version in libperf.map, audit all
+     sizeof(struct perf_cpu) assumptions, update perf.data
+     serialization if needed.
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index a1dd25db65b62f6b..e1a0b0d272109ecb 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -6,7 +6,13 @@
 #include <stdbool.h>
 #include <stdint.h>
 
-/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
+/**
+ * struct perf_cpu - wrapper around a CPU number.
+ * @cpu: CPU number, -1 for the "any CPU"/dummy value.
+ *
+ * int16_t limits this to 32767 CPUs.  Widening to int requires a libperf
+ * ABI bump — see tools/lib/perf/TODO for the full scope.
+ */
 struct perf_cpu {
 	int16_t cpu;
 };
-- 
2.54.0

