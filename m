Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716A33F8D8
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176418; cv=none; b=J7Y6tadOl9+fPjZ8uhiC8qOwWmF5oZjmuMfCX/sw/NwFga9+wk7s+mlIT2DeIUGGL65TzV1CRlbbluOyF82e3WkFCVazH4fJSHl0vRxs6MbkkakXJF5WLJjmzIAa1iE9QMJmMrOmlD1tlBYDWfTVCydIhNTDZUDFjya+aJw1SmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176418; c=relaxed/simple;
	bh=FDL8Iccuse66Bxed+XPCxWHerT7aoF5GBEUCMbgX28E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xy3DW/cZgviVBsVVN+3sROD2tk+fmGjoAvHISoZx2ZVTiz5oNdM9xTwNGOLfQKxs0e90MvdGn9xb55DWvAXy6aj4ZFgcaHa+xThFL9QQSZZEhHFuGm2tUH4t3DH9aYf+0HwzJrJ0httLh8d9RTFF1j+JATWCIZBCzhveWYdXs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wp/ZyHyl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wp/ZyHyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764176414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GVxnRSGS2Ql1rPwd1LWbH/+Gj7SmBJzETLU23n/HatQ=;
	b=Wp/ZyHylmit296I1fyY3kR2wPReaDjigZoPnH7/QHWG31Co7jEr5HOQORgshH2izLQWTJt
	i+WAvn2YNvwb1JBRukpM283VSYLoe7E9FmbYIoaWw/ZCYKMgfb5laCpvi5cKq9iRWuoPhi
	UVFCEtRAueBqzCAhGVgkAeD/G6UymVU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-r9JpdcYROMu9lmsqFNKXyA-1; Wed,
 26 Nov 2025 12:00:08 -0500
X-MC-Unique: r9JpdcYROMu9lmsqFNKXyA-1
X-Mimecast-MFC-AGG-ID: r9JpdcYROMu9lmsqFNKXyA_1764176407
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CBBB19560AA;
	Wed, 26 Nov 2025 17:00:06 +0000 (UTC)
Received: from tallison-mac.rdu.redhat.com (unknown [10.13.33.156])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10F431800451;
	Wed, 26 Nov 2025 17:00:03 +0000 (UTC)
From: Trevor Allison <tallison@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tallison@redhat.com,
	mpetlan@redhat.org
Subject: [PATCH] perf pmu: fix unit listing for SPR uncore event
Date: Wed, 26 Nov 2025 11:59:57 -0500
Message-ID: <20251126165957.96312-1-tallison@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix issue where certain SPR uncore "M3UPI" events were listed as
just "UPI" in the json, causing them not to be found.

Fixes 54f5de6f2998c

Signed-off-by: Trevor Allison <tallison@redhat.com>
---
 .../arch/x86/sapphirerapids/uncore-interconnect.json          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json
index 8b1ae9540066..64eb0d02af57 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json
@@ -6640,7 +6640,7 @@
         "PerPkg": "1",
         "PublicDescription": "Valid Flits Received : All Data : Shows legal flit time (hides impact of L0p and L0c).",
         "UMask": "0xf",
-        "Unit": "UPI"
+        "Unit": "M3UPI"
     },
     {
         "BriefDescription": "Null FLITs received from any slot",
@@ -7146,7 +7146,7 @@
         "PerPkg": "1",
         "PublicDescription": "Valid Flits Sent : All Data : Counts number of data flits across this UPI link.",
         "UMask": "0xf",
-        "Unit": "UPI"
+        "Unit": "M3UPI"
     },
     {
         "BriefDescription": "Valid Flits Sent : All LLCRD Not Empty",
-- 
2.50.1 (Apple Git-155)

