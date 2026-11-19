Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114347;
	b=aKAuYvUFkQybKWbScNoNgSWsRpLlfnznZUfcHdpqzpGIB+1FNSx5gnPZ+VfOjNKkMY4B
	 yLgQfFlPYQ3FrHqZU661qcQbqYxLNvu4l0U6RL9U3cabm8TiBXXdHf3xau72+1ZI02Hsq
	 Dp5wA5maov7GvazJN6Qo4mJ4AQsbJ0jIFyxbZbGFfEsT+H4lqGo1T+/pDiErfgqCl8lmT
	 gZuD/chdawM3+2/viFDi72pBRBIoDdwhYmpaFDXxFUwwowhsYRpRuVssYCTq1+t0ZpdTH
	 RxuUcwXlDUhfj2H4hpxREb3ErQPG+r95MfOdaFOUHYRuT3VJb+SaNAaNzR8uJFGyzTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bNWLKDAO741BW0/XzcsTHBHCUfXie0HtjfUo7inFESE=;
	b=znrOu6jwJUDO2z4MA3cPAWvdPwaj8HPhoKs8Cv7Qs3XcwPp+NnijOkgryZZXVPJ3aFCo
	 wasP41Ejoapooc9Z8xZySj3u3EzzuAXsTAsR+36fov2qSjmdFq3CHhtQ1N20MK0kkXZyf
	 zaGiouzavBAwgmAmySFPbsMI/q0kVujOI+r5a4z3FAHkMiLjepRzqCxNocaVOl9ejbEmS
	 OpEKfOA2zmZyVhlnv8PVfvX/LPxie7c1rUfAJpbgdB1BWjTnevMd2Ve4K+Zonf2nsv/0+
	 Oyidktdvz2ni6pS08H5GbCvfm2Rz52qIEcAMSB1kaLCo8wU0OqnxADS2ly6Jz9FoADQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lZOrdfUJ;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1219606AAAE
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1219606AAAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lZOrdfUJ
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4e778acdbc6so171552b6e.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114346; x=1795719146; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bNWLKDAO741BW0/XzcsTHBHCUfXie0HtjfUo7inFESE=;
        b=lZOrdfUJxhj4PyuQ+jlK4Nh6fpZaN4LvU3djgNemxAO/MqlPGsv9XnAnP78Rqs+ocz
         GJnevXj/F3VkP/tVFCVJv4SppHGnek68CSWLMj1hrryTZ8d4yEMlCW1FKn8o/vhxWhVC
         +D8JJ0KDK9lR4d4j7TLEMvUZoRsTkGPt4TOJpZM0bnkTftawvIiOtNnq+0msUKrgcE1C
         uRZHrrY3tHpjSQr1gZlFZgZ8JskJNznxheqSr0+8tA+rlLf6CNBsCqMl7dbNF/WG7CQn
         sUM6kurEFVmiwoKsD9VF4vczrG5Cur10YF+BDkEjLtaY5NRyFHHO0xcgebRK+n9oHvhh
         Sinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114346; x=1795719146;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNWLKDAO741BW0/XzcsTHBHCUfXie0HtjfUo7inFESE=;
        b=b/Y8/lilp+DaK3JgAgCVcEP9u6hHKyGXy0oeSQhVyfdqUWOr44u0EnzoXyZD1dmsRK
         E7cD/s1mlVCzgrGvLUbPJqjRsV1pvhvyOpo1KgiDKkWeTHrdgj2Vrbn/XdRDa4mf7Uhe
         3jQAWYnIWZFG0/iyHCKEt1mhAthlnOcHuDLgqbjwDrtn5uE4ncFlr+pTCkkpamH2QT1t
         SHfW/VV3B+Pm7w2OTbUx3RbLdTmSi8NgyDuVvecdkA+AJDaoBGx1zZ54XWivtMBhBy3l
         /TO5xglpPBfizb7pUquDPX5Sl1WnNHmk4GDHVxJvzZMOezwiihcwL078chMIXGcvu0V+
         vQNg==
X-Forwarded-Encrypted: i=1; AL+hErFcsZkkyyxMSOjA8Sz/nFTQdFdbdCvGbCnL6KOnDDw9tWoUxnF+ivTYVsmKhMFPA7YAUeyIFT762G5Wi0j9hEBI@vger.kernel.org
X-Gm-Message-State: APuU4Z8joZzcZOU211Etq3jGe1YJ+wQZIJlpCJ1KDeB3Lpf/tHAtAcIw
	nmDcJ3a3zdzFOBr6BdeKprr6FuggrQrfmcABof9EWSpUzH0Q5mqLIDMRejE9Al+/w/7E4Tc5UjP
	4Nx3+9JZaoRxnHax2kIvHHlcdvw==
X-Received: from iogs7-n1.prod.google.com ([2002:a05:6602:c447:10b0:9c8:85bd:e3c2])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1983:b0:574:4c3f:992f with SMTP id 5614622812f47-57a0bb6079dmr866880b6e.42.1795114345394;
 Thu, 19 Nov 2026 10:52:25 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:52 +0000
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
Message-ID: <20261119185215.632334-11-coltonlewis@google.com>
Subject: [PATCH v10 10/33] perf: arm_pmuv3: Expose number of general-purpose
 counters in sysfs
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

Expose the number of general-purpose event counters implemented by each
ARMv8 PMUv3 instance at
/sys/bus/event_source/devices/<pmu>/caps/num_counters.

This allows userspace (such as VMMs configuring
KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS for a Partitioned PMU on
heterogeneous systems) to query the maximum number of general-purpose
counters for a specific PMU without reading PMCR_EL0.N directly from
EL0.

Suggested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 667ce27d2347c..1676f13cc7c38 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -457,12 +457,26 @@ static ssize_t branches_show(struct device *dev,
 
 static DEVICE_ATTR_RO(branches);
 
+static ssize_t num_counters_show(struct device *dev,
+				 struct device_attribute *attr, char *page)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
+	int nr_cntrs = bitmap_weight(cpu_pmu->cntr_mask,
+				     ARMV8_PMU_MAX_GENERAL_COUNTERS);
+
+	return sysfs_emit(page, "%d\n", nr_cntrs);
+}
+
+static DEVICE_ATTR_RO(num_counters);
+
 static struct attribute *armv8_pmuv3_caps_attrs[] = {
 	&dev_attr_branches.attr,
 	&dev_attr_slots.attr,
 	&dev_attr_bus_slots.attr,
 	&dev_attr_bus_width.attr,
 	&dev_attr_threshold_max.attr,
+	&dev_attr_num_counters.attr,
 	NULL,
 };
 
-- 
2.56.1.708.g77570a6a1d-goog

