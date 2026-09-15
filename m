Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74964BB5D4;
	Tue, 15 Sep 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487380; cv=none; b=NKbjpsFehdoTLvnfe6cEQUrl8xBYeycoISqVQXo+ACwBj2YdFLkvc5OO23UYLUFim2C5aTctzO5h0NKtPoxp+58yey+4IGPTAqm5ZhObfpjNUOWKBCJ1ubEST48ICTuQc22lMSTUVtQffZLFtslkxUzZ/ikVEhwjwnxUI0/+q94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487380; c=relaxed/simple;
	bh=goYiVNAh7k6LrTB80GAwHLKvpuHR7WeoPkl/mqvmd2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ew7IKT2nMjzI2sPQvx9grhlALat32f0CXo+sQt98/CapwjVt3fB9Bky5iExibQHlv7PaW1Sv9OBKpZ18IqaXyEHm5DNKsc+Ad0vYGob9nKh6r2DQR1XO/txmeDCjvpEpqRs2f5BdLcrZ0t2EDSX/NNKpHA3jXIXh/glvIKk7xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VDu+61na; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VDu+61na"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 813841D70;
	Tue, 15 Sep 2026 08:49:34 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B80203F882;
	Tue, 15 Sep 2026 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487378; bh=goYiVNAh7k6LrTB80GAwHLKvpuHR7WeoPkl/mqvmd2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VDu+61nacaNq62c+Y4fyqJUKJh0gegijVuObVTnfmfQcF7eQGvM6tpV/52nb8UUpi
	 ATAWZFQfTn4LYJlaohsrQzEzkAehS1YaKMmdKqv2fcQbPmUOKH18QuHjdAxZyBYknp
	 s2GQ5gKXdM1YxWd/z3F5Yb3eKO2jJPNLuhPhaYug=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:59 +0100
Subject: [PATCH 13/25] coresight: trbe: Handle an already disabled sink
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-13-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=1564;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=goYiVNAh7k6LrTB80GAwHLKvpuHR7WeoPkl/mqvmd2I=;
 b=1WIYqNYiThALBMj8kG5F4TrNuDDUl31UG37XqvGx0yGPWo0Z05JjSFFwCnQfQd+VJeYGU9hDV
 u623GE8RbunDL+u+YzcnNxXZyS96GY9YwNxS7cwu7g+Ga1JkzGy7oTB
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

arm_trbe_disable() detaches the trace buffer and clears cpudata->buf. A
subsequent disable dereferences this NULL pointer in the buffer consistency
check before testing whether the sink is still in perf mode.

Check the mode before accessing the buffer and return success when the
sink is already disabled. This allows deferred event cleanup to revisit a
path that an AUX snapshot has already disabled after a failure.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 8eb625d3fc99db57a18e35ef59ef814dacf20a09..6da89a890712d32e87a15f7c564ff4dc4d197bb1 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1098,11 +1098,15 @@ static int arm_trbe_disable(struct coresight_device *csdev)
 	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
 	struct trbe_buf *buf = cpudata->buf;
 
+	/* A failed AUX snapshot may have already disabled the sink. */
+	if (cpudata->mode == CS_MODE_DISABLED)
+		return 0;
+	if (cpudata->mode != CS_MODE_PERF)
+		return -EINVAL;
+
 	WARN_ON(buf->cpudata != cpudata);
 	WARN_ON(cpudata->cpu != smp_processor_id());
 	WARN_ON(cpudata->drvdata != drvdata);
-	if (cpudata->mode != CS_MODE_PERF)
-		return -EINVAL;
 
 	trbe_drain_and_disable_local(cpudata);
 	buf->cpudata = NULL;

-- 
2.34.1

