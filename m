Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50DC49EC45;
	Fri,  4 Sep 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531442; cv=none; b=kDVSz1azsA3+AsVrIVqZ2gUVboSjR3xKog7RV63veccl4tMdLvDIrRaGdwDHtmA3CFvtx5KGp7a5aflu0uXvnAAQ8fmsofnYu2vzWUth3TsmPNk4BywiznTWYF7Wa1P61SAE69VIczJFhFHwTiEtE/0J+NPoCdH474JoMH0rV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531442; c=relaxed/simple;
	bh=pT9sdg+CfMTYJSz0VcJtLaqEyqz4UIzLUnqcZ9zN/Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLNpEbE0JslOKJSa+aH9JAE3zbKtL4dGCxHn+JE7nyXEY+Rv0hIMzftPEEsIZdn3aZjKFp/jsl5FweeImURZUHvYuDupjdFeidttF7/x23n8HkZVL7oxnyL0l8pVQs05jWjFL2T1TZvulmRlpJE+PIGPkj7eRZ+xbBZoYv8IV2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDCTJ43U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDCTJ43U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640B71F00A3D;
	Fri,  4 Sep 2026 14:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531441;
	bh=Qy6d4nELX8J/khKPdYa1XVS0tZxs5YB/dlFsCmQO1/0=;
	h=From:To:Cc:Subject:Date;
	b=hDCTJ43Uz4E0nD/07uj4/5gp6XPWVuy9P8YWX5oy4FXEUCHLhMv5d2Y6aEiOdoq6g
	 6Eq0U/U01hRpLPsa8ZMaMG+Lb+6FCMBggltrf9KwuLo8qbLNrt1EPhHin+YxjfyryN
	 DkEyhjW6a8ft8Y1Bj0Qw4U+NBejedLdrD0a5R8ga47KX5OVnpIOkuWqyXhLYZvT/DD
	 a2UV1NHwtNOExDmdORfXVXrqeOVKmo/JWokaSu/sWweTlFuE5aCX526PfHBSXMSkoJ
	 Gm+2wOvoLNwdK0Cqb7qbCtO3USC2vck9gZ1Sbrhg85ySBfQP7t96Ko4aTgoIikm+aT
	 p4Cb3Qxlo01Og==
From: Thorsten Blum <blum@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Annotate x86_pmu::hybrid_pmu with __counted_by_ptr
Date: Fri,  4 Sep 2026 16:17:00 +0200
Message-ID: <20260904141659.224248-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; i=blum@kernel.org; h=from:subject; bh=pT9sdg+CfMTYJSz0VcJtLaqEyqz4UIzLUnqcZ9zN/Ts=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmzLt1OPvn2xc0f2Us6v9+KPPVzyhq9bdkPtxzOuJ004 Z5nTNVhz45SFgYxLgZZMUWWB7N+zPAtrancZBKxE2YOKxPIEAYuTgGYyJSLDP+rGi7FhXt7zbZe V+Tw2Ns9qWnry07/HWs6Q6auOvF5SzEvI8MePcObJ31e9hbveBL4VrjgZuN90Q+6By/afdzhsUq v9CQnAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Add __counted_by_ptr() to x86_pmu::hybrid_pmu to improve access bounds
checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/x86/events/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 71ed5b2acea2..b66691a4fc31 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1050,7 +1050,7 @@ struct x86_pmu {
 	 * unique capabilities.
 	 */
 	int				num_hybrid_pmus;
-	struct x86_hybrid_pmu		*hybrid_pmu;
+	struct x86_hybrid_pmu		*hybrid_pmu __counted_by_ptr(num_hybrid_pmus);
 	enum intel_cpu_type (*get_hybrid_cpu_type)	(void);
 };
 
