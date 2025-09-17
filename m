Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D273002A0;
	Wed, 17 Sep 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130929; cv=none; b=LTZaODywcb3zVqbBQd02fEGMUiclft9lO1hbtDii1x3EFAzY+iOsVHPuz9Xhcf+bix0AKOW2OAaorw3p09lW4jqqRG7Ef0da6anFzazATRP+U1TZc8cCDnC2MjbpvHXHB/tOgM+7bKE2Di0mtIbLAjgF5873Vq7hF36sMkwloHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130929; c=relaxed/simple;
	bh=/9UdUZ9OJII8IHbRr4Maef/QuxaY9QyUmTQxAX7pvqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1WxwENPVh9Vhvvlj9eAtJhyjuDEDqDV6rpv9u+M1e6vIRXRF+MgkRjGwmB2E+2BVFIfbeGtVkZrv1QNHKN0IXx4RhoBAmbheX9EbdsEQLoE9AkKcEVtnxQ+rvrSQULDFpw1wvaW0tNOOVOO5FNNuesCF7OjCXkiQmPhnRD2dLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D86E726BC;
	Wed, 17 Sep 2025 10:41:58 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D3803F694;
	Wed, 17 Sep 2025 10:42:05 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 17 Sep 2025 18:41:39 +0100
Subject: [PATCH 2/2] perf: arm_spe: Prevent overflow in PERF_IDX2OFF()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-fix_aux_trace_index-v1-2-e36a76ac6292@arm.com>
References: <20250917-fix_aux_trace_index-v1-0-e36a76ac6292@arm.com>
In-Reply-To: <20250917-fix_aux_trace_index-v1-0-e36a76ac6292@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758130921; l=1032;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=/9UdUZ9OJII8IHbRr4Maef/QuxaY9QyUmTQxAX7pvqg=;
 b=x0p7c5gNdLZczsCfpgoOfdRVsyQTPiTO8a7q3eclGz88s9gvUi3g63j/BIGmu+UrjcROmjZ+6
 UCpvygM7/WrALEAZljLPsga55AGq0wDkfpn8JHk/HzPcrAAruaPZDGS
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Cast nr_pages to unsigned long to avoid overflow when handling large
AUX buffer sizes (>= 2 GiB).

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 369e77ad5f13ffb490bf8f128fee5180d1254bc6..8f14cb324e018349fbe19c5c20d92a9cdcfd2e73 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -97,7 +97,8 @@ struct arm_spe_pmu {
 #define to_spe_pmu(p) (container_of(p, struct arm_spe_pmu, pmu))
 
 /* Convert a free-running index from perf into an SPE buffer offset */
-#define PERF_IDX2OFF(idx, buf)	((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+#define PERF_IDX2OFF(idx, buf) \
+	((idx) % ((unsigned long)(buf)->nr_pages << PAGE_SHIFT))
 
 /* Keep track of our dynamic hotplug state */
 static enum cpuhp_state arm_spe_pmu_online;

-- 
2.34.1

