Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD320E33E;
	Fri,  4 Apr 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789750; cv=none; b=VDIcxSJf31aM3k0GiwIyb5xDOvQdLfIjwzgkr6fDyCJg0L83XS46MYNjaazcjKgc6+SqxH+YQKHqS6i5EgaGfNIqQE7Wq5drxLHKfTyynQiCXoOzRkvQJIsbWuELEH59s/izV1Fm76JpV1NaIQ6j3eQM349W7P8JPu44reeF3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789750; c=relaxed/simple;
	bh=5bKVYp6tBNwdr8sgZ0U9e8u6ORf1X05snObhsyXiobo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqzYcoucXaGiuhQDW+S1LmPQqO9FPzcbI36IoXFOb5GwI5ELXDh1KXQjoRhgWAYn4m1nSpqMjBYRTjvbLkSukaxBYSsrt7SAsW0QMXXQmYIxhd6Zfat6X4Kmju/geS4vh8HAq8EHGR+ATRijX7U14h88EFgoQcpuK+Pq40gCC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXn3kcS3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXn3kcS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6368C4CEDD;
	Fri,  4 Apr 2025 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743789749;
	bh=5bKVYp6tBNwdr8sgZ0U9e8u6ORf1X05snObhsyXiobo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXn3kcS3vzSNMwtLarNiOBfwO58rPmknbpijd8Uv+ITAAXbmwAiwsjIwQysWMkFO3
	 7mMeGTOYwceb2UcShFbfLMgOEV+VyiYPYNp2TTkWbYLtRBF+eKxZRqoex6Aqw4Ol8t
	 gD3sNPmlePpvvu1nPiiT0j0/hyE+n+kLTRhmiNTJutHlurS45WtHDvJInmXQe93J1I
	 FPfb468LRXcoKBQy5Attz9hk+p53sp7KGsALKD/J+DSSXXKvN5T7RK0Kvu7PKh9nln
	 dx0l75EIzRAjZK4TZvTHb25qmjoTtrfofJhxPwq4jmn0GKEs3/HMeKVrGiFgr6uwgg
	 MNhqV4l2Ixp+A==
Date: Fri, 4 Apr 2025 11:02:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Fix inconsistent failures in perf trace's
 tests
Message-ID: <Z_AeswETE5xLcPT8@google.com>
References: <20250404041652.329340-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404041652.329340-1-howardchu95@gmail.com>

On Thu, Apr 03, 2025 at 09:16:52PM -0700, Howard Chu wrote:
> There are two failures that frequently occur in perf trace's tests. One
> is the failure of 'perf trace BTF general tests'; The other one is the
> failure of 'perf trace record and replay', which, when run independently,
> always succeeds.
> 
> The root cause of the first failure, is that perf trace may give two types
> of output, depending on whether the comm of a process can be parsed, for
> example:
> 
> mv/312705 renameat2(CWD, "/tmp/file1_VJOT", CWD, "/tmp/file2_VJOT", NOREPLACE) = 0
> :312774/312774 renameat2(CWD, "/tmp/file1_5YcE", CWD, "/tmp/file2_5YcE", NOREPLACE) = 0
> 
> In the test, however, grep is always looking for the comm 'mv', which
> sometimes may not be present.
> 
> The cause of the second failure is that 'perf trace BTF general tests'
> modifies the perf config, and because tests are run concurrently,
> subsequent tests use the modified perf config before the BTF general
> test can restore the original config. Mark the BTF general tests as
> exclusive will solve the failure.

I'm not sure if the config is the cause of the failure.  Also I don't
see it restored.

IIUC the export only affects child processes from the current shell.
So other tests running in parallel won't see the config change.

But still, there should be something to affect the behavior.  It's
strange to miss the task name in COMM record.

I also confirm that running the test serially fixes it.

Thanks,
Namhyung

> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Fixes: 0255338d6975 ("perf trace: Add tests for BTF general augmentation")
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> index a25d8744695e..4833618a116b 100755
> --- a/tools/perf/tests/shell/trace_btf_general.sh
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -1,5 +1,5 @@
>  #!/bin/bash
> -# perf trace BTF general tests
> +# perf trace BTF general tests (exclusive)
>  # SPDX-License-Identifier: GPL-2.0
>  
>  err=0
> @@ -29,7 +29,7 @@ check_vmlinux() {
>  trace_test_string() {
>    echo "Testing perf trace's string augmentation"
>    if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
> -    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
> +    grep -q -E "^.*/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
>    then
>      echo "String augmentation test failed"
>      err=1
> @@ -40,7 +40,7 @@ trace_test_buffer() {
>    echo "Testing perf trace's buffer augmentation"
>    # echo will insert a newline (\10) at the end of the buffer
>    if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | \
> -    grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
> +    grep -q -E "^.*/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
>    then
>      echo "Buffer augmentation test failed"
>      err=1
> @@ -50,7 +50,7 @@ trace_test_buffer() {
>  trace_test_struct_btf() {
>    echo "Testing perf trace's struct augmentation"
>    if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | \
> -    grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
> +    grep -q -E "^.*/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
>    then
>      echo "BTF struct augmentation test failed"
>      err=1
> -- 
> 2.45.2
> 
