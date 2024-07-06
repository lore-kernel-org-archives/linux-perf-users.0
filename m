Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A8013F012;
	Sat,  6 Jul 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720290582; cv=none; b=GovrAeCNIp6dkX0XdjW5EsbX351upKRzSm1bjdSPwoCgUe4MYWvycxo7+vgim3oru8P54qIy2vW3Jtmo7nnIkE70AcrXomytGwWDx6fOekxnTNa4uOLPM0tg4yj8l7wl6JcZQI65DQM6nWojRDg+6BncSYDuwSxkmxIdV2gwtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720290582; c=relaxed/simple;
	bh=yNgyEFWkYeDt9gHpsqik/Pv7ObpWw7SzaszTkLU7elM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwYvLwn1Y3Zdny8rwm1h6IfSYGG64FlGvrQwP+IYKk3JN4qY9Rdc2ewr0IpT1rCM+K2rq7uPSKTkRNVQQdn0naZIHycByl4doTrf9TEk99jDztE8OxPiLHoD86gfn6Tc/FNyl5Ws5axAXVwg8Es6DLMSP37tfSe85JOP0Yy6mJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53909DA7;
	Sat,  6 Jul 2024 11:30:05 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7475C3F73B;
	Sat,  6 Jul 2024 11:29:37 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	James Clark <james.clark@linaro.org>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 4/7] perf: build: Link lib 'lzma' for static build
Date: Sat,  6 Jul 2024 19:29:09 +0100
Message-Id: <20240706182912.222780-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240706182912.222780-1-leo.yan@arm.com>
References: <20240706182912.222780-1-leo.yan@arm.com>
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
index 8107e530e433..abfd82595d81 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -212,27 +212,27 @@ $(OUTPUT)test-numa_num_possible_cpus.bin:
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

