Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5F18C938;
	Mon,  9 Sep 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919885; cv=none; b=li/UW1yoRhfK+1vy/jQmk8ZgRjkqJmjgRyBcWp/hmuLd5y9svloYH4aw0/jZNzGpZJzRgM49vx8aOwZatNZSMVLFzFffSAyR78elWQ6VUFE819/7xa9vHjEdQyy/PMdbsSAFxCh5R3EdVlYHDTGwguQ2d0WMEVrF68XTP2YErEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919885; c=relaxed/simple;
	bh=8vg3AuHJblhrjLiUGlZqJUh7L/RmFtVibjViGgrID3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz5udVvfnX/ArwKqhYPO3SI8qWnpC8i8YJXiUbR98tfLs79Jb0XtD1pKAFsqkA/jfLUdOhtsRSMj5jQk3aHhqgWGA+ULV6JZpCuWrvMd/+U4oEG8JVLGR1O+xT4l3OPKihUXhzI6O6FA3GoYZUovLuNGhtMz8RjI2H8hjdnB4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUaik6H1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUaik6H1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACADC4CEC6;
	Mon,  9 Sep 2024 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725919885;
	bh=8vg3AuHJblhrjLiUGlZqJUh7L/RmFtVibjViGgrID3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUaik6H1pAFWMN2k/yGeY+knwPSvuMsOw2ui1tQVsOScmGvrSLoFsFcE7JxmBUdb3
	 Mzp9Wmrv6o2fL8h+BHqXGGAWSTs/fotu7qJYxfkDT2CHZeaQhdfX7EfMlE5KNnTJ6W
	 Nwf5hhulrm+aUILRXYLE9eBssfQolW1ZuKEbQ5UGQpzKq+CaBBMkJMKdNCdSAIR6AM
	 1t5NReNaTLPvF+q7aSBJNOnRNw8tmXPR+MuLXDjLIZS7A8raoBXmmPhAMuq2flnr6V
	 1tpjfS2AhM0ZeSDPZ0UQ3ZEf3uIo6yH9XTgo/qiLGxMWbgZdSfKWZInB82JF4KBpaW
	 6iZ24nfS3HLFQ==
Date: Mon, 9 Sep 2024 19:11:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] perf trace: Add general tests for augmented
 syscalls
Message-ID: <Zt9yiQq-n-W6I274@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-9-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240824163322.60796-9-howardchu95@gmail.com>

On Sun, Aug 25, 2024 at 12:33:22AM +0800, Howard Chu wrote:
> In this test, augmentation for:
> 
> * string
> * buffer
> * struct
> 
> Is tested.

Please install ShellCheck to test it:

  GEN     perf-archive
  GEN     perf-iostat
  TEST    /tmp/build/perf-tools-next/tests/shell/trace_btf_general.sh.shellcheck_log
  CC      /tmp/build/perf-tools-next/util/header.o

In tests/shell/trace_btf_general.sh line 50:
	echo "Unexpected signal in ${FUNCNAME[1]}"
                                   ^------------^ SC3028 (warning): In POSIX sh, FUNCNAME is undefined.
                                   ^------------^ SC3054 (warning): In POSIX sh, array references are undefined.

For more information:
  https://www.shellcheck.net/wiki/SC3028 -- In POSIX sh, FUNCNAME is undefined.
  https://www.shellcheck.net/wiki/SC3054 -- In POSIX sh, array references are...
make[4]: *** [tests/Build:91: /tmp/build/perf-tools-next/tests/shell/trace_btf_general.sh.shellcheck_log] Error 1
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: tests] Error 2
make[2]: *** [Makefile.perf:777: /tmp/build/perf-tools-next/perf-test-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools-next/util/perf-util-in.o
  LD      /tmp/build/perf-tools-next/perf-util-in.o
make[1]: *** [Makefile.perf:292: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢[acme@toolbox perf-tools-next]$
 
> Please use this command:
> 
> perf test "perf trace general tests"
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 67 +++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> new file mode 100755
> index 000000000000..0b4ea8462390
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +# perf trace general tests
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
> +buffer="this is a buffer for testing"
> +
> +trap cleanup EXIT TERM INT HUP
> +
> +trace_test_string() {
> +  echo "Testing perf trace's string augmentation"
> +  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | grep -q -E "renameat[2]*.*oldname: \"${file1}\".*newname: \"${file2}\".*"
> +  then
> +    echo "String augmentation test failed"
> +    err=1
> +  fi
> +}
> +
> +trace_test_buffer() {
> +  echo "Testing perf trace's buffer augmentation"
> +  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | grep -q -E ".*write.*buf: ${buffer}.*"
> +  then
> +    echo "Buffer augmentation test failed"
> +    err=1
> +  fi
> +}
> +
> +trace_test_struct_btf() {
> +  echo "Testing perf trace's struct augmentation"
> +  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | grep -q -E ".*clock_nanosleep\(rqtp: \{1,\}, rmtp: \{1,\}\).* = 0"
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
> 2.45.2
