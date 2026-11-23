Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419456;
	b=IF3lV4GUM/I4d2hAiCvH0OkwT/5EzjYwPdbxKLpF8RI7hJ0el13i49Iavzn85H92KnWR
	 t7KD8T0BTWk0fnQ8AjdtfXFuix+KmJgBniQxbO8cgokWrhweg3hZzc8XHMKBFh6+kXsaE
	 wIzXDJ+3RpPSZ8htDoosYfTGGcOokAfMSJjoZ7Wa3MNIBjjzIsqAou2X9eaWjuViADYy/
	 7eiz1gFGqaoT3+Ojd6+i/FWHLzu9agxokqLlHwOt0tnx23ZjatYhqJOTs/CLcTvjk8VVH
	 UQ5KNAw415zkib9qTSXOnSERc6oFC+g2QRwlPV9K5+vm2IFLDov/kxHavcs+FCaAoOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rJQj8diT46gF85iLvVaD+FzVg+GKyURO+Mwx9Pr2V/8=;
	b=rHBdEzGf7XwxEqd1Lm+qMA+drsrUxCFOq7PibqptNLmgCju8hemJUH46drdd5W/M/ygH
	 EfkJNBnLQ24gpsx8/8eSIOCVGMalvtVnZUULwt9gq7D1D86rmzOFVd6Wx2EgQ9peUb0Fr
	 c/Qh3YXQZjmq4Jpn3Napgw78eiR20zODkZEtIR5GcwWUfIfyNLEC7e5SMis1+1bjSlzAY
	 /gsZst6PAtovMGZFPvYbftL+7haQeGbXatFL/460Z4cna3fi7qEN2O5ByzjPDEy0i0Z0s
	 xybvBnW2lACddoVG4TP+Eoa8Or5HzyRAhNgQcVqz3nFFsiABMj/hNi91iQT6bWtReww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jh5YCpnU;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA96606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA96606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jh5YCpnU
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so2362952a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795419455; x=1796024255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rJQj8diT46gF85iLvVaD+FzVg+GKyURO+Mwx9Pr2V/8=;
        b=Jh5YCpnUkEfXv6fYN5/4HZIoqbtFnyazkD8wJxqLU19xivxBvbhJAGtij27r+B4dQS
         kjom1vH8nwa2u09YiSy5huBoWvTfiO/I/j4XtUzt8xlD3BKHxfh30GlfxBEKUNsOkuq1
         FVKAlhb57u6MP/DXEn/HvvaCRFn8A2MpImlea+jBUiCmtvY5qbjCLIQn74G+1cDWYlDQ
         fpU3+wTLbxWMK7YSx7I3Ntwx60+O6xk3KyKbHOFWEN0kvSSFo5Z4l1gZUZ0KEh5H60aI
         8N1xwuslLvqbaYVFIyz0gstGHIvLccxJLmNCwGZfGc8uTe0t9E+FgNwKeLdgSibAi66y
         AD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795419455; x=1796024255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJQj8diT46gF85iLvVaD+FzVg+GKyURO+Mwx9Pr2V/8=;
        b=TVstaiK0TxXYVXp9Ef+tKQ1PvDCOOAZ51yHtdyPfV8o5isS6BTKuvBg11jue7fDTVc
         nMTnNM7EmQMYIAFl3FZwwBGkxDzd+BbgKlGMDVUDaOtfdjNBt/ZJ5HMpPCUFWUpSv5qV
         dqIoyepPqiU4mRWgadKL1H+ARFeYbSHy7UCFA7XLRTT8Rm0svRuHpv/1GTdgZxwWOduG
         pgS8z8kMSIQYwLUEgzxN/dZ4BNPcm0cKp0qxan/pSOGiAKci5cs9NZif2rZL6/V8coj7
         1+nFaOWkmTelBjZ35IuoMIOQIDB1JmnGhiN1YuRJ/dZEXsgRFrgIOwdxa1stlMPn5QMt
         wA8w==
X-Forwarded-Encrypted: i=1; AL+hErFJAaIP/LJuNHHY6luaAaZhIYCa7mPKLsYLYU7A2UDL8Q8bMkiAKx74xV9grpz9ffavtc7px+g1ESdiZtwdFJV2@vger.kernel.org
X-Gm-Message-State: APuU4Z/KRXDtzabigaF3s26xKPAxAca++zyfCosRnvBvwN3NXqTEakxc
	I9si99LnblB4gH+fPxCduiCaOWs3fbOAgQS1EwMoUZrPVz6B4xSRd3yLgpQzQQ==
X-Gm-Gg: AZFdTZdLhVhhWa0EWZGdvi2vPXZAZ4LObeePm3XjOUmwphTt5/UgxolzIeHjIW7eoFE
	2hiwfSaYfysWyxe2Yeb7iq59fgDaQ7NUxH3Rxveyo0FG0C0ySFUnhKFrkY44fe8VzVF8ueRcjYr
	j1BGXkjRFSR0t5tiWvjwCWp3F5CleKpaKcXZdyB7GVrj8K2VjvxagbsYTXkfv2rl5if/Ii8TxMh
	cYMnIOknUMG9yEHbaesZU5LvqvXOlG2uj+gVFxsGxW5h9wY2YhwjqWVxpFriZnlST4kEx1EKNE9
	pyEqXWa8q6jYxRRsmlioDCrd6PBGF/kv0ll6+B8In7gT7ugQAQ9EUxybWKxz+GzEgQhlgjiETJ9
	TUvneHMVSCC95Wjj42KQ24bzqmT26oUxxwxTMSwrS/SxBDNtVSg0duv9U9iug3nEh3i5ym9fOsF
	qlJ1CPtXUPk7TalfrYOOGa5voSi6EPj5buVeVa511vLHa5MVfRNFiut/DTuEdnqsk49qH8cILTW
	smU39ES4FwetGVQ298N/5i9sn09n4APpvROrLoV+Z92TVJkjdpiFfC00tWWab0YJwZyZue806tc
	OfCFxYbSWeg8k+FCFuxZuTDU9MmzhAagpg==
X-Received: by 2002:a17:90b:4c4f:b0:3b1:ae88:5c31 with SMTP id 98e67ed59e1d1-3b41c959673mr10442468a91.43.1795419455243;
        Sun, 22 Nov 2026 23:37:35 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm227222a91.5.2026.11.22.23.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:37:34 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: robh@kernel.org,
	leo.yan@arm.com,
	james.clark@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>
Subject: [PATCH] perf: arm_spe: Probe PMSNEVFR and PMSDSFR filter bits independently
Date: Mon, 23 Nov 2026 15:37:19 +0800
Message-Id: <20261123073719.3190149-1-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PMSEVFR_EL1, PMSNEVFR_EL1 and PMSDSFR_EL1 each have their own
implementation-defined RES0 bit sets, with the remaining bits being
RAZ/WI. The driver discovers the supported event filter bits by
probing PMSEVFR_EL1, but then reuses the resulting mask to validate
the inverse event filter (config3) and never validates the data
source filter (config4) at all beyond checking for the presence of
the FDS feature.

This has two consequences:

  * The inverse event filter is written verbatim to PMSNEVFR_EL1, so
    if PMSNEVFR_EL1 implements a different set of bits to PMSEVFR_EL1
    then a filter using bits that are RAZ/WI is accepted and silently
    has no effect, while a filter using bits that are writable in
    PMSNEVFR_EL1 but not PMSEVFR_EL1 is wrongly rejected with
    -EOPNOTSUPP.

  * PMSDSFR_EL1 holds an inclusion mask which the driver exposes
    inverted, so a set config4 bit requests that a data source is
    excluded and a cleared bit requests that it is included. Bits
    that are RAZ/WI are stuck at 0, so their data sources cannot be
    included while the data source filter is active: exclusion
    requests are always honoured, but inclusion requests for such
    sources are silently dropped.

Discover the supported filter bits of PMSNEVFR_EL1 and PMSDSFR_EL1
separately, probing each register only when the corresponding feature
(FnE / FDS) is implemented. Validate the inverse event filter against
the PMSNEVFR_EL1 mask, and reject data source filter configs which
ask to include a data source whose PMSDSFR_EL1 bit is not implemented.
For missing features, keep a full mask so that filter requests are
still rejected alongside the pre-existing feature checks.

Runtime-tested on Cortex-A78AE (SPEv1.0, which implements neither
FnE nor FDS) and on an SPEv1.2 CPU implementing FnE (but not FDS):
the PMU probes cleanly with the per-register discovery in place,
event filter configs are validated per-bit against the probed masks
with unimplemented bits rejected using -EOPNOTSUPP, and sampling is
unaffected. The PMSNEVFR_EL1 probe path itself is exercised on the
SPEv1.2 CPU, where the register happens to implement the same bits
as PMSEVFR_EL1. Only the FDS path lacks coverage on hardware
implementing the feature.

Fixes: 8d9190f00a975 ("perf: arm_spe: Add support for SPEv1.2 inverted event filtering")
Fixes: e6a27290d800 ("perf: arm_spe: Add support for filtering on data source")
Tested-by: Ping Li <leeonion.muyu@gmail.com>
Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 drivers/perf/arm_spe_pmu.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 707778c67dab..00d54202c59b 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -92,6 +92,8 @@ struct arm_spe_pmu {
 	u64					features;
 
 	u64					pmsevfr_res0;
+	u64					pmsnevfr_res0;
+	u64					pmsdsfr_res0;
 	u16					max_record_sz;
 	u16					align;
 	struct perf_output_handle __percpu	*handle;
@@ -818,13 +820,22 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	if (arm_spe_event_to_pmsevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
-	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
+	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsnevfr_res0)
 		return -EOPNOTSUPP;
 
 	if (arm_spe_event_to_pmsdsfr(event) != U64_MAX &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
 		return -EOPNOTSUPP;
 
+	/*
+	 * The data source filter is exposed inverted, so validate the
+	 * value written to PMSDSFR_EL1 (~config4) rather than config4
+	 * itself.
+	 */
+	if (ATTR_CFG_GET_FLD(attr, inv_data_src_filter) &&
+	    (arm_spe_event_to_pmsdsfr(event) & spe_pmu->pmsdsfr_res0))
+		return -EOPNOTSUPP;
+
 	if (attr->exclude_idle)
 		return -EOPNOTSUPP;
 
@@ -1228,6 +1239,20 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	write_sysreg_s(U64_MAX, SYS_PMSEVFR_EL1);
 	spe_pmu->pmsevfr_res0 = ~read_sysreg_s(SYS_PMSEVFR_EL1);
 
+	if (spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT) {
+		write_sysreg_s(U64_MAX, SYS_PMSNEVFR_EL1);
+		spe_pmu->pmsnevfr_res0 = ~read_sysreg_s(SYS_PMSNEVFR_EL1);
+	} else {
+		spe_pmu->pmsnevfr_res0 = U64_MAX;
+	}
+
+	if (spe_pmu->features & SPE_PMU_FEAT_FDS) {
+		write_sysreg_s(U64_MAX, SYS_PMSDSFR_EL1);
+		spe_pmu->pmsdsfr_res0 = ~read_sysreg_s(SYS_PMSDSFR_EL1);
+	} else {
+		spe_pmu->pmsdsfr_res0 = U64_MAX;
+	}
+
 	dev_info(dev,
 		 "probed SPEv1.%d for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
 		 spe_pmu->pmsver - 1, cpumask_pr_args(&spe_pmu->supported_cpus),

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.34.1

