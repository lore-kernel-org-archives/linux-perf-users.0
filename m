Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335541168C;
	Mon, 31 Aug 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181903; cv=none; b=MMJFYTPeYLC68XoJKOtOs5OazJw7KqoMV3hjAHa9M3omZENZTnnRi9hFbTVMNDGmoPNMkD74S/VW+rfrnclHL/RmsRfUY9rErvdFCx0QQmhHM5a6HIR4TeO7jUIYRErbF/mB/KXNEHjz+stlm4Ibl00rxhbb4CxiscbDZ2Ol1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181903; c=relaxed/simple;
	bh=mQ9/gJJcQQov+Doh+sJfAXCLJ1leHtvJWreaTIrvAVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOE7XRLPjPTNZLogT5R0levimS946rhTkyssd677Gd59lL9meTQT1dGR3KEoEDLUzQ+oaEAlxta1YpO/rfxowkCrtbtDAlxGbUa9n/1k6SY+35wnv8xDyUlasS4Mw6azFKEggP9AYDfBgbg1dSOTwoXfjfMNoAp7n8wMooYeyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c56civa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c56civa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA161F000E9;
	Mon, 31 Aug 2026 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181901;
	bh=okQFdCODrC8WurKsSQVifgP3fXAC2pPoWES9ZUJp16I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c56civa9VmfMf3j9KdYiDzKEzAeiLk9Pr/V2nAGuGwZ2obAkJ+K2KYBjZ2gpCryCQ
	 Dnb2euWBg6JlLLAnRoo9uNAT//pokxlaO2rRtwmB7GZFSkDoImx3ixHw5NcVMI2QTJ
	 t/wKR8vfVkohi198uaC0JHZ/HsfqOlQQdqYyZ5wT2ns7hPKIrk8FD9DfBuDu+5kYRs
	 1dw4kG/cgckvnukoe33WDfPe83AH2f7GTf8TTel5L9EhkndlqR168RSnogM7XOLYBK
	 Ok4kKPoYoqMa7ZKnfSzQU9oRd3LAqr0kJprwoeEa4dJ3Qw6P3OzErmJP97y9kN29n9
	 bmjrCtwfMLXrQ==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Stefano Sanfilippo <ssanfilippo@chromium.org>
Subject: [PATCH 04/12] perf jitdump: Prevent integer underflow in debug info size calculation
Date: Mon, 31 Aug 2026 10:11:00 -0300
Message-ID: <20260831131110.4681-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831131110.4681-1-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_debug_info() and jit_repipe_unwinding_info() compute payload
sizes by subtracting the fixed header size from total_size:

  sz = jr->prefix.total_size - sizeof(jr->info);

When total_size is smaller than the header struct (from a truncated or
corrupted jitdump record), the subtraction underflows to a massive
value, causing an oversized allocation followed by an OOB memcpy.

Validate that total_size covers at least the fixed header before the
subtraction in both functions.

Fixes: 598b7c6919c7 ("perf jit: add source line info support")
Fixes: 0284fecd13b6 ("perf jit: Add unwinding support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stefano Sanfilippo <ssanfilippo@chromium.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 14bd23c8d1963e92..f79e9420c6bd7c51 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -671,6 +671,10 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	if (!(jd && jr))
 		return -1;
 
+	/* total_size must cover at least the fixed header */
+	if (jr->prefix.total_size < sizeof(jr->info))
+		return -1;
+
 	sz  = jr->prefix.total_size - sizeof(jr->info);
 	data = malloc(sz);
 	if (!data)
@@ -699,6 +703,10 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	if (!(jd && jr))
 		return -1;
 
+	/* total_size must cover at least the fixed header */
+	if (jr->prefix.total_size < sizeof(jr->unwinding))
+		return -1;
+
 	unwinding_data_size  = jr->prefix.total_size - sizeof(jr->unwinding);
 	unwinding_data = malloc(unwinding_data_size);
 	if (!unwinding_data)
-- 
2.55.0

