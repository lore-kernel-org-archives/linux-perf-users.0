Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CC286412;
	Wed, 25 Jun 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864938; cv=none; b=PaXmC1uHoTbfe2C/MK85OQngEA1axuaxwP9dzT4fnpS6VrPZbMAUPGqB4rKJ9eEDdu8+Ma4sZW3WBb2VCniwpoO8bDzaVjiY5x9tkMq6U4jtoWnRYFa9QCv8ZWOhZMAg2lv8xNY1eA/QhP1sDDiy/6nsD62P07TYQbP/Dm4ZPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864938; c=relaxed/simple;
	bh=udi9Dj+TB3DzEDfD+VOVtv+BMkNrVkihkKNjVOl4DgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/+onam0kIeoEi79Ba3HyPuTrigAuobE+4lWtUi+Ggxu1ngRtOQxKb/LG+P0uTZFWdb8tKRYfd2h98dCDS2FxySx3eM7C+a/Zy3fJrSZkmcWkUqU4UgTswygKnRxOiH4z8/Qf5bPOq9WLC8sFTbkk0GAx/mM9jhIyq1gMYx5zFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flaElob/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flaElob/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750864937; x=1782400937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=udi9Dj+TB3DzEDfD+VOVtv+BMkNrVkihkKNjVOl4DgA=;
  b=flaElob/J2R/Jgu0XLlOe7ij9fkaaXt38hWSbjZpkUBmWUWTfz9VDpZC
   pczwJ0To2lFTxveY/kTKFlHWJBBOfm/qsQWU/LfclgAJuvXSkq/uMT2og
   evzfAxzPS5p9c+WlVJh+BfH/WpSz4hZf7M7zy1h4vcOI/m0Uqd1LCBgZX
   pmGlutNk5VvbJM9f34/n3X+DqLvvq5XRnwC6tA/ikgv1R5YSvRgkuhb/y
   pSrXz5KoI1vRsG8iDHvR6DO7mqz8JVtm2BZNXlLhJJHDiFQzVJr2Yp1w/
   o7FfdO+9+dr3VZabIZc0lXGp3ZKaRXS0oHKaUuCpD55iVusIaIIbLUP3h
   g==;
X-CSE-ConnectionGUID: jyJbm1bXSWWUQKd0pOdAIg==
X-CSE-MsgGUID: ZJjdFP+nSdGfuv7UzO0i4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70573260"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="70573260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:22:16 -0700
X-CSE-ConnectionGUID: WPMLVT8JSx+gj9sU/NfDJQ==
X-CSE-MsgGUID: snl4U3dqQUyLma4P7zG57g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152018305"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by orviesa009.jf.intel.com with ESMTP; 25 Jun 2025 08:22:13 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] tools/perf: Add --exclude-buildids option to perf archive command
Date: Thu, 26 Jun 2025 00:14:01 +0800
Message-ID: <20250625161509.2599646-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aFrzSpvzzWeHdyJ5 () google ! com>
References: <aFrzSpvzzWeHdyJ5 () google ! com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When make a perf archive, it may contains the binaries that user did not want to ship with,
add --exclude-buildids option to specify a file which contains the buildids need to be
excluded. The file can be generated from command:

    perf buildid-list -i perf.data --with-hits | grep -v "^ " > exclude-buildids.txt

Then remove the lines from the exclude-buildids.txt for buildids should be included.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/perf-archive.sh | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
index 6ed7e52ab881..7977e9b0a5ea 100755
--- a/tools/perf/perf-archive.sh
+++ b/tools/perf/perf-archive.sh
@@ -16,6 +16,13 @@ while [ $# -gt 0 ] ; do
 	elif [ $1 == "--unpack" ]; then
 		UNPACK=1
 		shift
+	elif [ $1 == "--exclude-buildids" ]; then
+		EXCLUDE_BUILDIDS="$2"
+		if [ ! -e "$EXCLUDE_BUILDIDS" ]; then
+			echo "Provided exclude-buildids file $EXCLUDE_BUILDIDS does not exist"
+			exit 1
+		fi
+		shift 2
 	else
 		PERF_DATA=$1
 		UNPACK_TAR=$1
@@ -86,11 +93,29 @@ fi
 
 BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
 
-perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
-if [ ! -s $BUILDIDS ] ; then
-	echo "perf archive: no build-ids found"
-	rm $BUILDIDS || true
-	exit 1
+#
+# EXCLUDE_BUILDIDS is an optional file that contains build-ids to be excluded from the
+# archive. It is a list of build-ids, one per line, without any leading or trailing spaces.
+# If the file is empty, all build-ids will be included in the archive. To create a exclude-
+# buildids file, you can use the following command:
+# 	perf buildid-list -i perf.data --with-hits | grep -v "^ " > exclude_buildids.txt
+# You can edit the file to remove the lines that you want to keep in the archive, then:
+# 	perf archive --exclude-buildids exclude_buildids.txt
+#
+if [ -s "$EXCLUDE_BUILDIDS" ]; then
+	perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " | grep -Fv -f $EXCLUDE_BUILDIDS > $BUILDIDS
+	if [ ! -s "$BUILDIDS" ] ; then
+		echo "perf archive: no build-ids found after applying exclude-buildids file"
+		rm $BUILDIDS || true
+		exit 1
+	fi
+else
+	perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
+	if [ ! -s "$BUILDIDS" ] ; then
+		echo "perf archive: no build-ids found"
+		rm $BUILDIDS || true
+		exit 1
+	fi
 fi
 
 MANIFEST=$(mktemp /tmp/perf-archive-manifest.XXXXXX)
-- 
2.47.1

