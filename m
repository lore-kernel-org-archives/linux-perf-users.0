Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6B3E9296;
	Wed, 18 Mar 2026 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859534; cv=none; b=A1BY18vyGmVOXU0CDSd8mza3aA2IDFYdGyrpojdUsOxv0U/mjfQ51s8iydDP080+0p6fv4Y3TDZx7zWq1CFaMMcxMLWA8yz9kqa31+9pRwINFgvAIa6RY2lNWkL02+Va5ifo2BvVkJGM2AuUtjpcXJJaCED0iKG6exrloO5xEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859534; c=relaxed/simple;
	bh=qj8CMAHp1lvOPYMSKNerBJkmowMeLKbAffaRtbgH+4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lYbJzLbv+xPPf/lwDQ64OD0bcqy4HjGnWc3gUFYV2BTjemSV7pLcuvBYyi715NVeRg1EnLljroB86FH+EywK1YT2Ukm2K24b1noGp4VWZ0H63T/eaYiZqkoUZvTMq/NivXxRxUmq2Ztvdq26W00NW2AMLl8lvsTeq98BRXBC3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr1eP1K2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr1eP1K2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05360C19421;
	Wed, 18 Mar 2026 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859534;
	bh=qj8CMAHp1lvOPYMSKNerBJkmowMeLKbAffaRtbgH+4U=;
	h=Date:From:To:Cc:Subject:From;
	b=gr1eP1K2mEOLslLJOIVGuLFZlUVQSbzVkHqPGbIpprU00B06U16jgRGxCYcMo3yUO
	 vMzv6boZfgdfKHK6RJ/0lOrNis1yXERusQIF24Xda0ymmd0IG/7GasWevFYy/t3Q/+
	 l5XIFXKWjtvbPZru5AYdxSTcyZsX5fwDoZoM7XPXPSsFJ5iVW5hmkZIhesxGjxr0V0
	 PzPyYFO4YfyrTEQxMrjuuRQ39kvQn2/gkAtbn8YiCyQywr70sxcR2vvvCKW+IgiRCI
	 iY93pIktUFqXrI8PEXLHdxpL0s2fXvWI3JADePNYNJRye6o22ijLU2HDLeA7V+0ScY
	 K1rwCQv/t8oNg==
Date: Wed, 18 Mar 2026 15:45:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Kim Phillips <kim.phillips@amd.com>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <abryyyeNQR3ovN-R@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick up the changes from these csets:

  9073428bb204d921 ("x86/sev: Allow IBPB-on-Entry feature for SNP guests")

That cause no changes to tooling as it doesn't include a new MSR to be
captured by the tools/perf/trace/beauty/tracepoints/x86_msr.sh script.

Just silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Cc: Borislav Petkov (amd) <bp@alien8.de>
Cc: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index da5275d8eda63e19..6673601246b382e6 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -740,7 +740,10 @@
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
 #define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
 #define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
-#define MSR_AMD64_SNP_RESV_BIT		19
+#define MSR_AMD64_SNP_RESERVED_BITS19_22 GENMASK_ULL(22, 19)
+#define MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT	23
+#define MSR_AMD64_SNP_IBPB_ON_ENTRY	BIT_ULL(MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		24
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 #define MSR_AMD64_SAVIC_CONTROL		0xc0010138
 #define MSR_AMD64_SAVIC_EN_BIT		0
-- 
2.53.0

