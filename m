Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966553EDAD6
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929518; cv=none; b=B5Z7v68CPp8af+eKfqKuY/AzPilVzMR6F4x6N4LUaCPyG8rX+77xYE5yJNUxpAimeThWzaykhtdbsmEbygdGU1hqz0GQn8JweWfZ27cOor7LnO+NqwGL/96CAqxXMMcbM5ODqbA8SnunpXVpc/YPnlb3wQiUt4qWRuHEg6HIO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929518; c=relaxed/simple;
	bh=Kt0JxjDXw64yyFAEbn3FTtOy6aQbbH4PD8HMmdQ27Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QYavhy0JJm0pvuMQkMuSf82aGLnf2VcUIQpmTEx+ZKIvEuxBvWwu9Eh0+uUjEP/L0haA3YD9C6fdCV+PBHb5WGyv4Zyw/UdGVGkeN9YX/bMWG7y1BUnXbZ5586N6U/kTQZPQf2yh2p17VJ7iJLpHkmR4lXKk6namCGpTlQZxQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlhMW9VE; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlhMW9VE"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7dcde7bf859so10210907a34.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929514; x=1778534314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpZCDOiFD5ADpp1wKWAJRO360JAEeKFaw0Z2nRZPnRE=;
        b=HlhMW9VE0NFY70PhISGn17Oofl80Z56pJcbBKpIluqSVljhaZ8buUUJO9fzngWsVdL
         Fy+ZafFrc0cZFRXAvUMSfROgONzy9Nnd6OZmVBN4PIAw6cUdb3yPkcjc364kUKimMp7M
         RWp0ahV1XdNXjbmIU1+DALrzRCBW3eiMpfsjzd1gNNZmcWCyQyu5Iu0AXnAOnf4V5W2h
         Vnz3U95GVyzS0bSiEL+zNk71PrescclXwHhvqe5PRchMLvr5mFxPcvhcplqcSFF9e9y7
         iGjcPAW+flEX1gE79anaXR2MLqwoSOvp86M8He78uA13Aw31nspLJOoYx4mjNMnfQnkH
         3/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929514; x=1778534314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpZCDOiFD5ADpp1wKWAJRO360JAEeKFaw0Z2nRZPnRE=;
        b=ryd9vd6vkjrxLrEBZZHI/I4q3Yd7LgoC/RWc0p8m8auDykJVGCH7PkZ+95Wj/b/ou9
         Ckd/uk2jXtDDVjVhoyEiOr+9xdKMfAuATSSbRUZo3mZcf7UwLjjERIyiVgjSPYIVArjJ
         By3kbe0aRYgAXrxd6DHqosiDGZk/fEssl+4iRc7T/xz5aJoYHXOfdXgoLEjQLu6qxLXr
         wL+27QV+RykvePEHNaQPuT1PNrKHSHosJpkxX449UxX6AMYoTrv+wxckVyinHccyD3nx
         rNQl16E/gctgV7k7H+ryYQpmX3gUEWx8BdV5BO2xxUf7Haq7OYK72Q9kbD9CFSsJ1Lxg
         c9bg==
X-Forwarded-Encrypted: i=1; AFNElJ9e2BtLOJbujzilB9Syip/LfLpljf86jSDcrEUEGs77MStxIX39TStTpi9YnyOZXh/TC19hm01axFoRU5ktVvm7@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqTmfqiMO5apCXx4iRxvLpnnf+L1SfjFVaL4BbWYm7LzZuocx
	0NTCs5TyrW5ZL/Oc6+roP8YiOE5d+06JwyIrKcLqPUGNx8CUD79Z2KtRolA6DQ1+0g/hFa24mN2
	TD2pkxik1SPCiA1c8NRDXflTnkg==
X-Received: from ilqa6.prod.google.com ([2002:a05:6e02:1206:b0:4fa:1fcf:cad3])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:99b:b0:694:8bfa:7817 with SMTP id 006d021491bc7-69697db8330mr6011884eaf.53.1777929514318;
 Mon, 04 May 2026 14:18:34 -0700 (PDT)
Date: Mon,  4 May 2026 21:17:58 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-6-coltonlewis@google.com>
Subject: [PATCH v7 05/20] perf: arm_pmuv3: Check cntr_mask before using pmccntr
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Check cntr_mask before using pmccntr to ensure it's available. With a
partitioned PMU, there may be instances where pmccntr is being used by
the guest and will ba absent from cntr_mask.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 1cceb1f614515..7ff3139dda893 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -993,6 +993,9 @@ static bool armv8pmu_can_use_pmccntr(struct pmu_hw_events *cpuc,
 	if (evtype != ARMV8_PMUV3_PERFCTR_CPU_CYCLES)
 		return false;
 
+	if (!test_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask))
+		return false;
+
 	/*
 	 * A CPU_CYCLES event with threshold counting cannot use PMCCNTR_EL0
 	 * since it lacks threshold support.
-- 
2.54.0.545.g6539524ca2-goog

