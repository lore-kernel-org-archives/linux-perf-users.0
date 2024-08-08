Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE318E056;
	Thu,  8 Aug 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127688; cv=none; b=KqMufeFri6F7k7VL8tJFhPjMqP9QzevZZvXhRCJYAy2RXRzIdWbeLUHPMSU4QWA+i0QS/gxwtaY3xMWrtNmpqyZYg9I2Lha7rTBGUkxAQU5mCD6gZBxTz9JlP55Yuw/tNw4yDYxbRm/1oM3GR58rMk15/SLg5pjwaKTsf/r10FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127688; c=relaxed/simple;
	bh=3bmBR8LGeH2dYpdGK2nOw0cjjBNumXI44Uzp2DOECW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=audKK6apmzCmEQV3BebRHuTB/y/5AuDgki2IVMi+RN/rTEdtoQj5iJotyhZ/JdbGe8Oqmiy9+n6W6pjOtrpSvdpbcwLB63x+CrxBiL9FoGpj8uWEeyS7cKlL4K+qKatlJQfT9pgJsPklL8bCzBZYuyAFtvZpY+qicNfMIIyGyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NANa96po; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NANa96po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144F4C4AF0D;
	Thu,  8 Aug 2024 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723127687;
	bh=3bmBR8LGeH2dYpdGK2nOw0cjjBNumXI44Uzp2DOECW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NANa96po9l7Bb3N5HpsY2lCmRDc2A+ZGed6ONmFrm/k7HwrU1QR3omNOdTNdNQVce
	 vMflAztH8OPhr+3XFuH6KyRMdFSwD/1QFJl/sJg0XhgZHeQJCLsR58vbxKt1CO8Wnf
	 qYRBTb34L5HLeRiWkozOoL/ZaqH7O4dA4OiHotud/qon3KS8zMlL1LJPPh/Y6j5Ev7
	 6cePMitTNePp61/g9tQO5jVPVXbcA4nD+fBU3fRM8ZDIgslvF6xa8kFK0CLfE6Kgg3
	 JmO8Jbg7ksMKp6E7qZwF8GCv/UA9WB1AikioBEVjNeX/LvAyfyaI68GavwZHi2SdAB
	 /Nx/nReQ03wwg==
Date: Thu, 8 Aug 2024 11:34:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Changbin Du <changbin.du@huawei.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Add set of perf record LBR tests
Message-ID: <ZrTXftup0H46R8WK@x1>
References: <20240808054644.1286065-1-irogers@google.com>
 <20240808054644.1286065-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808054644.1286065-2-irogers@google.com>

On Wed, Aug 07, 2024 at 10:46:44PM -0700, Ian Rogers wrote:
> Adds coverage for LBR operations and LBR callgraph.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record_lbr.sh | 161 +++++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_lbr.sh
> 
> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
> new file mode 100755
> index 000000000000..baf168d0ddbb
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_lbr.sh
> @@ -0,0 +1,161 @@
> +#!/bin/bash
> +# perf record LBR tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +if [ ! -f /sys/devices/cpu/caps/branches ]
> +then
> +  echo "Skip: only x86 CPUs support LBR"
> +  exit 2
> +fi

root@x1:~# ls -la /sys/devices/cpu*/caps/branches 
-r--r--r--. 1 root root 4096 Jun  4 16:07 /sys/devices/cpu_atom/caps/branches
-r--r--r--. 1 root root 4096 Aug  8 11:21 /sys/devices/cpu_core/caps/branches
root@x1:~#

I'm getting:

root@x1:~# perf test -vvvv LBR
 97: perf record LBR tests:
--- start ---
test child forked, pid 2033388
Skip: only x86 CPUs support LBR
---- end(-2) ----
 97: perf record LBR tests                                           : Skip
root@x1:~#

So I added the following follow-up patch, ack?

- Arnaldo

From f6ea332dd25cc62b9493b2d40040c2fb35253d9e Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 8 Aug 2024 11:26:13 -0300
Subject: [PATCH 1/1] perf test shell lbr: Support hybrid x86 systems too

Running on a:

  root@x1:~# grep 'model name' -m1 /proc/cpuinfo
  model name	: 13th Gen Intel(R) Core(TM) i7-1365U
  root@x1:~#

It skips all the tests with:

  root@x1:~# perf test -vvvv LBR
   97: perf record LBR tests:
  --- start ---
  test child forked, pid 2033388
  Skip: only x86 CPUs support LBR
  ---- end(-2) ----
   97: perf record LBR tests                                           : Skip
  root@x1:~#

Because the test checks for the /sys/devices/cpu/caps/branches file,
that isn't present as we have instead:

  root@x1:~# ls -la /sys/devices/cpu*/caps/branches
  -r--r--r--. 1 root root 4096 Aug  8 11:22 /sys/devices/cpu_atom/caps/branches
  -r--r--r--. 1 root root 4096 Aug  8 11:21 /sys/devices/cpu_core/caps/branches
  root@x1:~#

If we check as well for one of those,
/sys/devices/cpu_core/caps/branches, then we don't skip the tests and
all are run on these x86 Intel Hybrid systems as well, passing all of
them:

  root@x1:~# perf test -vvvv LBR
   97: perf record LBR tests:
  --- start ---
  test child forked, pid 2034956
  LBR callgraph
  [ perf record: Woken up 5 times to write data ]
  [ perf record: Captured and wrote 1.812 MB /tmp/__perf_test.perf.data.B2HvQ (8114 samples) ]
  LBR callgraph [Success]
  LBR any branch test
  [ perf record: Woken up 25 times to write data ]
  [ perf record: Captured and wrote 6.382 MB /tmp/__perf_test.perf.data.B2HvQ (8071 samples) ]
  LBR any branch test: 8071 samples
  LBR any branch test [Success]
  LBR any call test
  [ perf record: Woken up 23 times to write data ]
  [ perf record: Captured and wrote 6.208 MB /tmp/__perf_test.perf.data.B2HvQ (8092 samples) ]
  LBR any call test: 8092 samples
  LBR any call test [Success]
  LBR any ret test
  [ perf record: Woken up 24 times to write data ]
  [ perf record: Captured and wrote 6.396 MB /tmp/__perf_test.perf.data.B2HvQ (8093 samples) ]
  LBR any ret test: 8093 samples
  LBR any ret test [Success]
  LBR any indirect call test
  [ perf record: Woken up 25 times to write data ]
  [ perf record: Captured and wrote 6.344 MB /tmp/__perf_test.perf.data.B2HvQ (8067 samples) ]
  LBR any indirect call test: 8067 samples
  LBR any indirect call test [Success]
  LBR any indirect jump test
  [ perf record: Woken up 12 times to write data ]
  [ perf record: Captured and wrote 3.073 MB /tmp/__perf_test.perf.data.B2HvQ (8061 samples) ]
  LBR any indirect jump test: 8061 samples
  LBR any indirect jump test [Success]
  LBR direct calls test
  [ perf record: Woken up 25 times to write data ]
  [ perf record: Captured and wrote 6.380 MB /tmp/__perf_test.perf.data.B2HvQ (8076 samples) ]
  LBR direct calls test: 8076 samples
  LBR direct calls test [Success]
  LBR any indirect user call test
  [ perf record: Woken up 5 times to write data ]
  [ perf record: Captured and wrote 1.597 MB /tmp/__perf_test.perf.data.B2HvQ (8079 samples) ]
  LBR any indirect user call test: 8079 samples
  LBR any indirect user call test [Success]
  LBR system wide any branch test
  [ perf record: Woken up 26 times to write data ]
  [ perf record: Captured and wrote 9.088 MB /tmp/__perf_test.perf.data.B2HvQ (9209 samples) ]
  LBR system wide any branch test: 9209 samples
  LBR system wide any branch test [Success]
  LBR system wide any call test
  [ perf record: Woken up 25 times to write data ]
  [ perf record: Captured and wrote 8.945 MB /tmp/__perf_test.perf.data.B2HvQ (9333 samples) ]
  LBR system wide any call test: 9333 samples
  LBR system wide any call test [Success]
  LBR parallel any branch test
  LBR parallel any call test
  LBR parallel any ret test
  LBR parallel any indirect call test
  LBR parallel any indirect jump test
  LBR parallel direct calls test
  LBR parallel system wide any branch test
  LBR parallel any indirect user call test
  LBR parallel system wide any call test
  [ perf record: Woken up 9 times to write data ]
  [ perf record: Woken up 51 times to write data ]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Woken up 5 times to write data ]
  [ perf record: Woken up 559 times to write data ]
  [ perf record: Woken up 14 times to write data ]
  [ perf record: Woken up 17 times to write data ]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Woken up 11 times to write data ]
  [ perf record: Captured and wrote 0.150 MB /tmp/__perf_test.perf.data.lANpR (1909 samples) ]
  [ perf record: Captured and wrote 2.371 MB /tmp/__perf_test.perf.data.Olum8 (3033 samples) ]
  [ perf record: Captured and wrote 1.230 MB /tmp/__perf_test.perf.data.njfJ8 (1742 samples) ]
  [ perf record: Captured and wrote 5.554 MB /tmp/__perf_test.perf.data.4ZTrj (29662 samples) ]
  [ perf record: Captured and wrote 19.906 MB /tmp/__perf_test.perf.data.dlGQt (29576 samples) ]
  [ perf record: Captured and wrote 0.289 MB /tmp/__perf_test.perf.data.CAT7y (4311 samples) ]
  [ perf record: Captured and wrote 3.129 MB /tmp/__perf_test.perf.data.diuKG (3971 samples) ]
  LBR parallel any indirect user call test: 1909 samples
  [ perf record: Captured and wrote 4.858 MB /tmp/__perf_test.perf.data.sVjtN (6130 samples) ]
  LBR parallel any indirect user call test [Success]
  [ perf record: Captured and wrote 3.669 MB /tmp/__perf_test.perf.data.AJtNI (4827 samples) ]
  LBR parallel any indirect jump test: 4311 samples
  LBR parallel any indirect jump test [Success]
  LBR parallel direct calls test: 3033 samples
  LBR parallel direct calls test [Success]
  LBR parallel any indirect call test: 1742 samples
  LBR parallel any indirect call test [Success]
  LBR parallel any call test: 4827 samples
  LBR parallel any call test [Success]
  LBR parallel any branch test: 6130 samples
  LBR parallel any branch test [Success]
  LBR parallel system wide any branch test: 29662 samples
  LBR parallel any ret test: 3971 samples
  LBR parallel any ret test [Success]
  LBR parallel system wide any branch test [Success]
  LBR parallel system wide any call test: 29576 samples
  LBR parallel system wide any call test [Success]
  ---- end(0) ----
   97: perf record LBR tests                                           : Ok
  root@x1:~#

Cc: Adrian Hunter <adrian.hunter@intel.com>,
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anne Macedo <retpolanne@posteo.net>,
Cc: Changbin Du <changbin.du@huawei.com>,
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
Cc: Jiri Olsa <jolsa@kernel.org>,
Cc: Kan Liang <kan.liang@linux.intel.com>,
Cc: Mark Rutland <mark.rutland@arm.com>,
Cc: Namhyung Kim <namhyung@kernel.org>,
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record_lbr.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index baf168d0ddbbf447..ead87b731898d70b 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -4,7 +4,7 @@
 
 set -e
 
-if [ ! -f /sys/devices/cpu/caps/branches ]
+if [ ! -f /sys/devices/cpu/caps/branches -a ! -f /sys/devices/cpu_core/caps/branches ]
 then
   echo "Skip: only x86 CPUs support LBR"
   exit 2
-- 
2.44.0

