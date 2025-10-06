Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDE72DAFA3;
	Mon,  6 Oct 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767721; cv=none; b=hv/7NbNc+gDFAanP0yLOTgun1vOsAZkiEJ11C3ueh5mdduHz0ylNwEyaYZECI7PdtWKDOVYA3JK/R8x24W/40pgS8SLIh4ZeJJQr6RHzCSxtnkGmVmpHBhoHC372aZLBPQ2gHJUJQAcE2m1AhrKLmWQCUIxjNDWXHmpn/NTqVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767721; c=relaxed/simple;
	bh=6JaO7UUmiEVn7pKrHNGJDEz9BYZJxL1KrwbjcRDT7O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUhG0FK66W/bwFsP3yHMAwqzrfCtgf02gUUiOvUAMwWfSzE/YyGCTmmMuteeQu51lCRFRoa7Pf83mlrioh+dbGES5uM0d50fb5Eb46XEJToK1N2h53mhC+W6wmB3j+khvTeRkd1pDOaMgpqGwlgeLWFf+AE1jGWN8g/bgnVAZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2749E1515;
	Mon,  6 Oct 2025 09:21:51 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 926983F738;
	Mon,  6 Oct 2025 09:21:56 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 06 Oct 2025 17:21:29 +0100
Subject: [PATCH v3 7/9] perf test coresight: Dismiss clang warning for
 unroll loop thread
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-perf_build_android_ndk-v3-7-4305590795b2@arm.com>
References: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
In-Reply-To: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759767696; l=1677;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=6JaO7UUmiEVn7pKrHNGJDEz9BYZJxL1KrwbjcRDT7O4=;
 b=Lt1QqvHfOSB9vlFHFsS4Jsx07yuXXDBJvHmH9ANcX4UcxoVzli1my1N8n0DqahPDTvzLHJsdb
 AG1Hvg+beaLDrTNowNSUpqt/TUBAaJzkKKDZ63Txa8cZJotCjhVyBMC
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

clang-18.1.3 on Ubuntu 24.04.2 reports warning:

  unroll_loop_thread.c:35:25: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     35 |                         : /* in */ [in] "r" (in)
        |                                              ^
  unroll_loop_thread.c:39:1: warning: non-void function does not return a value [-Wreturn-type]
     39 | }
        | ^

Use the modifier "w" for 32-bit register access and return NULL at the
end of thread function.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c     | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
index 0fc7bf1a25af3607b40f091f62176134ddb7f9f6..8f4e1c985ca38ab545a05189432a14a6d888d34c 100644
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
@@ -20,7 +20,7 @@ static void *thrfn(void *arg)
 	for (i = 0; i < 10000; i++) {
 		asm volatile (
 // force an unroll of thia add instruction so we can test long runs of code
-#define SNIP1 "add %[in], %[in], #1\n"
+#define SNIP1 "add %w[in], %w[in], #1\n"
 // 10
 #define SNIP2 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1
 // 100
@@ -36,6 +36,8 @@ static void *thrfn(void *arg)
 			: /* clobber */
 		);
 	}
+
+	return NULL;
 }
 
 static pthread_t new_thr(void *(*fn) (void *arg), void *arg)

-- 
2.34.1

