Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFB178C71;
	Mon, 10 Jun 2024 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013316; cv=none; b=Iaqn9DtF4VFlkR5wnR8y28k19R1yVqDjN10nntaBcgbCiJIUOJr4dQYrJtSZlgjKGe/6z0SVOOOAIesY+PByiN+h+xWAjE7AoKPCaJVZAt4G8K0pj22DlVMnpvIpUfaNFdlmpe6YPjRdaxKO3Z/QvHO1gpxkNcxc9hWS+6/h6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013316; c=relaxed/simple;
	bh=66m4mWoqQDyTgo08cySdR6zX8px99PeFOWizcje8QwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5pea64j3ZleezdDb/+0grRf9SA7tYs0NzVgBBBDja8L68udMmElH8QoIxtb6LR5nfML7QWPs75dBYqmSuXA7TFiCLiwLIg4sEYjtDL9WIHjA+8uzVFZ39aVh4XFHKufmQ/RH6bRd6cdPAMI5wCYMBqzPwUt5HQk9VRwyZHyWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 359FB12FC;
	Mon, 10 Jun 2024 02:55:39 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E7353F73B;
	Mon, 10 Jun 2024 02:55:12 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 4/6] perf: build: Link lib 'lzma' for static build
Date: Mon, 10 Jun 2024 10:54:31 +0100
Message-Id: <20240610095433.336295-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610095433.336295-1-leo.yan@arm.com>
References: <20240610095433.336295-1-leo.yan@arm.com>
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
index b23b3e8ad5e4..9e5663eefc01 100644
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

