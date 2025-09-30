Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44326B76D;
	Tue, 30 Sep 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251327; cv=none; b=F8QShiUBjQgo+EStMKd5kKC3USaGJ0F7mht/Emik1Rigixd+OIfDK63lyAHrzc1XmkxfBnaa79XYX3KgWnHI/V2ZDmfEKXtAJH4NtSL+zAx8GpVwZYzKnGsA3IO0/abj12HdXcZ8Mlp3HeKV/w8e0KIb1hWllUnWuz9ZH+vFDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251327; c=relaxed/simple;
	bh=cmg2aP/OdJEbju4k0iOcFl8K9ZROTOnbUW84a1thBFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJRfIuGsMKpHe9XIyHsEc+Y7eNtRzszVwNxzNAJOtHAOk0SqzAavZYm6ETlM80wIQ4KR7NLNmFXF/s1YyFSppO/jqmLIW+MGOdqzsyvon9vmJ7Ud4wK9tW7GhpcLdiSWKf9V5515MevOfbVAn5Xt81ZSUJF5gk1QPlg0L5sKdN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68925106F;
	Tue, 30 Sep 2025 09:55:17 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBC5D3F59E;
	Tue, 30 Sep 2025 09:55:22 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 30 Sep 2025 17:54:52 +0100
Subject: [PATCH v2 4/8] perf test coresight: Dismiss clang warning for
 memcpy thread
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-perf_build_android_ndk-v2-4-2ea440b7ef01@arm.com>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
In-Reply-To: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759251311; l=1020;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=cmg2aP/OdJEbju4k0iOcFl8K9ZROTOnbUW84a1thBFk=;
 b=NzpFUhV66bUX0M0Pm4Pz/PqkXq7i194l89hn5IBh5wwZxXbjFJrR5wji5ol2lgY1iOPzIKbUJ
 7G7Jfxa7djGB4lRZv8rn38KcngiSvFQ6kkU5I/55nYuXDh5YsYtJVjU
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

clang-18.1.3 on Ubuntu 24.04.2 reports warning:

  memcpy_thread.c:30:1: warning: non-void function does not return a value in all control paths [-Wreturn-type]
     30 | }
        | ^

Dismiss the warning with returning NULL from the thread function.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
index 5f886cd09e6b3a62b5690dade94f1f8cae3279d2..7e879217be30a86431989dbf1f36d2134ef259cc 100644
--- a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
+++ b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
@@ -27,6 +27,8 @@ static void *thrfn(void *arg)
 	}
 	for (i = 0; i < len; i++)
 		memcpy(dst, src, a->size * 1024);
+
+	return NULL;
 }
 
 static pthread_t new_thr(void *(*fn) (void *arg), void *arg)

-- 
2.34.1

