Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7B40F74A;
	Fri, 21 Aug 2026 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291375; cv=none; b=lksKignZ7FzRYuz/QDG5dSMFgma3a1Lr1a13dKmdBwdqaxCmyDNXCfF+q7BT4q/Dy0osJ3Llkxnpxzg/4bC/Tjqf6LbsUjwVmPKKMsnwXCCSg2/KmCI90S9qwJuW1eRo+fHFbnLRpY15fEtoTWpr+a9122SE80pJs0tVlqoZ+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291375; c=relaxed/simple;
	bh=HWxa1AZQIeHftwYIuZGqxXn+VypsNqsJaWLDzH4s4Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uN+HYOJwi1BiDqJP2ab1kni0Qq5HfOVjcTsAuYPPlH/vFTU9Ho0ZzrqY74d1QldB/4hq+AFvtsklFcKACqu1Xc8mctgjOmaZoCszL9LGY96y3C1jlRu2/OPC7GypZkCrPWF7SOZ2NEQPJcaQ82Z6yiYkVQlLvE8dNJaTJBWtrYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtoVuX9/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtoVuX9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787291374; x=1818827374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HWxa1AZQIeHftwYIuZGqxXn+VypsNqsJaWLDzH4s4Iw=;
  b=VtoVuX9/TQpHIHc5DifeqmcDosOst6EDzGO2TuuyQikvdmtddUoOG8QL
   GBG3OxNi5uDlclQsNFP6GY8CBfjX27PNzgSwWPPXou+G0yCvw/IDuW6eS
   apEzBq3vEc2C1Wzms0HxQ3qJodkAD4D6tC5IZbvo3/Lh8u1ipIj/caCaq
   pVj8RrCz1D6Z2wxIPtziEKZfCJEkBadYEB+KUNzXtjjXxx5NMG9gbeols
   LkF0Zsg5b3z8b+kpgAp93pqLL00WP9LDjQCSgHQbp3lN2yE37h+9T7f8Q
   Im7g8tbJ2z1BNn7buhGmrkJA/KKEUGlh8H17Q0FGbBTyeBn0sJ6BgEK72
   Q==;
X-CSE-ConnectionGUID: mxCEJiofRIiDFQdzOsl6Tw==
X-CSE-MsgGUID: iGKIZ1R1TUmG/KPQS4SGuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87691991"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87691991"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 22:49:33 -0700
X-CSE-ConnectionGUID: lZumh/SDQcOHm8fzt/yZkg==
X-CSE-MsgGUID: MIiOmRIDRxu1Z49NJNarUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="270476192"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa005.jf.intel.com with ESMTP; 20 Aug 2026 22:49:29 -0700
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
Subject: [PATCH 4/4] perf tests c2c: Add function view stdio coverage
Date: Fri, 21 Aug 2026 13:56:11 +0800
Message-ID: <9bd7a313c9c1d71058e857c320c6d5c30cf4cbfa.1787283281.git.jiebin.sun@intel.com>
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

Exercise the function view without driving a terminal now that it has
a stdio path. Keep the existing datasym record/report coverage and make a
separate recording of the contended locks used by the futex hash benchmark.

Always check the function table headers, table replacement, missing-iaddr
diagnostic, and conflicting options. A machine can support c2c recording
without capturing a contended sample, so report a skip when the hierarchy
is empty rather than treating hardware sampling variance as a failure.

When samples are available, check generic row shapes for all three
hierarchy levels, their expanded fold signs, cacheline addresses, and the
absence of trailing whitespace in the table body.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/tests/shell/c2c.sh | 113 ++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/perf/tests/shell/c2c.sh b/tools/perf/tests/shell/c2c.sh
index f5f223cbf9cc..cf76359d19cc 100755
--- a/tools/perf/tests/shell/c2c.sh
+++ b/tools/perf/tests/shell/c2c.sh
@@ -6,10 +6,15 @@ set -e
 
 err=0
 perfdata=$(mktemp /tmp/__perf_c2c_test.perf.data.XXXXX)
+funcdata=$(mktemp /tmp/__perf_c2c_function_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_c2c_test.output.XXXXX)
 
 cleanup() {
 	rm -f "${perfdata}"
 	rm -f "${perfdata}".old
+	rm -f "${funcdata}"
+	rm -f "${funcdata}".old
+	rm -f "${perfout}"
 	trap - EXIT TERM INT
 }
 
@@ -58,6 +63,114 @@ test_c2c_record_report() {
 	echo "c2c record and report test [Success]"
 }
 
+test_c2c_function_report() {
+	echo "c2c function stdio report test"
+
+	if perf c2c report -i "${perfdata}" --function -c pid > "${perfout}" 2>&1 ; then
+		echo "c2c function stdio report test [Failed: report accepted missing iaddr]"
+		err=1
+		return
+	fi
+	if ! grep -Fq "The function view requires iaddr in --coalesce." "${perfout}" ; then
+		echo "c2c function stdio report test [Failed: missing iaddr diagnostic]"
+		cat "${perfout}"
+		err=1
+		return
+	fi
+	if grep -Fq "Shared Data Functions Table" "${perfout}" ; then
+		echo "c2c function stdio report test [Failed: partial report on missing iaddr]"
+		cat "${perfout}"
+		err=1
+		return
+	fi
+
+	if perf c2c report -i "${perfdata}" --function --stats > "${perfout}" 2>&1 ; then
+		echo "c2c function stdio report test [Failed: accepted conflicting options]"
+		err=1
+		return
+	fi
+	if ! grep -Fq -- "--stats and --function cannot be used together." "${perfout}" ; then
+		echo "c2c function stdio report test [Failed: missing conflict diagnostic]"
+		cat "${perfout}"
+		err=1
+		return
+	fi
+
+	# Exercise contended futex hash-bucket locks so the function view can get
+	# reader, writer, and cacheline rows without changing the original test.
+	if ! perf c2c record -o "${funcdata}" -- \
+		perf bench futex hash -t 4 -r 1 -s > /dev/null 2>&1 ; then
+		echo "c2c function stdio report test [Skipped: recording failed]"
+		err=2
+		return
+	fi
+
+	if ! perf c2c report -i "${funcdata}" --function > "${perfout}" 2>&1 ; then
+		echo "c2c function stdio report test [Failed: report failed]"
+		cat "${perfout}"
+		err=1
+		return
+	fi
+
+	for expected in "Shared Data Functions Table" \
+		"#    Cycles    Store" \
+		"#         %    count  Function / Contending function / Cacheline" \
+		"# .........  ......." ; do
+		if ! grep -Fq "${expected}" "${perfout}" ; then
+			echo "c2c function stdio report test [Failed: missing '${expected}']"
+			cat "${perfout}"
+			err=1
+			return
+		fi
+	done
+	for unexpected in "Shared Data Cache Line Table" \
+		"Shared Cache Line Distribution Pareto" ; do
+		if grep -Fq "${unexpected}" "${perfout}" ; then
+			echo "c2c function stdio report test [Failed: found '${unexpected}']"
+			cat "${perfout}"
+			err=1
+			return
+		fi
+	done
+
+	if ! awk '/^# \.+/ { body = 1; next }
+		body && !/^#/ && NF { found = 1 }
+		END { exit !found }' "${perfout}" ; then
+		echo "c2c function stdio report test [Skipped: no contended samples]"
+		err=2
+		return
+	fi
+
+	# The spaces intentionally verify per-level indentation and expanded
+	# fold-sign placement without depending on symbol names.
+	for expected in \
+		'^  - +[0-9]+\.[0-9]+% +[0-9]+  - ' \
+		'^ +[0-9]+    - ' \
+		'^ +[0-9]+        0x[[:xdigit:]]+$' ; do
+		if ! grep -Eq "${expected}" "${perfout}" ; then
+			echo "c2c function stdio report test [Failed: missing hierarchy row]"
+			echo "  ${expected}"
+			cat "${perfout}"
+			err=1
+			return
+		fi
+	done
+
+	if awk '/^# \.+/ { body = 1; next }
+		body && /[[:blank:]]$/ { found = 1 }
+		END { exit !found }' "${perfout}" ; then
+		echo "c2c function stdio report test [Failed: trailing whitespace in table body]"
+		cat "${perfout}"
+		err=1
+		return
+	fi
+
+	echo "c2c function stdio report test [Success]"
+}
+
 test_c2c_record_report
+if [ "${err}" -eq 0 ]; then
+	test_c2c_function_report
+fi
 cleanup
 exit $err
-- 
2.52.0

