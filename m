Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDE337BA4;
	Wed, 10 Jun 2026 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110396; cv=none; b=iPJoMxzNtrP/5UJD9ZRKeKHpa0Z9fsulziuKZ91opJAl7nlyadOQVZhgUQhq2Ee8UmJ3x6bB2hj7q4uZXSCiCKHUqFvrKbI2E6kUAgrvLslAqbojk8JPWzsz+HMpSMHgBrhCTrFP8f7xMm1Mp64cqGlFjZ9P7Aw2HhmtVsZixys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110396; c=relaxed/simple;
	bh=whP9jx6KDB4/4o+dk2mUw7td7rlHM3I1owTU6AcY++Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6VMx4UwSlSothNE1saDgjUBCJ6LyKLN+mNzx6MgJ+ks5skNMC3EWfdp6+x5GXVweLXnjeoxEeKzTdD7XOjTUlDJmuH2N12LCRym9BElGPcCmluhoPCpHYW1c18014ThpiCaBwKL3uHGW+pDyOUqke0yBCCeRdN717b9Jv8xndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f73m++uK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f73m++uK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96A21F00898;
	Wed, 10 Jun 2026 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110395;
	bh=TyfKr8lVqchVJszhm+AWCn41Ltfy4bgQtnnQFKxtpF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f73m++uKocx5TMIN7ov/u0Dc5HlbuizzBBvfSRnO6gDutnZsiL1UZn1hAP4yGFUeM
	 MISvHlrcNrmWUK46gaIKbLDtiYW6yINtuC0th9UIgsWEfvwASoZSyG52AQUvFAJLlD
	 615oKAAFkeWI89l3DVMARh0j9s9cJi8CFcFgyJ4tZIPpSAsyl+KfUQuQ0w2BLZbI6L
	 EbxNezXrXMyH9RKwPWtQFhaMnm2qVmAEE4Or5zGPuChiRHiMtojVdVDTi7qer1yIE1
	 6gUz7UmeGnMux8HYxNkL4TJ9R0yuLiM4exIZqD4437fV2vwUBqcAtsRFmfWn+5Fps9
	 6Q4RGFJpWvH3Q==
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
Subject: [PATCH 11/11] libperf: Document code simplification case for widening struct perf_cpu
Date: Wed, 10 Jun 2026 13:52:05 -0300
Message-ID: <20260610165207.2077258-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165207.2077258-1-acme@kernel.org>
References: <20260610165207.2077258-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a bullet point to the libperf ABI TODO explaining the code
simplification benefit of widening struct perf_cpu.cpu from int16_t
to int: the narrow type forces defensive truncation checks at every
boundary where wider CPU indices are narrowed, and values > 32767
silently wrap to negative numbers (two's complement), bypassing
bounds validation without them.

Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/TODO | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/perf/TODO b/tools/lib/perf/TODO
index 486dd95dc57208a8..e179728697d8c7c0 100644
--- a/tools/lib/perf/TODO
+++ b/tools/lib/perf/TODO
@@ -11,6 +11,14 @@ together.
      (x86_64 max is 8192, arm64 is 4096), but NR_CPUS limits keep
      growing.  perf clamps to INT16_MAX in set_max_cpu_num() as a
      safety net.
+   - Code simplification: the int16_t forces defensive truncation
+     checks at every boundary where a wider CPU index (int from
+     sample->cpu, al->cpu, etc.) is narrowed into struct perf_cpu.
+     Without these checks, values > 32767 silently wrap to negative
+     numbers (two's complement), bypassing bounds validation.
+     Widening to int eliminates this entire class of silent
+     truncation bugs and removes the need for the INT16_MAX clamp
+     in set_max_cpu_num().
    - Scope: struct perf_cpu is embedded everywhere — perf_cpu_map__cpu(),
      perf_cpu_map__min(), perf_cpu_map__max(), perf_cpu_map__has(), the
      for_each_cpu macros, and all internal callers.  The perf_cpu_map
-- 
2.54.0

