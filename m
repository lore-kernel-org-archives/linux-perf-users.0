Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642134;
	b=K17LFX1ND3d1sAd96DhA5yYKCIB9pR+eF6AYG+NzW+TYbb7+2TmtHg6jF6lHfi+mEBIO
	 01TwHZPGQTTpwXzJXg4WCfOnQT8mclQnfxOvdHF5fxERTIJ5EVWBQ4Cwn/u/GiBSNnw0n
	 btn4VEr8BUTD+JDsgck6IQ7G5bREzfnTM7CvTOXR549cO50kmCPdCXGgtApQQMUzNB5eX
	 j6+rJv3Bpd5nm2aIcFYacPr5K2nVZ19xtViSUcTFQyufVDaqL/zer2/jB8vgIfdCrjwl3
	 0I2urQpSLrMhW9D2rwzAOyQZ135oGZVuSMcwTy7F01lmAaNQuMvmu6zXThLB3oYmKtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7uO9CSS53SjJtcEDs5Drh76EXuohXBT2i84Rzw+3Dz0=;
	b=SYCZbrBp6pTnRhZ9dvbCnSj6Ry936Dq3LtK2TgWk2b2eZnjSIZdCyayprxdAkQmsZW4g
	 HhUIgUxvkSPxOy+AOlGNMY7ZRGJcLW2QgzyjuNFz5a0Wyc9uKin61sTEqj8FODLX+Soh7
	 adpOVRbj4/1L8hKnyZiJLDSaVf9WAbQEGBPCTZ+840JF7b1mA1nXJgpwNESYmZoIW67pL
	 gDd+DUrHOm8U1h9b5nh1zScSP2UURg3gsAd8ws+KgGBSfojUGd7vPk1Yr0Ujh1ChXGmwV
	 +EUoCHmoVGBavQDcNTw2MvchoKOAauZruMyd5FRoOLJsGOKnrLQn9GYSt9mZBKvTSmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTojB9CF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95E606A686;
	Wed, 25 Nov 2026 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTojB9CF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5E31F000C6;
	Wed, 25 Nov 2026 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642134;
	bh=7uO9CSS53SjJtcEDs5Drh76EXuohXBT2i84Rzw+3Dz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bTojB9CFYg0p+Iqk1k97e21OL5PQugpLX6zGz41K1Qw6yKmVzxDSQzFmWQdmCpbbg
	 rm829PR8Un9kj68WjFe0iZJZezajLY+KgQU3pgLeImdKF8DR7Fw9glCoZb6rcwlhQr
	 yHaHtgXyDw63qiA/t71pkG14b9EaJUI1wU6rjEljW0he5AhM6r5eEVQmT42Jkp4Ih8
	 cL+Wf/h0AQT3IWI37ApjAqmS9+XyJH5BSANrfs2k1GJt7XuNKDsXK0kzoaewe/DriF
	 a2Ivd+6cW2/8NLLrshoQ0NtxM9Fvq1JXL8LT798VPoFMBgtaHON989dsdJnPJZl7/j
	 70GQaY1Ls8wSw==
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
Subject: [PATCH v4 02/11] perf tools: Add perf_env__is_same_boot()
Date: Wed, 25 Nov 2026 13:28:42 -0800
Message-ID: <20261125212851.1792988-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261125212851.1792988-1-namhyung@kernel.org>
References: <20261125212851.1792988-1-namhyung@kernel.org>
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
2.56.1.831.g720f3f5937-goog

