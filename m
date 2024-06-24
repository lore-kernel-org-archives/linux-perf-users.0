Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31851A0708;
	Mon, 24 Jun 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267651; cv=none; b=MVOFjZsg3rspDPYivbfvg3HFbauuqH92lhxaULS+rVnXc+S63lHdExA0ENHuqZdTh9ytv+MjZHpeG+Gxx1Su+kymurYCZpm3Xo9M21xxxCDDezRBbGioKrOQ9W+z1fA7mOl+P+tPsjjSNXP7byWuAbobkYgE2YozERI5BP7dnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267651; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN0sh91fzta6/Y3kRcNAokTd1nh7Af1zkefwHF8xJBtZK8FREZ92dnOBrlUNWsFONpRGHNWvX0PnB+BBnBrVemnNi4JWN2JhwCMrNx3vVVqTePrqN2Vj9wdVrUSjvgm6R2mGS11dgskpKJfr7om7Z4/iHS5595LfugRlr9LqeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XeS+B2dn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XeS+B2dn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719267650; x=1750803650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=XeS+B2dnzhXQiuwuXl0MGToxg180JWSdNLDJPqBIW5fc/CsP1D1x4JOL
   Y39FP9sEEALajkNlUYueBUa0eJ+ZbM97n+dSUpIB+7m1/5smNmzgJukNS
   0iVNiotBlFDDfISWhV4zW+73KsVjBZiYx8L6Dmk4fFDtFQ3qJqBhngPIE
   Fi1YKDJhS65Dyz+PnfzdPT3QotO2QGc05FDDyrxvOw2XWZybUk6WPNehD
   sc3koB2+Yvk/nbnwNXEmU61UNSfyuvYab/Yv9Wckbw1AizBavKBhRIrZ9
   zxWtH3PoCGB35sZRbovZaCxuzM7mTGE32VOdr6q46OtoBw3ttxVlj/eNC
   Q==;
X-CSE-ConnectionGUID: tkt+Qda+Tt6S9jafow4goQ==
X-CSE-MsgGUID: oB0dJAQITYmfBYAwaCYXbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41681610"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="41681610"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 15:20:45 -0700
X-CSE-ConnectionGUID: ey3MijPkR1ugQF1XIhMNug==
X-CSE-MsgGUID: dfPiBmlGT+ucDwR2dJnf0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="48608221"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 24 Jun 2024 15:20:46 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v14 2/8] perf data: Allow to use given fd in data->file.fd
Date: Mon, 24 Jun 2024 18:20:18 -0400
Message-ID: <20240624222026.229401-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624222026.229401-1-weilin.wang@intel.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

When in PIPE mode, allow to use fd dynamically opened and asigned to
data->file.fd instead of STDIN_FILENO or STDOUT_FILENO.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/data.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 08c4bfbd817f..98661ede2a73 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -204,7 +204,12 @@ static bool check_pipe(struct perf_data *data)
 				data->file.fd = fd;
 				data->use_stdio = false;
 			}
-		} else {
+
+		/*
+		 * When is_pipe and data->file.fd is given, use given fd
+		 * instead of STDIN_FILENO or STDOUT_FILENO
+		 */
+		} else if (data->file.fd <= 0) {
 			data->file.fd = fd;
 		}
 	}
-- 
2.43.0

