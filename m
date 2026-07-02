Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28CA310779;
	Thu,  2 Jul 2026 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011948; cv=none; b=UbUb2N/Q1VQIiLoc7hDDJg68Al9BBJEeGTMS8LMks2n7Ncdo7Iig0XUK7CFM3sOcBJk3YgMb+iVg6s8NX684IBZWRxB9KrYifnmSvjSmvR/IYj4QPoEVAY0P6BQ0Sp/nsJJif2Mi4OvvlN+yek5vsHB6aYjleYFzNMDk5KPdm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011948; c=relaxed/simple;
	bh=Z9D2qSGiQ3LAherp1GRKw5aRfHCfU8hdsMJK5H8Q3ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fairruJibEUmju79/NFpwEaWPcsk+Td4YIpcKzHb8MPEA1LacKs7lBbjfzi0gWrSfANZLCBjnE3OJuWI3oMUE43BJIsq9WIfmOKpi9CxFlRe5lViE0Ids2sBwJVxfAmJML0r9T+SCob4J+HEyklI5cJdTv9BuhdrHVMjArxCPCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WoFGd+hD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WoFGd+hD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD021D13;
	Thu,  2 Jul 2026 10:05:40 -0700 (PDT)
Received: from e132581.cambridge.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C45693F85F;
	Thu,  2 Jul 2026 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783011944; bh=Z9D2qSGiQ3LAherp1GRKw5aRfHCfU8hdsMJK5H8Q3ec=;
	h=From:To:Cc:Subject:Date:From;
	b=WoFGd+hD+1SmysK0Hg7D+TgbciBIQ1Yz5/zPfkz09h1tlTPKFC6VaoTwLcUHeREHt
	 ITNryvAtnJ3LjYHn6JORWcbL1y6EIBSI4D+/OSu9rO2/cDrSJKM4fvA0qnyoVhBld7
	 UmWBOTm6Q2aaFDuO5WkeK/jaAhCVZ3mnWTJ2MUaM=
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf: arm_spe: Make wakeup range check overflow safe
Date: Thu,  2 Jul 2026 18:05:21 +0100
Message-Id: <20260702170521.4103426-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code checks whether the wakeup point is in the current
writable range by comparing it with handle->head + handle->size.

The perf AUX head is a monotonically increasing index, so that addition
can overflow when head is close to ULONG_MAX. In that case, a wakeup
point which is still inside the free space range can be missed.

Use unsigned subtraction to compare the distance from head to wakeup
against the handle->size. This can dismiss the issue when addition
overflow.

This is unlikely to happen in practice, but the change makes the
watermark check logically correct.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index dbd0da111639..b64cf2313a20 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -577,7 +577,7 @@ static u64 __arm_spe_pmu_next_off(struct perf_output_handle *handle)
 	 * the page boundary following it. Keep the tail boundary if
 	 * that's lower.
 	 */
-	if (handle->wakeup < (handle->head + handle->size) && head <= wakeup)
+	if ((handle->wakeup - handle->head) < handle->size && head <= wakeup)
 		limit = min(limit, round_up(wakeup, PAGE_SIZE));
 
 	if (limit > head)
-- 
2.34.1

