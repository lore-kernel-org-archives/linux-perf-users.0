Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601821CA02
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184259; cv=none; b=kbAr3Vu+irHLCX8qz9l0ES7Vv6jBTJmieBdYAluTb+31l3vu5SMG489t/RHRfT0muPDrzR7iBTPpq64MeqyusRbZHyPWxMXmxXb76RNBwHcGR9HMXxUycQJ25QKgjU1tkJWaiMFxo7GEPfNCIoDmFEsL0QhmnO+a4EBgfa7cjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184259; c=relaxed/simple;
	bh=J2NUFjvvXMu9+MHY1GKuFX/hcjZoK4TGwPSbICa6OJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eTpsV8/pUOuchyR1fuW6n0zKSwroMUwb9OoM/2YUJEeT4sDC53pg9sf8pP3sDRYL5F/Oz7Zebe8C59jLDBge/MTx3tjP3Jn7nsKiSltMLflPng/8aGdIdTrE2aZrodcQoGJCLRx2TqIh1ZeAXzvBQytKuKE9bMi9y3Iq75RBz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0LNyTYW; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0LNyTYW"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48049955f7fso18039025e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 08:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769184256; x=1769789056; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRaAyzpQLD9z0tMt/n74ydmpLXpoLNEfmnc5Kofzl7k=;
        b=G0LNyTYWnCXnECn9ZETLZhUbyRAJVSlwrXXayexjEGi2y4IlEvhL0hHci/Y6d2pCt5
         GhMZXK3zDCsFn+iVxv6T9BawoazHbRC1nkd22vhmRMmK0Svu0dr82f/n6njwFiTw+Ag9
         hsJp6pFDgt2P/kwEqQWSPi6pKjco5J1YD1HJVwF0dVn7E33fhBlMVP3Mg3LKH6oRS9OF
         HwUENDLa/3xuFwzCKSgcVKpmax3CvqzI7NMJTBrEO2+t6K6l3p9lvysRdza9lfrCpr17
         R/43xU/Vx10LrRl7SWtGDlrqcklfSkh+uMY1/5EpuI0a1ZJsjzkQqiAC0BRnc7d9dULl
         h9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769184256; x=1769789056;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRaAyzpQLD9z0tMt/n74ydmpLXpoLNEfmnc5Kofzl7k=;
        b=g6+R6+lPn9cUQN3tGY9a1+J1keko+JEiKAuDnuhYOVpCVHuImsV5C6OzNE7VWRRdWp
         k/WKat6C6ejt7kVT512S/uWXuWYv4djcDhBgzGdEbZ60Ew0nyiU2x5zvjDfc0uUnaqQz
         IQUr9NxKkgQ7/Tf/+SenZZ2rCE0AHKeYKd12h1gcKkvZeBnZMnwPrK8i41FUoaN6GMB1
         HRJVnnNqu+aL8AQbkZThFZUPd35WD1ozy+m8klxzaFwijcCu1M4kDsj5hVKRNoOWPIWO
         Qdt61+EpTjH9RHQ+efMEqAMOGWQZqANorjkG/B5db/jvHnyn43aDlvuZWXjOYwHMsYLz
         u62w==
X-Forwarded-Encrypted: i=1; AJvYcCWyS6hPeuWPSociY8dGIbodtczxlYPavMd/79aisQ4wg4X4n9jYhXhkLw1bKCnrSujuwNVoZgYSG49GkuSuxPhu@vger.kernel.org
X-Gm-Message-State: AOJu0YxkR4KjOHfwpIHoaqR5GC/DF3+XbWE53jcsOAyUIIS17eA0ll5r
	BWSmF27ORFe7av9iiMQbe9AG4cJzL+CGWn/2mq+0laTUL/ow6TvWmNh3tINNrlVSa/8=
X-Gm-Gg: AZuq6aItKcnJ9nT8zgjIJLP2Ok1fHblHrMTHx7FytuGkdUzikwgL+ihoZEJP3yHBDZq
	YPCvHyI+yhVdMOu5vnAagZNvImhYZ7TOhHf/7PTZF4tKELc4Az+QfPIzVOSJ4SQuiQXEOD29Bos
	1oa0/tia5oiaT0kPBtHQ+IPYhN0SYTA109IR5OcYQXX23/2yON6VCCceyCuRLIo2KgmbHut0Emk
	QcQo29DP4R7CoKlgEse2H5aX9JL+BQn6K8zrkJRcUraKuTQ4uF5Pq4LLSw8du/XNzqf1RK4wOJ1
	faNoqYUjcuLhzsy07lyqoKPcs4qik6/Qfl6wVGBaZUtPgSFU8Txl7lNIepqfxhIm2KVoiGv5YfB
	VciQJqbYgQ1qxT4YSRkv4AQ8IRgKGCDpxFumfHtrJ3tU5wv1D/aNKwLbqsw2DtGBhjFeZwAVF9f
	5rs4EqJOitY1LW7Om3GcB9
X-Received: by 2002:a05:600c:638e:b0:480:4ae2:def1 with SMTP id 5b1f17b1804b1-480511f42d4mr29154775e9.13.1769184256022;
        Fri, 23 Jan 2026 08:04:16 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm7382016f8f.38.2026.01.23.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:04:15 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 23 Jan 2026 16:03:53 +0000
Subject: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOibc2kC/x3MSwqAMAwA0auUrA3YClW8irgImmrET2lEBPHuF
 pezePOAchJWaM0DiS9ROfYctjAwzLRPjDLmBlc6X1pX4UIbK2pkTLzSTWcGOHrv7FCTb0KATGP
 iIPe/7fr3/QABhG0pZgAAAA==
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Alexandru Elisei <Alexandru.Elisei@arm.com>, 
 Anshuman Khandual <Anshuman.Khandual@arm.com>, 
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The Arm ARM known issues document [1] states that the architecture will
be relaxed so that the profiling buffer must be correctly configured
when ProfilingBufferEnabled() && !SPEProfilingStopped() &&
PMBLIMITR_EL1.FM != DISCARD:

  R24557

  While the Profiling Buffer is enabled, profiling is not stopped, and
  Discard mode is not enabled, all of the following must be true:

  * The current write pointer must be at least one sample record below
    the write limit pointer.

The same relaxation also says that writes may be completely ignored:

  When the Profiling Buffer is enabled, profiling is not stopped, and
  Discard mode is not enabled, the PE might ignore a direct write to any
  of the following Profiling Buffer registers, other than a direct write
  to PMBLIMITR_EL1 that clears PMBLIMITR_EL1.E from 1 to 0:

  * The current write pointer, PMBPTR_EL1.
  * The Limit pointer, PMBLIMITR_EL1.
  * PMBSR_EL1.

When arm_spe_pmu_start() occurs, SPEProfilingStopped() is false
(PMBSR_EL1.S == 0) meaning that the write to PMBLIMITR_EL1 now becomes
the point where the buffer configuration must be correct by, rather than
the "When profiling becomes enabled" (StatisticalProfilingEnabled())
from the old rule which is much later when PMSCR_EL1 is written.

If the writes to PMBLIMITR_EL1 and PMBPTR_EL1 are re-ordered then a
misconfigured state could be observed, resulting in a buffer management
event. Or the write to PMBPTR_EL1 could be ignored.

Fix it by adding an isb() after the write to PMBPTR_EL1 to ensure that
this completes before enabling the buffer.

To avoid redundant isb()s in the IRQ handler, remove the isb() between
the PMBLIMITR_EL1 write and SYS_PMBSR_EL1 as it doesn't matter which
order these happen in now that all the previous configuration is covered
by the new isb().

This issue is only present in arm_spe_pmu_start() and not in the IRQ
handler because SPEProfilingStopped() is true in the IRQ handler. Jumps
to the out_write_limit label will skip the isb() but this is ok as they
only happen if discard mode is set or the buffer isn't enabled so
correct configuration is not required.

[1]: https://developer.arm.com/documentation/102105/latest/

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: James Clark <james.clark@linaro.org>
---
A previous version of this was posted here [1] bundled with other
changes to support running in a guest. Since then the known issues doc
linked in the commit message has been released so this is a resend of
only the critical part that also needs to be fixed for hosts.

A redundant isb() has also been removed in this version which is not
present in the previous version.

[1]: https://lore.kernel.org/linux-arm-kernel/20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org/
---
 drivers/perf/arm_spe_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 4801115f2b54..62ae409fd5b4 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -639,6 +639,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	limit += (u64)buf->base;
 	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
 	write_sysreg_s(base, SYS_PMBPTR_EL1);
+	isb();
 
 out_write_limit:
 	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
@@ -780,10 +781,8 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 		 * PMBPTR might be misaligned, but we'll burn that bridge
 		 * when we get to it.
 		 */
-		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
+		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
 			arm_spe_perf_aux_output_begin(handle, event);
-			isb();
-		}
 		break;
 	case SPE_PMU_BUF_FAULT_ACT_SPURIOUS:
 		/* We've seen you before, but GCC has the memory of a sieve. */

---
base-commit: c072629f05d7bca1148ab17690d7922a31423984
change-id: 20260123-james-spe-relaxation-d6621c7a68ff

Best regards,
-- 
James Clark <james.clark@linaro.org>

