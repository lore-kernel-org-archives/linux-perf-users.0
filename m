Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514D3B1013;
	Mon,  8 Jun 2026 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949922; cv=none; b=tfvvDdFbBE9lrHimGzed4+pIQECo13HyJNqpnRQmHas/wkmUgaI8Ch18Xij6MqyX/CuYsEHYzEHkZuPE4w/aQIOoJlTqxFyyORqsMZ6WCiS/JOZhDz7uGlFW5NBt6zKXg4GlwkAs6mTUbX5GC6CBhRXQCpi8xScz/ZtOyClpcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949922; c=relaxed/simple;
	bh=Yxt2oGqbnRLOMT0IaI+YY3WRaZ1CguTk5gpMRDf8Kug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOElEyDDD6amCYZxXJ/KvwJeGeftryyeSLYLUfKci83WBDfrHxiKuwH+bhxzeoLpzwdQOt0elAyPEt+WTmvC3HxnOfiAGruXajkO9sh+QwikzI2I4J0MXCV5MxiBXABJ8AtsREHQWlH/ztjC96Xltn9gHz9nadcEfFwmgNyNSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyXnSrUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyXnSrUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40BE1F00893;
	Mon,  8 Jun 2026 20:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949921;
	bh=9W8x4UTgIbevM4uKCUF+8Jr1ycseFqIZcpnfDeqRiXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gyXnSrUeEGWByGquW/CSpRDp1hUaMrwPW00qaLLjyCFXgQ9W9NscD7fLyuikTgmh4
	 AusOxtSuEraP1KIhX59yy0HvrUWX2F1ZGCS/OnXy6NwERTK2C7ChGoXE3rokUC74RP
	 8vr5RHyjfv230MwfJp0TtTOxhKwjjXNRQk4R8IDalCnm2knQR9rSCv6m5DtHf747y9
	 yt3z0MNhy6eVEh1jFrAFZar+w3M05mQOgxfye0Pv/c1QyDP/xqJPn6uf+kypHSxDVy
	 uyZYB2qTR/SFpPXrfe+wHBMlCv0uoD0XQ9OTcJhDhj6SFOq0VeSYMCr35rzaDEoSGa
	 hyUISCMTuL4/Q==
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
Date: Mon,  8 Jun 2026 17:17:51 -0300
Message-ID: <20260608201753.1979464-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608201753.1979464-1-acme@kernel.org>
References: <20260608201753.1979464-1-acme@kernel.org>
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
silently wrap past bounds validation without them.

Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/TODO | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/perf/TODO b/tools/lib/perf/TODO
index 486dd95dc57208a8..1a3644aa1f38dde4 100644
--- a/tools/lib/perf/TODO
+++ b/tools/lib/perf/TODO
@@ -11,6 +11,13 @@ together.
      (x86_64 max is 8192, arm64 is 4096), but NR_CPUS limits keep
      growing.  perf clamps to INT16_MAX in set_max_cpu_num() as a
      safety net.
+   - Code simplification: the int16_t forces defensive truncation
+     checks at every boundary where a wider CPU index (int from
+     sample->cpu, al->cpu, etc.) is narrowed into struct perf_cpu.
+     Without these checks, values > 32767 silently wrap to small
+     positive numbers, bypassing bounds validation.  Widening to int
+     eliminates this entire class of silent truncation bugs and
+     removes the need for the INT16_MAX clamp in set_max_cpu_num().
    - Scope: struct perf_cpu is embedded everywhere — perf_cpu_map__cpu(),
      perf_cpu_map__min(), perf_cpu_map__max(), perf_cpu_map__has(), the
      for_each_cpu macros, and all internal callers.  The perf_cpu_map
-- 
2.54.0

