Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10543368D4A
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169102; cv=none; b=cYERhPud+glDMQ5zSavGQZVeMf1wryGC+0KHa96e0uCuEk0iomDwrQ92xggMc6A9zmpNVOHZq3XIRJwJlaBwzdXzNaacb2gMkrJFOatBX5PiSwE/gVhCwjIA9OQsxAopl6cAvONvbXsFE0ytrRL4xCA1gOCt9tpa7q3aOkp/wQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169102; c=relaxed/simple;
	bh=CEZxLgC/u6Or746I2VQL7d48IHnhlAScXkAvqVqjI2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdVGXVfEUTvU4Op+0BqYH3xRkWvhs5611Rti0HVPalnEsEKnJ181u7XWZuqQjZyajvEiy5ED4afAgtM2IsECY/ADHK3k3nqkO7M3tYDzFeQedlF+SE3bWDSjt7EynsfQK/qV2GxFG/xS/fLOIBR4qBEX9TLne2Xoq+8ZqpKSyPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qPTjjZcG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPTjjZcG"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bec405a6ea5so1104756966b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781169099; x=1781773899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TemVgYrN3v0a2/ATuSaJzKVDM6WJr0lztDtX3dOOHeo=;
        b=qPTjjZcGgXaAz6UJ5ROSbehJMXcSxseuRRilz9B5Lq7oK0rw3BtJtDkL4Fem3huWAt
         yjtJMI4ixE8TeTw7LuRf6djFU01sVCC/gy5AT4mNGjtI4j3JRaGVOxOQ5d3j7Y9xOZYx
         YSiYHeCXPrD4QjAlvj3LBuix+s0MIhtt1oqyFD+PVYRmPY+yGt2ssW7Wsyuy1kVm3TRa
         hj1zz5KYefBKdqew7H3+OtttM2D5SWvPCg44rI/KBl9oJ72T8yTQKZSpFPHr7cF9OKh+
         iM94NK43VLTDmWluNN5BMv9T5Npv5zk1m1ETJroQzm5QM9LUGz7zRHZXNQx3pzgkH5bt
         f6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781169099; x=1781773899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TemVgYrN3v0a2/ATuSaJzKVDM6WJr0lztDtX3dOOHeo=;
        b=coSgVpsrNRVGZ4YdJu9Ddt4oQ2qaeNMnS4DlyGsKI9JCp3caawaXgN8QrZGImdt/5h
         r3Z5ty5DL9exHe2TZGmAJ4WhKnpRcmKxl+M4/gEPU+Vsx/Ld+8YQLTUX5m9ljpL+PAw4
         gPpQ57Xw/CjM0c+gYcdhey3VnUyt7HDfwTouWxjYcaKXAHitbAUqZ4Ke+V3FqeYPA+Di
         8eWG6Nw47X/mmZSBLHJyLisghy8yCyalJhH3uR6A8CqzRp/IQEpk5CWKRd6Kj/HealAB
         IHEKc+ozxBGkAn/G41nj3OIVIEieGykQWGSREms24TGIBygndvbyejd1AbctxGB7qd6g
         mjTg==
X-Forwarded-Encrypted: i=1; AFNElJ8mW9aqkCjc18+D+gxAr+QveJsuVuwvszT2ozbCIijOGD/bGXTkMtLcGrMj+GININdOYCr2GAQ/R7WKaDQVnzxT@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwDiO1Icsrm8eaSiDilX/U+CagA9n5m/3TC9RwMREsG4S9G6P
	HULAaiG9/919OIHWvFDLeObVaCGVkPLyWhL1hQyJ1iKYZj6HrN/idpS6EzPD68qCYy0=
X-Gm-Gg: Acq92OEa9TCZSQ/ZtKih+5Quqm6Gdz62pKhLVEWBmKScFzJ+Uxd8ntMpRoCbAsqdCUq
	Dtj6k0Gofq1H3KU0a4A8EJ/DekrcdiQT4zVO/7Xg5tIzowCAlG8nMnaPqiKxsGHwAeFMqjikskP
	VaAWFhHv0Gqxq+7d3+Od2rC0i75t0pY0bBb2DjrCQheEKaXF8NyQj/G0MZTm1qf+TX88eg6e4z3
	019TZqZAmFgng8FTP1tJXiP0W6SpAjzmGmC4EdvUDgIXERlzWZ24ziAbxlZ839sBeBjsV06zvGv
	btlsj2vpPPv9wEZGGBKj0d0EErPnbU5c6wD2jjq1Bb8pYtndw3UlxRy/r5dbhPv+dSkaYL2S00K
	r8uREUtbnlKp6BoY32kDx6QcZRwHzchgRn3yGTb5BTodok4LvXZqBMEmge9NG/IN6vNAwFDldxW
	VInYh9BVp6BZHrf1x8VRZaG2HbEV4aIYap1/vZ2DA=
X-Received: by 2002:a17:907:2d24:b0:be2:7f13:8e33 with SMTP id a640c23a62f3a-bfc87ef676fmr89235566b.45.1781169099271;
        Thu, 11 Jun 2026 02:11:39 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb53c3461sm36589966b.41.2026.06.11.02.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 02:11:38 -0700 (PDT)
Message-ID: <c6f6766b-ef3f-4260-9569-620d351027ff@linaro.org>
Date: Thu, 11 Jun 2026 10:11:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] perf test: Add Arm CoreSight callchain test
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
References: <20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com>
 <20260611-b4-arm_cs_callchain_support_v1-v7-8-1ba770c862ae@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-8-1ba770c862ae@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2026 8:57 am, Leo Yan wrote:
> Add a CoreSight shell test for synthesized callchains.
> 
> The test uses the new callchain workload to generate trace and decodes
> it with synthesis callchain. It then verifies that the instruction
> samples show the expected callchain push and pop.
> 
> Use control FIFOs so tracing starts only around the workload, which
> keeps the trace data small. The test is limited to arm64 systems with
> the cs_etm event available.
> 
> After:
> 
>    perf test 136 -vvv
>    136: CoreSight synthesized callchain:
>    --- start ---
>    test child forked, pid 3539
>    ---- end(0) ----
>    136: CoreSight synthesized callchain			: Ok
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/Documentation/perf-test.txt        |   6 +-
>   tools/perf/tests/builtin-test.c               |   1 +
>   tools/perf/tests/shell/coresight/callchain.sh | 168 ++++++++++++++++++++++++++
>   tools/perf/tests/tests.h                      |   1 +
>   tools/perf/tests/workloads/Build              |   2 +
>   tools/perf/tests/workloads/callchain.c        |  24 ++++

Maybe "syscall" is a better name? There's not any difference between 
this one and others like the deterministic one I added with regards to 
the callchain.

>   6 files changed, 200 insertions(+), 2 deletions(-)
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
> index afc06cec49546d29d86b94840c7021c5bf5c88e3..8994488cc206863ba77f7e7e5803e62f18e151ba 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -166,6 +166,7 @@ static struct test_workload *workloads[] = {
>   	&workload__jitdump,
>   	&workload__context_switch_loop,
>   	&workload__deterministic,
> +	&workload__callchain,
>   
>   #ifdef HAVE_RUST_SUPPORT
>   	&workload__code_with_type,
> diff --git a/tools/perf/tests/shell/coresight/callchain.sh b/tools/perf/tests/shell/coresight/callchain.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..e9f907f60e3a4574f13a9c651d541c675f07a4ad
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/callchain.sh
> @@ -0,0 +1,168 @@
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
> +	[ "$(uname -m)" = "aarch64" ] || {
> +		echo "Skip: arm64 only test" >&2
> +		return 2
> +	}

Minor nit, but for consistency with the other coresight tests we should 
probably not check for arm64 and only check for cs_etm//.

> +
> +	perf list | grep -Pzq 'cs_etm//' || {
> +		echo "Skip: cs_etm event is not available" >&2
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
> +'[[:space:]]+[[:xdigit:]]+ foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'([[:space:]]+[[:xdigit:]]+ .*\n)*'
> +}
> +
> +callchain_regex_2()
> +{
> +	printf '%s' \
> +'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
> +'[[:space:]]+[[:xdigit:]]+ do_syscall\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ callchain\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'([[:space:]]+[[:xdigit:]]+ .*\n)*'
> +}
> +
> +callchain_regex_3()
> +{
> +	printf '%s' \
> +'perf[[:space:]]+[0-9]+[[:space:]]+\[[0-9]+\][[:space:]]+([0-9.]+:[[:space:]]+)?[0-9]+ instructions:[[:space:]]*\n'\
> +'[[:space:]]+[[:xdigit:]]+ syscall(@plt)?\+0x[[:xdigit:]]+ \(.*\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ do_syscall\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
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
> +'[[:space:]]+[[:xdigit:]]+ do_syscall\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
> +'[[:space:]]+[[:xdigit:]]+ foo\+0x[[:xdigit:]]+ \(.*/perf\)\n'\
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
> +	# Conver from offset to line
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

In tests/shell/coresight/callchain.sh line 144:
	l7=$(find_after_line "$(callchain_regex_1)" "$file" "$((l6 + 1))") || 
return 1
         ^-- SC2034 (warning): l7 appears unused. Verify use (or export 
if used externally).



> +	return 0
> +}
> +
> +run_test()
> +{
> +	local data=$tmpdir/perf.data
> +	local script=$tmpdir/perf.script
> +
> +	if ! record_trace "$data" "$script"; then
> +		echo "$name: perf record/script failed"

In tests/shell/coresight/callchain.sh line 155:
		echo "$name: perf record/script failed"
                       ^---^ SC2154 (warning): name is referenced but 
not assigned.


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
> index 75b377934a0e62b9ac1fec245520ea0978ac957e..dfdf9a2720b22f67a3d7b53d0ed14e0654059c8f 100644
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
> @@ -26,3 +27,4 @@ CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>   CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>   CFLAGS_inlineloop.o       = -g -O2
>   CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> diff --git a/tools/perf/tests/workloads/callchain.c b/tools/perf/tests/workloads/callchain.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a7eca77277496eec2f47d6f1a646552c298a533f
> --- /dev/null
> +++ b/tools/perf/tests/workloads/callchain.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include "../tests.h"
> +
> +static void do_syscall(void)
> +{
> +	syscall(SYS_getpid);
> +}
> +
> +static void foo(void)

According to Sashiko on my other review, even with -O0 these symbols can 
be renamed when built with LTO. As you are looking for matches on 
function names, you should probably make them global and with unique 
prefixes and leave a comment. At least I did that wherever I was 
matching on a function name, and only used static for ones that weren't 
matched. Would be a good habit to the pattern gets copy pasted to other 
workloads and tests.

> +{
> +	do_syscall();
> +}
> +
> +static int callchain(int argc __maybe_unused, const char **argv __maybe_unused)
> +{
> +	foo();
> +
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(callchain);
> 

