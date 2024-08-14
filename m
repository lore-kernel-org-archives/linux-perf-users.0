Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18B1B8E89
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650837; cv=none; b=eL82NCn6kIbIm2As5CDG1pi9Cm4lMV8jAQQFmYeB40QYhAEEjDXWsWH+JPR5ofjR356D6gpj92QpgGKztZozcdHDbdIajrsaxuzop7dWiQah05PH6ZZBeyMvH/zxyiILhASNLGQ2COrTIgOj/pr3SzdIhVWVakvdLjJUmaBGmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650837; c=relaxed/simple;
	bh=eKNjJZ4Qs7JDy2DBtPYY+8s3bzOIZ3d84AbpueKLOKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA+VFM48ZReUYtFsasWmwPH8V6vwjZmbiAxla2+RgcSelzCWZmUXio9GeeDVXLhYghDebuN6Va5zysQLwwsHRKA6lvJjpZQSlyFvaGJXkyZC+c8raf0LAzCVAe4ZELaE50nlVpGfYVe46ru/HFhEYhFVjonE0mVR5qfJYQC7d6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHaKajUM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHaKajUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A60BC4AF09;
	Wed, 14 Aug 2024 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723650836;
	bh=eKNjJZ4Qs7JDy2DBtPYY+8s3bzOIZ3d84AbpueKLOKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHaKajUM86Z0cBZSjslbNdMtr59k52PtGl4Mxva5E0gwcWQ+VMTk+Vb2McTpFotR8
	 E0HFnpKu/iD4y8JkxgwRUWS5xeXXCtJiuboGcinQj9Jn4Ouw/PvPgn1DaYGVWEpbKr
	 Q1Rnm4u42WyAk/eCXujrLdOnXhp5z10hnNXwcL8UddloQO4LfDsmIU/rapQ6YcJ+TX
	 JKaIfrloJtWBMBi+c1o6j0o153hvYO7CmvH2fG7JPVPffTJuQX/zn14mxynqJoF77c
	 8AseD/SeajtwRYKyMmILJmn2+FFmNcfm8WRotLB9eJqpJWde+VDwzBNaGHlriPZoub
	 Dway9nDMLKC+g==
Date: Wed, 14 Aug 2024 12:53:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com,
	adrian.hunter@intel.com, atrajeev@linux.vnet.ibm.com,
	irogers@google.com, jolsa@kernel.org, kjain@linux.ibm.com,
	mpetlan@redhat.com, rstoyano@redhat.com
Subject: Re: [PATCH v3] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZrzTEQUYDpxui2oZ@x1>
References: <20240814151734.15409-1-vmolnaro@redhat.com>
 <ZrzOFDmwl9Z8F8NP@x1>
 <ZrzO2T1s_tIpqizG@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrzO2T1s_tIpqizG@x1>

On Wed, Aug 14, 2024 at 12:35:55PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 14, 2024 at 12:32:39PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Aug 14, 2024 at 05:17:34PM +0200, vmolnaro@redhat.com wrote:
> > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Ok? I'm applying it with this change. Thanks,
> 
> So I added this to the log message:
> 
> Committer notes:
> 
> Instead of disabling ShellCheck warnings all the uses of 'uname -n',
> i.e. those:
> 
>   In tests/shell/record.sh line 35:
>   default_fd_limit=$(ulimit -Sn)
>                             ^-^ SC3045 (warning): In POSIX sh, ulimit -S is undefined.
> 
> We can just switch from using '/bin/sh' to '/bin/bash' for this test, as
> bash _has_ 'ulimit -n', so ShellCheck will not emit that warning.
> 
> There are dozens of 'perf test' shell tests that do just that,
> '/bin/bash' is a reasonable expectation for those tests.
> 
> ----------------------------------------------------------
> 
> Please let me know if you find any issues with this course of action,

Well, I looked again and since we're switching for /bin/bash as a
requisite for this test, then we better use your v2 patch that doesn't
have the logic for checking if 'ulimit -n' is available, i.e. I'm
picking this instead:

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 7964ebd9007d8eeb..29ab077b3811d494 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf record tests
 # SPDX-License-Identifier: GPL-2.0
 
@@ -23,6 +23,15 @@ br_cntr_file="/caps/branch_counter_nr"
 br_cntr_output="branch stack counters"
 br_cntr_script_output="br_cntr: A"
 
+default_fd_limit=$(ulimit -n)
+# With option --threads=cpu the number of open file descriptors should be
+# equal to sum of:    nmb_cpus * nmb_events (2+dummy),
+#                     nmb_threads for perf.data.n (equal to nmb_cpus) and
+#                     2*nmb_cpus of pipes = 4*nmb_cpus (each pipe has 2 ends)
+# All together it needs 8*nmb_cpus file descriptors plus some are also used
+# outside of testing, thus raising the limit to 16*nmb_cpus
+min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
+
 cleanup() {
   rm -rf "${perfdata}"
   rm -rf "${perfdata}".old
@@ -197,11 +206,19 @@ test_branch_counter() {
   echo "Branch counter test [Success]"
 }
 
+# raise the limit of file descriptors to minimum
+if [[ $default_fd_limit -lt $min_fd_limit ]]; then
+       ulimit -n $min_fd_limit
+fi
+
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
 test_branch_counter
 
+# restore the default value
+ulimit -n $default_fd_limit
+
 cleanup
 exit $err
