Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5747121516B;
	Mon,  7 Apr 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042815; cv=none; b=Wja/yIvmaotA+xI+UdUMw8Y9kW8aeHuRQEzbpPsmbJuQB3buWcYeT3w+iWRqBnOJqegCFWSloNYUMFGjj5d9wse8BttKqLwDhiDNPCcdYf2o/2lc8qCfLpPTDbJ8/CznB3/4dQw84cpHbtar+uta/E5XsVBMrN3fKerYcLliGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042815; c=relaxed/simple;
	bh=obM2gqiCgCvLNKL1QVcio0LYuOkw8F8jjmVGogoyKg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyjdTT3NfQHuOxeXlkkfrKCzYKpR/KXsKeQjqx0N0TettRrq9s8eWo0qFIP0LJo3ykuPBzuvHgwbDbe1Lbj0c7tupKhA659c4H2dY3WBFf2han2Mfy8L/olRjB0WAsoobI18AHTttg6vJywFplZTSfnavx+f2lrH3I6fmOCKmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C4251CC4;
	Mon,  7 Apr 2025 09:20:15 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C87B3F694;
	Mon,  7 Apr 2025 09:20:13 -0700 (PDT)
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
Subject: [PATCH v2 6/6] arm64: Kconfig: Remove GCS restrictions on UPROBES
Date: Mon,  7 Apr 2025 11:19:51 -0500
Message-ID: <20250407161951.560865-7-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407161951.560865-1-jeremy.linton@arm.com>
References: <20250407161951.560865-1-jeremy.linton@arm.com>
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
index a182295e6f08..b962a1321ebf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2236,7 +2236,6 @@ config ARM64_GCS
 	default y
 	select ARCH_HAS_USER_SHADOW_STACK
 	select ARCH_USES_HIGH_VMA_FLAGS
-	depends on !UPROBES
 	help
 	  Guarded Control Stack (GCS) provides support for a separate
 	  stack with restricted access which contains only return
-- 
2.49.0

