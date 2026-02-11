Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A131C3F0C;
	Wed, 11 Feb 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814498; cv=none; b=Cbxj/HEItKYUD4bPwuf2KUqo0/tGzEYI0agZUro9LSby5DDyOJRXkkPDEAOld4exjrRWc9+XOm5r3vkt8UjsHxtnKajnfPu31m+1ryULjeFZGE6MApJGZHFuahXHUikoOhGNR9IBibWsDOU0VJQVO1zK1zoWDS1VJ5XeDckhzBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814498; c=relaxed/simple;
	bh=gsrzadTq43js7WZY4x/JF5C3E8yJWOGekiXLNXSS0m0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s/sz4KIBbN5Qe2iurSnjhdQ9fQytcAtf37sNPt5KUH320xLjV+kELusrxZBNSDe3QweVwXRktBKLmK+lqalNXnZv+KyP3PryPf8VsG3BQCdIhEtmGgMekx44iCc/meggerdROhbznFhTQ2lqzNa1uSFtU7Kur2b+PWwdVOazG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqSB6AQ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqSB6AQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B51C19421;
	Wed, 11 Feb 2026 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770814498;
	bh=gsrzadTq43js7WZY4x/JF5C3E8yJWOGekiXLNXSS0m0=;
	h=Date:From:To:Cc:Subject:From;
	b=XqSB6AQ/HpGvV8sVQK05y+C8opjcw0JFRwpv8JAzA7zN8TiPdqYJ5VF740ryXMLk1
	 FZvv6/Rs2jIK4G2wlkYO+PGgufkP4LyiOY5eW1Hq8fal8usB4jOeHGt+KNxGtrQkdc
	 459isaBdjnyXbCmRdI3Va+0thIcxd5DWa2FgtYCCZjIdK7KSyuOSSn6bNpQhswEXay
	 OZk7SYR54vXdJ/SvBtBt7YUgrcPg9VZENI1pwtpaiZWsUBX8u3HfSMJyVioFqkNxmD
	 9KYZrXU/hR2fyzJFiiuUZBxNZ8Z6SLmV/AmE85I/CNHyxdioISujZtyk2fSf2nw4Ku
	 19OCDwxkD+OUg==
Date: Wed, 11 Feb 2026 09:54:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf test data_type_profiling.sh: Skip just the Rust
 tests if code_with_type workload is missing
Message-ID: <aYx8HIerWMAQguUs@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Namhyung suggested skipping only the rust tests when the code_with_type
'perf test' workload is not built into perf, do it so that we can
continue to test the C based workloads:

With rust:

  root@number:/# perf test -vv "data type"
   83: perf data type profiling tests:
  --- start ---
  test child forked, pid 2645245
  Basic Rust perf annotate test
  Basic annotate test [Success]
  Pipe Rust perf annotate test
  Pipe annotate test [Success]
  Basic C perf annotate test
  Basic annotate test [Success]
  Pipe C perf annotate test
  Pipe annotate test [Success]
  ---- end(0) ----
   83: perf data type profiling tests                                  : Ok
  root@number:/#

Without:

  root@number:/# perf test "data type"
   83: perf data type profiling tests                                  : Ok
  root@number:/# perf test -vv "data type"
   83: perf data type profiling tests:
  --- start ---
  test child forked, pid 2634759
  Basic Rust perf annotate test
  Skip: code_with_type workload not built in 'perf test'
  Pipe Rust perf annotate test
  Skip: code_with_type workload not built in 'perf test'
  Basic C perf annotate test
  Basic annotate test [Success]
  Pipe C perf annotate test
  Pipe annotate test [Success]
  ---- end(0) ----
   83: perf data type profiling tests                                  : Ok
  root@number:/#

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/data_type_profiling.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
index 3ef72a10850d0734..2a7f8f7c42d094a2 100755
--- a/tools/perf/tests/shell/data_type_profiling.sh
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -4,11 +4,6 @@
 
 set -e
 
-if ! perf test --list-workloads | grep -qw code_with_type ; then
-	echo "Skip: code_with_type workload not built in 'perf test'"
-	exit 2
-fi
-
 # The logic below follows the same line as the annotate test, but looks for a
 # data type profiling manifestation
 
@@ -42,6 +37,11 @@ test_basic_annotate() {
 
   case "x${runtime}" in
     "xRust")
+    if ! perf check feature -q rust
+    then
+      echo "Skip: code_with_type workload not built in 'perf test'"
+      return
+    fi
     index=0 ;;
 
     "xC")
-- 
2.53.0

