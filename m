Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476028;
	b=jK4ko18yA6O6mActTQ0dD9lu/Vp38CqYU/wtfWR+B9AntWtDAR3qLYvCH+ZG0qdpf4cV
	 tRO7/i5PErVFyZNKOhXG1OAQMcVQteft6UuFMKLUh63o3qqmakLa6MmC7LkI0Dk4hPJ0V
	 gSYe66FVGW7Y/WZ7GpqScD9+JYIJbHo3VWodapq/vbliwKND3OL8x3QPEkn2VKXQZoEZx
	 iAShdSWtkkR7RGGZwYAH7xn7RhMGvbldCL+M3/1/V3ZXb0crjuXa2tWHS4jhCHVj1802i
	 FtzDQbUikBGxBbAt/937+QLZ5jQTvwDJRs/5ub0JNlal8hVYxgsMbP25+KjjXjQGPEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476028;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VbKK1R499nIxeC6VlE6iA0ncZPvjtJsKyOCEBTg9GBA=;
	b=D2zLRi7P1fEBMPha8+DQhj0CIFX+DziJX35wKZfYKIMqWf7kFbMxvoVLyUrLSDqKTX+N
	 Wrpz35SBii8cpONMXpMZJ7l3tTVVe8kg7904wzrF5+q6HH+19HcMAHRpZwEBQIJAPiEEJ
	 DoeoAXhP6t0Y1cmNGN7kNZNBf6u4ZvihT9Y9nbzKHh5aaYay3qZO+mrWkc+/XTZdX7w4E
	 GHNBvy7RwxKt2p91d/dgNsXava8hh+9AIWx5GhiwYFVNYuRPqRspDWCKDE/EWhMUPLd/k
	 effZsaXMRAMNVLH8l10f0IDEoiUGyQOyTxTrPivNoEwm52KDJ7yUAhLBdlh36KfciQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7IKCkNz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D307606A339;
	Mon, 23 Nov 2026 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7IKCkNz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5641F000E0;
	Mon, 23 Nov 2026 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476027;
	bh=VbKK1R499nIxeC6VlE6iA0ncZPvjtJsKyOCEBTg9GBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k7IKCkNzqbaB7E4UaenjYmC5asCG1Z4fp5SUIQADKpfR/27vusxgapjce+c4DG9tH
	 6UCUWQcDBSkaHEMvMzusUUyGVYmszxYwSDVtQzq2At4eGJiv4nfBHeVXrD9+bCC3Ce
	 NU2oeFnzyFLYC2UVYAF3+FIBjHLZFJ0JpzUubnSXYRBsNRQa3U/Lkg6ZgPI50ggC+G
	 ePQn8ZVbf6JQhfy7spFAzHCIudbgHAe0wVAyCiq4k7x0Sc+Im6HfIrmhpuQU9i6/YC
	 J6L28w7siwrmlOKO8MQ7EoC5YjMdgd4zh2JG10YOWb5PG6W8S2GMTFGKEpUjMQVwGH
	 vmwpYJn6RiMoA==
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
Subject: [PATCH v3 02/11] perf tools: Add perf_env__is_same_boot()
Date: Mon, 23 Nov 2026 15:20:16 -0800
Message-ID: <20261123232025.1406560-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123232025.1406560-1-namhyung@kernel.org>
References: <20261123232025.1406560-1-namhyung@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add perf_env__is_same_boot() to compare the recorded boot_id in struct
perf_env against the running host's /proc/sys/kernel/random/boot_id.
For live sessions where no offline header was populated, it falls back
to reading the host boot_id and returns true.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/env.c | 25 +++++++++++++++++++++++++
 tools/perf/util/env.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index f624ba98e23c6a77..ce1f9ab2c40a9599 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -445,6 +445,31 @@ const char *perf_env__boot_id(struct perf_env *env)
 	return boot_id;
 }
 
+static char *host_boot_id;
+
+static void init_host_boot_id(void)
+{
+	host_boot_id = read_host_boot_id();
+}
+
+bool perf_env__is_same_boot(struct perf_env *env)
+{
+	const char *env_boot_id;
+
+	DO_ONCE(init_host_boot_id);
+	if (!host_boot_id)
+		return false;
+
+	if (!env)
+		return true;
+
+	env_boot_id = perf_env__boot_id(env);
+	if (!env_boot_id)
+		return false;
+
+	return !strcmp(env_boot_id, host_boot_id);
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4180380f4533790a..2d0a67ae306fb362 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -190,6 +190,7 @@ int perf_env__kernel_is_64_bit(struct perf_env *env);
 bool perf_arch_is_big_endian(const char *arch);
 const char *perf_env__os_release(struct perf_env *env);
 const char *perf_env__boot_id(struct perf_env *env);
+bool perf_env__is_same_boot(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
-- 
2.56.1.809.ga0b61035b5-goog

