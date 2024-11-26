Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F231D90B1;
	Tue, 26 Nov 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639788; cv=none; b=UVlEB3HQUA2UWzF29njnuYQFUpu3MEABinJz6ShZ/aZ5aAAxwHudUmx8CxI2LHjqBnvRbXWRqHPCDmJ8CglpLI3c5av8GuQ00dfby8Ekyen7ZS4op1kUtxLKraltJc0iB3BK3hL62whcF1N1DhM48pUHCdlfO5aUs/2XSjKjv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639788; c=relaxed/simple;
	bh=fUFOTs7mH3cBCL51Q+pyuhcwq/5vErsOBXqvsEUDzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOQOOXe6tPD26pd9RZMcylPyZaqDn+U+Ge7Wwp7dNDSy0qSrsrWPK5gT9qOFoxxptWqb48JkWjqiL7SheyQXqaAt7XZ7gfIQ07Xg7EMIC69yt0kXEIxJ1XdzcglaJNaJoKYMcbM17ngDyHOcvj3VViIeVnwzq/ztBKEnGXakBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG5kujaX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG5kujaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643A4C4CECF;
	Tue, 26 Nov 2024 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732639787;
	bh=fUFOTs7mH3cBCL51Q+pyuhcwq/5vErsOBXqvsEUDzdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TG5kujaX41hkOEUSdMgyNFVULy107EeWWbzaoqV1rfT/ZiEmPJygSIHi+w0wpiLT7
	 DibDV0SlIWXTvULX2znU7By9HQu23hUz7Ue3VF8x18w9UcuxZ1QH0basrMJ+ATeg7p
	 SG42E8ZEsaDQRLXLEi/tuBqspVHFYCtfmt5anLliVZEPR8u14rImZmJPuX0CH3D+fi
	 0yHZzNx/L2BQRuussO+KwR3rKQ9Yo79eS0xWJ1HjEv7moJnZ+SQVhmGtvT8sFpKX8G
	 TAWrYY8TMapMWs4frppqCN6RUghIskHHBQZ4ZjvGsvmFr5WfzqrCaFYepTXziO4Ius
	 SKhe5TZDcr8Yg==
Date: Tue, 26 Nov 2024 13:49:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf trace: Add tests for BTF general augmentation
Message-ID: <Z0X8KJd5LYrgUJUh@x1>
References: <20241123005512.342079-1-howardchu95@gmail.com>
 <20241123005512.342079-2-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241123005512.342079-2-howardchu95@gmail.com>

On Fri, Nov 22, 2024 at 04:55:10PM -0800, Howard Chu wrote:
> Currently, we only have perf trace augmentation tests for enum
> arguments. This patch adds tests for more general syscall arguments,
> such as struct pointers, strings, and buffers.

scripts/checkpatch.pl has some warnings here I think we can address
easily, some not so much, like the SPDX that we need to add logic to
'perf test' to noticed its the SPDX and skip it, looking at the next
line for the test description.


The long lines we can just make them multiple lines with the first ones
ending in \


⬢ [acme@toolbox perf-tools-next]$ rm -f 0001-* ; git format-patch --no-cover-letter HEAD~ ; scripts/checkpatch.pl 0001-*
0001-perf-trace-Add-tests-for-BTF-general-augmentation.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#31: 
new file mode 100755

WARNING: Missing or malformed SPDX-License-Identifier tag in line 2
#37: FILE: tools/perf/tests/shell/trace_btf_general.sh:2:
+# perf trace BTF general tests

WARNING: Misplaced SPDX-License-Identifier tag - use line 2 instead
#38: FILE: tools/perf/tests/shell/trace_btf_general.sh:3:
+# SPDX-License-Identifier: GPL-2.0

WARNING: line length of 252 exceeds 100 columns
#55: FILE: tools/perf/tests/shell/trace_btf_general.sh:20:
+  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ renameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${file2}\", flags: .*\) += +[0-9]+$"

WARNING: line length of 203 exceeds 100 columns
#65: FILE: tools/perf/tests/shell/trace_btf_general.sh:30:
+  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +echo\/[0-9]+ write\(fd: [0-9]+, buf: ${buffer}.*, count: [0-9]+\) += +[0-9]+$"

WARNING: line length of 275 exceeds 100 columns
#74: FILE: tools/perf/tests/shell/trace_btf_general.sh:39:
+  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +sleep\/[0-9]+ clock_nanosleep\(rqtp: \(struct __kernel_timespec\)\{\.tv_sec = \(__kernel_time64_t\)1,\}, rmtp: 0x[0-9a-f]+\) += +[0-9]+$"

total: 0 errors, 6 warnings, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-perf-trace-Add-tests-for-BTF-general-augmentation.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
⬢ [acme@toolbox perf-tools-next]$

> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 68 +++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> new file mode 100755
> index 000000000000..7bcca81a40d8
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -0,0 +1,68 @@
> +#!/bin/bash
> +# perf trace BTF general tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +err=0
> +set -e
> +
> +. "$(dirname $0)"/lib/probe.sh
> +skip_if_no_perf_trace || exit 2
> +
> +file1=$(mktemp /tmp/file1_XXXXX)
> +file2=$(echo $file1 | sed 's/file1/file2/g')
> +
> +buffer="the content of the buffer"
> +
> +trap cleanup EXIT TERM INT HUP
> +
> +trace_test_string() {
> +  echo "Testing perf trace's string augmentation"
> +  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ renameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${file2}\", flags: .*\) += +[0-9]+$"
> +  then
> +    echo "String augmentation test failed"
> +    err=1
> +  fi
> +}
> +
> +trace_test_buffer() {
> +  echo "Testing perf trace's buffer augmentation"
> +  # echo will insert a newline (\10) at the end of the buffer
> +  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +echo\/[0-9]+ write\(fd: [0-9]+, buf: ${buffer}.*, count: [0-9]+\) += +[0-9]+$"
> +  then
> +    echo "Buffer augmentation test failed"
> +    err=1
> +  fi
> +}
> +
> +trace_test_struct_btf() {
> +  echo "Testing perf trace's struct augmentation"
> +  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +sleep\/[0-9]+ clock_nanosleep\(rqtp: \(struct __kernel_timespec\)\{\.tv_sec = \(__kernel_time64_t\)1,\}, rmtp: 0x[0-9a-f]+\) += +[0-9]+$"
> +  then
> +    echo "BTF struct augmentation test failed"
> +    err=1
> +  fi
> +}
> +
> +cleanup() {
> +	rm -rf ${file1} ${file2}
> +}
> +
> +trap_cleanup() {
> +	echo "Unexpected signal in ${FUNCNAME[1]}"
> +	cleanup
> +	exit 1
> +}
> +
> +trace_test_string
> +
> +if [ $err = 0 ]; then
> +  trace_test_buffer
> +fi
> +
> +if [ $err = 0 ]; then
> +  trace_test_struct_btf
> +fi
> +
> +cleanup
> +
> +exit $err
> -- 
> 2.43.0
