Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD8130A68;
	Thu, 13 Jun 2024 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249799; cv=none; b=m1/scLoaLcYgIaZD8OZNnT3gsZlfg7ruHl7zWQOZpNvWerOrIuFQkc32pMqZprcJ3zKzOnoNRm8vitigtn4GwxGVDE/IlFudXFRUZLfKqJRAj6Zg09tIsA/o1elgEJqZHy32nd5OlUvrAw13IQA+9U53QZB0IeLX9CO+U15t3Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249799; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUpYXcYMtoXZ7WeKgFdjsGIMjtSFlllBbDnCAjuifFYvT+LtbxI5wK3s/k4Ux0E9TZZD6BJQ8QhKsc1Ja+6PJ7unjhLnXv+TyDWWEEeDdQhTVVeqyeuSE3XTaBtntW7oWoeS8sUdFCPaT0Lr4DZdyJ8tJbq6YWG3Bdw3HV81F8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F13DQwU/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F13DQwU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249798; x=1749785798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=F13DQwU/IXSwqI4+bisdJHPz9L7f/S3zNg+p/7WtifomBvEOzO/zd+oZ
   3UzJmU/GQ3I3MLEs1HM0ls9RyXl0pEmDLUgIJ88vvRqsAcgQ7SZxRy9V0
   0ynNRQj/OpLkLwtrX90+9IYywAnmyYs4DAz07Y0RQg6WX9EqDTIsD5a6O
   3RKTFWvVsEOYzZ0XSGd+seqUw4SgiuRPHIptSmRPM5uHanIOZg/a5LEyI
   Kc9j0COMh0wNl8bPf3NiAGD4mfMax9jE0UjQ7mWv967qxb+Y/TT2O5QmE
   3iYCrG0gZ3zKlBjbOn0XaRUlDx+++g+mPbgNtJCJM4QTPP0kKE+7Uz/1X
   A==;
X-CSE-ConnectionGUID: F3IiW5uJRR+NjG0ZA/aMFQ==
X-CSE-MsgGUID: JeCCoAEVSISPSCMX07sUpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12046712"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12046712"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:36:37 -0700
X-CSE-ConnectionGUID: IQL9ezSvT8OHxw/RxzeWeA==
X-CSE-MsgGUID: QWRH2GPBR+iyqJPLq7c1tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40100350"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jun 2024 20:36:36 -0700
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
Subject: [RFC PATCH v13 3/9] perf data: Allow to use given fd in data->file.fd
Date: Wed, 12 Jun 2024 23:36:23 -0400
Message-ID: <20240613033631.199800-4-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613033631.199800-1-weilin.wang@intel.com>
References: <20240613033631.199800-1-weilin.wang@intel.com>
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

