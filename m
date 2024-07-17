Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433C1405E6;
	Wed, 17 Jul 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204587; cv=none; b=oqMGsxqXLLv907aCpIozzik/MVwFoSJG3OP++8P+NoyIQIsfKUwv6S6wFCQqvnwtbHOPrJsDiBUkiMskatSK6AWCQwrcveSHTuSH15AMtFCLptn1RzX81HH3iieQsFi7E4RHYNVwEmoo/dik0EILRlTlKpHWhMP3JroLUNqLKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204587; c=relaxed/simple;
	bh=wo7GIUvNuBV/NXXAqy2+mHPHpop6wUNXRasu8vnTEfA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c050xIycbAJiR9ubil1eI22aybU+sFo2AlFi+qALKrk9uqBZsbCGuJC3xCoUSgrlwue33OUeJJPUUbd7Mwk9EClS+hcBcamjv322jdyXjsecqBfujoXc5YPvZ3C6tbhT18XPfh4OskYC/2x5TE8o5r6oS3/Nk3bPaDXPV+ptd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B3D41063;
	Wed, 17 Jul 2024 01:23:31 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 13C523F762;
	Wed, 17 Jul 2024 01:23:03 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 4/6] perf: build: Link lib 'lzma' for static build
Date: Wed, 17 Jul 2024 09:22:09 +0100
Message-Id: <20240717082211.524826-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717082211.524826-1-leo.yan@arm.com>
References: <20240717082211.524826-1-leo.yan@arm.com>
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
index 08b2be257639..2d5be5c17d65 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -211,27 +211,27 @@ $(OUTPUT)test-numa_num_possible_cpus.bin:
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

