Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE811FCFE7;
	Mon,  2 Dec 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138413; cv=none; b=F8FEnRVOfac99y1M3inhMehNFY4JatUCL9gEaWXoiH1wBG195gw4wwmI9uyR6FiqkfGL76BCFh8Op3tXUil2H82TFNSbqCRXEPsnCOFQlwmKvvy6G382PDac5ntfkeol3pjlGlC+fRaxQ041X5fuZoa9NMLBRY/COVlddPzAqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138413; c=relaxed/simple;
	bh=kd6W06N/AFB8/6eSvxw+YEuTby5eDyhs4z8FLM2F1Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LyP5DLYb+PIB9lm5nH5n0S8MkTuPglFfu0bNurEBmWgLhdNA4m99N52S9hi/ggnA3qJCruPXZINY2FGovo1zVeH79GCEu1yMewFN1t5lnxwGkLBSCIP/eFI1cAFBybokLb/JypoBYpZ0MBailbxmU8XoNEb6dyS3nT6HpFB7Mxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 538EE1063;
	Mon,  2 Dec 2024 03:20:38 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA4F83F71E;
	Mon,  2 Dec 2024 03:20:07 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Guilherme Amadio <amadio@gentoo.org>
Subject: [PATCH v2] perf test record+probe_libc_inet_pton: Make test resilient
Date: Mon,  2 Dec 2024 11:19:58 +0000
Message-Id: <20241202111958.553403-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test failed back and forth due to the call chain being heavily
impacted by the libc, which varies across different architectures and
distros.

The libc contains the symbols for "gaih_inet" and "getaddrinfo" in some
cases, but not always.  Moreover, these symbols can be either normal
symbols or dynamic symbols, making it difficult to decide the call chain
entries due to the symbols are inconsistent.

To fix the issue, this commit identifies three call chain entries are
always present.  These entries are matched by iterating through the
lines in the "perf script" result.  The recording attribute max-stack is
set to 4 for the possible maximum call chain depth.

After:

  # perf test -vF pton
  --- start ---
  Pattern: ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
    Matching: ping  285058 [025] 1219802.466939: probe_libc:inet_pton: (ffffa14b7cf0)
  Pattern: .*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib/aarch64-linux-gnu/libc-2.31.so|inlined\)$
    Matching: ping  285058 [025] 1219802.466939: probe_libc:inet_pton: (ffffa14b7cf0)
    Matching: ffffa14b7cf0 __GI___inet_pton+0x0 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
  Pattern: .*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$
    Matching: ping  285058 [025] 1219802.466939: probe_libc:inet_pton: (ffffa14b7cf0)
    Matching: ffffa14b7cf0 __GI___inet_pton+0x0 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
    Matching: ffffa1488040 getaddrinfo+0xe8 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
    Matching: aaaab8672da4 [unknown] (/usr/bin/ping)
  ---- end ----
   82: probe libc's inet_pton & backtrace it with ping                 : Ok

Reported-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Closes: https://lore.kernel.org/linux-perf-users/1728978807-81116-1-git-send-email-renyu.zj@linux.alibaba.com/
Reported-by: Guilherme Amadio <amadio@gentoo.org>
Closes: https://lore.kernel.org/linux-perf-users/Z0X3AYUWkAgfPpWj@x1/T/#m57327e135b156047e37d214a0d453af6ae1e02be
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes from v1: Fixed a typo s/Seatch/Search.

 .../shell/record+probe_libc_inet_pton.sh      | 34 ++++++++++---------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 47a26f25db9f..3fbc7a7409af 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -43,17 +43,8 @@ trace_libc_inet_pton_backtrace() {
 		echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlined|.*/bin/ping.*\)$" >> $expected
 		;;
-	ppc64|ppc64le)
-		eventattr='max-stack=4'
-		# Add gaih_inet to expected backtrace only if it is part of libc.
-		if nm $libc | grep -F -q gaih_inet.; then
-			echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		fi
-		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
-		;;
 	*)
-		eventattr='max-stack=3'
+		eventattr='max-stack=4'
 		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	esac
@@ -76,14 +67,25 @@ trace_libc_inet_pton_backtrace() {
 	fi
 	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
 
-	exec 3<$perf_script
 	exec 4<$expected
-	while read line <&3 && read -r pattern <&4; do
+	while read -r pattern <&4; do
+		echo "Pattern: $pattern"
 		[ -z "$pattern" ] && break
-		echo $line
-		echo "$line" | grep -E -q "$pattern"
-		if [ $? -ne 0 ] ; then
-			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
+
+		found=0
+
+		# Search lines in the perf script result
+		exec 3<$perf_script
+		while read line <&3; do
+			[ -z "$line" ] && break
+			echo "  Matching: $line"
+			! echo "$line" | grep -E -q "$pattern"
+			found=$?
+			[ $found -eq 1 ] && break
+		done
+
+		if [ $found -ne 1 ] ; then
+			printf "FAIL: Didn't find the expected backtrace entry \"%s\"\n" "$pattern"
 			return 1
 		fi
 	done
-- 
2.34.1

