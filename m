Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22384AC16D
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270986; cv=none; b=czihOEbSIybADeSJuTqzQ1/9bDU7KbyReP/ubEaA9pxjxMRwcEEwR8g/PraaK4xwoQNghpw/yVG2FrcqBzs3yk/EAOZtSuvbKnrJ1BOmDLPX+CNLlk9AhK7f4paBL3XNkLvIynSa0dQ/TxdlXIMT1XLbSGIA+Cy7C9xy+EwFa4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270986; c=relaxed/simple;
	bh=bOEdgouGHEEo1BIh7aODW7wWmMI80FtXCBdxXzh8Vlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sR0kSGoFz/uA90kuDWZ0/4IgttE1q0sBvGsleIquF+cCfZ1b+Y4zGybzXxaMnNH9i4JdOSdfF6ZEXA34GSJodPzpL2BvjhNJZWSez9DWYwBS5CatJGRmVLptRdoWz+fdh9TEBzm2kOWv69QDt7p8BhwuGubAPjiZSnn7nyH5BXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qqn/9jOG; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qqn/9jOG"
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4519ef1babeso108311fac.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270980; x=1790875780; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5W1e+57WPZC5ylekLTUke1/q6aLnHyh/qcUsGkQ31Y=;
        b=Qqn/9jOGskhPVLxSp6Y2z+oUeLp3Nd7WzyIf6e0MXWTuPI0UmreCUTTT5+Z0bRYg8x
         zMCxfI2Pwp5WR1enkiyXpQHK27njVVKzEXS4+stISpItYtUpGVU/iFvUTO8iayxgvnaw
         kUXhxGmy5GuM/940A2Kj69dsrwwdGCxbd5QAUhZAQHV5nEd6w+L2dTRkDHwguGI4yN9+
         s4ZA/zGFYNS2J0kBHNGliGvKLCP+vmssh8nL6PBLlTHvMoA0mEcDqWsYm+CVs4u9nk+B
         uEXtiAvUxYGpLf8sRAqkv3yldm7Zs/9JOKqqV16XfxURkc/he3I8Ocybb7dz70U7U1bt
         Yu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270980; x=1790875780;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f5W1e+57WPZC5ylekLTUke1/q6aLnHyh/qcUsGkQ31Y=;
        b=di+najZDHH3YHiUTmPF+db3Pb8sQOZ8QikoeOSonUDo9U0BpuXx3fYM9C0dWJfAPpj
         GHxCe12ZNqUWmAEQ6l806yFB9LL1f9r4WMQEV4dXF++ohKoiyAGKJ54lqR+oyarHm7lQ
         wduVtZNHjZ2Y+8S9Q0kvOsUthd137zF7hO6//clniP1j3jCotMx7ehdrHSftGBIh7Uid
         PGyAQnZ9+JbeFo5z/Q8ORZ7mQWPPxoxOUA4Wb5ffORaDH11mMRHfsTz/J+jgjerFFsDp
         DQwdh9/dXaVIJ4BB4DIc+dSHe+7TEuHDdu8SnP1RdiOIHcBcMb6n2DYn76Zk5BIUVJKc
         Ijbg==
X-Forwarded-Encrypted: i=1; AKwUvBwVOnyMhbRCcMMgOhYrFFUc+nm8nFgNRpWAynOXiPFEQcy8NbVgPj5Yo2g45GIwi5l8imI/bVoSJlnQe6srhKfM@vger.kernel.org
X-Gm-Message-State: AFuF++kTEi1ghRdYzo8XdDtIDGFX6dgNe94Ph0EVIcqWBYA+cv3ZI9bk
	/fDxhvkj/E22Hrfsm2glxzUDjucSwWUsBQNzcD32oRFtVZxm+LQuOluwMbbeI+Iarh/3j3hcvKL
	RUXzZwQarIUrruiRd8Hmz3eeZig==
X-Received: from iljv7.prod.google.com ([2002:a05:6e02:13c7:b0:50c:1029:973d])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4703:b0:4bb:5ceb:47e9 with SMTP id 5614622812f47-4d72ac46b14mr3160836b6e.37.1790270979881;
 Thu, 24 Sep 2026 10:29:39 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:13 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-8-coltonlewis@google.com>
Subject: [PATCH v9 07/22] perf: arm_pmuv3: Allocate counter indices from high
 to low
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Zide Chen <zide.chen@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Mingwei Zhang <mizhang@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

To minimize collisions between host and guest counters, allocate host
counters from high to low. How the pivot HPMN is defined to partition
the counters gives the guest the low index counters.

Verify both the upper odd counter and lower even counter are present in
cpuc->cntr_mask when allocating 64-bit chained events so that an odd
HPMN boundary does not leak a guest counter into a host chained pair.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index c15a34684137a..4fcdae8021a56 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -958,10 +958,12 @@ static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
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
 
@@ -974,17 +976,22 @@ static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
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
2.56.0.rc1.310.g51773c2048-goog

