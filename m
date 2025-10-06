Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FE82DE1FE;
	Mon,  6 Oct 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767718; cv=none; b=MXqHxgm+87tpeIwYJh5yjTLvN70idrawwTMsUSCBEYCUbiXNWfGjFDGKqra6Dvt3dv7Q1evGMms9/7DIgxHARYqXd9vA0EpZpJYB7Z7Ht0o7C2ByftL1TU5Jd6Q7JLP9goCfPozL4IZAl7fzcG8YdMo0G7bz6Xz11P+QwhZEiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767718; c=relaxed/simple;
	bh=a3IPmV5jlnePssZURERzGDN5YmfphWeM3ATbsnwKAQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iRLk+lR1lxNTc14Z6tSstg8EQDtCbIUKpooHa+Lwp1EXWrBoEZtEAjGZrgj+mLJxnaDQg34gS4djkDYT33pcCbZdxVDKHBS4lmg3YnSBfViKwB8sELqnz5mRxBJ+iNZ9E2X3o7fYKKZOFqfm1h6zT+sJe+MF09Nw+3WIvzVR6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58DB21516;
	Mon,  6 Oct 2025 09:21:48 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C43C33F738;
	Mon,  6 Oct 2025 09:21:53 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 06 Oct 2025 17:21:28 +0100
Subject: [PATCH v3 6/9] perf test coresight: Dismiss clang warning for
 thread loop
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-perf_build_android_ndk-v3-6-4305590795b2@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759767696; l=2703;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=a3IPmV5jlnePssZURERzGDN5YmfphWeM3ATbsnwKAQg=;
 b=OsSTrd6d//ZmcbwP7/iVL4/KlsaJyKeaLDALKKWQf+IycnhEC8MFr0EWMFuV+FtOy/8aUMlVK
 XiDTqhxx8s0DHMhBJ9B15cITHrjjtS/ShJAyu37L2/Ngklwrhonzipy
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

clang-18.1.3 on Ubuntu 24.04.2 reports warning:

  thread_loop.c:41:23: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     41 |                 : /* in */ [i] "r" (i), [len] "r" (len)
        |                                     ^
  thread_loop.c:37:8: note: use constraint modifier "w"
     37 |                 "add %[i], %[i], #1\n"
        |                      ^~~~
        |                      %w[i]
  thread_loop.c:41:23: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     41 |                 : /* in */ [i] "r" (i), [len] "r" (len)
        |                                     ^
  thread_loop.c:37:14: note: use constraint modifier "w"
     37 |                 "add %[i], %[i], #1\n"
        |                            ^~~~
        |                            %w[i]
  thread_loop.c:41:23: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     41 |                 : /* in */ [i] "r" (i), [len] "r" (len)
        |                                     ^
  thread_loop.c:38:8: note: use constraint modifier "w"
     38 |                 "cmp %[i], %[len]\n"
        |                      ^~~~
        |                      %w[i]
  thread_loop.c:41:38: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
     41 |                 : /* in */ [i] "r" (i), [len] "r" (len)
        |                                                    ^
  thread_loop.c:38:14: note: use constraint modifier "w"
     38 |                 "cmp %[i], %[len]\n"
        |                            ^~~~~~
        |                            %w[len]

Use the modifier "w" for 32-bit register access.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/shell/coresight/thread_loop/thread_loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
index e05a559253ca9d9366ad321d520349042fb07fca..86f3f548b00631682767665fc5e9d5b8551a3634 100644
--- a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
+++ b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
@@ -34,8 +34,8 @@ static void *thrfn(void *arg)
 	}
 	asm volatile(
 		"loop:\n"
-		"add %[i], %[i], #1\n"
-		"cmp %[i], %[len]\n"
+		"add %w[i], %w[i], #1\n"
+		"cmp %w[i], %w[len]\n"
 		"blt loop\n"
 		: /* out */
 		: /* in */ [i] "r" (i), [len] "r" (len)

-- 
2.34.1

