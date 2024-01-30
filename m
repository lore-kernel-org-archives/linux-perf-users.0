Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02966997A
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640972; cv=none; b=uJY3EL5BnhY4K2qY38EhzsfR9agPcD+RxWU/aJY0Xfref9Ryw1LKVN+pfVt2fyGU45LNgaIbt4/BMHvIDQBxea/0IaPQiIzGGb9MJJ/VVLXWJ50N23kY1E2TojSmggQbTUpiXvl7nhytjY47tWKzshYm0ln8l5Vd1YJ3CaaDmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640972; c=relaxed/simple;
	bh=pZg272ZAMmDydAlkb2PwtOa6ZshaXGQtttGvMufxAhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ay+S49BLr3zBRodBioh84Ewv95e0O/e4r1d0OKaIFjgrfCPyhw7KT5o60yq4I+Z4wgg3Hm4rVKSIaoyI+ex1KJY6lP1EPf99qcUpyUUXYkBb9y4j6mEkpfbTZNl+xxJ/d6tM+GWfQzY/2gbjNgZjyD7uXPiwq0oH5mTQn41OUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG8q5+oa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG8q5+oa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706640971; x=1738176971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pZg272ZAMmDydAlkb2PwtOa6ZshaXGQtttGvMufxAhY=;
  b=QG8q5+oav+w1hfN5bBnzxhqDNM/gd7ND9YlwROsvxp4MFpqQHy6SC/eN
   EIIk4uCzGhARf6m69QWLebxw4EXP+jx+MzJ0ZrPaRsLQfU2vNgAqzHm+v
   M1rIWEzl96f7+N/gwXfoehDHWp4JTMADntsOpt7nPrRqg19Kl5jXEqnY4
   w/RHkvMlXJT0LY7BGeWCYVbxjPfxOTByB3riHupX4SHxiM2iHHYaz6jQR
   aCtSLnfy/JlQQZJQX3Ci6ycfoQzDIwRZnjoKp1WF0L+dlxNTZ8rmUxUI7
   AvCW230dHYWi/KrHfC3IKHWYQ0QkQPVhCAXrV4KzZpq5+YQtx4Iq6vfI+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3219367"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3219367"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:56:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="911534470"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="911534470"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:55:59 -0800
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf report: Prevent segfault with --no-parent
Date: Tue, 30 Jan 2024 10:55:52 -0800
Message-ID: <20240130185552.150578-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent a perf report segfault with the (non sensical) --no-parent
option

Signed-off-By: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 30254eb63709..92a1bd695e8a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3372,7 +3372,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 				sort_dimension_add_dynamic_header(sd);
 		}
 
-		if (sd->entry == &sort_parent) {
+		if (sd->entry == &sort_parent && parent_pattern) {
 			int ret = regcomp(&parent_regex, parent_pattern, REG_EXTENDED);
 			if (ret) {
 				char err[BUFSIZ];
-- 
2.43.0

