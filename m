Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114346;
	b=IoEShrPI4YRfPsp4wY0kZAkyoKYss5NCBzoNtKmCojcd0X50GnugzAv7qssFjB+y7lRk
	 34lfBMcDjKEHMwQe7gH8m4IdnG9hEgY7Zu1SzH54/mXMwbe06unrvWYBHTxsg7UV2c3O7
	 KBQ90cIltkFjtQhe70s9WKHCnjKmGi+q27Y9yFSnynbBpzfAwC83VRc9v0XgHg48dabOF
	 K4kDAA2cVGhsWGQvSCcBx7vRwnZMhmtcZiho8GyQoyOt+WU9sihmSwH9D5VU6lp9sQjy5
	 /xENFRmflR/cuNsQilLrgBbF4Jteo4jqPNz8OSdCuGD1Q7vYONZ3giRnp27NpnwOaaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pLq92bALDfzVSwPCFwlrCOZ9rlSOsAmXjgSBQp7hHGc=;
	b=D0WuFP2eVRIApkYTApmMxVgEEqHq5pDHNF5uZhwKKQrGVLJcRdIj037lqedoy7pfWlLv
	 OEgiPtxV6ZB8o7iCzbeuNoA6nIW3qFElA0PaM+FSMkrjFUGMjv+5AGJ3prlqvTJx5vHlk
	 uPb9Aflg1Pd2NOz0nuqcUob4BSb5pSoEARcst2RNnhlwYATngNIFr1/s0VBaqKusvDf15
	 SNUrG0OdFW5O2t5VyXbVD/cRverrZ27B0CzVjbfPoDYwe+LZQJRETvD1o8yO5VP4X0oG5
	 bf9NvP/bRQRtv0tnmH+w8mAZRoiaxu+BrCnSRR/ja8V5KUIMBSMXHI23mm1yc6Xmquw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tk39+s2P;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3860A6F74
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AA3860A6F74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tk39+s2P
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b597558c4cso178563b6e.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114345; x=1795719145; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLq92bALDfzVSwPCFwlrCOZ9rlSOsAmXjgSBQp7hHGc=;
        b=Tk39+s2PF7TzJCqELszbOhUyF4TYDgFSc/xNOI6cR3l16fmcVNtuohC02GSEIBYfjJ
         8lyf1v1YWJRA0pHtYPiFRUZk1x+qt7hbgEQ1+Sfq6aA1qdH277jleFQij8npLpsEgo+Q
         GLOi3fjdHLmqOTbwgd0L+ATBcdhXzcuo81CDJYR0FLJNT2dcvt9PO2lAt9GxrE5Ltyic
         OXv2BF4klsX1OW/d8/cWZR6tOyqh0uzlT/P4U1Y5YxU+DcCawNy6iinsACcrR9l9/Qu5
         TwDBryt1RZuU+kd/qnguQFYSHmrO6oq/+3p+VY1b7Jg9CVW8fOF8UJgptO0s/ncgyQ2q
         r4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114345; x=1795719145;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLq92bALDfzVSwPCFwlrCOZ9rlSOsAmXjgSBQp7hHGc=;
        b=OuY1g/tvjOqlxvYOIlzRTQcN/mafUMBA+OjsGsXzHARnhVWEqkLQtZaYR5qeVdRXeU
         kfBMvddZ1VM3VTGU1/TAYfmqQbfkJtacxvcA1lw56xlucgFHgkrheiNKSdKMf6n818++
         PwNl45c+fQI2QPUQbt4acF7cFA4m94uWuotM0PD/nq2jptlwOYxw+6mn6eWGDLjbHweQ
         JDA3ynBqkLOaPALdgEZq1PvCrD/PaJVWfLfPHGUdRTCNmW/OGuAyi2A0lp3kr6pVer+4
         DNv8m8QTjZUxfL5KT+Y9n+kuTg0xBu32wpVxKExRnuBvUPIF3rcOfugzlOT8ysbO/XbD
         TqxA==
X-Forwarded-Encrypted: i=1; AL+hErGeuqUkSwlvtw3TyP2xC9TqBBqDvWMHTtBpFHWDN5HXx8XHzqWSSQx652WLi0WCKZAybyly6ZeaIv8oOa9Z8o/A@vger.kernel.org
X-Gm-Message-State: APuU4Z+yxe2idEQbXr71HvjizYPVxvxRq9vG9+s3mCRZAuY8P5dg3rXI
	Af2SoqcIaQ8e8akqtY1F5dH/GZlHHFbybtH3A9ihdl2f9iui9Xkox8KPZO/yuHcwmwux0/4ki/A
	LNjxGJJ6FK2C9qlaqvOYesyikMg==
X-Received: from ioo10-n2.prod.google.com ([2002:a05:6602:864a:20b0:9c7:8645:9285])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:178b:b0:55c:8ed:4db8 with SMTP id 5614622812f47-57a0cbda8b5mr953892b6e.62.1795114344372;
 Thu, 19 Nov 2026 10:52:24 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:51 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-10-coltonlewis@google.com>
Subject: [PATCH v10 09/33] perf: arm_pmuv3: Allocate counter indices from high
 to low
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

MDCR_EL2.HPMN assigns low-index general-purpose counters (0..HPMN-1) to
the guest and high-index counters (HPMN..N-1) to the host. Allocate host
event counters from high index to low index to minimize collisions with
guest counter partitions and avoid rescheduling host perf events on vCPU
load when enough upper counters are free.

When allocating a 64-bit chained pair (even counter idx - 1 paired with
odd counter idx), verify that both idx and idx - 1 are present in
cpuc->cntr_mask so an odd HPMN boundary cannot allocate a guest-owned
even counter as the lower half of a host chained event.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 9ce915754b0a5..667ce27d2347c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -957,10 +957,12 @@ static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc)
 {
 	int idx;
 
-	for_each_set_bit(idx, cpuc->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
+	for (idx = ARMV8_PMU_MAX_GENERAL_COUNTERS - 1; idx >= 0; idx--) {
+		if (test_bit(idx, cpuc->cntr_mask) &&
+		    !test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
+
 	return -EAGAIN;
 }
 
@@ -972,17 +974,22 @@ static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc)
 	 * Chaining requires two consecutive event counters, where
 	 * the lower idx must be even.
 	 */
-	for_each_set_bit(idx, cpuc->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
+	for (idx = ARMV8_PMU_MAX_GENERAL_COUNTERS - 1; idx >= 0; idx--) {
 		if (!(idx & 0x1))
 			continue;
-		if (!test_and_set_bit(idx, cpuc->used_mask)) {
-			/* Check if the preceding even counter is available */
-			if (!test_and_set_bit(idx - 1, cpuc->used_mask))
-				return idx;
-			/* Release the Odd counter */
-			clear_bit(idx, cpuc->used_mask);
+
+		if (test_bit(idx, cpuc->cntr_mask) &&
+		    test_bit(idx - 1, cpuc->cntr_mask)) {
+			if (!test_and_set_bit(idx, cpuc->used_mask)) {
+				/* Check if the preceding even counter is available */
+				if (!test_and_set_bit(idx - 1, cpuc->used_mask))
+					return idx;
+				/* Release the Odd counter */
+				clear_bit(idx, cpuc->used_mask);
+			}
 		}
 	}
+
 	return -EAGAIN;
 }
 
-- 
2.56.1.708.g77570a6a1d-goog

