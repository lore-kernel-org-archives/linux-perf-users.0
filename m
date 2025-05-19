Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC221FF54;
	Mon, 19 May 2025 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690905; cv=none; b=bngXwFh7EdAS8eCM0zGKnOLzNf0Ub7pcSWM2NrnVQngXDdwgc0+iycunjCurwubIlUmDd4cFAgfYRoe+JQYbAtZQfst9R4EQOedz7qk+EgT/KELR6dpJCssU5eu6+Rz9/8PFS1knICvO3dTeDZws/w2zjXty2XHSsJwIA8k27UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690905; c=relaxed/simple;
	bh=Hlqw696bBlJIgwGkjUB/E+7h+yUpLqOxKn/qbcNd81c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXLtCOTMIHjdoS0cL5qT062mKci5gSA17I3ROoDXvwHHOps0YGa1HXFiiCUdPrXV0oFfT29PJ/sl4M+glQq8urIzr3q8z+e6L6HtVJDBd51pGEB4f7CdHllB7aJhcqA6zy05KRf5GRi7QV7ammnE8tPiW6GvccUJNTfoRBr+NTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIR90joE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIR90joE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0BBC4CEE4;
	Mon, 19 May 2025 21:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690905;
	bh=Hlqw696bBlJIgwGkjUB/E+7h+yUpLqOxKn/qbcNd81c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIR90joELPl4X+sp4wZG4vVt+/ijRWovbuZshm8zfJ0hLTWnJU3FT1oTWJ6c6WBvN
	 nDFVZ5YXQ+gw3nzJPlNCzmqh0B4bYlctBWx/lg5Ar8pMRI8WVkBNzRK01NeHakrM5X
	 unVhMPGaEd756ZN2KcDZm36Mduc47G692Z1W29Qc5EV/tAr+zprxyGewg4lJn9aJQf
	 I4XNBGnvNxvwbm2Ze1OR+B8V5g4bdq5NKqXOvsj35SwfAUIZB2F5rXKiQ0kwvQqwl7
	 2npJYxf5Oa9Iy0efc23baIdXHrZrf2ravx+EeQk3tK49sJNEKKBc1kgr5so0Zp4gyE
	 cHyNt6i4uYq8Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 2/7] tools arch x86: Sync the msr-index.h copy with the kernel sources
Date: Mon, 19 May 2025 18:41:21 -0300
Message-ID: <20250519214126.1652491-3-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519214126.1652491-1-acme@kernel.org>
References: <20250519214126.1652491-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from these csets:

  159013a7ca18c271 ("x86/its: Enumerate Indirect Target Selection (ITS) bug")

That cause no changes to tooling as it doesn't include a new MSR to be
captured by the tools/perf/trace/beauty/tracepoints/x86_msr.sh script,
for instance:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh | head
  static const char * const x86_MSRs[] = {
  	[0x00000000] = "IA32_P5_MC_ADDR",
  	[0x00000001] = "IA32_P5_MC_TYPE",
  	[0x00000010] = "IA32_TSC",
  	[0x00000017] = "IA32_PLATFORM_ID",
  	[0x0000001b] = "IA32_APICBASE",
  	[0x00000020] = "KNC_PERFCTR0",
  	[0x00000021] = "KNC_PERFCTR1",
  	[0x00000028] = "KNC_EVNTSEL0",
  	[0x00000029] = "KNC_EVNTSEL1",
  $

Just silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/r/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index e6134ef2263d50d1..e7d2f460fcc699e4 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -211,6 +211,14 @@
 						 * VERW clears CPU Register
 						 * File.
 						 */
+#define ARCH_CAP_ITS_NO			BIT_ULL(62) /*
+						     * Not susceptible to
+						     * Indirect Target Selection.
+						     * This bit is not set by
+						     * HW, but is synthesized by
+						     * VMMs for guests to know
+						     * their affected status.
+						     */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
-- 
2.49.0

