Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29033EE;
	Fri,  7 Jun 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717790753; cv=none; b=SQVD6/o/tvc9xR8HrfPQQ3/o4Lbv010TOM5/8hxwzTtcjzCkMp4Zjps0KPEaeQRxadvDtFanFAqDAv82G/0D+PlfRSURlbEUqsuu5yiZ5TecbyXpYp1iuFiWFGp44V5uVPmpSAIcn8UHvAdw34dFnkEhuln76EqrbJ5qCAV/scU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717790753; c=relaxed/simple;
	bh=HYe1s44uoKtDjU2ht8FvQtcve8B+M4pKuiV3mHZO+dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0hfE2vdqKRzyc5stUNg5I+iNY8zEQT/O2ldFtiXAxvqM2ObKp0VXYjvOoNLwN6A5TTQQjWIzcu0rPsc+Il6NjKFa4RUJhiN8ZDkZXeXy9ojexHTUZWee7Bk9u2Q/KSQSfqikZtt0P1MRiE7xQe/SejQM/XgyqlZ9BGH+w3+FGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdTI4eBi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdTI4eBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881F1C2BBFC;
	Fri,  7 Jun 2024 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717790752;
	bh=HYe1s44uoKtDjU2ht8FvQtcve8B+M4pKuiV3mHZO+dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdTI4eBi5NppaDAceI9lRHsdRe9lyWjV8NlepVU5OqQAJSSdB3cRH4UuovZC0IEwJ
	 hDJgmo+BlAXjZNdk+ntPE722bvcGYpWwpBiz4iWIja4F72sNeBv0zB/cxGkM/v9k1q
	 ujH0bLTs3CDT5Nf15u2GkBzHTv8Z03P1c9t2GvRkQyAQOBxzOsMxV5AONA9gvYHChF
	 /+oR8kYjgtBdZSGdhWuHLBnlJjpX8nWSmmGuyXgbSWu3sG2R03C2TqZCNArfjgCnB2
	 017lSfFU5POLdTrvYUb8KTAE7U7Gc7qOI352otd+kpKIVFdgl7VMcBQH4laZoG9jm1
	 2OjAIM04Ts3Mw==
Date: Fri, 7 Jun 2024 13:05:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Speed up test case 70 annotate basic tests
Message-ID: <ZmNoH-RoIXwVPJt5@google.com>
References: <20240607054352.2774936-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607054352.2774936-1-tmricht@linux.ibm.com>

On Fri, Jun 07, 2024 at 07:43:52AM +0200, Thomas Richter wrote:
> On some s390 linux machine (mostly older models) and with debug
> packages installed, the test case 'perf annotate basic tests' runs
> for some longer time.
> Speed up the test and save the output of command perf annotate
> in a temporary file. This is used to perform pattern matching via
> grep command. This saves on invocation of perf annotate which
> runs for some time.
> 
> Output before:
>  # time bash -x tests/shell/annotate.sh >/dev/null 2>&1; echo EXIT CODE $?
> 
>  real   4m35.543s
>  user   3m19.442s
>  sys    1m14.322s
>  EXIT CODE 0
>  #
> Output after:
>  # time bash -x tests/shell/annotate.sh >/dev/null 2>&1; echo EXIT CODE $?
> 
>  real   2m2.881s
>  user   1m30.980s
>  sys    0m30.684s
>  EXIT CODE 0
>  #

Oh.. it takes too long.  I think we should limit the output from
perf annotate in some way.  Anyway, the patch looks ok.

> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/annotate.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
> index 1db1e8113d99..b072d9b97387 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh
> @@ -15,12 +15,13 @@ skip_test_missing_symbol ${testsym}
>  
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
>  testprog="perf test -w noploop"
>  # disassembly format: "percent : offset: instruction (operands ...)"
>  disasm_regex="[0-9]*\.[0-9]* *: *\w*: *\w*"
>  
>  cleanup() {
> -  rm -rf "${perfdata}"
> +  rm -rf "${perfdata}" "${perfout}"
>    rm -rf "${perfdata}".old
>  
>    trap - EXIT TERM INT
> @@ -41,8 +42,11 @@ test_basic() {
>      return
>    fi
>  
> +  # Generate the annotated output file
> +  perf annotate -i "${perfdata}" --stdio 2> /dev/null > "${perfout}"
> +
>    # check if it has the target symbol
> -  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${testsym}"
> +  if ! grep "${testsym}" "${perfout}"
>    then
>      echo "Basic annotate [Failed: missing target symbol]"
>      err=1
> @@ -50,7 +54,7 @@ test_basic() {
>    fi
>  
>    # check if it has the disassembly lines
> -  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${disasm_regex}"
> +  if ! grep "${disasm_regex}" "${perfout}"
>    then
>      echo "Basic annotate [Failed: missing disasm output from default disassembler]"
>      err=1
> -- 
> 2.45.1
> 
