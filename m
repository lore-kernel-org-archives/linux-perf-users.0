Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291733EA;
	Sun, 18 May 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747589938; cv=none; b=t5opGTjdA700jlYYkBDbQRRFkmZctT2KDfD4vJltUCBJ7nbM8BP2pcpjuwF1cL5fXu1bxqofCFtrGc5GQa9JuAbs4icXatmhtrbDQMOR72wOiE1Z+jyial8ys6ImsSoOsFVWQoCZHKMSesA7Lq1mTtnOGu97P4bSaiyZJTjCx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747589938; c=relaxed/simple;
	bh=1rcFx6S0KdiGhIZJMwa0fKOgFgcI8zc8sWDeyHYjAas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsXeE2xBJ5lAjfnejlDnTv4WFw21o/kgu/svQ8dl4rqOM66JNaR/r/qW9JXHtYDVXFoFi747wUTVcFDWt2I018YZliW3Z0ygrK7u8RHOn2vMQYe0tQRxZGJpATDog8Ith0zylRcOMCyoCfSnKlfDy5nz0YQ3h3wx0TJcMWEMG3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0sqxmNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0sqxmNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0782C4CEE7;
	Sun, 18 May 2025 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747589937;
	bh=1rcFx6S0KdiGhIZJMwa0fKOgFgcI8zc8sWDeyHYjAas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0sqxmNUKelsGsObyfIz2r7Jg1+To6iW1iChzD9J0xtLMDPaD7PXl66oIe1UKhJwe
	 j8STJewCSlQxmLyPtuZvKToOREdTJcVeiIJHcx+DDI0aes20G54TCSuaM5JSjd5MUG
	 PhXgDstk3ntk8jzaXsm2ar6TI3O390h5mwA0TWh7DvfdNwcLd1uX0WXHkVt1j/N8Q2
	 hhtYyBPlamaeuaiIqs7K8GekkbUHkDFKOlSrlElIYHmDZEJ+vBpI5Kl7VEm5dWnZHQ
	 IpBEdhVbd2R+vf+bLP4bCdCAV9kLRNKPMIiC92vetJiSViZC7h/1I2i3MDYxE+r6Jk
	 2yjzVaJf91YdA==
Date: Sun, 18 May 2025 10:38:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] perf test trace: Remove set -e for BTF general
 tests
Message-ID: <aCobLyqonDU4qnzv@google.com>
References: <20250517163230.1237469-1-howardchu95@gmail.com>
 <20250517163230.1237469-5-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517163230.1237469-5-howardchu95@gmail.com>

On Sat, May 17, 2025 at 09:32:29AM -0700, Howard Chu wrote:
> Remove set -e and print error messages in BTF general tests.
> 
> Before:
>     $ sudo /tmp/perf test btf -vv
>     108: perf trace BTF general tests:
>     108: perf trace BTF general tests                                    : Running
>     --- start ---
>     test child forked, pid 889299
>     Checking if vmlinux BTF exists
>     Testing perf trace's string augmentation
>     String augmentation test failed
>     ---- end(-1) ----
>     108: perf trace BTF general tests                                    : FAILED!
> 
> After:
>     $ sudo /tmp/perf test btf -vv
>     108: perf trace BTF general tests:
>     108: perf trace BTF general tests                                    : Running
>     --- start ---
>     test child forked, pid 886551
>     Checking if vmlinux BTF exists
>     Testing perf trace's string augmentation
>     String augmentation test failed, output:
>     :886566/886566 renameat2(CWD, "/tmp/file1_RcMa", CWD, "/tmp/file2_RcMa", NOREPLACE) = 0---- end(-1) ----
>     108: perf trace BTF general tests                                    : FAILED!
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> index a25d8744695e..e78e653fc8f1 100755
> --- a/tools/perf/tests/shell/trace_btf_general.sh
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -3,7 +3,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  err=0
> -set -e
>  
>  # shellcheck source=lib/probe.sh
>  . "$(dirname $0)"/lib/probe.sh
> @@ -28,10 +27,10 @@ check_vmlinux() {
>  
>  trace_test_string() {
>    echo "Testing perf trace's string augmentation"
> -  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
> -    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
> +  output="$(perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
> +  if ! echo "$output" | grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
>    then
> -    echo "String augmentation test failed"
> +    printf "String augmentation test failed, output:\n$output"

Looks like you need "\n" after the output as well.

>      err=1
>    fi
>  }
> @@ -39,20 +38,20 @@ trace_test_string() {
>  trace_test_buffer() {
>    echo "Testing perf trace's buffer augmentation"
>    # echo will insert a newline (\10) at the end of the buffer
> -  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | \
> -    grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
> +  output="$(perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1)"
> +  if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
>    then
> -    echo "Buffer augmentation test failed"
> +    printf "Buffer augmentation test failed, output:\n$output"

Ditto.  And probably for the previous patch too.

>      err=1
>    fi
>  }
>  
>  trace_test_struct_btf() {
>    echo "Testing perf trace's struct augmentation"
> -  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | \
> -    grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
> +  output="$(perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
> +  if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
>    then
> -    echo "BTF struct augmentation test failed"
> +	printf "BTF struct augmentation test failed, output:\n$output"

And here as well.

Thanks,
Namhyung


>      err=1
>    fi
>  }
> -- 
> 2.45.2
> 
