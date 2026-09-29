Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BE521200
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684584; cv=none; b=R+rv3kJWs3nFoENOTbqy6xbr1L/dxS+/pGba/Q6A0xUrT9zvruFB8hNAaJU/rcg6IpHlagm+JvGbtqEDolIUhPHoYtWyn9v1qZia8l29AKd3seRLo2S/3ukM/u7nuIBc2/Qh/j+iiUVhNlv9K4M1AHoOkvijtZ4P2x4QXyqC+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684584; c=relaxed/simple;
	bh=WT4gq31nqrP8Fe2y3D59ZEOHqafYjC83nzbUyNfaSfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPDQdagRBIZzNwTThBslaYe9ElBs0PNmIO+4PpZ2cOLyk2elsrgzw28WrAWeTceUIsdf3/4aGXagzstb/iUSeQjJrnPR+pe4fTgkoI9gebVhcD6jBLYbNYruriIEDsph7mNZYO9FxDEzNuOHVzlCL2V/Fpz0sG5IUH5/+HDeuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vtdMnr07; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtdMnr07"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso25789875e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790684578; x=1791289378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAoykZR6asRmW0K7OS4CG9fLxAWwLUV9JiX7VJ+7PxE=;
        b=vtdMnr07bJcUkuZTfu9JC10LPUaKBIRrSsmVxC5kkk1iT5n2m21mc5ZuluCdy+T6E3
         Im4/As1WCA7eQQCfr3T7fPHYOLh5Qcz0Xc3MQLeJyKjs3BwBTMC78DmOo8cu/ytx8aQw
         H2uoLSLmLGGO5qm4svRrQB1yKih2UZ34Qo4MUA/3fatviBBK8SMcn6SyB2TfABkXf9kl
         x5J2MfrCrM5VhZ/QRsJgHI75aaR7zXUJwc2deU7qkkM4GL6OQBncLhVTmmSRiZuAArd7
         3cLND1QlTyK5m2UVy0TLa4s9nlxsBjC4AgCy61jvHd3iKHI0/EclMqmTnfJ1zq3w8HHv
         yxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684578; x=1791289378;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oAoykZR6asRmW0K7OS4CG9fLxAWwLUV9JiX7VJ+7PxE=;
        b=Gd/aiHZTDsJ48kt5UpSdHCRpZ2/mKThVaoBLDBbc04BxQjSq+b8/i+U020Qz0WBdgh
         8X980wbSfadpdoZdfKx7x5qdhnwgpHY5Uit507W/O5A7l4oIHkBo4HqRV3IpvaXfIuEL
         4o21Hbzsr+8hJOxE/3JC2rPBPz/v/qmQMd4Ixzn2qaGWWMspvycz2JintMlpPDZfh2Yk
         QzByo89T5GEQtGqSJa8dt/cF7YgEe6OLMweu+8HAmoNCDsW3Y2uTw1mmznHdWHGyvZoE
         DuLBccVnPh83ohvBbQLiUcJV/sKid3/ObNxRlGmeLQGVqDd+bce3wsbiSiBGTjp+z7GR
         95/A==
X-Forwarded-Encrypted: i=1; AKwUvBwRK0qQ8Api3PmhCxvIPlL8lz3lO2IL43uyMCnTUbbzY1KFLdpAcTeh1vxGJIgKYA5GL01CFo2z3t1S3BwJayb4@vger.kernel.org
X-Gm-Message-State: AFuF++lDxKwRZbhucy7qNcBm/CkQb+vaU1ByqKjjzNuegLmOXp04vtQe
	69HXzGHZCWiez1Dxot2WU1F2jQ4MCNGI9WXVRNs+Ij6pdP7+IWxuRElN7wH0rThz34Y=
X-Gm-Gg: AYBFou3w4fr0kO3cKxBiIePECUumdVivbDURGdIuvc9PSHg/CVRiw5A4ohF3cOvn0gI
	6pZ7ncfZj8uUxt/W6nijmP+SRO35P05yO8+YjkgPGcF7aSPEidtzyBZxRrEijbq3IAedA2lVinq
	N77zWe85Jakst74O/PIHlR6+QSaG4C4RvduObSc/xVdsrOB/zbgS4/uswRyufkveRGC6KHRNyi9
	28Wgkzxhlmri0VJmVudLXqJeeCCr3VoK43a4EU6+On5Ys+kq9HGNPF07fAxf2jGLltowvABMvvr
	3Stq5H/9kSqjXnSuRecJ4lbQzDdseA/kBqqHMJqlqbQm3I3jL920HrHvKkJmwnZAbcrNSE5JNAG
	piyiJVjEmtmrKQZTTkla8SH19jPy5zdKIJyV82SKTlQ2/v8EqsVGl+Dhj9B9B0/Yc8DNrzwEI6o
	V6nShm/qVAGI1mOM7CQgB7BrixRJIXrrDK1DQJTDchn6f+8satM2+frQiOlDpAPBoXNMGofP32U
	ss=
X-Received: by 2002:a05:600c:4ecf:b0:4a0:108:3b54 with SMTP id 5b1f17b1804b1-4a001e8c316mr100957425e9.32.1790684577698;
        Tue, 29 Sep 2026 05:22:57 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013b8f6f5sm5072545e9.10.2026.09.29.05.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 05:22:57 -0700 (PDT)
Message-ID: <d371220f-9ad2-41ca-a2a5-930c46801c31@linaro.org>
Date: Tue, 29 Sep 2026 13:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] perf tests: Check CoreSight IRQ entry and exit
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-11-6ab8c07a5455@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-11-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/09/2026 16:21, Leo Yan wrote:
> Add an AArch64 branch_not_taken_loop workload and a CoreSight shell test
> checking IRQ entry and exit PCs. Use cpu-clock generates timer
> interrupts.
> 
> Retry at different timer frequencies and skip if no complete pair is
> captured.

Maybe we need to look into storing existing recordings somewhere or 
committing small ones into the repo again. This test took 3 minutes to 
run on my N1SDP, which is 3x longer than the entire Coresight suite, and 
then it skipped anyway:

173: CoreSight IRQ entry and exit:
---- start ----
test child forked, pid 6804
Recording timer IRQs at 1000 Hz
No complete exception entry/exit pair
No complete IRQ pair in this recording
Recording timer IRQs at 4000 Hz
No complete exception entry/exit pair
No complete IRQ pair in this recording
Recording timer IRQs at 10000 Hz
No complete exception entry/exit pair
No complete IRQ pair in this recording
[Skip] No complete IRQ pair after three recordings
---- end(-2) ----
173: CoreSight IRQ entry and exit


Really this test is only looking for how a single exception on a single 
branch is decoded, it shouldn't be affected by how it was recorded. Even 
a few bytes of trace would be enough to test it. Or maybe we could add 
some kind of unit test framework that mocks out OpenCSD and allows us to 
script how different packets affect the decoder?

But we have to be careful to not add slow tests because it means they're 
much less likely to be run, or results ignored as it's so hard to 
iterate quickly. Or also in this case, silently skipped if something 
regresses.

> 
> For example, an expected hw int/iret pair is:
> 
>    hw int           5cc928 => ffff800080010c80 insn: 63 04 00 f1
>    ...
>    iret   ffff800080012284 =>           5cc928 insn: e0 03 9f d6
> 
> The entry PC is the architectural resume address, here SUBS X3, X3, #1
> at 0x5cc928. After the IRQ is handled, ERET returns to the same PC to
> continue execution.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/tests/builtin-test.c                    |   1 +
>   tools/perf/tests/shell/coresight/irq_entry_exit.sh |  37 +++++
>   tools/perf/tests/shell/lib/coresight_exception.sh  | 165 +++++++++++++++++++++
>   tools/perf/tests/tests.h                           |   1 +
>   tools/perf/tests/workloads/Build                   |   2 +
>   tools/perf/tests/workloads/branch_not_taken_loop.c |  33 +++++
>   6 files changed, 239 insertions(+)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 6259ed805c5f75799d52ac742b77cf278f98bd9d..8eab221f115e75a3ef90be975d4ed0558ceb2b16 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -171,6 +171,7 @@ static struct test_workload *workloads[] = {
>   	&workload__datasym,
>   	&workload__landlock,
>   	&workload__traploop,
> +	&workload__branch_not_taken_loop,
>   	&workload__inlineloop,
>   	&workload__jitdump,
>   	&workload__context_switch_loop,
> diff --git a/tools/perf/tests/shell/coresight/irq_entry_exit.sh b/tools/perf/tests/shell/coresight/irq_entry_exit.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..f164daa222b0550ceb106aa6a1215740a1432017
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/irq_entry_exit.sh
> @@ -0,0 +1,37 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# CoreSight IRQ entry and exit (exclusive)
> +
> +# shellcheck source=../lib/coresight_exception.sh

No need for these anymore, see 
https://lore.kernel.org/linux-perf-users/20260921-james-perf-shellcheck-source-v1-1-adcfc107c997@linaro.org/

> +. "$(dirname "$0")/../lib/coresight_exception.sh"
> +
> +test_irq_entry_exit()
> +{
> +	# IRQs must return to the interrupted PC. Retry at different timer
> +	# frequencies if trace gaps leave no complete entry/exit pair.
> +	for freq in 1000 4000 10000; do
> +		echo "Recording timer IRQs at $freq Hz"
> +		if ! record_trace_with_cpu_clock "$freq" branch_not_taken_loop; then
> +			cat "$tmpdir/record.log"
> +			echo "Failed to record the IRQ workload"
> +			return 1
> +		fi
> +
> +		decode_trace || return 1
> +
> +		check_exception_pairs "hw int" "iret" 0
> +		result=$?
> +		case $result in
> +		0) return 0 ;;
> +		1) cat "$tmpdir/script.log"; return 1 ;;
> +		2) echo "No complete IRQ pair in this recording" ;;
> +		*) return "$result" ;;
> +		esac
> +	done
> +
> +	echo "[Skip] No complete IRQ pair after three recordings"
> +	return 2
> +}
> +
> +setup_exception_test || exit $?
> +test_irq_entry_exit
> diff --git a/tools/perf/tests/shell/lib/coresight_exception.sh b/tools/perf/tests/shell/lib/coresight_exception.sh
> new file mode 100644
> index 0000000000000000000000000000000000000000..f0133c258625147405ba4641ff7e442437fc66b8
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/coresight_exception.sh
> @@ -0,0 +1,165 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Common helpers for CoreSight exception entry and return tests.
> +
> +cleanup()
> +{
> +	case $? in
> +	0|2) rm -rf "$tmpdir" ;;
> +	*) echo "Test files retained in $tmpdir" ;;
> +	esac
> +}
> +
> +record_trace_with_cpu_clock()
> +{
> +	local clock_opts=()
> +
> +	record_freq=$1
> +	shift
> +
> +	# A zero frequency omits the cpu-clock event.
> +	if [ "$record_freq" -gt 0 ]; then
> +		# Generate timer IRQs without delivering a signal to the workload.
> +		clock_opts=(-e cpu-clock:u -F "$record_freq")
> +	fi
> +
> +	# FIFO control bounds the trace to the workload.
> +	# --kcore supplies the running kernel's instructions for decoding.
> +	taskset -c "$cpu" perf record -B --no-bpf-event --per-thread --kcore \
> +		-e cs_etm/timestamp=0/uk "${clock_opts[@]}" \
> +		-m,4M -D -1 --control fifo:"$tmpdir/ctl","$tmpdir/ack" \
> +		-o "$tmpdir/data" -- \
> +		perf test --record-ctl fifo:"$tmpdir/ctl","$tmpdir/ack" -w "$@" \
> +		> "$tmpdir/record.log" 2>&1

There's a shellcheck warning here:

   (warning): Word is of the form "A"B"C" (B indicated). Did you mean 
"ABC" or "A\"B\"C"?

You can avoid it by passing the whole path as "$cf" and "$af" like the 
other coresight tests.


