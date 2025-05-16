Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2B1DFE8;
	Fri, 16 May 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386347; cv=none; b=QO49XLFAEvgodQ1KkmX9WSHTW+YJrGu2HkPeAz8tomU35zhTGZC96npGT+uFW1DA71Gx3t6w6AO2Q1cRcOFLF6L/9lSN2qw6B7oBByEkmN/0uuBr2vHwUvmKR0TValP1voW2fEmWXUP8Y/I95Pnvae7XAtq56OZkfLd1uyuhY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386347; c=relaxed/simple;
	bh=+xvzhVpofD6Y7KI26Z67qDl+ILn+Ae1I9LCLCtDvjEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aQPbhG+XcmelRG+U7f67SVbZHRwvZEhjU7W7WK2PjqPcjUHgTiSljtbfqphDUlyEubtioCZhpno7HiKTccFEbx8sqP7TRWvYwso4WrBve/vISaK3YkHhaCus8nbV6ORhegyKmjYsOlAxOafPePnQlxNA8NNqiAwVhte7Oh9scHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B092A1655;
	Fri, 16 May 2025 02:05:31 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC71B3F63F;
	Fri, 16 May 2025 02:05:41 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf test probe_vfs_getname: Correct probe line for updated kernel code
Date: Fri, 16 May 2025 10:05:32 +0100
Message-Id: <20250516090532.916743-1-leo.yan@arm.com>
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
matches the defined regular expressions.  This causes the script to fail
when attempting to add probes.

Update the regular expression to search for the call site of initname().
This provides a valid source line number for adding the probe.

Fixes: 611851010c74 ("fs: dedup handling of struct filename init and refcounts bumps")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 89f72a4c818c..cbfdd2a62c6e 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,12 +13,8 @@ cleanup_probe_vfs_getname() {
 add_probe_vfs_getname() {
 	add_probe_verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
-		result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
-		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
-		if [ -z "$line" ] ; then
-			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
-			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
-		fi
+		result_initname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
+		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_initname_re" | sed -r "s/$result_initname_re/\1/")
 
 		if [ -z "$line" ] ; then
 			echo "Could not find probeable line"
-- 
2.34.1

