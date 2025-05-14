Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE42820C7;
	Wed, 14 May 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235688; cv=none; b=YYbAULH1bGLvb7saYQYdRss394PnjO7KfKo3jZtDAYGVgat+FQzweHOpd+O6OVEhBezzFhNZ4uJSkzJ/lJbiB4vr1Hl0YdxqHRSur5AYx3vEHbHB48Nv3vbVnypfjvJErIuEmklLXkGTIAdqHJcw0QKZuw0zcBEb1ZVVulwIPPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235688; c=relaxed/simple;
	bh=eftPXZUtS7TWj+fyRnjgJB01av2QQsqnM0j4qbjXMQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0PHqPSx63MrGeHDmoF8IMEqKZLYiKN6y23PeqlOqp/qJqELehSgVyXAJNLGvmKSqqOQCmt9+YBTTcJjnn07y6G4eU6mD3YQWgpC1yIBY4hRxn7BD4PxIN0P6xgF/G99HbCOZhlzO9vH4Hcu8bzBYiqoWjVS5tZbLCnCoAahRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRosZTLe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRosZTLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235686; x=1778771686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eftPXZUtS7TWj+fyRnjgJB01av2QQsqnM0j4qbjXMQk=;
  b=FRosZTLeiVxmFuH36Vl3u+7QBQ5Ur+X1bLYfKyGYrJngtikwZOz1raxE
   yxp6Yo4FbB12JDVUo2L0PbmMeJ+8R9Q9nQNTQU+5WHVuThDb7tnC4r796
   X9rC6mZ7cdwXVcccIhjOa+2zFW+f1g237ewkZbyMc4uDJubrTnuQSoYrf
   DlUfBMpeBBHOjvNyKAUcdetsNMM49Ss8yWisaBRR9Zifyjp/5wHSFV7BE
   PXSvjESbbnhpGfKRtGud0+crqQyckUAtDe0iWPgGBkIdZhwo+xAxWgR6Y
   EN3MXx71b4gtv/exsnJgGLd8l6NxqIGn0Em1Qey6euL9bOpqS7vWU6CEd
   Q==;
X-CSE-ConnectionGUID: 3wGaa6vEQN+FFVjTU65Gcg==
X-CSE-MsgGUID: zmU2tb3OSyydU5eMN7oh4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072727"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072727"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:44 -0700
X-CSE-ConnectionGUID: gG+wDnInSwu+VvYjARXzXA==
X-CSE-MsgGUID: LoRybGhBS4KvjBMm5+qKlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939163"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:44 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	silviazhao <silviazhao-oc@zhaoxin.com>,
	CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [PATCH V2 04/15] perf/x86/zhaoxin: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:50 -0700
Message-Id: <20250514151401.2547932-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250514151401.2547932-1-kan.liang@linux.intel.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
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
Cc: silviazhao <silviazhao-oc@zhaoxin.com>
Cc: CodyYao-oc <CodyYao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 2fd9b0cf9a5e..49a5944fac63 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -397,8 +397,7 @@ static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
-- 
2.38.1

