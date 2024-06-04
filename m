Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F7414534C;
	Tue,  4 Jun 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493571; cv=none; b=TL4Q7EOg/4WGAcI5qUKQYyL+RZX37tC0XV8BpK38fOsrl+sKA2gZzC6PK8yn10FCPiFlMyv2KTbrxYM+gVUagGFnuPE+zlOOqsMYN/F6f7vRt3J2ipEVQsjOTxTkJ7kURzkwuHOOlRH306ScEftucnDj4nQ4DidUPHY7YjlrIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493571; c=relaxed/simple;
	bh=EzGLbDGq3jstPVn9G98FIOjt8qMcsCAL/4PAIvj0ZVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiG1U+LmNG0VBopdoQ+EvvA6JJc7x3B7IvZzLQcPeuDgdO6BUGLEBbWz7s9aROzUikKruyLoMx6Yn8p3Jm/X0lEr6ediibjEl/7tuOAuYZq5x4LTKsGhigsvZObfJyVaEqI+1QtRrvq5f0JKF/QJA/Zj08bQOGv8fyyvw0vNtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 653BD1042;
	Tue,  4 Jun 2024 02:33:13 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 585E43F762;
	Tue,  4 Jun 2024 02:32:47 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	"Mateusz Kowalczyk" <fuuzetsu@fuuzetsu.co.uk>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 5/6] perf: build: Link lib 'lzma' for static build
Date: Tue,  4 Jun 2024 10:32:22 +0100
Message-Id: <20240604093223.1934236-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604093223.1934236-1-leo.yan@arm.com>
References: <20240604093223.1934236-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libunwind feature test failed with the static linkage. This is due
to the 'lzma' lib is missed, so link it to dismiss building failure.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 2f4cfb7b8c14..18aa6e654804 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -200,27 +200,27 @@ $(OUTPUT)test-numa_num_possible_cpus.bin:
 	$(BUILD) -lnuma
 
 $(OUTPUT)test-libunwind.bin:
-	$(BUILD) -lelf
+	$(BUILD) -lelf -llzma
 
 $(OUTPUT)test-libunwind-debug-frame.bin:
-	$(BUILD) -lelf
+	$(BUILD) -lelf -llzma
 $(OUTPUT)test-libunwind-x86.bin:
-	$(BUILD) -lelf -lunwind-x86
+	$(BUILD) -lelf -llzma -lunwind-x86
 
 $(OUTPUT)test-libunwind-x86_64.bin:
-	$(BUILD) -lelf -lunwind-x86_64
+	$(BUILD) -lelf -llzma -lunwind-x86_64
 
 $(OUTPUT)test-libunwind-arm.bin:
-	$(BUILD) -lelf -lunwind-arm
+	$(BUILD) -lelf -llzma -lunwind-arm
 
 $(OUTPUT)test-libunwind-aarch64.bin:
-	$(BUILD) -lelf -lunwind-aarch64
+	$(BUILD) -lelf -llzma -lunwind-aarch64
 
 $(OUTPUT)test-libunwind-debug-frame-arm.bin:
-	$(BUILD) -lelf -lunwind-arm
+	$(BUILD) -lelf -llzma -lunwind-arm
 
 $(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
-	$(BUILD) -lelf -lunwind-aarch64
+	$(BUILD) -lelf -llzma -lunwind-aarch64
 
 $(OUTPUT)test-libaudit.bin:
 	$(BUILD) -laudit
-- 
2.34.1

