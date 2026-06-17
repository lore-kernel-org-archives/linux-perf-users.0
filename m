Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CB37EFF8
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685527; cv=none; b=I/OAKX2PSR/Jg/Nr8B2selMVwqKwIZ5tg8IfXmTsqju5P3A1qmhNZ40EPWea8UEuhIe7Vg7Ln8YaYs6K4IkJ4af7f8kZDe2xGGpKRg0jHw9L9aPZhJADeNa3DfgegtE/1iDldLAzV7AG8k82jJ/x2BDaY7/gSzfhexWIJ5egEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685527; c=relaxed/simple;
	bh=O4iN7aVV/pNI27dsN3kIyLuSzh1Ed06GXj6tzoq0qKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5+KZpJrywQcEBwe1fzHwlCzBFLRSlTAMMxvnanbRewXsdRjbVqhuuGinncqXb2sUOGfU+AyugJBsgLvi/KGhEZsXEiN48DFOjKPLOMeY2ElI2Lp8Nc7nSms8wTlHZjcA+lD+IVY1LnKdO3tyFrgVWiynMyenBafoARiwVyMYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cq3ymy/U; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cq3ymy/U"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so4261270f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781685524; x=1782290324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxQkYPDeG9/K/PqOacJLwmZ2WmaJbUWGTbBP5HUZIyU=;
        b=Cq3ymy/UQcJjDUPZK5b52lj5MOdgaaADUilw6MojTUnUzeXdi6q77zPBMB9/VzwENQ
         UkWm4UphX6XR9Y3rw15wID4tkjQ78Ax3vcQv+BrW+xAVS5gEGjDevaCBM2n37nk7dwG/
         TezzlocHT6hIlMQoUBz2DIiNtxRBVK5lVtCFKqToukQDjBTssM62YrVSoHx4739/dxud
         WmmH3IYzo5ZEMLsJvwBWDjA7A6kiq1r0w1Xhb7I+OCFb6nBhp4tuWG3GclobiMZKxC1i
         OuR0UILOxwzdyzK626HxYo9q4S39cYx6G/ItpuHlGCaj4Aj/quTqYi55pUOkOYCPASOn
         aKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781685524; x=1782290324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxQkYPDeG9/K/PqOacJLwmZ2WmaJbUWGTbBP5HUZIyU=;
        b=HHDmM7eJ6g3IoJ5NXv1AcbBrBRmaaBmLhsDnvZyE6wmKRO25A68dKmONoGSNlPM+nn
         BmAJs6n+FlebjsjxRlrgSoBUoQvd6lwfN5eQY2khCNSIiW6Ql8BYHdPXIgiyFpqjjwmw
         91+JHm/j7TsgAjMTKE0DMtzVnizlS8MJXbyM1oq9rhPOdolxDxVlmbu5RkUfxJrZhREG
         Hwmr3NC8HwoEDJQUtFTyxXgVVlrU/BbK1OhLipbWH+GN3c3kBE22a6oPBsqsgxpHGQ37
         ylIJbLD2WnoqiVJdNwzRVmKOQRxblg4hp27wr83okYmP1DB5kiCGtRADuS2P/fscoQfL
         DuuA==
X-Forwarded-Encrypted: i=1; AFNElJ9o5/9VJtuXSnXXxTkqORvovmd/Ye2xfXpqkg07qpKybePgKLU8uJ4UVvgNGBUEM+S8SN5JbXWxyuSoYyQxQayN@vger.kernel.org
X-Gm-Message-State: AOJu0YypFTz6NbJYycnPFZ3i0KoeQKx7tzCx+/OFJmVTn39pbZXj440N
	0H6Ml+iK/CdVhqm56azogz7Lk6C92e/1LKJHvJGuhM/5vV8LiDTx7UMjJU+s+yVO1po=
X-Gm-Gg: AfdE7cm9C0dfhGuehYrBr0Cyb7pmFeop+qphIXNl46dK9+jVYld/V0TRG5IeaNFpBdJ
	nEfSU8/a47YKCWPoyLCvzy1q4cX8zvWgD2wDghjjyoyibmjNHXvIlUix/whCQOLNqi8Pz9PLOb4
	VV8v/lBw2tSo8K3rJkZDrcCERKVj9Fi7c88FVVufzhns4ubfG2cqL+Y8+g2gAs2Z6TsDVpXXDeZ
	Bdr2cutGNTs5AuNnIfb8OywsCVKr1vQDKg9mps79CGuKCEGuXcZIUugu8361GTx3PRCQufEErST
	q2HqqOT9BCHFVY+H+PpniXjccUz+ID7lUsLrJldGcxYh+Dx/sbqGbq6w4UnQGnL07h5Sj0QKA+m
	LhbXfVHZ0iel8acXFWchpMMUi/ePg4hMaKT4nLiNZBocZvQ897rkuI6Bop3DUDhYnHfwPJLa+/l
	U4dV7bO8w1nhc9UgEV+g==
X-Received: by 2002:a05:6000:4602:b0:460:70d1:c75 with SMTP id ffacd0b85a97d-4623f3e0a31mr4263904f8f.13.1781685523826;
        Wed, 17 Jun 2026 01:38:43 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-462236047c8sm7311876f8f.10.2026.06.17.01.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 01:38:43 -0700 (PDT)
Message-ID: <00183ce3-e387-4ca3-9eb8-67aa6a1221e5@linaro.org>
Date: Wed, 17 Jun 2026 09:38:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 9/9] perf test: Add Arm CoreSight callchain test
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
 <20260616-b4-arm_cs_callchain_support_v1-v9-9-f8fad931c413@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-9-f8fad931c413@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2026 3:51 pm, Leo Yan wrote:
> Add a CoreSight shell test for synthesized callchains.
> 
> The test uses the new callchain workload to generate trace and decodes
> it with synthesis callchain. It then verifies that the instruction
> samples show the expected callchain push and pop.
> 
> Use control FIFOs so tracing starts only around the workload, which
> keeps the trace data small. The test is limited to with the cs_etm
> event available and root permission.
> 
> After:
> 
>    perf test 138 -vvv
>    138: CoreSight synthesized callchain:
>    ---- start ----
>    test child forked, pid 35581
>    Callchain flow matched:
>      l1=4642868 l2=4642880 l3=4642895 l4=4642919 l5=4670494 l6=4670500 l7=4670520
>    ---- end(0) ----
>    138: CoreSight synthesized callchain                                                                           : Ok
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/Documentation/perf-test.txt        |   6 +-
>   tools/perf/tests/builtin-test.c               |   1 +
>   tools/perf/tests/shell/coresight/callchain.sh | 172 ++++++++++++++++++++++++++
>   tools/perf/tests/tests.h                      |   1 +
>   tools/perf/tests/workloads/Build              |   2 +
>   tools/perf/tests/workloads/callchain.c        |  33 +++++
>   6 files changed, 213 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
> index 81c8525f594680d814f80e6f88bcce8d867bb350..859df74e62efc4b1e80da13ae8e053356f68ae54 100644
> --- a/tools/perf/Documentation/perf-test.txt
> +++ b/tools/perf/Documentation/perf-test.txt
> @@ -57,7 +57,8 @@ OPTIONS
>   --workload=::
>   	Run a built-in workload, to list them use '--list-workloads', current
>   	ones include: noploop, thloop, leafloop, sqrtloop, brstack, datasym,
> -	context_switch_loop, deterministic, named_threads and landlock.
> +	context_switch_loop, deterministic, named_threads, landlock and
> +	callchain.
>   
>   	Used with the shell script regression tests.
>   
> @@ -69,7 +70,8 @@ OPTIONS
>   	'named_threads' accepts the number of threads and the number of loops to
>   	do in each thread.
>   
> -	The datasym, landlock and deterministic workloads don't accept any.
> +	The datasym, landlock, deterministic and callchain workloads don't accept
> +	any.
>   
>   --list-workloads::
>   	List the available workloads to use with -w/--workload.
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 7e75f590f225e3284980829707ca8d916c98cada..1d1f38127e05429a27f31beda814f2b5f5a75089 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -168,6 +168,7 @@ static struct test_workload *workloads[] = {
>   	&workload__jitdump,
>   	&workload__context_switch_loop,
>   	&workload__deterministic,
> +	&workload__callchain,
>   
>   #ifdef HAVE_RUST_SUPPORT
>   	&workload__code_with_type,
> diff --git a/tools/perf/tests/shell/coresight/callchain.sh b/tools/perf/tests/shell/coresight/callchain.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..13cca7dc11184002e3ddc058c0d0ffa1c458c483
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/callchain.sh
> @@ -0,0 +1,172 @@
> +#!/bin/bash
> +# CoreSight synthesized callchain (exclusive)
> +# SPDX-License-Identifier: GPL-2.0
> +
> +glb_err=1
> +
> +if ! tmpdir=$(mktemp -d /tmp/perf-cs-callchain-test.XXXXXX); then
> +	echo "mktemp failed"
> +	exit 1
> +fi
> +
> +cleanup_files()
> +{
> +	rm -rf "$tmpdir"
> +}
> +
> +trap cleanup_files EXIT
> +trap 'cleanup_files; exit $glb_err' TERM INT
> +
> +skip_if_system_is_not_ready()
> +{
> +	perf list | grep -Pzq 'cs_etm//' || {
> +		echo "[Skip] cs_etm event is not available" >&2
> +		return 2
> +	}
> +
> +	# Requires root for trace in kernel
> +	[ "$(id -u)" = 0 ] || {
> +		echo "[Skip] No root permission" >&2
> +		return 2
> +	}
> +
> +	return 0
> +}
> +
> +record_trace()
> +{
> +	local data=$1
> +	local script=$2
> +
> +	local cf="$tmpdir/ctl"
> +	local af="$tmpdir/ack"
> +
> +	mkfifo "$cf" "$af"
> +
> +	perf record -o "$data" -e cs_etm// --per-thread -D -1 --control fifo:"$cf","$af" -- \
> +		perf test --record-ctl fifo:"$cf","$af" -w callchain >/dev/null 2>&1 &&
> +
> +	# It is safe to use 'i3i' with a three-instruction interval, since the
> +	# workload is compiled with -O0.
> +	perf script --itrace=g16i3il64 -i "$data" > "$script"
> +}
> +
> +callchain_regex_1()
> +{
> +	printf '%s' \
> +'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain_foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'([[:space:]]+[[:xdigit:]]+ .*\n)*'
> +}
> +
> +callchain_regex_2()
> +{
> +	printf '%s' \
> +'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain_do_syscall\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain_foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'([[:space:]]+[[:xdigit:]]+ .*\n)*'
> +}
> +
> +callchain_regex_3()
> +{
> +	printf '%s' \
> +'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
> +'[[:space:]]+[[:xdigit:]]+ syscall(@plt)?\+0x[[:xdigit:]]+ \(.*\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain_do_syscall\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain_foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'([[:space:]]+[[:xdigit:]]+ .*\n)*'
> +}
> +
> +callchain_regex_4()
> +{
> +	printf '%s' \
> +'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
> +'[[:space:]]+[[:xdigit:]]+ .*\+0x[[:xdigit:]]+ \(\[kernel\.kallsyms\]\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ syscall(@plt)?\+0x[[:xdigit:]]+ \(.*\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain_do_syscall\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain_foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'([[:space:]]+[[:xdigit:]]+ .*\n)*'
> +}
> +
> +find_after_line()
> +{
> +	local regex="$1"
> +	local file="$2"
> +	local start="$3"
> +	local offset
> +	local line
> +
> +	# Search in byte offset
> +	offset=$(
> +		tail -n +"$start" "$file" |
> +		grep -Pzob -m1 "$regex" |
> +		tr '\0' '\n' |
> +		sed -n 's/^\([0-9][0-9]*\):.*/\1/p;q'
> +	)
> +
> +	if [ -z "$offset" ]; then
> +		echo "Failed to match regex after line $start" >&2
> +		echo "Regex:" >&2
> +		printf '%s\n' "$regex" >&2
> +		echo "Context from line $start:" >&2
> +		sed -n "${start},$((start + 100))p" "$file" >&2
> +		return 1
> +	fi
> +
> +	# Convert from offset to line
> +	line=$(
> +		tail -n +"$start" "$file" |
> +		head -c "$offset" |
> +		wc -l
> +	)
> +
> +	echo "$((start + line))"
> +}
> +
> +check_callchain_flow()
> +{
> +	local file="$1"
> +	local l1 l2 l3 l4 l5 l6 l7
> +
> +	# Callchain push
> +	l1=$(find_after_line "$(callchain_regex_1)" "$file" 1) || return 1
> +	l2=$(find_after_line "$(callchain_regex_2)" "$file" "$((l1 + 1))") || return 1
> +	l3=$(find_after_line "$(callchain_regex_3)" "$file" "$((l2 + 1))") || return 1
> +	l4=$(find_after_line "$(callchain_regex_4)" "$file" "$((l3 + 1))") || return 1
> +
> +	# Callchain pop
> +	l5=$(find_after_line "$(callchain_regex_3)" "$file" "$((l4 + 1))") || return 1
> +	l6=$(find_after_line "$(callchain_regex_2)" "$file" "$((l5 + 1))") || return 1
> +	l7=$(find_after_line "$(callchain_regex_1)" "$file" "$((l6 + 1))") || return 1
> +
> +	echo "Callchain flow matched:"
> +	echo "  l1=$l1 l2=$l2 l3=$l3 l4=$l4 l5=$l5 l6=$l6 l7=$l7"
> +
> +	return 0
> +}
> +
> +run_test()
> +{
> +	local data=$tmpdir/perf.data
> +	local script=$tmpdir/perf.script
> +
> +	if ! record_trace "$data" "$script"; then
> +		echo "perf record/script failed"
> +		return
> +	fi
> +
> +	check_callchain_flow "$script" || return
> +
> +	glb_err=0
> +}
> +
> +skip_if_system_is_not_ready || exit 2
> +
> +run_test
> +
> +exit $glb_err
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 7cedf05be544ad79a99e86d30dfa4f7b01ca0837..cee9e6b62dcc838c864bbe76efe3b638ed75b134 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -248,6 +248,7 @@ DECLARE_WORKLOAD(inlineloop);
>   DECLARE_WORKLOAD(jitdump);
>   DECLARE_WORKLOAD(context_switch_loop);
>   DECLARE_WORKLOAD(deterministic);
> +DECLARE_WORKLOAD(callchain);
>   
>   #ifdef HAVE_RUST_SUPPORT
>   DECLARE_WORKLOAD(code_with_type);
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index 7bb4b9829ba245740c8967e6bf3235614cdd55a3..048e371eb63e316453b6b46ebd0a02794c3d25d7 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -13,6 +13,7 @@ perf-test-y += inlineloop.o
>   perf-test-y += jitdump.o
>   perf-test-y += context_switch_loop.o
>   perf-test-y += deterministic.o
> +perf-test-y += callchain.o
>   
>   ifeq ($(CONFIG_RUST_SUPPORT),y)
>       perf-test-y += code_with_type.o
> @@ -27,3 +28,4 @@ CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>   CFLAGS_inlineloop.o       = -g -O2
>   CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>   CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> diff --git a/tools/perf/tests/workloads/callchain.c b/tools/perf/tests/workloads/callchain.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..3951423d8115e9efb49af8ba2586001fc6f02761
> --- /dev/null
> +++ b/tools/perf/tests/workloads/callchain.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include "../tests.h"
> +
> +/*
> + * Mark as noinline to establish the call chain, and avoid the static
> + * annotation to prevent LTO from renaming the functions.
> + */
> +noinline void callchain_do_syscall(void);
> +noinline void callchain_foo(void);
> +noinline int callchain(int argc, const char **argv);
> +
> +noinline void callchain_do_syscall(void)
> +{
> +	syscall(SYS_getpid);

I get this error when compiling for x86, but it works on Arm:

tests/workloads/callchain.c:17:10: error: use of undeclared identifier 
'SYS_getpid'; did you mean '__getpgid'?
         syscall(SYS_getpid);
                 ^~~~~~~~~~
                 __getpgid
/usr/include/unistd.h:659:16: note: '__getpgid' declared here
extern __pid_t __getpgid (__pid_t __pid) __THROW;


> +}
> +
> +noinline void callchain_foo(void)
> +{
> +	callchain_do_syscall();
> +}
> +
> +noinline int callchain(int argc __maybe_unused,
> +		       const char **argv __maybe_unused)
> +{
> +	callchain_foo();
> +
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(callchain);
> 

