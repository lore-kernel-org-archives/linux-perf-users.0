Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE882451C6;
	Tue, 10 Dec 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869840; cv=none; b=KYDps4BdcRP+jaXSErbgAKctcQfInxmRZQq9/Wvt2ZgiK/wOvc/OfwWHbm4HVmFvddCCLY0OS3ZVlIlvCu3Nq729ms2+LABzMsiz2jLDq1kk1DMAH+mpfGsVd+qetAkbGfKCRsoAt6Ef0Yjh5WYtHF+YH/beEkr4ghpliD/UsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869840; c=relaxed/simple;
	bh=9+51JCB/pG5QGsHxuMElgRDWlaGSIllUoxznJzKEcbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/abxeKj+kgSNLJwNJzp7Svl3ZdtVf60rtGu3kOPuIaTmFipCAlMvIBxe6HKavHAAW5Ivn/zF9Nvpk8ZPVOAElBrc29+3m12fweDi+19J1H6ysn6cll+aztU2G0a86uFJ49YM1vHbCXbBldjQo4PbVTQpzKrX1R1bJ47cPDNbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIF4hkjj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIF4hkjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385B3C4CED6;
	Tue, 10 Dec 2024 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733869839;
	bh=9+51JCB/pG5QGsHxuMElgRDWlaGSIllUoxznJzKEcbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIF4hkjjuZNfR+HmsFgPDxY2qk6pMNQ18HA7+QYsxNBOS5wbEdkgZFFdvWNaCqAuz
	 9rxGOqyWjEGF53PuTnlOfPj1H1Y/qD1Cbe7TrwTZPh3wxxiCI6E8O74x3cXfEL40We
	 nO6yh7MGvidEQpVIeYv2GAK+I6yYLhw7PSvWY1kWL0+O+hDCXh2nYX8+AbdYnn1iOX
	 A4dgbY78T+ZJr5X7jsSNt/HX0/AF7XWoLLF6JelqXmH2/PJpx2CQb1pa+DM4w8O8bF
	 Sr/2GlhcJEAD/PgLbQr8OrP23Awwh6Hx/GTPfuMiqw8F6i3gStutSBCMlGIrG4hlVM
	 ekbcMAQljUTWw==
Date: Tue, 10 Dec 2024 14:30:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf trace: Add tests for BTF general augmentation
Message-ID: <Z1jBDHeEnPrsL7DQ@google.com>
References: <20241126223257.22465-1-howardchu95@gmail.com>
 <20241126223257.22465-2-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126223257.22465-2-howardchu95@gmail.com>

Hello,

On Tue, Nov 26, 2024 at 02:32:56PM -0800, Howard Chu wrote:
> Currently, we only have perf trace augmentation tests for enum
> arguments. This patch adds tests for more general syscall arguments,
> such as struct pointers, strings, and buffers.
> 
> These tests utilize the perf config system to configure the perf trace
> output, as suggested by Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 81 +++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> new file mode 100755
> index 000000000000..903310b355c4
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -0,0 +1,81 @@
> +#!/bin/bash
> +# perf trace BTF general tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +err=0
> +set -e
> +
> +. "$(dirname $0)"/lib/probe.sh
> +skip_if_no_perf_trace || exit 2

The kernel might not have BPF/BTF support.  I think you can check if
/sys/kernel/btf/vmlinux is there and skip the test if not.

Thanks,
Namhyung

> +
> +file1=$(mktemp /tmp/file1_XXXXX)
> +file2=$(echo $file1 | sed 's/file1/file2/g')
> +
> +buffer="buffer content"
> +perf_config_tmp=$(mktemp /tmp/.perfconfig_XXXXX)
> +
> +trap cleanup EXIT TERM INT HUP
> +
> +trace_test_string() {
> +  echo "Testing perf trace's string augmentation"
> +  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
> +    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
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
