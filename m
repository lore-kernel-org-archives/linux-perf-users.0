Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997159;
	b=uZL0iGJfLl38L+AGrH6nUDyFntIHwFv3Rkf019QyMw5Op2yYdNO0tgQ89QDuVwx3qDEV
	 45ylM7dYwZN657mDsSUyid0UrNzFOd0zxW0nWOvFPmzoGSUO87XV6UMwyIpd7iJ+tjVvM
	 TN6a35RjEMhn576r3jxpWvHcgvwLv21qDgo63+zto5TI8uUuSeFVAT/qaGewUCNzK4zO1
	 XvP2NJJVA6TyH/eXTcnRr1hURmk/QirVZX4Z49T+jW+rEExU14nfZHdb3oQOT9XQ7tgfx
	 BmrXwriYuU1XbLN0hMq4wI8LOApt6jprNPVZq1PIAl0q+XlTt+zyzPpuvfmGn0+GHnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yvyTQy7QXUkCqUdPoN6xekhnCdJic/iB4Nnp6WsuGuw=;
	b=AduSn7qLrbsGoT7X+8HNuIz1smvFvskHKBzoE7MflfcGcDlzIkyiYrVoQohNcgKdfpFj
	 kX4dwVFPhsQuOtlxj3mqyEy+VnwySJoeUNHZ+XztXRwPFmRowQZQrWTtMmigU4aQeh3la
	 BKuag+xdx+s9zSdUre0JCafXzz85gKCCyXmqxx+GIz+ei+arwv2A1pbo7pfdZUVDoyCUm
	 egr7OAYIt2ZY2X3/r2KzZ6kKOiTLBbHCnQuFYWmmsnIILw84PbKpNWMnv1hC/Ldpirf3i
	 ByKMif5SosWiU5zsci6O+qvWLI2h5bfkikzpSDJVNJAxqTqa5il/DqaD9mPJDE1UGhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--amitamishra.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Af+RmXH4;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A41606A32F
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 10:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A41606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitamishra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Af+RmXH4
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cddc4bde4adso567466a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 02:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794997159; x=1795601959; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvyTQy7QXUkCqUdPoN6xekhnCdJic/iB4Nnp6WsuGuw=;
        b=Af+RmXH4lmOl1Zkkgo/zqrNLUdoc6JZg+vynU4oZoEtYIb0XE722BWtdDyLwYymzrD
         rOUsB1J97x7PIrU4RJzBMIj5wlWDw6duluvOWChfes+dM6imoEOUK8gGSiqLC6s+NDOh
         0LwUUxwDNjMn0lE6pXZJlWxYS1FWca0UY7B8y5NqtP2sfquAFdoR6FQW7pSBFgPk7FLa
         lPwsMXd5nekKWpH4aOzP/I97iBRX9btMNKSzJMgZGBFL3BrLQBkCBhctjEs3Nhmd2I5R
         U3iZgcax3NSvIkcI3pms6BSERailwI/xXVV9X5AGBBOzeJ2DTSJh/PfAySwyZuOum5S6
         XmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997159; x=1795601959;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvyTQy7QXUkCqUdPoN6xekhnCdJic/iB4Nnp6WsuGuw=;
        b=zo0pzz8jiI+S5dsL2KIri0V2wOsUQwiYGVbERm5Ylr2wPXvgAIAs/sJwN46UX9yDTm
         BxLaPn3WZOmKjXt6UUyJKKq264HA5qdWqoMC1x/IpnKcW2OJLKwQZlNyNEuKghXvv+5r
         uBWO6RJMw1B2TBV1V1k0RllKVrSEI38/I3fHJqOUZVeB3dzNvO/81+6124P2BxD6O9TG
         IzgdNapRK98LPVxI381gLzM5XXdZr5KfUrjdR6btWFWNjyp/qJS2xDeF/REpiHzNBFxh
         rY0fbPni4wO/+IoebEg8rAxcZ9DCsFkAXvil33EF0cCwnbgplEL5B79bCK0a/jvk4RWj
         gTAQ==
X-Forwarded-Encrypted: i=1; AL+hErEpQMgpTZiWgsZv+ZZ1G/Pmna7NvI2ilONfQWG+L2QBLzGcQJESqPHkMiPe6MMtvBvU2Q/kXyajWPz7+wECgDxD@vger.kernel.org
X-Gm-Message-State: APuU4Z/me5HN2zWk33ArGGhlyL38PHODTvTkNgewH9XuUteKfikjDVDj
	gSYcC1gI7xW9Z6PPh/QPC9cyg96viEMgRhXKCZ/ZIhn+iRf9z3bGoOWmNYSxhMoMrc/8FEB7pXR
	We6Yi8XV1pEzWWtJe9h1bkULOyg==
X-Received: from pjbbx13.prod.google.com ([2002:a17:90a:f48d:b0:3b1:cec2:5b9])
 (user=amitamishra job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b88:b0:3b1:ba59:56a1 with SMTP id 98e67ed59e1d1-3b3d07ca529mr2196929a91.39.1794997158388;
 Wed, 18 Nov 2026 02:19:18 -0800 (PST)
Date: Wed, 18 Nov 2026 10:19:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118101913.3135869-1-amitamishra@google.com>
Subject: [PATCH 0/2] perf/smmuv3: Add runtime PM support
From: Amita Mishra <amitamishra@google.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amitamishra@google.com
Content-Type: text/plain; charset="UTF-8"

On some SoCs, SMMUv3 Performance Monitor Counter Groups (PMCGs) reside
in switchable subsystem power domains rather than an always-on domain.
Currently, when such a PMCG is probed, the power domain is attached and
powered on, and remains powered on indefinitely even when no perf events
are active.

This series adds runtime power management support for SMMUv3 PMCG
devices that are attached to a PM domain:

- Patch 1 documents the optional power-domains property in the
  arm,smmu-v3-pmcg devicetree binding.
- Patch 2 adds runtime PM support to the arm_smmuv3_pmu driver, keeping
  the PMCG powered only while probe or at least one perf event is
  active, and guarding post-event perf context and shared IRQ callbacks
  against accessing registers of a suspended PMCG.

Amita Mishra (2):
  dt-bindings: perf: arm,smmu-v3-pmcg: Allow power-domains
  perf/smmuv3: Add runtime PM support

 .../bindings/perf/arm,smmu-v3-pmcg.yaml       |   3 +
 drivers/perf/arm_smmuv3_pmu.c                 | 134 +++++++++++++++---
 2 files changed, 118 insertions(+), 19 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.1.703.gf848ed807c-goog

