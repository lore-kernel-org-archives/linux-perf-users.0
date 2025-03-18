Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9A2147F7;
	Tue, 18 Mar 2025 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330941; cv=none; b=GjBYV8KUthHedEr9ti+pz2TFzmMhZte9N7UP6BW8QTDbUjA6+JCRD737N834ju0j9xxnAI/4mubGZBOucJ5eXrl1drCWvRdDaPwsgH4TjaueYU4hSfhUFuWXuBd8KR49qhnId+X1Sg7n9M9IxQjQ5V/BTdQnERbGqLxg+QT5nkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330941; c=relaxed/simple;
	bh=/PZRRTDVlLur05eM4XoOBcAajZs7m9VrpQi9rIlYK3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr4BJqxcYW5N6kSed3GQv0Y6+KMxjOdtQ5OaJWseyAcmvqG8MTKd3xpfFUQGH8kANlc8C0kKGuDcOYyohJmqkLvjiXxcuEP2+ZpeetFjf/KDX70u5EJT2z4j1C3q61/f/Lue1P4ZIC+Hk+/oo0llJIU4ITh/28Y9AmtMlfq9lRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 175701C01;
	Tue, 18 Mar 2025 13:49:08 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D52B3F694;
	Tue, 18 Mar 2025 13:48:59 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thiago.bauermann@linaro.org,
	broonie@kernel.org,
	yury.khrustalev@arm.com,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 7/7] arm64: Kconfig: Remove GCS restrictions on UPROBES
Date: Tue, 18 Mar 2025 15:48:41 -0500
Message-ID: <20250318204841.373116-8-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318204841.373116-1-jeremy.linton@arm.com>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the uprobe paths have been made GCS compatible
drop the Kconfig restriction.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..8e6fe551f5fb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2223,7 +2223,6 @@ config ARM64_GCS
 	default y
 	select ARCH_HAS_USER_SHADOW_STACK
 	select ARCH_USES_HIGH_VMA_FLAGS
-	depends on !UPROBES
 	help
 	  Guarded Control Stack (GCS) provides support for a separate
 	  stack with restricted access which contains only return
-- 
2.48.1

