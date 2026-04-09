Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D6388398
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723041; cv=none; b=UG7+a/1dSROD4rEPQXN3SQmkc2xwMKIbBQGBkdWVH4OFihK9jinoMWnvzAXBfZJn2rnVIUXwMAX2rQEMuQK0kRutFGJ17AM+Wa2vFkFolTivUVCglv5LyFhzfMhxEdno3PHoNRNAeFNE1ee9rAok1WV1kXAKa+RTyVRQvrQ9aWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723041; c=relaxed/simple;
	bh=hsN+1Dyjtw+h6WDEWMgR6FdOsbGs/rAklDyaDGgXUn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfkhmTWxi+QCgMQRm5ijGzShBvC8XEWFIGk3PFCZUwRICMBmC5qMJRCwbTMHpoBpB8vDlIc1Zwg1ix5luxDTaKW76Nfyj0WQ0MwKqjGoDaXYgEP8T3+622G4S4oSCD4Et6uOC9OIt/tKqZQMsJkRAyOPHWi/JrqJgBUBtWDi5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lpCts/eY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpCts/eY"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso7238875e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775723038; x=1776327838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJBR5DnCB+IoMrJrmV3CyYE8JNDWJ2jRPlxgDiETZOw=;
        b=lpCts/eYsuAt/lU0BMFWi/igmjRYM3rjcJXOKMW1EYm8t85DZrtTrt078LP8vZNq72
         V+e+tHSt1v56a8v11IaI4148v05kh2coXBj2PO4za1bnUAWDVD7xDnRUsYi82bbJfuSY
         CBipXs/favA4PuALonHOvgxErEHDYGj+B1Kj/52nqlgajza9hcjj8y7DwSbLDANf+5zq
         Wun8Tdw59T2iQnCp3ijLeg6Tw/rg6pTQxUR7bQve3wOJLYW4yww5ixV9c/RPW/h9X1Gf
         DAUN1rK2SjIuIeIt5wxo7yORgMTUOLi6782iroVoqh9eiJ7euVeaTPNb6BR1S2z7hw40
         8zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775723038; x=1776327838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJBR5DnCB+IoMrJrmV3CyYE8JNDWJ2jRPlxgDiETZOw=;
        b=fN5SYINCOIOzc/qCfFlmWc4daehXiNfMzM4YyxT/kUEE7joRdANeEa7lnwhprVhySu
         aKcQ60kB7p6uOYMiSk5Uy7KsAYl2yBKtIwdlIwgX1QJGMtSMW3LK8ggFfA9tRr/HAxlO
         VzdzW3lhK30CZ2Gh6Rg4NAG0XLh6jI3/KthbNlwHA7oL/nL9X7No+pjk9W1t2wPPhyHA
         yPQnL/FMn86ZAy21hVfgcYYHB37L1bfnhxL38bmsl39+JL/gF2Dtkogmj814CiLfPf6S
         MH3HYx93EQnyzYgRhOzfKFFF2mZujZYkRrVlXSswHDbfi9oxwxCwc13zj0Yvt8k0b/a6
         BMYA==
X-Forwarded-Encrypted: i=1; AJvYcCWDlF7BXNNPmsIqQdtB/JE8QnVNoKeuCMqlyJaRMRKGe8NWfLTCwJWuU55vPpkdN1l++fPXrJ2rRQ56RKD7sXJD@vger.kernel.org
X-Gm-Message-State: AOJu0YxQK1SqhPU7haBmUzVLLCCfZXfRAq9etjXlg5nuTTK1+Od5/dGb
	8vITD8FYDIf7WOJTDGg9a5tO4EibavEY0vsFXHzkXCF16BohvEEwHVs3clvzo/9nFko=
X-Gm-Gg: AeBDieumJfpn7WgEznaNwekD+pm5fIN2h1itSrHYuLrw46p19tx5/vXxSNGvbeVtMzk
	yBeb+dbh+et+lI5yEFdlClZ78euCf10zXKD3wGgsiUQ0EpPqcZFEoaU8AWyijijdH303tdIPF72
	5BaavxvvLwF1TJYa30so6XHdZRnOq9uf4Mvyp30T88khlqFIIne/grc2vp3Zs9xjtbx8hs3lY1s
	O1X+aymPh5AGDsnGeSChoIG90eXmk/GqQ3lKnNTTzdS9JM+4T70X3/NOZSm12AFewiwS+hGTIN4
	PraePrv9fV2tzkv8foFbj5bhqH/2Geno/cEQW7GJXTA4RV/C9KGz9oM9dU9DC+T3mdPEqPimjuT
	6qHH+EPxYbsabbkQ7g+v+O9ZpuAFbkR/i8UoEtm5wHi7poCxyMgrmAbeV8cezlbNpKHy1gzE9Yt
	dF+bcwKK0k8HDJT3IU9no9i66DKj8mNlnu76qwGXc=
X-Received: by 2002:a05:600c:c0dc:b0:486:fe83:861c with SMTP id 5b1f17b1804b1-488cd54140amr24229935e9.7.1775723037764;
        Thu, 09 Apr 2026 01:23:57 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd1bb778sm56591285e9.7.2026.04.09.01.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:23:57 -0700 (PDT)
Message-ID: <1d6da8c9-c8e2-4edf-adee-7eac2f832c51@linaro.org>
Date: Thu, 9 Apr 2026 09:23:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf test: Fixes for check branch stack sampling
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, german.gomez@arm.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
References: <CAP-5=fUgSTa1+m6PXLm6JSxTcvEbZymwwDKqiV_X+OwcKXga9A@mail.gmail.com>
 <20260409000216.196083-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260409000216.196083-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2026 1:02 am, Ian Rogers wrote:
> When filtering branch stack samples on user events they sample in user
> land but may have come from the kernel. Aarch64 avoids leaking the
> kernel address for kaslr reasons but other platforms, for now,
> don't. Be more permissive in allowing kernel addresses in the source
> of user branch stacks.
> 
> When filtering branch stack samples on kernel events they sample in
> kernel land but may have come from user land. Avoid the target being a
> user address but allow the source to be in user land. Aarch64 may not
> leak the user land addresses (making them 0) but other platforms
> do. As the kernel address sampling implies privelege, just allow this.
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

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
> v4: Address feedback from James Clark.
> v2,v3: Address Sashiko feedback.
> ---
>   tools/perf/tests/shell/test_brstack.sh | 146 ++++++++++++++++---------
>   1 file changed, 96 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index 85233d435be6..eb5837f82e39 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -38,9 +38,13 @@ is_arm64() {
>   	[ "$(uname -m)" = "aarch64" ];
>   }
>   
> +has_kaslr_bug() {
> +	[ "$(uname -m)" != "aarch64" ];
> +}
> +
>   check_branches() {
>   	if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$1"; then
> -		echo "Branches missing $1"
> +		echo "ERROR: Branches missing $1"
>   		err=1
>   	fi
>   }
> @@ -48,6 +52,8 @@ check_branches() {
>   test_user_branches() {
>   	echo "Testing user branch stack sampling"
>   
> +	start_err=$err
> +	err=0
>   	perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
>   	perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR/perf.script"
>   
> @@ -73,59 +79,88 @@ test_user_branches() {
>   	perf script -i "$TMPDIR/perf.data" --fields brstack | \
>   		tr ' ' '\n' > "$TMPDIR/perf.script"
>   
> -	# There should be no kernel addresses with the u option, in either
> -	# source or target addresses.
> -	if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> -		echo "ERROR: Kernel address found in user mode"
> +	# There should be no kernel addresses in the target with the u option.
> +	local regex="0x[89a-f][0-9a-f]{15}"
> +	if has_kaslr_bug; then
> +		# If the system has a kaslr bug that may leak kernel addresses
> +		# in the source of something like an ERET/SYSRET. Make the regex
> +		# more specific and just check the target address is in user
> +		# code.
> +		regex="^0x[0-9a-f]{0,16}/0x[89a-f][0-9a-f]{15}/"
> +	fi
> +	if grep -q -E -m1 "$regex" $TMPDIR/perf.script; then
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
> +	# address that must be in the kernel.
> +
> +	# Look for source addresses with top bit set
> +	if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> +		echo "Testing kernel branch sampling [Failed kernel branches missing]"
> +		err=1
> +	fi
> +	# Look for no target addresses without top bit set
> +	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{1,15}/" $TMPDIR/perf.script; then
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
> @@ -136,14 +171,15 @@ test_filter() {
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
> @@ -154,26 +190,36 @@ test_filter() {
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


