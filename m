Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C921FB5;
	Mon,  6 May 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956034; cv=none; b=YlZhxPkHHfY+OIQSXhHW3xz97920etkGvc7bSxogKqDb3TAaVt1r5S6KQzQiz1pARTCAHBYYA3ZfnqKCKDSLd2NlsQCYLnUvyVY/eStjM2HzZ+ubW5Okx1yYO8ZqI0OUeg3wL2yWDnDdKdV4fY9N6cH2ONKRgustimxMb94pA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956034; c=relaxed/simple;
	bh=Zm6ll3FEAXahkq1OIN9xIIhtasqCrGYzDDOCbIaZh7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgKYGT6mfhDNZqqCvaJTbTyiBkXkRcY0tpBVOdCnIgZwpFB/z11ZWDUicb93v5fb99pZ0aYhbDUgzRLG+2HOazEJ7B2x3nH/ER8buR+Fn3NERVGtTlG37dkyg/2Zg0kUxt3DzBklMpy3ktAl1wdjm851QoPuCzvAa35HsB9Plqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qlYKp4u+; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qlYKp4u+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=e0tx6Bela2CqZ7OGR87TCeW+BT6kGw+m9pXjhCP7LkU=; b=qlYKp4u+sBvV8taZ
	7AArr51PjRktN7xJ8xP9WpQ2kp2P+tApXRWgOJP8EIaNp3XHBIf2S6jDQTVu9muUQl/F99NIPl6HP
	79ipq37FIamYPQxR2/QhxOlHa5YLh8g0Z7fppXjHBfQ1CpqreboZ+nNOqR/ZBqNdyUQMpcq+rGO6w
	sfjesmdZ/G3vDzAcs36jGbnkPDveEgwYBqaTSH3WhmEsi3tHRPhBi5zXKazfop0EbSFZpZ+jXk+Vb
	20EImGfeS1Y3zUAaqdPReSQwu5LRv5+jLy6d5ds+8u/6QcETNYHUHALmbEXMXKYVFwKHPAKop4IJ0
	X6Y7pA1lRfE4+GS5JQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3mOt-004pfV-0c;
	Mon, 06 May 2024 00:40:15 +0000
From: linux@treblig.org
To: jolsa@kernel.org,
	peterz@infradead.org
Cc: linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf/x86/cstate: Remove unused struct 'perf_cstate_msr'
Date: Mon,  6 May 2024 01:40:09 +0100
Message-ID: <20240506004009.770451-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

This looks like it's unused since
Commit 8f2a28c5859b ("perf/x86/cstate: Use new probe function")

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/x86/events/intel/cstate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 326c8cd5aa2d2..dcf3f152a2a64 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -143,12 +143,6 @@ struct cstate_model {
 #define SLM_PKG_C6_USE_C7_MSR	(1UL << 0)
 #define KNL_CORE_C6_MSR		(1UL << 1)
 
-struct perf_cstate_msr {
-	u64	msr;
-	struct	perf_pmu_events_attr *attr;
-};
-
-
 /* cstate_core PMU */
 static struct pmu cstate_core_pmu;
 static bool has_cstate_core;
-- 
2.45.0

