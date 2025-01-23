Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CA1F4E35;
	Thu, 23 Jan 2025 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613282; cv=none; b=SnykATwLrgscLkwhKBBCmBND13x7n27nKFs+XsC3fVSQaiv2T/F3mGj0QvaNV2PpYzpd2pNg7S9UVKu3dHDk6EjUhBZy+Q1mS98KLrZwqJF4+10/InJj8sQ3L05FRf+sat6NkvV7q0T5wNEPfGm2w8pN6Xg4fk1Niva3YJdGBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613282; c=relaxed/simple;
	bh=z8tAD9zaxuzIlqzE32+Zvrc3lbsY4IkgS8q2NB9ON2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gidcFBfONV/pt5EWhOvoxkSbtp+ONdrjzhAakk8LjLwTAbTDjSx0cYjmPSiIBMuhSt3oPSMa8DhUwV79R8p+8dAYsVJN/N6bqDcWYNRAbEMZ9s82TbCHTHk2c4azn9YXED49GJJpXKpLeYuo/kMarSFPWeRL05NmF2F30aR6fY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFf7T6Gm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFf7T6Gm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613282; x=1769149282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z8tAD9zaxuzIlqzE32+Zvrc3lbsY4IkgS8q2NB9ON2M=;
  b=DFf7T6GmuN5c/HtIv+yLWT3bzsqZCQsw0mqOfHLWppTHqUO1nFQRQ+s9
   pEFXi+a4n6kk+kmd0jVbPbwZyPVvc3mMjWek/ICjv+Ofu8fMvhZK1pEaF
   Pt2nWqcI3mxrU0LyJD8gq2+jTdo9jGdyUhbSLbGbiVx3HX6Du93+G3wJ2
   qvvmlHA+w8415QACLxTKrAMGj6rBuf7Ro8ER3dfSAi2so0AlqfAlUr+6Y
   L2FQJok89g4uAqOvroIDmDjitnl9Jo8vX+pcnw6OcXaLEVqtjAcfsGPdb
   etteAjsztexhOJm+5pcjXFwUOgiXZtpendWu3nrJvhA7I7nw3hgs6Rc8S
   Q==;
X-CSE-ConnectionGUID: qjY6WSZKR8ukcy/30Jxpqw==
X-CSE-MsgGUID: X2BNBf9pT7S+rYDO1q1E2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513252"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513252"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:21:22 -0800
X-CSE-ConnectionGUID: Yl7J6cnnT7SHcDtuLAVk7w==
X-CSE-MsgGUID: /Rc1ZM2kQKSx/gdRZENS3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334812"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:21:17 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 20/20] perf tools/tests: Add vector registers PEBS sampling test
Date: Thu, 23 Jan 2025 14:07:21 +0000
Message-Id: <20250123140721.2496639-21-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current adaptive PEBS supports to capture some vector registers like XMM
register, and arch-PEBS supports to capture wider vector registers like
YMM and ZMM registers. This patch adds a perf test case to verify these
vector registers can be captured correctly.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 0fc7a909ae9b..521eaa1972f9 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -116,6 +116,60 @@ test_register_capture() {
   echo "Register capture test [Success]"
 }
 
+test_vec_register_capture() {
+  echo "Vector register capture test"
+  if ! perf record -o /dev/null --quiet -e instructions:p true 2> /dev/null
+  then
+    echo "Vector register capture test [Skipped missing event]"
+    return
+  fi
+  if ! perf record --intr-regs=\? 2>&1 | grep -q 'XMM0'
+  then
+    echo "Vector register capture test [Skipped missing XMM registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=xmm0 -e instructions:p \
+    -c 100000 ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,iregs -i - 2> /dev/null \
+    | grep -q "XMM0:"
+  then
+    echo "Vector register capture test [Failed missing XMM output]"
+    err=1
+    return
+  fi
+  echo "Vector registe (XMM) capture test [Success]"
+  if ! perf record --intr-regs=\? 2>&1 | grep -q 'YMMH0'
+  then
+    echo "Vector register capture test [Skipped missing YMM registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=ymmh0 -e instructions:p \
+    -c 100000 ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,iregs -i - 2> /dev/null \
+    | grep -q "YMMH0:"
+  then
+    echo "Vector register capture test [Failed missing YMMH output]"
+    err=1
+    return
+  fi
+  echo "Vector registe (YMM) capture test [Success]"
+  if ! perf record --intr-regs=\? 2>&1 | grep -q 'ZMMH0'
+  then
+    echo "Vector register capture test [Skipped missing ZMM registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=zmmh0 -e instructions:p \
+    -c 100000 ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,iregs -i - 2> /dev/null \
+    | grep -q "ZMMH0:"
+  then
+    echo "Vector register capture test [Failed missing ZMMH output]"
+    err=1
+    return
+  fi
+  echo "Vector registe (ZMM) capture test [Success]"
+}
+
 test_system_wide() {
   echo "Basic --system-wide mode test"
   if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
@@ -303,6 +357,7 @@ fi
 
 test_per_thread
 test_register_capture
+test_vec_register_capture
 test_system_wide
 test_workload
 test_branch_counter
-- 
2.40.1

