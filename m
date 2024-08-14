Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972F1B1402
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649559; cv=none; b=Iua4CcREgmYqNaz7l40uSYjKRVaX5o20JbbbA2y0Kra6x+zZZ5O0TB74cj7Em6KoBva11PtdW6DprVp2+3M2ztrUFEnhdIWUjai6kQ1v0e+KyCQJR8qNt8WM3jfk1NbnHSKaeqEVjkrqor79te9vIASKbpkxy230Kom1DuOt+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649559; c=relaxed/simple;
	bh=zz+YrMBOpf3lZ1InXmWnXj4epipPZp4tSK8KUaYj5Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9kF8AQYsdf0GvY4WfSIdMheRf5IpxEriDQmHjm+wq14x7r8FRJZwzlg95Wkplvh3Xi75F3AVSKqX6luC66SLkfG09Py4XuL/sDYRD1Szi+WSFr7AlAG5ewzbkUCUiKZEkcIujQMym8LdB6ZWBLCmGtlfBJVPD3MWBc/ZBuGItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOY32ZiA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOY32ZiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84824C116B1;
	Wed, 14 Aug 2024 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723649559;
	bh=zz+YrMBOpf3lZ1InXmWnXj4epipPZp4tSK8KUaYj5Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOY32ZiARmrTUuTq20HbOvUcmFOaZOMjwwVZL72W2tZfH9A4ADXmZKaWunCznnju3
	 gvXOsemcbDSDwSeij77WRmqzez5FZV8yzenCIZ9RjkAtODQdXHitsdAFzzGV0JToc0
	 LKpskECeV+PexzhnDGP6uQ1lW4mY2iyK/Ikk7xgAhQThNGalOwJfr3GmZYxT27DSn8
	 vLwDgORxwoOezGhuUO66xgnwhNNjG7tFMgRz+sdGikuSpELlQEOp+A/QhSAyUbh+1K
	 tf50dBeadSVBD2T8QSMDMBTgl+t5laxv3WA1G8Iym+pOhSGJmx0+WYu33zeSHa03T5
	 1nah9kLQ/6tGA==
Date: Wed, 14 Aug 2024 12:32:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com,
	adrian.hunter@intel.com, atrajeev@linux.vnet.ibm.com,
	irogers@google.com, jolsa@kernel.org, kjain@linux.ibm.com,
	mpetlan@redhat.com, rstoyano@redhat.com
Subject: Re: [PATCH v3] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZrzOFDmwl9Z8F8NP@x1>
References: <20240814151734.15409-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814151734.15409-1-vmolnaro@redhat.com>

On Wed, Aug 14, 2024 at 05:17:34PM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Subtest for system-wide record with '--threads=cpu' option fails due
> to a limit of open file descriptors on systems with 128 or more CPUs
> as the default limit is set to 1024.
> 
> The number of open file descriptors should be slightly above
> nmb_events*nmb_cpus + nmb_cpus(for perf.data.n) + 4*nmb_cpus(for pipes),
> which equals 8*nmb_cpus. Therefore, temporarily raise the limit to
> 16*nmb_cpus for the test.

So it is not applying anymore, Kan Liang changed that file, I'm fixing
it up:

⬢[acme@toolbox perf-tools-next]$        git am ./v3_20240814_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
Applying: perf test record.sh: Raise limit of open file descriptors
error: patch failed: tools/perf/tests/shell/record.sh:22
error: tools/perf/tests/shell/record.sh: patch does not apply
Patch failed at 0001 perf test record.sh: Raise limit of open file descriptors
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
⬢[acme@toolbox perf-tools-next]$

Doing it manually makes us go farther:

⬢[acme@toolbox perf-tools-next]$ patch -p1 < ./v3_20240814_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
patching file tools/perf/tests/shell/record.sh
Hunk #1 succeeded at 23 with fuzz 2 (offset 1 line).
Hunk #2 succeeded at 123 (offset 1 line).
Hunk #3 succeeded at 217 with fuzz 1 (offset 7 lines).
⬢[acme@toolbox perf-tools-next]$

After applying it with the resulting diff, I think we should not disable
those changes, just state the precise shell we think is needed for this
particular test:

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 28f5fe3b380e0b06..de913ebeb54ba220 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf record tests
 # SPDX-License-Identifier: GPL-2.0
 
@@ -32,7 +32,6 @@ ulimit_supported=false
 # outside of testing, thus raising the limit to 16*nmb_cpus
 min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
 
-# shellcheck disable=SC3045 # ulimit is required for testing --threads option
 default_fd_limit=$(ulimit -Sn)
 if [ $? -eq 0 ]; then
   ulimit_supported=true
@@ -219,7 +218,6 @@ test_branch_counter() {
 
 # raise the limit of file descriptors to required minimum
 if [ $ulimit_supported ] && [ $default_fd_limit -lt $min_fd_limit ]; then
-  # shellcheck disable=SC3045 # ulimit is required for testing --threads option
   ulimit -Sn $min_fd_limit
 fi
 
@@ -231,7 +229,6 @@ test_branch_counter
 
 # restore the default value
 if [ $ulimit_supported ]; then
-  # shellcheck disable=SC3045 # ulimit is required for testing --threads option
   ulimit -Sn $default_fd_limit
 fi
 
⬢[acme@toolbox perf-tools-next]$

I.e. just state that /bin/bash is needed, like is done in multiple other
shell tests:

⬢[acme@toolbox perf-tools-next]$ head -1 tools/perf/tests/shell/*.sh | grep bash | wc -l
16
⬢[acme@toolbox perf-tools-next]$

Ok? I'm applying it with this change. Thanks,

- Arnaldo
