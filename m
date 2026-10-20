Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506945;
	b=IF5KBbaBPZjaMdbovNjnW5a47HJzb8rTBYgJJ7gd2R8KLb+ekBFtNvvC75cxkgCciwq5
	 56NThbpzhmzlzg8Xu0MU9V+MMZKm1sq2i/sCy2IvoJrQMyufTd61F+E2nzVGeSl6sj6Ra
	 El7XVgmhMyw4LV/QoUHmGJJiIRRoEsQUeWYZueuM9Cj1mnvJZ4551hd4bgmczWMgFecP6
	 P4yAIgN0cytI7ae3CufOmkgIzID+DO7t+2Wngc15a2AeuLaSLHAdre6sDBOTU4+Nzrl4M
	 abvVFUtmkUAIGjKEtRuirjTqCWcfbSzZs3MLTpzAA3FWr9MReTCC1L7/cNGWwBBZX6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=v4Iip/s7oVuzCnYoFEs3DZuJtsQZW95G7/pZOVyPUeg=;
	b=u3XFuCVaic0LsLJdOYFQVpL1HvrYHxuCs4volzwIRSthBqPZjkbCOWh6ppMNYfdZqwxo
	 Dabte043/M3wFdfxT3xrxglySinXV5Bir8ltcEyS86EiRPQHz7KelphVOxEdac2o4EXf7
	 b3L8l/DVU00X5/bBfSIr3MuC68tpwVA8yvWFffbiERGV9QsRjyWkbn8gQ2nPiW8USfi80
	 E8O0HDdn5INFK9lFuTn8+oD+1FedM00cRxBPetN1LIRilKxXB8g03k7oHM5kj/UHbKtPm
	 XTtnSas8pcdQ6Lq6rDiGb2dVqvcr3TNsX3NvMBljNJuh3j5XIFfUnaeKQY5ZckKzmWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OXj8iiTn;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E8606A31D
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 093E8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OXj8iiTn
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso36554135e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792506943; x=1793111743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4Iip/s7oVuzCnYoFEs3DZuJtsQZW95G7/pZOVyPUeg=;
        b=OXj8iiTnqnXMzCVHBB9sDkli8eLkiC+KnY8ep7iaeOHy86x6fHGQ+mgSz2JVg9F+X4
         xMN/zQRyLclbxu4vDkYH9wiuGY0+nGsh7aqrd7TwdyvX3RI948Me2fVSe5pS+0P4Ntft
         mRA1/WJp5Sx7A15uergYC8n+FW7CmkeRYvgNSkC3O3V6PJzQUuj6pPl9uS7W8zusxrOX
         1AgPlqx9LibIlqAK4eLkp5soCe5pLdPpsi1tsj8uEYRsswah58OqgcrN9BtnChhlGvdb
         x/Z7I2XXWqaBBBKt7R785Tc+F+sEnG0ZuBpp1/GbDdXXpSDAvveC2B42X8Wu7CUjGrDs
         AxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792506943; x=1793111743;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4Iip/s7oVuzCnYoFEs3DZuJtsQZW95G7/pZOVyPUeg=;
        b=0vD6OZEXhzkQsBVU4t7GGNNq9XgNN1n3NrXlLWPAaf/Fe6M4SaBTAk9mqASdU3R44O
         XOePBcxkKUAkBnDvtWPLN5ZAUR1O9G/7dsB99TGT70zXG6H7pYzShWjGmVUelhiDpvmF
         /NjHB7JCEq/2BEd1ZI2iU35ENc34KFA4tieZ09KZiKjEIk5KuYK0qJ6rM/IomTs5fGDK
         ZydHTYFkjCDvvO+NKx/BKgNBHJVI0aSumjr2Fm7DbcuonxWKn4lEgIyro7p1o7+1l0mx
         HeQUzJONeZYnRLVxPdHeyyw0eBB+8YCzTF8fowYzvqDiNhYDc7w7szuQlgc9KlKrnsfJ
         mc4A==
X-Forwarded-Encrypted: i=1; AKwUvByW/9vB/kab1Zz/2iTULx1+91sLjg9MrS4ExWbP2YD++HDSaa9aPJK5O1jcmfr2EaOpOyIQt3RDmlLN9of4P7Zk@vger.kernel.org
X-Gm-Message-State: AFq9FYK1hNpoy+7Lj5Pdikmx3X67p3lQoTj5YCb+j+20DSKaO7Xknag6
	0d9ywW2fvZjjkujnXDxJtbsdIOpMGbM3cqS15Z5mBCXhd/OgFHtZhdthki6bPeXD7do=
X-Gm-Gg: AYBFou3OAJFkQCO5bq0uPfwy++K5dbicag61pNP81z3VNsqLDTQgA1WJoOC8545On4j
	mSIGlpo+57dKcvJJW02HmO8hhjPSH1ydgF+S1GUhAGbA4mX0Ztgka2JsiiaxK7PFe55GV4sZMsU
	57RvQAOlMoPJ8XLe/G/LaYNpVSkDg0zqjXWMEFz7VkX9aU4dTPINKYhXMR+n47L1ODEnklFenIl
	rgA23fptXNMYlFOrT3yXjvGyN2BKoW63cOa4QS9THwPkQkKx4jphC1at+k+HS2rBwCmRRiSdr74
	gFsx2LbS2usyPP7Wia75hahYeJwx1yQL6aXxpmQOatq2GG7A5yP/x12IlaXGRfo1IZ2xZ/g709b
	NS9ZZmQgLugqxF9R/5p2cJ++1P7iWaSJ8Jeh00Kn2MTlzr2m6U28MWqqSi1PXsu3wEKF7litdEy
	cq0Jyv7SLrnf2VpX56DYQY4XeH0PcTLjdbR2r3y+mWBka06Nx08eeMgmpx/5oaNBHO059UxMqQk
	RXZ6QOZMHn5hw==
X-Received: by 2002:a05:600c:8709:b0:4a1:7b05:3a6d with SMTP id 5b1f17b1804b1-4a1d75e6fa6mr206342555e9.8.1792506943206;
        Tue, 20 Oct 2026 07:35:43 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm82506805e9.13.2026.10.20.07.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:35:42 -0700 (PDT)
Message-ID: <0792487e-b6fc-4b9d-8120-83281a15217c@linaro.org>
Date: Tue, 20 Oct 2026 15:35:41 +0100
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] perf test: Add CoreSight AUX sample decoding test
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-24-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-24-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:49, Leo Yan wrote:
> Add a shell test that records the brstack workload with 8 KiB AUX
> samples attached to cycle events. Pin the workload to a CPU with a TRBE
> sink and use per-thread recording with trace timestamps and context IDs
> disabled, exercising decoding with the owning sample's context.
> 
> Check branch stacks and callchains with --itrace=L4, L64, G3 and G3L64.
> Require at least one sample to reach both requested depths, with all
> callchain frames belonging to the workload, and reject samples exceeding
> either limit. Use a callchain depth of three to match the nested calls
> in brstack.
> 
> Compare with AUX decoding enabled and disabled to verify that adding
> history preserves the original PMU samples.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/tests/shell/coresight/aux_sample.sh | 189 +++++++++++++++++++++++++
>   1 file changed, 189 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/coresight/aux_sample.sh b/tools/perf/tests/shell/coresight/aux_sample.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..887ad6a085eacdfd192db3863fbb61dae1aa19b5
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/aux_sample.sh
> @@ -0,0 +1,189 @@
> +#!/bin/bash -e
> +# SPDX-License-Identifier: GPL-2.0
> +# CoreSight AUX samples with callchains and branch stacks (exclusive)
> +
> +export LC_ALL=C
> +
> +skip()
> +{
> +	echo "[Skip] $1"
> +	exit 2
> +}
> +
> +perf list pmu | grep -q 'cs_etm//' || skip "cs_etm is not available"
> +perf check feature -q libopencsd || skip "perf was built without OpenCSD"
> +[ "$(id -u)" = 0 ] || skip "No root permission"
> +command -v taskset >/dev/null || skip "taskset is not available"
> +
> +# AUX sample now supports per CPU sink (e.g., TRBE). Select a usable CPU
> +# and name its sink explicitly to avoid a shared sink.
> +sink=
> +for dev in /sys/bus/coresight/devices/trbe[0-9]*; do
> +	[ -d "$dev" ] || continue
> +	name=${dev##*/}
> +	cpu=${name#trbe}
> +	[ -e "/sys/bus/event_source/devices/cs_etm/cpu$cpu" ] || continue
> +	if taskset -c "$cpu" true 2>/dev/null; then
> +		sink=$name
> +		break
> +	fi
> +done
> +[ -n "$sink" ] || skip "No usable TRBE CPU is available"
> +
> +tmpdir=$(mktemp -d /tmp/perf-cs-aux-sample.XXXXXX)
> +
> +cleanup()
> +{
> +	rm -rf "$tmpdir"
> +}
> +
> +trap cleanup EXIT
> +trap 'exit 1' TERM INT
> +
> +fail()
> +{
> +	echo "$1" >&2
> +	cat "$tmpdir/stderr" >&2
> +	exit 1
> +}
> +
> +cf="$tmpdir/ctl"
> +af="$tmpdir/ack"
> +mkfifo "$cf" "$af"
> +
> +# Disable trace timestamps and context IDs to use the owning sample's context.
> +# Use a per-thread mmap so the explicit sink is only used on the pinned CPU.
> +if ! taskset -c "$cpu" perf record -o "$tmpdir/data" --aux-sample=8192 \
> +	-e "{cs_etm/@$sink,timestamp=0,contextid=0/u,cycles/period=100003/u}" \
> +	--per-thread -D -1 --control fifo:"$cf","$af" -- \

Minor nit, but on "[PATCH 00/14] perf cs-etm: Per-thread mode fixes and 
snapshot wrap support" I just did:

+if ! ls /sys/bus/coresight/devices/trbe* > /dev/null 2>&1; then
+	echo "No TRBE sinks, skipping output validation"
+	exit 0
+fi

I know looking up the actual sink, passing it in and also using 
--per-thread mode is "technically correct", but I think we can assume 
that any normal record command will work on any system with TRBE.

Otherwise, we should re-write all of the tests to only target CPUs with 
known loaded ETM instances instead of hard coding CPU 0 etc.

Other than that LGTM:

Reviewed-by: James Clark <james.clark@linaro.org>

> +	perf test --record-ctl fifo:"$cf","$af" -w brstack 1000000 \
> +	>/dev/null 2>"$tmpdir/stderr"; then
> +	# Kernels without snapshot_aux reject the sampling event at open time.
> +	if grep -Eq 'sys_perf_event_open.*event \(.*cycles.*\): Invalid argument' \
> +		"$tmpdir/stderr"; then
> +		skip "Kernel does not accept CoreSight AUX sampling"
> +	fi
> +	fail "Failed to record CoreSight AUX samples"
> +fi
> +
> +perf evlist -v -i "$tmpdir/data" >"$tmpdir/evlist" 2>"$tmpdir/stderr" ||
> +	fail "Failed to read AUX sample attributes"
> +grep -Eq 'sample_type:.*\|AUX(,|\|).*aux_sample_size: 8192(,|$)' \
> +	"$tmpdir/evlist" || fail "Missing AUX sample attributes"
> +
> +check_history()
> +{
> +	local options=$1
> +	local max_branches=$2
> +	local max_callchains=$3
> +	local output="$tmpdir/script-$options"
> +
> +	perf script -i "$tmpdir/data" --itrace="$options" \
> +		-F comm,pid,tid,cpu,event,ip,sym,brstack >"$output" \
> +		2>"$tmpdir/stderr" || fail "Failed to decode AUX samples with $options"
> +
> +	# Some windows may contain incomplete trace. Require at least one cycle
> +	# sample to reach both requested depths, and reject any that exceed them.
> +	if ! awk -v max_branches="$max_branches" \
> +		-v max_callchains="$max_callchains" '
> +		function check_sample() {
> +			if (in_sample == 0) {
> +				return
> +			}
> +
> +			if (branch_entries > max_branches || callchain_frames > max_callchains) {
> +				depth_exceeded = 1
> +			}
> +
> +			# Both depths must be reached in the same sample, with all
> +			# callchain frames belonging to the brstack workload.
> +			if (branch_entries == max_branches &&
> +			    callchain_frames == max_callchains &&
> +			    workload_frames == max_callchains) {
> +				found_sample = 1
> +			}
> +
> +			branch_entries = 0
> +			callchain_frames = 0
> +			workload_frames = 0
> +			in_sample = 0
> +		}
> +		{
> +			# A blank line marks the end of a sample.
> +			if (NF == 0) {
> +				check_sample()
> +				next
> +			}
> +
> +			# Sample header: comm pid/tid [cpu] event ...
> +			# The event may include a PMU prefix and configuration terms.
> +			if ($4 ~ /(^|\/)cycles([,\/:]|$)/) {
> +				check_sample()
> +				in_sample = 1
> +			}
> +			if (in_sample == 0) {
> +				next
> +			}
> +
> +			# Each branch entry is a field in 0xFROM/0xTO/... form.
> +			for (i = 1; i <= NF; i++) {
> +				if ($i ~ /^0x[[:xdigit:]]+\/0x[[:xdigit:]]+\//) {
> +					branch_entries++
> +				}
> +			}
> +
> +			# Callchain rows start with a hexadecimal IP, then a symbol.
> +			if ($1 ~ /^[[:xdigit:]]+$/) {
> +				callchain_frames++
> +				if ($2 ~ /^brstack(_|$)/) {
> +					workload_frames++
> +				}
> +			}
> +		}
> +		END {
> +			# Account for the last sample even without a trailing blank line.
> +			check_sample()
> +
> +			if (depth_exceeded != 0) {
> +				print "AUX sample history exceeds the requested depth" > "/dev/stderr"
> +				exit 1
> +			}
> +			if (found_sample == 0) {
> +				printf "No sample has %d branches and %d workload callchain frames\n", \
> +					max_branches, max_callchains > "/dev/stderr"
> +				exit 1
> +			}
> +			exit 0
> +		}
> +	' "$output"; then
> +		head -n 80 "$output" >&2
> +		fail "Missing AUX sample history or incorrect depth with $options"
> +	fi
> +}
> +
> +check_sample_identity()
> +{
> +	local fields=comm,pid,tid,cpu,event,ip
> +
> +	# Hiding history must leave exactly the original PMU samples, including
> +	# their PID/TID, CPU and sampled IP, with no synthesized events. Per-thread
> +	# recording does not require sample timestamps.
> +	perf script -i "$tmpdir/data" --no-itrace -F "$fields" \
> +		>"$tmpdir/original" 2>"$tmpdir/stderr" || fail "Failed to read cycle samples"
> +	perf script -i "$tmpdir/data" --itrace=L4 -F "$fields" \
> +		>"$tmpdir/decoded" 2>"$tmpdir/stderr" || fail "Failed to decode cycle samples"
> +	diff -u "$tmpdir/original" "$tmpdir/decoded" ||
> +		fail "AUX decoding changed the original cycle samples"
> +}
> +
> +check_history L4 4 0
> +check_history L64 64 0
> +
> +# brstack -> brstack_bench -> brstack_foo -> brstack_bar provides three
> +# nested calls whose caller frames can be reconstructed from an AUX window.
> +check_history G3 0 3
> +check_history G3L64 64 3
> +
> +check_sample_identity
> +
> +echo "CoreSight AUX sample decoding: PASS"
> 

