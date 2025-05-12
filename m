Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54798261381;
	Mon, 12 May 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042794; cv=none; b=APi2VU6Ihhn0mJlZsL5csXwrN/AlvWkMYH+vVJevXOnqvrK9G17sTgKtrQxn4UmhI19HrJ5HZhQg/cNNHkTUsJ/MC6yI64X4O07FcHaxWpfjvYxT4GdlgFiIKry7ExvfC0yjcGVqjbreuxWMdEiZ6sytRQdw7vansKMYg59/BgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042794; c=relaxed/simple;
	bh=GJ9BKJd2PRiCU2kpbBVN9+TUnj1dNbBrQ3BJhhqTcmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hySSoV9Ljl6smbiYsojLXibbJyfZ47HIN5sTATmxYHTov6f9jvdLbQbz8szGsQhxF5T7krkuseG+oBgEFF30HlXqJN0SZyAaBrYp4gIW37vK6Z6d5dYkN0X2HsOIlQ7F6cWlCsaKkVqZguzlJNByYclVWQ7uX4KR3soQW/1Z9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XeFACxJy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XeFACxJy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747042793; x=1778578793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GJ9BKJd2PRiCU2kpbBVN9+TUnj1dNbBrQ3BJhhqTcmo=;
  b=XeFACxJy0EQqitCNpi4d3S3y4kgK8F+Q/H8BxPpOb5oNXUt5xCm6fMm7
   sT7rcBM8mt8hSIoeHA5trq1p71erwSkPb8zVXA2cJhV5NcK/lpbsyRB+F
   4ggYdnMMZeuXiw/m8rjxflp2yrU8OqtPyJiA2hPE+61RPPMyKzXWq090C
   eBLWYqqvxGzdwqyV+3Z/GirtvVPYjZWC4vdtXgotmr+vZH92/6x4dQLyM
   j07Sv4oupvcJAH+Ua3uq1AdmH/Ro+j+4n7eFh2il3SMc63220CpzRvzmm
   5YgvUKsT7ASLL57gEzMZncZK9iiXaIzTnAWWotcJ5BXsDd49b7c3Sz5Cm
   A==;
X-CSE-ConnectionGUID: hh9bdC7UTcmsSVvWNkiY4w==
X-CSE-MsgGUID: NKDoc040Tk2rGsHNemRYug==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="36457535"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="36457535"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:39:51 -0700
X-CSE-ConnectionGUID: GOJ8cRRZS6SK52RSkifd1Q==
X-CSE-MsgGUID: geiVIFlZTdymWDQZhjZX1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142214310"
Received: from bvivekan-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.245.245.139])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:39:49 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3
Date: Mon, 12 May 2025 12:39:32 +0300
Message-ID: <20250512093932.79854-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250512093932.79854-1-adrian.hunter@intel.com>
References: <20250512093932.79854-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

The script allows the user to enter patterns to find symbols.  The pattern
matching characters are converted for use in SQL.  For PostgreSQL the
conversion involves using the Python maketrans() method which is slightly
different in Python 3 compared with Python 2.  Fix to work in Python 3.

Fixes: beda0e725e5f ("perf script python: Add Python3 support to exported-sql-viewer.py")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 121cf61ba1b3..e0b2e7268ef6 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -680,7 +680,10 @@ class CallGraphModelBase(TreeModel):
 				s = value.replace("%", "\\%")
 				s = s.replace("_", "\\_")
 				# Translate * and ? into SQL LIKE pattern characters % and _
-				trans = string.maketrans("*?", "%_")
+				if sys.version_info[0] == 3:
+					trans = str.maketrans("*?", "%_")
+				else:
+					trans = string.maketrans("*?", "%_")
 				match = " LIKE '" + str(s).translate(trans) + "'"
 			else:
 				match = " GLOB '" + str(value) + "'"
-- 
2.45.2

