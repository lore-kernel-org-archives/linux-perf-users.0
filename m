Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F076283124;
	Tue, 20 May 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765040; cv=none; b=Yl6WSXf+ZAbSaVYpkEnWU5QdTZM76bolKfW+TW8x/yqj6HpM8INWazYiANTpNnPb2gMUZEj/iDosY+Ou6jd/ps+5Vw8hcOMsA63jcImViw73EHjHmG56zDMVdqm19K05WYmwLmahIR+IzJ8f7QsMThzpzFbSwDqks+T3wy5QRuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765040; c=relaxed/simple;
	bh=jtzi1Dswis+7E8s5xuD4Q5RcegCZpv4/8lL3qUWjHa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mr8etga+NxzjL1pCnkXau5MRihF5jnjbKVPWiTPQxtvnxOkNh1VojV9SDHMPz3DuOeBR+eXhprlyOTJ6nqeEu8JFmQVj7V4Jg4XrBpWO+AKs25qWGmLr6y6JfNIPGDi8qnA56L/dc35EkAm95yCbx/0V66+JsJNnBJfXl1CxOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gcrn8Ma4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gcrn8Ma4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765039; x=1779301039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtzi1Dswis+7E8s5xuD4Q5RcegCZpv4/8lL3qUWjHa0=;
  b=Gcrn8Ma4Lj0uzGudalyTqui7vFZh3+b66EU3MmoD4Lswh/huyo7G8z0p
   +CDh4YEaQ+eZUvVDqm7K1fWPlzJWbKYqXotI3hfeQDgJEB4fD+qRi/ES1
   Jh6dvUSXLjR+yuUAyORMBAprvVppOGYpzqJTbeEp1qBJOjtFVUejiGR5z
   AREwokxmHKUk7Shff60jZfnrBmGJY1q8FqHjgMlsM4lLj0TSvf2UbAkYd
   9L58ehxLvljxyESPxR9DV0c2ZOjcgQufx4OSrJdsdMOiWFadngSGh0WUM
   2YdhJzSGhwKspH3XzLwRAeJLsJ92izFXcUgkMCvdyZoWMz7FKscxnAKP/
   w==;
X-CSE-ConnectionGUID: QICnwZHqSwOn3TFi1M+tKQ==
X-CSE-MsgGUID: vAyPyvxxQYWvZMQfMQhYlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49848009"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49848009"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:13 -0700
X-CSE-ConnectionGUID: aR+nO4m0SN6lMNNDd2P2pA==
X-CSE-MsgGUID: mT7kCPenRDGwkx/f5mixUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514715"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:13 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH V4 09/16] perf/apple_m1: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:37 -0700
Message-Id: <20250520181644.2673067-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Oliver Upton <oliver.upton@linux.dev>
---
 drivers/perf/apple_m1_cpu_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index df9a28ba69dc..81b6f1a62349 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -474,8 +474,7 @@ static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			m1_pmu_disable_event(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	cpu_pmu->start(cpu_pmu);
-- 
2.38.1

