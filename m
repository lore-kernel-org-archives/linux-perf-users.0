Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268C18951B;
	Fri, 13 Sep 2024 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268621; cv=none; b=EtJ+xXL3hRL+T8eqdahbMnmmajMPrlrW75ZrepIdZse0+pqICXkNBD7zQSaH41mCP6GRIO2aUQ/rB+wQhUcs/Rl0oQyQWc62zNIFHl8shltGez0I79w7o/b14eSrtf7F7Rw3LqyqXk2c8QMxTszLX41u17Z+gKVDqU60mLsAVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268621; c=relaxed/simple;
	bh=EtRtM2cTGDbwo7RsHNituM7SMCvqa4pTLi2Qzvb7C8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJSYz20ZnfFsEQgrVAV9Zf8x903/m0OVGeFatpl4q10D1fbHn6WjIiOTtP9wZ5E5R0I3rLaID9pN2Z68VvgGTwYsdvkyFLH5hVTaiB+kg3GUWcRTrEXLxXnXqIIaQyEkzQSptzLXVcdc6yz+fn+E0DDdqBrx522jphGp1XYRU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVjcV7eQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVjcV7eQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC6EC4CEC5;
	Fri, 13 Sep 2024 23:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268621;
	bh=EtRtM2cTGDbwo7RsHNituM7SMCvqa4pTLi2Qzvb7C8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVjcV7eQBvm19Nkj2vxcVt4tfTmi9pawMtllHfr4vJ+wH1Q3ftuLhMDYeWkfrPVyM
	 rNQzfYRyCaVkVECwNCV+8B1UMDpK6hSVwAd0DUaZmVBWvEVv0VprxTv0+33RKm4ZRB
	 nXFROWn7vxi4XdPd1Poz9/ZMQHPGlJWtg9LuV4ehQY2eWtwtyh9uF4YHMXp+FwgBIH
	 MdjYRD+o9SBj7vec2skizh4xXfn1u3333/E9xbDiEGhiSPSIWrRF87mSlsbBftUfJX
	 34/2K3mxzgc1gsIv9TK/kFwB6Lek0OxyyZLV/sqQ2/rDqqu6SgurARL09qCUHXjYNc
	 I9kKme90SybBQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>
Subject: [PATCH v2 11/11] perf/x86: Enable SFrame unwinding for deferred user callchains
Date: Sat, 14 Sep 2024 01:02:13 +0200
Message-ID: <79e489ab275f6df5bf200747a0e9b878469301d4.1726268190.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use SFrame for deferred user callchains, if available.

Non-deferred user callchains still need to use frame pointers, as SFrame
is likely to fault when it pages in the .sframe section.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d6ea265d9aa8..d618c50865d3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2861,6 +2861,7 @@ static int __perf_callchain_user32(struct pt_regs *regs,
 static void __perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 				  struct pt_regs *regs, bool atomic)
 {
+	bool unwind_type = USER_UNWIND_TYPE_AUTO;
 	struct user_unwind_state state;
 
 	if (perf_guest_state()) {
@@ -2879,13 +2880,14 @@ static void __perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	if (atomic) {
 		if (!nmi_uaccess_okay())
 			return;
+		unwind_type = USER_UNWIND_TYPE_FP;
 		pagefault_disable();
 	}
 
 	if (__perf_callchain_user32(regs, entry))
 		goto done;
 
-	for_each_user_frame(&state, USER_UNWIND_TYPE_FP) {
+	for_each_user_frame(&state, unwind_type) {
 		if (perf_callchain_store(entry, state.ip))
 			goto done;
 	}
-- 
2.46.0

