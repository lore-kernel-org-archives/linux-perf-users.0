Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0121DAC90;
	Fri, 25 Oct 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853548; cv=none; b=aoPx2ag84cbV+JR6KCutiIVDWit8TJk6TsXKhmN7Q8ewmsHJ2fLsM8Vcij8OdJpOgrc2gNmZ3z82rBJn0oR3gstTTtLdPAu+c2trDksYhNZYZFkFrGqyv1ImUG/9gGYvdxtj2IWYw/O8V+PZGvtkzz83r/v4gFbJCDC3QJGY15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853548; c=relaxed/simple;
	bh=SkhNz5Cxy9j4StmMS3kFeTFiAuFuEeuILFkfOBbdakY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mzk2wIDfxzgx1xY2ijksJG+sHpGK1Rd9O5gtVJW6tkGsn2kqxxIjqGZzUI55XdN2HDoZ/H4seinUxw5HtWmi9xMuzPeExhuizO00DXhs8he8h75P5D2c9rul5VUPZsAeJAaMBGO7avowxzp8UCu89xPSgYIdIfgOBc7Q9qnSZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12B6E497;
	Fri, 25 Oct 2024 03:52:56 -0700 (PDT)
Received: from VDW30FN91H.arm.com (unknown [10.57.79.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 144843F73B;
	Fri, 25 Oct 2024 03:52:23 -0700 (PDT)
From: Graham Woodward <graham.woodward@arm.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	Graham Woodward <graham.woodward@arm.com>
Subject: [PATCH v10 1/4] perf arm-spe: Set sample.addr to target address for instruction sample
Date: Fri, 25 Oct 2024 11:52:09 +0100
Message-Id: <20241025105212.51779-2-graham.woodward@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241025105212.51779-1-graham.woodward@arm.com>
References: <20241025105212.51779-1-graham.woodward@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an instruction sample, assign the target address to the field
'to_ip'.
If it is a non-branch record, to_ip will be 0, presenting a non-valid
target address.

Signed-off-by: Graham Woodward <graham.woodward@arm.com>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 138ffc71b..76d41c91f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -400,7 +400,7 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 
 	sample.id = spe_events_id;
 	sample.stream_id = spe_events_id;
-	sample.addr = record->virt_addr;
+	sample.addr = record->to_ip;
 	sample.phys_addr = record->phys_addr;
 	sample.data_src = data_src;
 	sample.period = spe->instructions_sample_period;
-- 
2.40.1

