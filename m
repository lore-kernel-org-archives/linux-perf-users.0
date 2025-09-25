Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32093054CE;
	Thu, 25 Sep 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817567; cv=none; b=OKo3p0rTCows095pwCq/l2gH0OU2XVflJxfUpi0XMzW9dtmidpvSf7uTWQn8xGtg5nHw5xXoXJeXL48wd4SkBFIMiWJKDxRZUUdQM7BLEUbgnXBXExe9ZFNH86FtajC5GU7rc8aC6y0KH/evpk4dFq1pYaJTdzz7snmaDmHEZ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817567; c=relaxed/simple;
	bh=pNjBTQXJ2yYV7pbLmX8VeGDdjyTrjnL7dgj3WPZocn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hFDM+54ucPSOAPXOiKo7SXFb9mlyG26SLNXwWrpyCwVUBrq2MQiAnmQ89esGIH/gDMP6igylAG+OQPslI8Y5joMcZj2geAoqz5RLjpFLFDGiEqBHqBbqLpLPKgk7+KvF9iqqVHPN5HD1abHs0PNAkWnLS8EqhWTBy+Wie6XHpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUSE+UEY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUSE+UEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758817566; x=1790353566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pNjBTQXJ2yYV7pbLmX8VeGDdjyTrjnL7dgj3WPZocn0=;
  b=KUSE+UEYxsEiNwrQL58Jhf/9I9YhI/TzsL+Fj3UFfS9AQaCOdNL/++OX
   Wopyn7VZPev5jpAg5ZO6FYqJVbuB09SlKK2RPlAHtyqkZ1TylUFHHFbrN
   EZXoI/z+clgQ2iDoHon24fdu8/BPGG6hrEx6LZVbhg7r/DDzcqS2+98kD
   4UjzntQ0pMPulWWQFjmwLOEW+5tnqRiFn6dJ5aUYuc55kn5PNhYBC+SLx
   fyB0aRg+JUe+UTlSlBgGPg+HrwkS2VQvoi8xtAtXNsWAbbKNLCEHtykVq
   TtIG6z2ac7vtdV25LG35xNxmcDtvz4T1fun9PgI2Cg7I6dHD6cG9pwSBo
   Q==;
X-CSE-ConnectionGUID: j46PBqtkTUqv1nA1ZUl9wA==
X-CSE-MsgGUID: X5EM0NfjS7qNAMSb5rTpzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60355442"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="60355442"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 09:26:05 -0700
X-CSE-ConnectionGUID: VkmZmm0WSQWRYBeC+EdUkw==
X-CSE-MsgGUID: oxijncKESWGrWM3Nmh3rSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="176956913"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa009.jf.intel.com with ESMTP; 25 Sep 2025 09:25:53 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	dave.hansen@linux.intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Remove myself from perf_events subsystem
Date: Thu, 25 Sep 2025 09:24:28 -0700
Message-Id: <20250925162428.3516894-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

I'm stepping down as the Reviewer of perf_events subsystem.
It has been an honor and a pleasure to work with everyone to improve the
perf_events subsystem. However, due to personal reasons, I have to leave
Intel. I believe it would be difficult for me to continue in this role
any further.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..2c788294cf84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19759,7 +19759,6 @@ R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 R:	Jiri Olsa <jolsa@kernel.org>
 R:	Ian Rogers <irogers@google.com>
 R:	Adrian Hunter <adrian.hunter@intel.com>
-R:	"Liang, Kan" <kan.liang@linux.intel.com>
 L:	linux-perf-users@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-- 
2.38.1

