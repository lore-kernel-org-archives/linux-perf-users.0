Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D331D5151;
	Mon, 16 Dec 2024 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332599; cv=none; b=HA/xAa8bo1d8xhNZyNQWxPHRBqg9190KSZFma7dm3LRS7n1r33b8Q8Wp65tSjgWgC5B4at3uWXdC5X8xA6tT1KuGmhkmb4nssGye8VpG1RnTrAraVJySc4Hx2JpBxv1jY3dJt+THXmhyTXHFJcSVwcmdiadWqgz88/E4r326xTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332599; c=relaxed/simple;
	bh=8P7g3If911f0PrtJhj9QLr/GhMEjTmsK8A98libHOKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJNc0uCXxUqdViUunK3gg1iKrQZts3hghqjKCSQHzR6tAQAjUPnCi8k2gwwZ++Gf3r8szI0M+jozhROiJGv22QxxCRn92Tb2GNVx6HPvqrBry0cPF9MHMq0djzL7pRrdzLvKLBJVFqWZOGZXCXA+ua6C2eyIR9cwNDxUjhssoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3Xs5jih; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3Xs5jih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734332598; x=1765868598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8P7g3If911f0PrtJhj9QLr/GhMEjTmsK8A98libHOKQ=;
  b=T3Xs5jih9iLDw+M5IEl1HWJDAD8ubUQJwXMeNBF/F4Ri+XRpzy9H9dDL
   iyLt2h6OVY8TlWJ1g3w5mTQJ5b8OA1pJ+qqSi6dpksFMGuuTgEEdctQkX
   jLDITzU8GEjxITOdpaV/tnh4WrmyA5+zuPLKomNdPDnCAmv84HeoDOFhl
   efEgbGGylQYzrW5nN4hI/Xua+aW7XSre2ArY3bN/kZwVvLUr1NRf2D7nz
   egVNhdAq+8ikwcsyRlu+HAE0tkmJkNQNCt57cW+eiihcGi8ZQe5yAlcTK
   v0LbFpmUqRUPa5gJ6yPA6F0k4LiDGw1triBuxHcIe1V9TiYYEKbgvWA5i
   Q==;
X-CSE-ConnectionGUID: o53wegZ6QmOs6bOP/Yd6SQ==
X-CSE-MsgGUID: 1f7cL4raR2urVF291DzEmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34584290"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34584290"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:03:18 -0800
X-CSE-ConnectionGUID: lFCkl4GWQ4uLh5aW32Dhcw==
X-CSE-MsgGUID: IjEH/Bg5RQ+DCZh8R7gW7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101258828"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.115.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:03:15 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V16 7/7] perf intel-pt: Add a test for pause / resume
Date: Mon, 16 Dec 2024 09:02:43 +0200
Message-ID: <20241216070244.14450-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216070244.14450-1-adrian.hunter@intel.com>
References: <20241216070244.14450-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add a simple sub-test to the "Miscellaneous Intel PT testing" test to
check pause / resume.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index e6f0070975f6..f3a9a040bacc 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -644,6 +644,33 @@ test_pipe()
 	return 0
 }
 
+test_pause_resume()
+{
+	echo "--- Test with pause / resume ---"
+	if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/aux-action=start-paused/u uname ; then
+		echo "SKIP: pause / resume is not supported"
+		return 2
+	fi
+	if ! perf_record_no_bpf -o "${perfdatafile}" \
+			-e intel_pt/aux-action=start-paused/u \
+			-e instructions/period=50000,aux-action=resume,name=Resume/u \
+			-e instructions/period=100000,aux-action=pause,name=Pause/u uname  ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	if ! perf script -i "${perfdatafile}" --itrace=b -Fperiod,event | \
+			awk 'BEGIN {paused=1;branches=0}
+			     /Resume/ {paused=0}
+			     /branches/ {if (paused) exit 1;branches=1}
+			     /Pause/ {paused=1}
+			     END {if (!branches) exit 1}' ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
 count_result()
 {
 	if [ "$1" -eq 2 ] ; then
@@ -672,6 +699,7 @@ test_power_event			|| ret=$? ; count_result $ret ; ret=0
 test_no_tnt				|| ret=$? ; count_result $ret ; ret=0
 test_event_trace			|| ret=$? ; count_result $ret ; ret=0
 test_pipe				|| ret=$? ; count_result $ret ; ret=0
+test_pause_resume			|| ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.43.0

