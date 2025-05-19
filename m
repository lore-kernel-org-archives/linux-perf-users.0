Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D561FCE;
	Mon, 19 May 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643293; cv=none; b=Tyi7oHVmUv8DhCG56d2vQRVkMajF8/QwAPf7VbDdo15IELyWkL8xkdhDekvRBPpMoFbUDHHzdpSEHNTNb7HJdbZjl37Vhi2hnIQjZD5WYngWVaeUHY2UBJCqM07he60vqW9x9/mWoCuDonIyil2SnbyJIYrQ96QAq1EfsmT7gMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643293; c=relaxed/simple;
	bh=EZwYfI6UoItoqaAQx0P/SnWP4DI4Px525DAcQTTWdgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qWbP5NsLAuNwu5CJW6NbEJ2fB6XJMqES0pHvxeHG0gMaRhUg0+C/1zd6FFC0mXDUwwO6mzteAFDFCyCXTB+1Ttg5lrzzWCCxzZZwZxx08Tr0vrVLEmyiKo5ZsRLxDHZzLG9kH8K0gk7pOBb+w/dfSHqM86cxAKdfdZy+oI+p3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A475E153B;
	Mon, 19 May 2025 01:27:52 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 285BD3F5A1;
	Mon, 19 May 2025 01:28:04 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2] perf test probe_vfs_getname: Add regex for searching probe line
Date: Mon, 19 May 2025 09:27:55 +0100
Message-Id: <20250519082755.1669187-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 611851010c74 ("fs: dedup handling of struct filename init
and refcounts bumps"), the kernel has been refactored to use a new
inline function initname(), moving name initialization into it.

As a result, the perf probe test can no longer find the source line that
matches the defined regular expressions. This causes the script to fail
when attempting to add probes.

Add a regular expression to search for the call site of initname(). This
provides a valid source line number for adding the probe. Keeps the
older regular expressions for passing test on older kernels.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Fixes: 611851010c74 ("fs: dedup handling of struct filename init and refcounts bumps")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---

Changes from v1:
- Keep old regexps to be compatible with older kernels (Arnaldo)

 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 89f72a4c818c..58debce9ab42 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,8 +13,16 @@ cleanup_probe_vfs_getname() {
 add_probe_vfs_getname() {
 	add_probe_verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
-		result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
-		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
+		result_initname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
+		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_initname_re" | sed -r "s/$result_initname_re/\1/")
+
+		# Search the old regular expressions so that this will
+		# pass on older kernels as well.
+		if [ -z "$line" ] ; then
+			result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
+			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
+		fi
+
 		if [ -z "$line" ] ; then
 			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
 			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
-- 
2.34.1

