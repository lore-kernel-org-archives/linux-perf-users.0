Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F43A1FCF4F;
	Fri,  3 Jan 2025 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926481; cv=none; b=A57wAEFC9F05xEjHo8F0PfVGpzjq61LNRP8UW0R93YzUAVK/BUHL+HB8LpnxFmau1vswMlsWDgOuzEeNgbLSt3a5s7/5Qz05VXwdN+SGxZZn3sc5bJTDg3gS7TjtF2ZX/FbYvaWn0uN7GNRH5x0zhwMCaIRJHvXYKdTP3cR2j0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926481; c=relaxed/simple;
	bh=bc2M8yWpQL/mZ1Ab3rnvVOxKxrLXJ/WK4tDr/jdYdGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE9pPEF6RZzjqNDnkVj7Op/6gX5oWenL8COcJ2YdHKUAYoepVcVqDJCzu27T24Qq7obkdfiW2NFc7NuzlJ0XB+ugzj0kkjYvW9l9gFFWHZpEOD2+xuH0NVrhkTwiQ5QPKizS+WNmE4wsV3/uJjqFYRZnvU1v07n939/nUp+Xey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFF2E1480;
	Fri,  3 Jan 2025 09:48:22 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CFC63F673;
	Fri,  3 Jan 2025 09:47:54 -0800 (PST)
Date: Fri, 3 Jan 2025 17:47:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v2] perf test record+probe_libc_inet_pton: Make test
 resilient
Message-ID: <20250103174747.GA781381@e132581.arm.com>
References: <20241202111958.553403-1-leo.yan@arm.com>
 <2b3bc88a-e435-4ccc-a543-c8f8566dd306@linux.ibm.com>
 <Z04YU78EMUWhHtXL@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z04YU78EMUWhHtXL@google.com>

Hi all,

Happy new year!

On Mon, Dec 02, 2024 at 12:28:03PM -0800, Namhyung Kim wrote:
> 
> Hello,
> 
> On Mon, Dec 02, 2024 at 02:48:01PM +0100, Thomas Richter wrote:
> > On 12/2/24 12:19, Leo Yan wrote:
> > > The test failed back and forth due to the call chain being heavily
> > > impacted by the libc, which varies across different architectures and
> > > distros.
> > >
> >
> > For s390 using 6.13.0.rc1
> >
> > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Thanks for the test, but I think the patch excludes s390 to be safe.
> And I think we can test s390 in the same way.  If you're willing to do
> some more tests, Leo can update the patch to include s390 as well.

This case continuously fails on Arm64, so let's not forget to land the
fix.

I agreed with Namhyung for consolidation the test as possible.

@Thomas, could you test on s390 for below change?  And if you could
confirm the 'fp' mode for callgraph is supported on s390, then we even
can unify the event attribute:

  eventattr='max-stack=4'

Thanks,
Leo


---8<---

From 71bb457c7b5370693081856e7804ebe62c214301 Mon Sep 17 00:00:00 2001
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 2 Dec 2024 11:19:58 +0000
Subject: [PATCH] perf test record+probe_libc_inet_pton: Make test resilient

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
 .../shell/record+probe_libc_inet_pton.sh      | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 47a26f25db9f..326d924641e0 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -37,24 +37,14 @@ trace_libc_inet_pton_backtrace() {
 
 	echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
 	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
+	echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
-		echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
-		echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlined|.*/bin/ping.*\)$" >> $expected
-		;;
-	ppc64|ppc64le)
-		eventattr='max-stack=4'
-		# Add gaih_inet to expected backtrace only if it is part of libc.
-		if nm $libc | grep -F -q gaih_inet.; then
-			echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		fi
-		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	*)
-		eventattr='max-stack=3'
-		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		eventattr='max-stack=4'
 		;;
 	esac
 
@@ -76,14 +66,25 @@ trace_libc_inet_pton_backtrace() {
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
2.25.1

