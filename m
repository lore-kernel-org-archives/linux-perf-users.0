Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D2125DE
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Oct 2023 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0AD610B;
	Mon, 23 Oct 2023 06:17:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC412F4;
	Mon, 23 Oct 2023 06:17:48 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC23F3F762;
	Mon, 23 Oct 2023 06:17:04 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	atrajeev@linux.vnet.ibm.com,
	tianruidong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: [PATCH] perf tests: test_arm_coresight: Simplify source iteration
Date: Mon, 23 Oct 2023 14:15:49 +0100
Message-Id: <20231023131550.487760-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two reasons to do this, firstly there is a shellcheck warning
in cs_etm_dev_name(), which can be completely deleted. And secondly the
current iteration method doesn't support systems with both ETE and ETM
because it picks one or the other. There isn't a known system with this
configuration, but it could happen in the future.

Iterating over all the sources for each CPU can be done by going through
/sys/bus/event_source/devices/cs_etm/cpu* and following the symlink back
to the Coresight device in /sys/bus/coresight/devices. This will work
whether the device is ETE, ETM or any future name, and is much simpler
and doesn't require any hard coded version numbers

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---

This was discussed here previously:
https://lore.kernel.org/all/20230929041133.95355-2-atrajeev@linux.vnet.ibm.com/

I chose not to add a fixes tag like the original because shellcheck
isn't part of the build so it doesn't really fix any real issue yet and
is just a refactor.

 tools/perf/tests/shell/test_arm_coresight.sh | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index fe78c4626e45..65dd85207125 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -11,19 +11,6 @@
 
 glb_err=0
 
-cs_etm_dev_name() {
-	cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
-	trcdevarch=$(cat ${cs_etm_path}/mgmt/trcdevarch)
-	archhver=$((($trcdevarch >> 12) & 0xf))
-	archpart=$(($trcdevarch & 0xfff))
-
-	if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
-		echo "ete"
-	else
-		echo "etm"
-	fi
-}
-
 skip_if_no_cs_etm_event() {
 	perf list | grep -q 'cs_etm//' && return 0
 
@@ -149,7 +136,9 @@ arm_cs_iterate_devices() {
 
 arm_cs_etm_traverse_path_test() {
 	# Iterate for every ETM device
-	for dev in /sys/bus/coresight/devices/$(cs_etm_dev_name)*; do
+	for dev in /sys/bus/event_source/devices/cs_etm/cpu*; do
+		# Canonicalize the path
+		dev=`readlink -f $dev`
 
 		# Find the ETM device belonging to which CPU
 		cpu=`cat $dev/cpu`
-- 
2.34.1

