Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51134283FC4
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063048; cv=none; b=kle7UERaC34SDtZ4IDQgI6RHkTkYJNxNTaaBUhG352SUZXuMYCO0AKwaR9SX2PkAodnV2CMJSlYGQHj/Lo2avFFPh/Oy4CD4g2TaFabbsAzfvDDB3Hj5ZlL8+/2UxNT1TNbWNQvctUxjAqaMguCTM40oryzNpqGvw5LFnYuC1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063048; c=relaxed/simple;
	bh=kpdBVoNDXUGawFhZX7sdwTPfiopLKCZkkb64hq2SvrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fH7PkgZvO37zUjMYKpvC4l+baMShy3zaGt/Y9SXAtDCMDov+Unn4x3mXPwT/VJETY9zgR6hArTlFXEa7ywvuJz1D1qsQUA6hwdRpUHB4K/8MoDFpmc/EE6Hx1B0DZgo2Z9ppLQwWJPlT0sH9QeEwM6EhOd2AajYqlLwMOdgsY3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pGvp4o7n; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGvp4o7n"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so58294575e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787063044; x=1787667844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/o2uYaPaSasZ8MEDQ2eIcDiLGsa5Fqsp2iOXFF4vDM=;
        b=pGvp4o7nM56AEkVhVRcSLDVAR34ywvbZee5yOLEzt+SGt3GclFkw74jZ69CAYBKnv4
         h52chopacgXrT9T7Hj4luXf4Gpw0ozkHsfycrq8kmjh6TfdjcHYXI9pMMa1VxHic4Tnn
         ZJl93j93dLLUF7lGoLVbT9Bqvj8Wa7xk0GcN9osl8Jn0yj9jTImFbEZbszmqwLGuiMsr
         ZOjTkytyDDgJad1OGaekrSMEBWkjYvHAEQV9lAM/o4DZhu1jQ1UqIU0O193zs2IadNIj
         rmIkSblLWcynLniz2ndI7TOtDYVtapT57few11tj9WjoEjnbPWH0cUkKZudOfKkl4MKS
         AnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063044; x=1787667844;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/o2uYaPaSasZ8MEDQ2eIcDiLGsa5Fqsp2iOXFF4vDM=;
        b=DaUiTu1whkt/g1InjJtY8S1OMxd4dcJnfWw3JnT8waTWbT3VhQErDXFMO9D8ZgPRYU
         f9Pt3zTXznl0hCJzW1Fn5Qf/YQ8hlWLUdRn3LvoRtom3mpmb9P3IDghgHcII/ftWlRK3
         B5M78j2qZBlx8v1OASuBT1t9VV/4LM+uIK1bsuAbknsqsF2l/aPRGKitVxS38l5mDB7T
         YoBdJMt7162hx/Z27HGtJYiEHlIIl46v+ufhisUw7QE2XMO6pD+3WWLc5lSgwCVNWSWc
         dqfJIDxX0nebrXCzgheK8otBlq3elljsxvFCPb0MoxA/9IdtHG8hCGNgAl11fkTYre0P
         yGnQ==
X-Forwarded-Encrypted: i=1; AHgh+RolQz51rXzDVj4Tju8YpSqt4lHPU+4ROuDI20NKG2rWZZ5Bm58bDGDivu81NL/L1g9Z0uZhuMaqHBoUzh+kLUf/@vger.kernel.org
X-Gm-Message-State: AOJu0YxseP3lFMI1aA+WTkIVDtMybFLTwusJFjgA/gYTjhvzNCFUekc3
	ZU/GCiQxU1BZLLSSeK8fq8I+sMvcIbKiekzLvn125PlB8cq9ktZ6HPGQzcdJNqAp9ds=
X-Gm-Gg: AR+sD13mDKlWsV42iIsX8cyGS07aKYb4BB2X+90IACSKs8LBgoaOd84chhkOJiqrk7Y
	xGA3jf5T8o115ZuudFHzRL5+djLqAiIqDjb3tXZxXY5HLVqAimqGAGPwtTmn7fcg2fa0NGX7Wwm
	FWcRkmREBL0VrKDpAegslcv5Qf8rr1soLr9dDe3pM6q1wgQHX+BTjnc17rTC/7rW6LLkB10Enwa
	h6hWi7Tw8LVZ3wX7WbBanvrzRiv0nlrep8E9+ozCPFrgSxzvtkwTWojFiZvZoGi4BsZQaPa3NPK
	p9ueBwlWfyXumf5iuPGxTCG1mhh9F88a/stUrd88fjT+a8qgJUkE/dUyTwzbcL+RE93MEEYCIpf
	PuJphDMZqO+EtDBJKT6bFrZXhJUwcm04CIuJkPYvEhHzl4Vk9GG2eW0T+yI0M8Pc+NIJDRLN2V8
	+bV6DLcIKtuCtELJDOf3ytHngvjyZdikzxNziNAyNJxzt5RdM9Ce304wqWKLSqhLz84b9vIxSGb
	EDx
X-Received: by 2002:a05:600c:468c:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-4999fb6d4d8mr126865575e9.11.1787063044086;
        Tue, 18 Aug 2026 07:24:04 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0fb867sm156785215e9.10.2026.08.18.07.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 07:24:03 -0700 (PDT)
Message-ID: <a96a5b96-707f-4a98-bd84-1aa919b9bccb@linaro.org>
Date: Tue, 18 Aug 2026 15:24:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] perf test cs-etm: Test branch history on existing
 samples
To: Amir Ayupov <aaupov@fb.com>
Cc: linux-doc@vger.kernel.org, Mike Leach <mike.leach@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
References: <cover.1787005265.git.aaupov@fb.com>
 <70f7ccb31e81282212161177124dfc3beff24ad9.1787005265.git.aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <70f7ccb31e81282212161177124dfc3beff24ad9.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/08/2026 23:22, Amir Ayupov wrote:
> Add a CoreSight shell test for --itrace=L. Record timestamped ETM trace
> with explicit -T sample timestamps and AUX pause/resume events, then
> check that the pause samples carry both a multi-frame callchain and a
> non-empty branch stack for each of the workload's two processes.
> 
> Decode the same recording with L4 and L64 and reject any branch stack
> deeper than the requested depth.
> 
> The test skips when cs_etm is absent, when not run as root, or when the
> recording turns out to lack virtual timestamps. It exercises the
> timestamp-gated path and the requested-depth bound; it does not attempt
> to verify that the attached history is correlated to the sample.
> 
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>   .../tests/shell/coresight/add_last_branch.sh  | 203 ++++++++++++++++++
>   1 file changed, 203 insertions(+)
>   create mode 100755 tools/perf/tests/shell/coresight/add_last_branch.sh
> 
> diff --git a/tools/perf/tests/shell/coresight/add_last_branch.sh b/tools/perf/tests/shell/coresight/add_last_branch.sh
> new file mode 100755
> index 0000000000000..6f09e720abe80
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/add_last_branch.sh
> @@ -0,0 +1,203 @@
> +#!/bin/bash -e
> +# SPDX-License-Identifier: GPL-2.0
> +# CoreSight branch history on existing samples (exclusive)
> +
> +perf list pmu | grep -q 'cs_etm//' || exit 2
> +
> +if [ "$(id -u)" != 0 ]; then
> +	echo "[Skip] No root permission"
> +	exit 2
> +fi
> +
> +tmpdir=$(mktemp -d /tmp/perf-cs-add-last-branch.XXXXX)
> +
> +cleanup()
> +{
> +	rm -rf "$tmpdir"
> +	trap - EXIT TERM INT
> +}
> +
> +# shellcheck disable=SC2317 # Called through trap.
> +trap_cleanup()
> +{
> +	cleanup
> +	exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +record_data()
> +{
> +	local cf="$tmpdir/ctl"
> +	local af="$tmpdir/ack"
> +
> +	mkfifo "$cf" "$af"
> +
> +	# Pin to one CPU so proc1 and proc2 alternate in one per-CPU trace
> +	# buffer. Start disabled and use the control FIFO to record only the
> +	# workload, not perf test setup and teardown.

This is more of a what comment than a why. I got that we were doing 
that, but the reason I left the comment on V1 was because I couldn't see 
why context switching is related to branch history. Doesn't the test 
still test the same thing if you record a single process without -C?

It's a bit hard to see what behavior the test is exercising. I see it 
also adds call-graph=fp, but it doesn't look for symbol names. How is 
testing for any non zero callchain related to coresight unless we also 
check the coresight branch stack matches it exactly via symbol names? 
Seems like it's just testing some other part of Perf here.

I would expect some references to the named symbols 
"context_switch_loop_proc2" from the workload, but I don't see them. It 
also seems to be very interested in timestamps as per the commit 
message. But how do you know it's not attaching the branch stack from 
proc1 to proc2 because it gets the timestamps wrong?

If it's easier to add a new workload with a deterministic branch history 
written in asm after a deterministic call chain we can do that. Then the 
test can test if a fragment of the branch history appears after an end 
fragment of the callchain.

> +	if perf record -T -o "$tmpdir/data" -C 0 -D -1 \
> +		--control fifo:"$cf","$af" \
> +		-e cs_etm/aux-action=start-paused/u \
> +		-e cycles/aux-action=resume,period=550019/u \
> +		-e cycles/aux-action=pause,period=100003,call-graph=fp/u -- \
> +		taskset --cpu-list 0 perf test --record-ctl fifo:"$cf","$af" \
> +		-w context_switch_loop 10000 \
> +		>/dev/null 2>"$tmpdir/stderr"; then
> +		return 0
> +	fi
> +
> +	echo "Failed to record ETM trace with AUX pause/resume" >&2
> +	cat "$tmpdir/stderr" >&2
> +	return 1
> +}
> +
> +decode()
> +{
> +	local size=$1
> +	local output=$2
> +
> +	if perf script -i "$tmpdir/data" --itrace="L$size" \
> +		-F comm,pid,tid,event,ip,brstack >"$output" \
> +		2>"$tmpdir/stderr"; then
> +		return 0
> +	fi
> +
> +	if grep -q "itrace=L requires virtual timestamped trace" \
> +		"$tmpdir/stderr"; then
> +		echo "[Skip] Virtual CoreSight timestamps are not available"
> +		cleanup
> +		exit 2
> +	fi
> +
> +	cat "$tmpdir/stderr" >&2
> +	return 1
> +}
> +
> +check_process_samples()
> +{
> +	local output=$1
> +	local comm
> +
> +	# Expect each process to have a pause-event sample followed by at least
> +	# one branch entry in 0xFROM/0xTO/... form.

Can we have an exact copy paste of the output instead of the text 
description? I still can't tell if what I'm seeing is expected based on 
this.

For example I get this, which you could paste verbatim into the test:

   proc2 
armv8_pmuv3_0/cycles,aux-action=pause,period=100003,call-graph=fp/u:
	ffff800080021440
	ffff8000813a6a04

(This is output from V1, I couldn't run V2 because of the invalid group 
desc issue)

> +	for comm in proc1 proc2; do
> +		awk -v comm="$comm" '
> +			$1 == comm && /cycles\/aux-action=pause/ {
> +				in_sample = 1
> +				next
> +			}
> +			!NF {
> +				in_sample = 0
> +				next
> +			}
> +			in_sample && /0x[[:xdigit:]]+\/0x[[:xdigit:]]+\// {
> +				found = 1
> +			}
> +			END { exit !found }
> +		' "$output" || {
> +			echo "No pause-event branch stack found for $comm" >&2
> +			grep -A 4 "^$comm .*cycles/aux-action=pause" "$output" \
> +				| head -n 20 >&2 || true
> +			return 1
> +		}
> +	done
> +}
> +
> +check_callchains()
> +{
> +	local output="$tmpdir/script-callchain"
> +	local comm
> +
> +	if ! perf script -i "$tmpdir/data" -F comm,event,ip >"$output" \
> +		2>"$tmpdir/stderr"; then
> +		echo "Failed to dump pause-event callchains" >&2
> +		cat "$tmpdir/stderr" >&2
> +		return 1
> +	fi
> +
> +	# Expect a pause-event header for each process followed by at least two
> +	# indented instruction-pointer frames.

Ditto

> +	for comm in proc1 proc2; do
> +		awk -v comm="$comm" '
> +			$1 == comm && /cycles\/aux-action=pause/ {
> +				in_sample = 1
> +				frames = 0
> +				next
> +			}
> +			!NF {
> +				if (in_sample && frames >= 2)
> +					found = 1
> +				in_sample = 0
> +				next
> +			}
> +			in_sample && /^[[:space:]]+[[:xdigit:]]+([[:space:]]|$)/ {
> +				frames++
> +			}
> +			END {
> +				if (in_sample && frames >= 2)
> +					found = 1
> +				exit !found
> +			}
> +		' "$output" || {
> +			echo "No multi-frame pause-event callchain found for $comm" >&2
> +			grep -A 8 "^$comm .*cycles/aux-action=pause" "$output" \
> +				| head -n 40 >&2 || true
> +			return 1
> +		}
> +	done
> +}
> +
> +check_branch_stacks()
> +{
> +	local output=$1
> +	local max_entries=$2
> +
> +	local ret
> +
> +	if awk -v max="$max_entries" '
> +		/0x[[:xdigit:]]+\/0x[[:xdigit:]]+\// {
> +			entries = 0
> +			for (i = 1; i <= NF; i++)
> +				if ($i ~ /^0x[[:xdigit:]]+\/0x[[:xdigit:]]+\//)
> +					entries++
> +			if (entries)
> +				found = 1
> +			if (entries > max) {
> +				status = 2
> +				exit
> +			}
> +		}
> +		END {
> +			if (status)
> +				exit status
> +			if (!found)
> +				exit 1
> +		}
> +	' "$output"; then
> +		return 0
> +	else
> +		ret=$?
> +	fi
> +
> +	case $ret in
> +	1) echo "No ETM branch stacks found" >&2 ;;
> +	2) echo "Branch stack exceeds requested L$max_entries depth" >&2 ;;
> +	esac
> +	# Expected decoded pause-event lines contain at most L<n> branch entries.
> +	grep 'cycles/aux-action=pause' "$output" | head -n 5 >&2 || true
> +	return 1
> +}
> +
> +record_data
> +check_callchains
> +
> +decode 4 "$tmpdir/script-L4"
> +check_process_samples "$tmpdir/script-L4"
> +check_branch_stacks "$tmpdir/script-L4" 4
> +
> +decode 64 "$tmpdir/script-L64"
> +check_process_samples "$tmpdir/script-L64"
> +check_branch_stacks "$tmpdir/script-L64" 64
> +
> +cleanup
> +exit 0

