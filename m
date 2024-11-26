Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE41B6D0E;
	Tue, 26 Nov 2024 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660694; cv=none; b=fIvas1xwABBoMH4Mu6gRA67zvvvxp544ITxd5prnawAS5zd2H6CcQvIu6crz/dNTG/fNPOYePGkRQ3CCOFIo76pzH6RoKzj61ICTVNuWq/YKIceSJ1aOY4gbfngJRTFohk78oR0qOA7nDobAGL2jHTheSfEDlbTSity9i47Z0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660694; c=relaxed/simple;
	bh=x7MrH/nVxsyiE1kMMZA96M6hnV/PUF855B9fXnSWOUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HxZlGLwhmBxZkPvlIa4/A2tDeqEUT3IqfvEiXvLiZggns7ITDOmCujkvyQZ7+QCheYUSs/SB2X6EmjmsjgeJ11kzgYiNMd/hUN0XAij093UBZa7bSEocbe5GZUqloqvwInZihF5OWKsxCPjxxJvHWdOCcxzhBhNNGpBnOfWzkqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15D90153B;
	Tue, 26 Nov 2024 14:38:40 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9094C3F66E;
	Tue, 26 Nov 2024 14:38:07 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Likhitha Korrapati <likhitha@linux.ibm.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Guilherme Amadio <amadio@gentoo.org>
Subject: [PATCH] perf test record+probe_libc_inet_pton: Make test resilient
Date: Tue, 26 Nov 2024 22:38:00 +0000
Message-Id: <20241126223800.193694-1-leo.yan@arm.com>
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
 .../shell/record+probe_libc_inet_pton.sh      | 34 ++++++++++---------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 47a26f25db9f..868b4d3eeb7f 100755
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
+		# Seatch lines in the perf script result
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

