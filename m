Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977710940;
	Sat, 14 Dec 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734136925; cv=none; b=Vuqz59ntC6cTXM4uQwY8a79QnLpUFZVzv9pxVN2odfVpCCmXFl1vg3WWnsFIeoWFjal3yHulHmEHRHqjzRCF41kS9s5XUx9a+hshpuWmWFsiao9e9jV4zVsENsHDFYTqgcl96WLyoqqtn27A1Y2kV8nvD5xaaHZYzeO90CndFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734136925; c=relaxed/simple;
	bh=Qaw5A57WI8zq1tXxYNIl7I3u3j5kqQH7y+PGaJpmsl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf6CNmoQYo8iRG4dH81bnq0cmt2EZIUJlH9uLxwIAgmhg7CIxuK19KZU+YWem0WGK5I8QdIrC/XqNZfBNA6+p4kyzkR/F2fiWRZiOV7Tva7rcbA4Q6uLKFwBbDVxEDNI/8v1JpJRWnDciBPTNEnNDcjhUNt0UPvMYhNmf27/ow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOsLTQft; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOsLTQft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCE2C4CED0;
	Sat, 14 Dec 2024 00:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734136924;
	bh=Qaw5A57WI8zq1tXxYNIl7I3u3j5kqQH7y+PGaJpmsl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOsLTQftyVjnOG9om7JwKAvLH7VxOF3gTKJdNlXKRTSECgqsu9fOsTXdMLTlLvKBH
	 rcQEGkU5e4NYVNidOO5o5+PcaF91QtK+iqt4VBm85pJJbPfTMj2lchg7inIGHDoyTM
	 BTsY8n7uWB1HNemFa2BbZDg1PVkuTEA9OyFNZHSn5IPt0TM6A06oTezFg80jVl++WM
	 ldl08C0kPqgVScTHRlwxb3/N8CnGQy0Z73uzWYVN6B3yRVCsRUMB4SOXGFbjWmoJfm
	 f9O/+D0LL2nVuWeqsN4+0rrm7N/v0TLR72zf187Nj9y2iljX5X83i1U/ej7LQJlQ21
	 YOnytpw5/v+2A==
Date: Fri, 13 Dec 2024 16:42:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf trace: Add tests for BTF general augmentation
Message-ID: <Z1zUW5itJzHI89gP@google.com>
References: <20241211224927.968483-1-howardchu95@gmail.com>
 <20241211224927.968483-2-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211224927.968483-2-howardchu95@gmail.com>

Hi Howard,

On Wed, Dec 11, 2024 at 02:49:26PM -0800, Howard Chu wrote:
> Currently, we only have perf trace augmentation tests for enum
> arguments. This patch adds tests for more general syscall arguments,
> such as struct pointers, strings, and buffers.
> 
> These tests utilize the perf config system to configure the perf trace
> output, as suggested by Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 93 +++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> new file mode 100755
> index 000000000000..bef07bad42bb
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -0,0 +1,93 @@
> +#!/bin/bash
> +# perf trace BTF general tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +err=0
> +set -e
> +
> +. "$(dirname $0)"/lib/probe.sh
> +
> +file1=$(mktemp /tmp/file1_XXXX)
> +file2=$(echo $file1 | sed 's/file1/file2/g')
> +
> +buffer="buffer content"
> +perf_config_tmp=$(mktemp /tmp/.perfconfig_XXXXX)
> +
> +trap cleanup EXIT TERM INT HUP
> +
> +check_vmlinux() {
> +  echo "Checking if vmlinux BTF exists"
> +  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1

Normally we do

  if [ ! -f /sys/kernel/btf/vmlinux ]

> +  then
> +    echo "Skipped due to missing vmlinux BTF"
> +    err=2

This can be overwritten by trace_test_string.


> +  fi
> +}
> +
> +trace_test_string() {
> +  echo "Testing perf trace's string augmentation"
> +  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
> +    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"

Does this work without BTF support?

Thanks
Namhyung


> +  then
> +    echo "String augmentation test failed"
> +    err=1
> +  fi
> +}
> +
> +trace_test_buffer() {
> +  echo "Testing perf trace's buffer augmentation"
> +  # echo will insert a newline (\10) at the end of the buffer
> +  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | \
> +    grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
> +  then
> +    echo "Buffer augmentation test failed"
> +    err=1
> +  fi
> +}
> +
> +trace_test_struct_btf() {
> +  echo "Testing perf trace's struct augmentation"
> +  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | \
> +    grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
> +  then
> +    echo "BTF struct augmentation test failed"
> +    err=1
> +  fi
> +}
> +
> +cleanup() {
> +  rm -rf ${file1} ${file2} ${perf_config_tmp}
> +}
> +
> +trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cleanup
> +  exit 1
> +}
> +
> +# don't overwrite user's perf config
> +trace_config() {
> +  export PERF_CONFIG=${perf_config_tmp}
> +  perf config trace.show_arg_names=false trace.show_duration=false \
> +    trace.show_timestamp=false trace.args_alignment=0
> +}
> +
> +skip_if_no_perf_trace || exit 2
> +
> +check_vmlinux
> +
> +trace_config
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
> 
