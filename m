Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121DC10F2
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651862; cv=none; b=ehcNJq+6hIApslVGRHEVF6HQ5eZGmvdESFCeAyxd62uNTBnNZw6rbx+3hq0JMEsVhd2FR4jU4c7dCGehsjDZ+lQCatp7OIIc+G1Univ5w2beeZoGr3f6KhHImJtmLS2DqZ5j4V5HkLGbR/dktFyQTTv7YYHNyiLZOwtChjNZWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651862; c=relaxed/simple;
	bh=qukH/BYHEpNO87t9lIuZhg8oaH1HONqUOkY2n+eD5KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IMpVsbMpCG7ug9qPJZqaewzTqz9vkHt9CDLSA17vUdP91rzpUC1p8bchknnQR6FCQLmUrlZw3Pf5xd0SriiguNyft63t/JWt9y2TNN0gKxTMhJGoHrFRuuGn2kHHKVQ68fYxd5gozCwhmUPer/NgkyPBmxeV3thCw0/nZlewUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7RfiDNR; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7RfiDNR"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b69bf5638so71985911cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 05:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775651860; x=1776256660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zfuq07n7NjyQsQJh87VmDg6OxJJtdzKazE8wAGxxxlM=;
        b=W7RfiDNRdFHOKjIsm3U0rouN7MEfCBM4p7pZSt1aLRhuy7hXFVa2s93QOG2aC81+ON
         zL94dLZOBejOGetZQMIBORWPCcvXbGmBmJMYBhXAludhp1QyH+Ffj25N2NOGAC4v6O+X
         UuHGmK1RiggKYoFycXVVNOBge4y3HgLF4LVgKZBh1ffsQR6bZz9VEE1bvY3Onwpqazls
         XQkYfGijNbDx2ZreUUPliaYqSmATm1VLUM0XclhLTxO6C19aKYLC6eikhWHRPEYZ1Tdd
         vlJvwRPV+K/iUfmSYD6B40yckgmCJaPjXemjiYbu3o7ZfyNBoYBIMQ05AVPGxgvzX/Wk
         4gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775651860; x=1776256660;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfuq07n7NjyQsQJh87VmDg6OxJJtdzKazE8wAGxxxlM=;
        b=obYD8veURNMjqTpqht1GpAP2NjslSlIZAaZSFA3tRiJtNPGUBz+Gy5rCGG0+Q4+sGg
         ncSVdB9/clAdqFX5PwxI8uFd6FDeBJqPILk+LxYSMRKYpCiMZ7ga9NCssWthzAyMpoQm
         v9fZOpBPCIvLy1goo53S5ps/aAEr4jL7co+f5OPqKLMfB0QYRb2sRIz8FXWpmGBKH713
         miu/i/68ADMuRWX7hZvT7jXj3VOSGKQ9bXD24u52K5QSL1REzyeDi6vNnV9GELtm5oja
         tqRcedd3gnxPitPMxmuvJUCVAYMtoY5zdjNPUTkggUo2IkN9pU1WBrkJMtmVAzaoYNoi
         re7w==
X-Forwarded-Encrypted: i=1; AJvYcCV74aGng01x5wItzt3XLIiNC3pF7gy8ivaY7Tp+w7xd/5suxgglAyMvI5/KVfoPbtKDehmqRy6Gv9crKvYy2rvM@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpaizcvOOCsE0DeIreKjIu2D+gz64QAPzJvZdg9//AaymJ0dg
	7i07cMWucPcK9XZHuvm8QfbJlm6O0qO4ZvtAnhHDFTBoRv7W8MZIbsAxsPYyIwcLCtx35YSzxS0
	EgLqxGd4=
X-Gm-Gg: AeBDietzlXIcF8z/MFJhv9VYHLPMnD+UWenAi+wovCEvuYMvNsD60uK9JbxJBU+rVhH
	S84ufRyHZ9bGSgZZx8bd+ZIoUHnP85XhF0j55Pvdi3ODiX9oGNUvUUFaSH6c6v2v5fIBJYvGgKL
	urP4ls47jk996chfdv+ZdfI5YhL7Kd3MzO3txpcqEILOm7HBk5r+ZItMdW1+TVnDK4tliP3NBaF
	YZdUVvbB6NGLAzoyeeOGCCHziP4QBqqJw2tnK8zoxaJhX0M1zDy01R0iZeLHOVCAWVMBn6nrl4R
	dm4WK3E+0WzfJvmCUMsOeMyj52Dm5CuAbBSvs58DkBSUTx9Ew1kGuc8aJkZacKFRpXZ4iuKFdTu
	X0FPCu//Ta+WfYCfgZFI5AutqvKtVAwW+EJDgAjZCezDqo9lbIYleToZY8Kj3F2/x1A/Mis8oiG
	b/GqNeGHSMZXkK7b8D3EKwItNTfeMO
X-Received: by 2002:a05:622a:288:b0:50d:71fe:85aa with SMTP id d75a77b69052e-50d71fe8a92mr270975081cf.16.1775651859877;
        Wed, 08 Apr 2026 05:37:39 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d895f825fsm86653001cf.11.2026.04.08.05.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 05:37:39 -0700 (PDT)
Message-ID: <2bcc84ca-87fd-4111-88ad-225d2e7b2bd9@linaro.org>
Date: Wed, 8 Apr 2026 13:37:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf test: Fixes for check branch stack sampling
To: Ian Rogers <irogers@google.com>
References: <20260408062048.61252-1-irogers@google.com>
 <20260408065841.165393-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 German Gomez <german.gomez@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260408065841.165393-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/04/2026 7:58 am, Ian Rogers wrote:
> When filtering branch stack samples on user events they sample in user
> land but may have come from the kernel. Avoid the target address being
> a kernel address but allow the source to be the kernel.

Doesn't that leak kernel pointers then? I thought they were supposed to 
be semi secret to not break KASLR? With /u on Arm64 all kernel branch 
addresses are filtered out or zeroed. I think it might be worth adding 
an architecture condition with a different test for Intel if the 
behavior is different. Otherwise we could start leaking pointers on Arm 
and the test would not detect it.

> 
> When filtering branch stack samples on kernel events they sample in
> kernel land but may have come from user land. Avoid the target being a
> user address but allow the source to be in user land.
> 
> Increase the duration of the system call sampling test to make the
> likelihood of sampling a system call higher (increased from 1000 to
> 8000 loops - a number found through experimentation on an Intel
> Tigerlake laptop), also make the period of the event a prime number.
> 
> Put unneeded perf record output into a temporary file so that the test
> output isn't cluttered. More clearly state which test is running and
> the pass, fail or skipped result of the test.
> 
> These changes make the test on an Intel tigerlake laptop reliably pass
> rather than reliably fail.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/test_brstack.sh | 134 ++++++++++++++++---------
>   1 file changed, 84 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index 85233d435be6..025ed9d3d110 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -40,7 +40,7 @@ is_arm64() {
>   
>   check_branches() {
>   	if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$1"; then
> -		echo "Branches missing $1"
> +		echo "ERROR: Branches missing $1"
>   		err=1
>   	fi
>   }
> @@ -48,6 +48,8 @@ check_branches() {
>   test_user_branches() {
>   	echo "Testing user branch stack sampling"
>   
> +	start_err=$err
> +	err=0
>   	perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
>   	perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR/perf.script"
>   
> @@ -73,59 +75,80 @@ test_user_branches() {
>   	perf script -i "$TMPDIR/perf.data" --fields brstack | \
>   		tr ' ' '\n' > "$TMPDIR/perf.script"
>   
> -	# There should be no kernel addresses with the u option, in either
> -	# source or target addresses.
> -	if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> -		echo "ERROR: Kernel address found in user mode"
> +	# There should be no kernel addresses in the target with the u option.
> +	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[89a-f][0-9a-f]{15}/" $TMPDIR/perf.script; then
> +		echo "Testing user branch stack sampling [Failed kernel address found in user mode]"
>   		err=1
>   	fi
>   	# some branch types are still not being tested:
>   	# IND COND_CALL COND_RET SYSRET SERROR NO_TX
> +	if [ $err -eq 0 ]; then
> +		echo "Testing user branch stack sampling [Passed]"
> +		err=$start_err
> +	else
> +		echo "Testing user branch stack sampling [Failed]"
> +	fi
>   }
>   
>   test_trap_eret_branches() {
>   	echo "Testing trap & eret branches"
> +
>   	if ! is_arm64; then
> -		echo "skip: not arm64"
> +		echo "Testing trap & eret branches [Skipped not arm64]"
> +		return
> +	fi
> +	start_err=$err
> +	err=0
> +	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
> +		perf test -w traploop 1000 > "$TMPDIR/record.txt" 2>&1
> +	perf script -i $TMPDIR/perf.data --fields brstacksym | \
> +		tr ' ' '\n' > $TMPDIR/perf.script
> +
> +	# BRBINF<n>.TYPE == TRAP are mapped to PERF_BR_IRQ by the BRBE driver
> +	check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
> +	check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
> +	if [ $err -eq 0 ]; then
> +		echo "Testing trap & eret branches [Passed]"
> +		err=$start_err
>   	else
> -		perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
> -			perf test -w traploop 1000
> -		perf script -i $TMPDIR/perf.data --fields brstacksym | \
> -			tr ' ' '\n' > $TMPDIR/perf.script
> -
> -		# BRBINF<n>.TYPE == TRAP are mapped to PERF_BR_IRQ by the BRBE driver
> -		check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
> -		check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
> +		echo "Testing trap & eret branches [Failed]"
>   	fi
>   }
>   
>   test_kernel_branches() {
> -	echo "Testing that k option only includes kernel source addresses"
> +	echo "Testing kernel branch sampling"
>   
> -	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
> -		echo "skip: not enough privileges"
> +	if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/record.txt" 2>&1; then
> +		echo "Testing that k option [Skipped not enough privileges]"
> +		return
> +	fi
> +	start_err=$err
> +	err=0
> +	perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
> +		perf bench syscall basic --loop 1000 > "$TMPDIR/record.txt" 2>&1
> +	perf script -i $TMPDIR/perf.data --fields brstack | \
> +		tr ' ' '\n' > $TMPDIR/perf.script
> +
> +	# Example of branch entries:
> +	#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
> +	# Source addresses come first in user or kernel code. Next is the target
> +        # address that must be in the kernel.
> +
> +	# Look for source addresses with top bit set
> +	if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> +		echo "Testing kernel branch sampling [Failed kernel branches missing]"
> +		err=1
> +	fi
> +	# Look for no target addresses without top bit set
> +	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{0,15}/" $TMPDIR/perf.script; then

Target can be "0x0" for jumps from the kernel back to userspace with 
only kernel branches turned on. Before we were only looking at source 
addresses but now it looks at targets the test fails on 0x0 targets on Arm.

I suppose we could special case 0x0? It starts to get a bit horrible to 
do in bash with regexes though.

The rest of the changes look good.

> +		echo "Testing kernel branch sampling [Failed user branches found]"
> +		err=1
> +	fi
> +	if [ $err -eq 0 ]; then
> +		echo "Testing kernel branch sampling [Passed]"
> +		err=$start_err
>   	else
> -		perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
> -			perf bench syscall basic --loop 1000
> -		perf script -i $TMPDIR/perf.data --fields brstack | \
> -			tr ' ' '\n' > $TMPDIR/perf.script
> -
> -		# Example of branch entries:
> -		#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
> -		# Source addresses come first and target address can be either
> -		# userspace or kernel even with k option, as long as the source
> -		# is in kernel.
> -
> -		#Look for source addresses with top bit set
> -		if ! grep -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> -			echo "ERROR: Kernel branches missing"
> -			err=1
> -		fi
> -		# Look for no source addresses without top bit set
> -		if grep -E -m1 "^0x[0-7][0-9a-f]{0,15}" $TMPDIR/perf.script; then
> -			echo "ERROR: User branches found with kernel filter"
> -			err=1
> -		fi
> +		echo "Testing kernel branch sampling [Failed]"
>   	fi
>   }
>   
> @@ -136,14 +159,15 @@ test_filter() {
>   	test_filter_expect=$2
>   
>   	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
> -	perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_filter,save_type,u" -- ${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
> +	perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_filter,save_type,u" -- \
> +		${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
>   	perf script -i "$TMPDIR/perf.data" --fields brstack > "$TMPDIR/perf.script"
>   
>   	# fail if we find any branch type that doesn't match any of the expected ones
>   	# also consider UNKNOWN branch types (-)
>   	if [ ! -s "$TMPDIR/perf.script" ]
>   	then
> -		echo "Empty script output"
> +		echo "Testing branch stack filtering [Failed empty script output]"
>   		err=1
>   		return
>   	fi
> @@ -154,26 +178,36 @@ test_filter() {
>   	  > "$TMPDIR/perf.script-filtered" || true
>   	if [ -s "$TMPDIR/perf.script-filtered" ]
>   	then
> -		echo "Unexpected branch filter in script output"
> +		echo "Testing branch stack filtering [Failed unexpected branch filter]"
>   		cat "$TMPDIR/perf.script"
>   		err=1
>   		return
>   	fi
> +	echo "Testing branch stack filtering [Passed]"
>   }
>   
>   test_syscall() {
>   	echo "Testing syscalls"
>   	# skip if perf doesn't have enough privileges
> -	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
> -		echo "skip: not enough privileges"
> +	if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/record.txt" 2>&1; then
> +		echo "Testing syscalls [Skipped: not enough privileges]"
> +		return
> +	fi
> +	start_err=$err
> +	err=0
> +	perf record -o $TMPDIR/perf.data --branch-filter \
> +		any_call,save_type,u,k -c 10007 -- \
> +		perf bench syscall basic --loop 8000  > "$TMPDIR/record.txt" 2>&1
> +	perf script -i $TMPDIR/perf.data --fields brstacksym | \
> +		tr ' ' '\n' > $TMPDIR/perf.script
> +
> +	check_branches "getppid[^ ]*/SYSCALL/"
> +
> +	if [ $err -eq 0 ]; then
> +		echo "Testing syscalls [Passed]"
> +		err=$start_err
>   	else
> -		perf record -o $TMPDIR/perf.data --branch-filter \
> -			any_call,save_type,u,k -c 10000 -- \
> -			perf bench syscall basic --loop 1000
> -		perf script -i $TMPDIR/perf.data --fields brstacksym | \
> -			tr ' ' '\n' > $TMPDIR/perf.script
> -
> -		check_branches "getppid[^ ]*/SYSCALL/"
> +		echo "Testing syscalls [Failed]"
>   	fi
>   }
>   set -e

