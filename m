Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77920B202;
	Mon,  7 Apr 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043779; cv=none; b=XQQGalVDffxy5kEG1vCJNrBuyKCCcp27QhYtF4fKn2ktGnmI+FBJdy+CLHORROQtttUE5ha+pjbbfnoRvpt6kYss4PC6S8vFnjclFmYumT/yJ90fAqKNB06SNpxntsnqxgnJ5dcKn+gvXN8wnEJuvtDH6aBrfXqQScR5MF7Gcj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043779; c=relaxed/simple;
	bh=bENQY9ERtvAVY2RV4jsv9pScR8V3LH32Pvzd2kOjte8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktamHjxnnGnX7wCGkpMxE43XdTt8jxL/9g8LUlHHRLNXgXG5JApaZdurIGDE2P2jR6kHjay3+PAUpP9EAcJvvMk16AAtpnrcVfa17mxV00dp6Ko2z3rnYYAlockG1KWDw5Lt33b2Y+UmibYRut59P4xwN2zbRsS4PNpxQ2+KX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnabVT5y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnabVT5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744043778; x=1775579778;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bENQY9ERtvAVY2RV4jsv9pScR8V3LH32Pvzd2kOjte8=;
  b=XnabVT5yc+FfeHJ2NfW4arjXTFOWqhNbp/jxnYqaIyy6yT7o6L2wFDsj
   f/oAcd9SMxGO3/cCzuof5nAw7hKcQCFJr4L/kuhK8vamFqc7xqWDyB47m
   L9gy1SD7zarYsiHmsPnRTo1FnrNYBe60vukmN8dLNpbxzUUF1nuug2kMq
   Hgi4MFNeocfgRwizdL4SwliJt+8ZXsxIuwmmmat5befNS7a3UfH5hei6Z
   d1+INBB41gjrwSznprDYnrSUXxiBJ8C+UnDF/fk5d9PFo8230RBVEhQJX
   gP3oUsN2Q3NEhamXofVtiNJmJ0KYCNQ2HmBEnHDRaYg5NsFNAi9rx05kg
   A==;
X-CSE-ConnectionGUID: nycZVteKTlCtVfIENGZ62A==
X-CSE-MsgGUID: jPEKzy8ETUGMfJ253UYMmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49096433"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="49096433"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 09:36:13 -0700
X-CSE-ConnectionGUID: 4a3SoxmpTNSlBygJTWcUGg==
X-CSE-MsgGUID: 2kc847DRTSuycdVPzH2aug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="159000403"
Received: from johunt-mobl9.ger.corp.intel.com (HELO localhost) ([10.124.223.249])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 09:36:09 -0700
From: "James O. D. Hunt" <james.o.hunt@intel.com>
To: linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	"James O . D . Hunt" <james.o.hunt@intel.com>
Subject: [PATCH] perf: header: Check read return
Date: Mon,  7 Apr 2025 17:35:38 +0100
Message-ID: <20250407163538.176140-1-james.o.hunt@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the `readn()` return value in `read_attr()` if there are remaining
header bytes to read (previously, the return value was being ignored).

Fixes: 69996df486fc3 ("perf tools: Enable reading of perf.data files from different ABI rev")
Signed-off-by: James O. D. Hunt <james.o.hunt@intel.com>
---
 tools/perf/util/header.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3cdc3b7b4ab..09dfd95e350c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4161,6 +4161,11 @@ static int read_attr(int fd, struct perf_header *ph,
 		ptr += PERF_ATTR_SIZE_VER0;
 
 		ret = readn(fd, ptr, left);
+		if (ret <= 0) {
+			pr_debug("cannot read %zu remaining bytes of header attr\n",
+				 left);
+			return -1;
+		}
 	}
 	/* read perf_file_section, ids are read in caller */
 	ret = readn(fd, &f_attr->ids, sizeof(f_attr->ids));
-- 
2.49.0

