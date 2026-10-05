Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13EF4D598E;
	Mon,  5 Oct 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221538; cv=none; b=eBXYI+clsoJ5E5jthx9UfYUd3M8gKo8KPDFk9uTzKLt8VsIOiqUmwpHsrBMSgjZ8PovQ6zWa4Bt0rM0ZwPHt/faUPnW/kVmEyCMe71u3z2G93gujj58jEJUxdsAUt/6ji6Okab7gDQnYrdu0uk9NZOgyzI39YHqutihpLxS+0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221538; c=relaxed/simple;
	bh=BKVfv0k2OyCMMDcsWAzv1mrJvKXYO8lRepgUBSKJ30U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFG+cEX1302ICyMHJXlmbV7rZXord5MZZobl9+qhtwFqwmxetMGeNc+uIXpepESlFyDioQqeDZdm2FeSdHDloIpPaTJFF+0mKBddWPbZbHj+DDQcq+i45j9PAHfFJCphfSwG/enhdJxi06dr8mAT8xh9sOsk6ik5uoEA222TfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC0EXngL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC0EXngL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95549C2BCF4;
	Mon,  5 Oct 2026 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791221537;
	bh=BKVfv0k2OyCMMDcsWAzv1mrJvKXYO8lRepgUBSKJ30U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aC0EXngLKOc/grCSzjcc3R/STFLZ8LdFXJsYzfl8joWnE5GaL1Wk1b704ZIHKybxz
	 vjDhvLsH5iGarcVSQESIJQ9vphWMXfQUhVetoWpgN300abRtmaAO/KcXAKteDIDQnu
	 LA4X2pYG+/ze+VGPjw3oexerWT5ZoaosAJ3szatYCqvtrxl70dgDHbaldECFG7JlgK
	 aQtT8RzZNZiEIp0ikDVU/eYlXzT3bVLz8iS+Jqo684ecrPF3ZXKGtTCBwftJx4ebvN
	 bfB4Oiz2qslpuyBwXzpx7WSwrE5quJhs2MEt7m6P2oVgv0aomFKU8HxLAEq/VQck5J
	 rRSzWj7mOMnMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B7CA5FF0;
	Mon,  5 Oct 2026 17:32:17 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Mon, 05 Oct 2026 10:30:31 -0700
Subject: [PATCH v5 1/5] perf symbols: Fix broken ELF_C_READ_MMAP fallback
 guard
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-perf-symbol-memory-send-v5-1-165dceb2b049@uber.com>
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
In-Reply-To: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andriin@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=H5Vq85Tm8NQPhPTcLutXNXbbky/gSKya9t0e+xIFiws=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBqw98fn4c0zsxhsv+8daOP7kc08sTOPVaozHdgz
 OQbkg3uBUOJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCasPfHxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtjrJg/8DArKUa1VHFXEfK8P76fLWlUbpcxW8XU
 PbyUYxuLQfrezBN6fNCYbxQihOMgxUXK/e9GVOoQ3dqrbR6GX8z/V2/lT9lz2sTNtK628eFxdBN
 EA/lV0U5WIQ8ZOM1QEjN5ON5iuREULFti+fJ80Dq8Udb/bDiz5q7G5QV0pqh0l6vK5WmNL2LvLf
 UHLqfJYQjpel1HpUYW2sWN7S1mWo0ISrmhs/3HT13GWs+bRFIUHVCtWJvU0zs4oHMrYomm1WRZ4
 u1jx5MFMxZ8Z4x4QhKO5pX3Zbi7xj2Jueba1R2S1BAoHMhnLbnL0+RQ6wzKeOusQ0wUu0ULv6h/
 8vqwwKJPWqwbFqJR7/FRpDUus0woDHl7Z4NZmP1LxSWRE2Ag8cMMWcVLS52pkb8Tb0SBJ9HVZ3I
 fp9Iee/G94lBPOSMRF7JpEK5Df+j0ZwdHz2B4cC/u5xhmjGLSv5173/SBXL3zcB32SFyGih3J8H
 z0oTGGY/GfNbf0UXFGC4UxpVe32zE4aPCM7azPDXGDOSqFgpkf8yqvgc0vI3EyTxftrC4iPjtJr
 JAOSN4tDsKohAbxJG6fN5c+H2HmnWvMBa8l7EJ2ccvPitZcZUoJ91EjyznnBp4oujcj1qFfjVdM
 I8OWBotP+it/qxShfH+Oj+7bFTV2lkULXYoZCSAdVk/YODWZMyMo=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com

From: Alireza Haghdoost <haghdoost@uber.com>

Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
detection") replaced perf's compile-time feature test with an #ifdef on
ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
preprocessor macro, so the condition is always false and perf silently
uses ELF_C_READ.

Perf already requires a sufficiently recent elfutils version that
provides ELF_C_READ_MMAP. Use the enumerator directly instead of
restoring a feature probe or retaining an unreachable fallback.

Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection")
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d0bac824c79c..46b1649c64fc 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -57,15 +57,7 @@ static inline bool is_livepatch_symbol(const char *str)
 	return strstarts(str, KLP_SYM_PREFIX);
 }
 
-/*
- * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
- * for newer versions we can use mmap to reduce memory usage:
- */
-#ifdef ELF_C_READ_MMAP
-# define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
-#else
-# define PERF_ELF_C_READ_MMAP ELF_C_READ
-#endif
+#define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
 
 #ifdef HAVE_LIBELF_SUPPORT
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,

-- 
Git-157)


