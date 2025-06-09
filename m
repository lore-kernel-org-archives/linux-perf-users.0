Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A828F3;
	Mon,  9 Jun 2025 03:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438167; cv=none; b=LTjyMAvm0ijmu2EATPzlUWaqBiH5iXpqWxYEHvZsa7QKtEjL98IUBXzm7/QMFRdvDRQOM2rczQ82eTxE1KVuyGe1wt5Qrs/pAikFEu2S+CxfRfbghzYv7DDjBajdUnqdIR0Ylfw0cn3WNaI/xx2TLZklD5O95cyT2k2Q+KooMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438167; c=relaxed/simple;
	bh=jg7j9SVjkwhaFfew7XZU/yjaLCTPaTUg2beG4A3fT60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjY5rE9cwZDES7M2oSQ1DGgvqNkp2LfeXziE+KUFmb3WOPFqxrpozaKoxK6e2JcYTEUUnJvVla2ZOXCJY6E8Lf+E76SY6QPUScS69mgPXMi7sZ6OH3jtNB5AngYa3nrQvx8nzegpd0JmegkCmk5jHYzuhkG0pKfAHdjJ2ormM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBUKEM08; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBUKEM08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749438165; x=1780974165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jg7j9SVjkwhaFfew7XZU/yjaLCTPaTUg2beG4A3fT60=;
  b=oBUKEM08+IqjXCd/UtV5nj0+WrbY756EW4j7hhKHgiXS6jbxlVbtR/96
   GZpyTj30wuPJOzi2o6nGdy4mCfvKXDNmEBtoWqx8Tn5+wUesd2j5sQf2F
   x+1bqDmiXt8CHlHlaNyf0f7SMJNl78HJGTByeocgCQfc2cV3HpMAEfr/9
   umFUmVeAUgbXFSecggnDkp7zubrwSRpIb0F3bVtbd3CxeEeEcGLnDrnAy
   K0Zwd0pT/WyBTX11hfUJi08JLKXf5uz8Z71HBHUDOyia+54iFryfL7poV
   /fV9/3G9giZSNiRhIZLUJyDMomHdVt9AL8SKTXHmcKmssULR6v/OJBgek
   g==;
X-CSE-ConnectionGUID: sU5noGdtSLylx9mkdlNx6g==
X-CSE-MsgGUID: gRIwQmnUQ0WOOX5LFVAEKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51604226"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="51604226"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 20:02:44 -0700
X-CSE-ConnectionGUID: Tf38NmHZQ0yJXOoSrg5Xyg==
X-CSE-MsgGUID: BiwuJCe+QmqcbGXZUjxfPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="169562812"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa002.fm.intel.com with ESMTP; 08 Jun 2025 20:02:41 -0700
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
Subject: [PATCH] Add --buildids-blacklist option to perf archive command
Date: Mon,  9 Jun 2025 11:55:42 +0800
Message-ID: <20250609035542.2364525-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When make a perf archive, it may contains the binaries that user did not want to ship with,
add --buildids-blacklist option to specify a backlist file which contains the buildids need
to be excluded. The blacklist file can be generated from command:

  perf buildid-list -i perf.data --with-hits | grep -v "^ " > buildids_blacklist.txt

Then remove the lines from the buildids_blacklist.txt for buildids should be included.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/perf-archive.sh | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
index 6ed7e52ab881..e5ff840ac6b4 100755
--- a/tools/perf/perf-archive.sh
+++ b/tools/perf/perf-archive.sh
@@ -16,6 +16,13 @@ while [ $# -gt 0 ] ; do
 	elif [ $1 == "--unpack" ]; then
 		UNPACK=1
 		shift
+	elif [ $1 == "--buildids-blacklist" ]; then
+		BUILDIDS_BLACKLIST="$2"
+		if [ ! -e "$BUILDIDS_BLACKLIST" ]; then
+			echo "Provided buildids blacklist file $BUILDIDS_BLACKLIST does not exist"
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
+# BUILDIDS_BLACKLIST is an optional file that contains build-ids to be excluded from the
+# archive. It is a list of build-ids, one per line, without any leading or trailing spaces.
+# If the file is empty, all build-ids will be included in the archive. To create a blacklist
+# file, you can use the following command:
+# 	perf buildid-list -i perf.data --with-hits | grep -v "^ " > buildids_blacklist.txt
+# You can edit the file to remove the lines that you want to keep in the archive, then:
+# 	perf archive --buildids-blacklist buildids_blacklist.txt
+#
+if [ ! -s $BUILDIDS_BLACKLIST ]; then
+	perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
+	if [ ! -s $BUILDIDS ] ; then
+		echo "perf archive: no build-ids found"
+		rm $BUILDIDS || true
+		exit 1
+	fi
+else
+	perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " | grep -Fv -f $BUILDIDS_BLACKLIST > $BUILDIDS
+	if [ ! -s $BUILDIDS ] ; then
+		echo "perf archive: no build-ids found after applying blacklist"
+		rm $BUILDIDS || true
+		exit 1
+	fi
 fi
 
 MANIFEST=$(mktemp /tmp/perf-archive-manifest.XXXXXX)
-- 
2.47.1

