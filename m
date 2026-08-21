Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006D40F751;
	Fri, 21 Aug 2026 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291364; cv=none; b=PNwpFzaWl9epGTmRgPJ8jsNxacPRcW5PR9ClqTFEgDvnFAJYeJwl2Kns94xewVZNwcD6e0/wQAPVdLFMec2Hp8N9dZIqMYUsEHn8enAFAJfHx5Uo027F9ksphg4SC55jHW0QYRDJhvsLbonHANqDzPZKX9YxTHR7BvI592IiPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291364; c=relaxed/simple;
	bh=KGrk8Cjn8wCWCTB57J+A0VqQw6g3R7B+FtoTdYlsacg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+8P5F4Jz+vxGc7kURdZKM2kWW9fGTY1lEB0WQSRMhPmoZASStkr9h63Y5ijonJ+G8EcqzfhTiQpQwtWtKkhWyzxsgg73SSYQc8J2QwmcyIYHnR4Mf9cizbgrLXa5V57rIlaOCWAeuGuTpre5NgX4Agoust8f00vKZwYK0TyUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcKMCRot; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcKMCRot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787291362; x=1818827362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KGrk8Cjn8wCWCTB57J+A0VqQw6g3R7B+FtoTdYlsacg=;
  b=UcKMCRot+rn4XJ2dbCrty7hHptLuqiWR9zb1kru/fKjsG/wuKsp/gMZ3
   UGoWHD523QkuxE/wPWtSg3HK7TBbA50qRNDlTNk3vJYUopt8xnc8Nb3qQ
   hzXjEYVNIxt5IVxnoTRRX9LQHufmkLUwqeOuR/iA+bJBqMKhLarJKQPHT
   GQ5UPPNa5CSoFxoMOh91Bbx7U47KiPoF5P2+LFb3EvKmffn8jrEHZPhDe
   2ddFDNqI4FuBX0BjK6DszOMrB823q3zwf4zDZpdcsBt2G5QNh3c1vGsQb
   N3QLTINY/p+7DMKwOzB1uPWhJFecsI3HAEfk3BQbBiqir+9a9ns2dNrZk
   g==;
X-CSE-ConnectionGUID: SXc39gBPT4ildQaFKXdcAg==
X-CSE-MsgGUID: BWK6iHE3TeWtZFHVWS/BiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87691954"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87691954"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 22:49:22 -0700
X-CSE-ConnectionGUID: V6xjQL8IRY+/OPhQhqpn6Q==
X-CSE-MsgGUID: xHzWl5xXQyepIupaEUIaPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="270476139"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa005.jf.intel.com with ESMTP; 20 Aug 2026 22:49:19 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	jiebin.sun@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] perf c2c: Fix documented default coalesce fields
Date: Fri, 21 Aug 2026 13:56:08 +0800
Message-ID: <a18212b62d45c7816dd8dc5fca90602365c6fdaa.1787283281.git.jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787283281.git.jiebin.sun@intel.com>
References: <cover.1787283281.git.jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default coalesce fields dropped pid in favor of iaddr, but the man
page still documents the old pid,iaddr default. Update it to match the
command.

Fixes: 423701a0c8d7 ("perf c2c: Change the default coalesce setup")
Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/Documentation/perf-c2c.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 8775889bc0a3..9e58a51c55de 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -341,7 +341,7 @@ output fields set for cacheline offsets output:
              Code address, Code symbol, Shared Object, Source line
   dso   - coalesced by shared object
 
-By default the coalescing is setup with 'pid,iaddr'.
+By default, coalescing uses `iaddr`.
 
 STDIO OUTPUT
 ------------
-- 
2.52.0

