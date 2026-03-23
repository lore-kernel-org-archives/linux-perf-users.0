Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9842FF65B;
	Mon, 23 Mar 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256199; cv=none; b=Zy3kf+YEpNAmENE45uf3wgn9wWNUsLBg06xeLGeK2T7vUzm/mcHxiJLvBjfsWdfAc8uxHWoQGJgCU+udb54V+uKqOkYWqi7x+Aun7PfZWZ0cUeh+39KrNtIc2m/cCXui6GgvisNVarNDiddI2U6q1w6Q9jtWTVsroh/DdFrddYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256199; c=relaxed/simple;
	bh=Id9MlTjHLssSvebUxKU7YvmLgOyjXr4gcsYwWX7Mkns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EkJ/cWKrLQ4qijfttq6Q26ElfMTSuWOulA9Ty0i16x1/KhLpzPHBWcFUd4mo8gf5CyTIwVtZE7JVRRvSvk5x/eogDWRsVcERMu5NMe0L2ikiqPRclfGA9AUkLZYQiM9vK5A/4d/P0xMaA3kgRdwX/j8Pa0AKrBlI8wTyF2K6nFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=fAa+4pmr; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="fAa+4pmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vP
	s1gjyr2I+YcPCugyRffk90ma0Gx4N8SOMaT+H/Vxo=; b=fAa+4pmrHhWvuWGNzU
	yWnKiDino3DoLU5THNtgfIz/CIexcykpbG1e5ykGqrl1yLoqwpe6beCONNDwAZKG
	WgMjvK009fppcVxftQmInGx0b1oj6yLr+JQIRbQTM9hcvfAfq7eO9K5xoHTS3kmB
	7QXaeM6ChkAB71OIMSpIPjX8I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3B_lp_8Bpc6ghAQ--.35356S2;
	Mon, 23 Mar 2026 16:52:58 +0800 (CST)
From: Honglei Wang <jameshongleiwang@126.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf symbols: Add 'intel_idle_irq' to the list of idle symbols
Date: Mon, 23 Mar 2026 16:52:55 +0800
Message-Id: <20260323085255.98173-1-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3B_lp_8Bpc6ghAQ--.35356S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4xuw4ktFW7CFyrXw1fJFb_yoW3AFb_XF
	yIgr1F9rWrAry8tFyxCFWrCryfAa1Y9rWkCF1DKw47Aan3Aw4DWFWDAr90gr4rXr4jyrZr
	XasxWrnrGr45GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbEfO3UUUUU==
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/xtbBoAukUmnA-2sC-AAA3e

Commit 32d4fd5751ea ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
introduced intel_idle_irq as entry of those with
CPUIDLE_FLAG_IRQ_ENABLE, say, skx and icx so far. Let's add a new
one to the list of idle symbols to avoid noise.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8662001e1e25..7cff66e7ce06 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -730,6 +730,7 @@ static bool symbol__is_idle(const char *name)
 		"cpu_startup_entry",
 		"idle_cpu",
 		"intel_idle",
+		"intel_idle_irq",
 		"intel_idle_ibrs",
 		"default_idle",
 		"native_safe_halt",
-- 
2.45.2

