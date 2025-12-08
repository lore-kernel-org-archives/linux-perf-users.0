Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A64A35;
	Mon,  8 Dec 2025 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765160200; cv=none; b=BClbShfkQg71j1SHL20gqnjGKrzapx6WWu4HKh73bkRQPa+2HivBIYQvGpUGdazdHvky6H/gW+PsRXh9fMI0vWU39QN5BHsUwQva+IGAsuDSHVnXLjHIpy6vFPpRwRX+chPt280jySGC5T/SAzDF9998bP4P8P2cb0TJ7LAQBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765160200; c=relaxed/simple;
	bh=jbqwtaTlwL62NVEuqmGDBIMo+picK/IFUvAAOO7jjOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmARWfN0Oy1ehvBIjgG8UJvb048MTwbCBy5PF4/IpBYdKYUfLjx+iB2wjefVP/LtFX8dTJ/6nhi7m1vKkeOEfXPsly3iYe0YKT4TlURTXf0Uq8x5r3fwFO4PmU7HAc7FvwVFiHOHdbA/kSHn11XBKJ9juBowrTbx36K33lZSuEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fCRWUR4D; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fCRWUR4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c6
	pq6gpDlehKMCuUUreYTwyBFsZqSoCCA8ybXdRfkRc=; b=fCRWUR4DNfmgtZF45J
	9Fbwb0TnmDhxB2Sk3DqmMDaYfD+75c0QTwZRaL+KG6CzeMDzkLM65gFxQBn5PUzq
	SmMfEh+sbTPmsDBcQ0QcuOQPzdUIYRQP+0EOibh04vfmwo1fYjZCDHTJj2cjbYFR
	agHmr39PWddwjcSygRAZpmER8=
Received: from haiyue-pc.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3Hsa_NDZpr9qQGg--.134S2;
	Mon, 08 Dec 2025 10:15:30 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: linux-perf-users@vger.kernel.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v1] perf tools: Add the legacy-cache.json to .gitignore
Date: Mon,  8 Dec 2025 10:15:14 +0800
Message-ID: <20251208021524.10101-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3Hsa_NDZpr9qQGg--.134S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry3Cr1rGFykCr1rXFWUArb_yoW3GwcEkw
	4xGryqkFW5trnYkry7JF4fur4Fq3WrA3s5JFy7KF15Jw45tasI9anYy3WDCFW5Gay5G342
	kwn8Zr1UZF4xZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRK5rcDUUUUU==
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbCzgIlkGk2NMJLqwAA3w

The commit 0012e0fa221b ("perf jevents: Add legacy-hardware and legacy-cache json")
will auto-generate: "pmu-events/arch/common/common/legacy-cache.json".

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index b64302a76144..5c59f954f52a 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -36,6 +36,7 @@ config.mak.autogen
 util/intel-pt-decoder/inat-tables.c
 arch/*/include/generated/
 trace/beauty/generated/
+pmu-events/arch/common/common/legacy-cache.json
 pmu-events/pmu-events.c
 pmu-events/jevents
 pmu-events/metric_test.log
-- 
2.52.0

