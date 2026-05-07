Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38763F23B7
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169497; cv=none; b=aXzRShhpZ/4GJBV7H1bl8eQxgaz9p5hsZVn5j7rFAtfiv/lHJcCfwWB5rwcWL1qqv1OdAiajS/vnKSvedi/cai88woKzsESpckC0h0VidxTdtl+votwnxSeTxpE1GNGKjJyppopPvwaDG6DA7b+2YVfeC9Q9dPwmMa260UnW+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169497; c=relaxed/simple;
	bh=zi2vqobtkfQnWuEcOzP+zQuDgwfp4pjNA/C4/dPT2ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYuTpsdXaplYJTR3X7CmaR85BVj7Vv0XoyVGMeEXvfM4NzNCJ8E8whu2LnNUKZrS9lZv50qKL2AyDiN2utK+s13dlrb3kEuAE61JIungItfEiPRJLnkawC4suPDCf96GPLf2l28ZTpLRYaCbIXtTmlbFjQXSH7tXizgcywAHzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gayIOu5d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gayIOu5d"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so6733305e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778169493; x=1778774293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDrVYe1x/+M89yDmvSuvz2DjENLcf4jB6Rl6S5vbQ2I=;
        b=gayIOu5drAP9QSQwSsxnNshvgtZzoV8mgNc01yrC8ZImvYWEIO+JfGP61eNZnMtKbM
         PILWWjboHsx2ZibgLVd4ZTv0WGbuj49DbkOnhsWKb26axDAku+UMFfBANK0trUJpMFa4
         6d/tVHhN54Nye6lxQteNy/VBVoBKA9Rjm6x6CfgBFNiHZ2cdizZmPn5qmeahyP8ZoQWM
         8PydrjVTauLAydk+XnQP0hbnXzfA4IxTGm5Amu2wZDkI/mYkE7XLt/1JwIZ8pjO60Z86
         ucs32w8e5ujN5G1ZTS0YNpu+imJsVnm4qdWIFbRbBFoDWTIpJeoLaZditGc27HmjkRDI
         rFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169493; x=1778774293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDrVYe1x/+M89yDmvSuvz2DjENLcf4jB6Rl6S5vbQ2I=;
        b=DNUkeZjf9mXlcZ11DYXcF2OCBvgXhqBrpUFt94UIiqBd+YcbwHK68jf6Vp7I1pdcTZ
         vlKlAMZXWuRihwCWWkKjamLkjetalROXc66N5uVaG9w8R94VTwdSZDq2meJOTQWbZ/cM
         YppAohi4K1QeTpMkNm+KtJvL+grsqgr/eycRcE6d1zUjyM8yAxd2Iwl/hubm1P5oiaqw
         Rp3G74u0mWdWSfaxyiXoC9/mptzkNj5N1LrpshEt9LkJIZTC4cK5GbcWMk1bEprbyVzF
         D/fbO8KrH6n4Qupw3h32WRJQrZ1Xlr5K1avSepOGrgeoaI/A/xn/7RXkCbTscM4pPw0m
         1Zeg==
X-Forwarded-Encrypted: i=1; AFNElJ9/R4/lvooY7EnzWvoASQoGugMXuDyZf3LYl1ryIkPCyKN2yzqXwIDwZbzCc3smNq02yHhckEBv670OUO8mOkMi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr05rGprA5vDW0fUadvHmoUb4qU2YtNHohws5VrA9cM/WdZjNA
	r/FGsco5QxNdADPEaRhTT1Va6jvKYfbTq9xtKo1khOebUuZez2Z0xtxoxJwlQGItbPc=
X-Gm-Gg: AeBDievLrSIjlunURTEipDkh6dQjIH8jfvDNI0YBrk4+w5jLQ8/B/5stKT1tU9hPvss
	TcZyH+DjIuVEsNOco1JCabIUaCV3Ni9KWobfmUyMGxbvZg8dn7Iu1eW+qF2FhxgyDKo86SK7t+q
	W0F3hOaubyt8yHICkCaZrs/e5TosJl7rhfe1Cdb1SKqS/qVAFa/aXco515OBEKVSqaK9d/cQYda
	7AmXhXAAVZEsotnXn4jKvYh1BduHMYY2MQcwrxQUi3JNRZAIwpdnHwbJW7tinNuZ0i37swFoFdR
	yT4xSAayJO8Vnj9p9LB9hZLBAiFF5cQhIQAp3SbfSlHpjihK6s6vVt95q878KYYpWulYRXQoVH/
	eL/Jm3BvOW49Fst7vh/Ti4Da2z5Wl0X7FP3RsO9VgRLNqYshItT2TniVedDw1/Z86G/b4/PB5vq
	xdz5fKQpyhwh1aaxxBSUFrkQZUsPhq
X-Received: by 2002:a05:600c:45c6:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-48e521e6090mr135869765e9.14.1778169492948;
        Thu, 07 May 2026 08:58:12 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538c4ae1sm128666765e9.12.2026.05.07.08.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 08:58:12 -0700 (PDT)
Message-ID: <d0ac5850-91e8-489b-be02-322c7c35fd07@linaro.org>
Date: Thu, 7 May 2026 16:58:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] perf test: Add inject ASLR test
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 acme@kernel.org, gmx@google.com, namhyung@kernel.org
References: <20260504072937.2103453-1-irogers@google.com>
 <20260506004546.3140141-1-irogers@google.com>
 <20260506004546.3140141-6-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260506004546.3140141-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/05/2026 1:45 am, Ian Rogers wrote:
> Add a new shell test `inject_aslr.sh` to verify the `perf inject --aslr`
> feature. The test covers:
> - Basic address remapping for user space samples.
> - Pipe mode coverage for `perf record` piped into `perf inject --aslr`.
> - Callchain address remapping.
> - Consistency of `perf report` output before and after injection.
> - Pipe mode report consistency.
> - Dropping of samples that leak ASLR info (physical addresses).
> - Kernel address remapping (skipping gracefully if permissions restrict
>    recording the kernel map).
> - Kernel report consistency with address normalization.
> 
> The test suite is hardened with global 'set -o pipefail' assertions to catch
> pipeline failures, stream-consuming awk processors to handle SIGPIPE signals,
> and a dedicated pipe output scenario validating raw 'perf inject -o -' stdout
> streams.
> 
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v5: Harden test suite verification pipelines by upgrading report checks to
>      strict sorted line-by-line diff comparisons to accommodate remapped pointer
>      shifts. Append || true fallback operators to grep-v filtering pipelines to
>      prevent the shell test from spuriously aborting under set -o pipefail on
>      empty inputs, ensuring graceful failure checks trigger correctly.
> v4: Reorder set -e/pipefail to prevent temp file leakage in root directory on
>      unprivileged record failures when run as root. Ensure grep report filters
>      have || true suffixes to avoid aborts under pipefail. Add comprehensive
>      pipe stdout injection attributes validation case.
> v3: Harden script with pipefail, SIGPIPE awk pipeline fixes, callchain empty
>      data asserts, baseline sample verification, and grep report abort
>      protections. Reorder set -e/pipefail to prevent stack leaks in mktemp
>      failures.
> v2: Add sum comparison for kernel overhead and 32-bit math corrections. Add
>      awk with gsub for trailing dots and brackets normalizations. Trap EXIT,
>      prevent race conditions and avoid hardcoded perf binary.
> ---
>   tools/perf/tests/shell/inject_aslr.sh | 459 ++++++++++++++++++++++++++
>   1 file changed, 459 insertions(+)
>   create mode 100755 tools/perf/tests/shell/inject_aslr.sh
> 
> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
> new file mode 100755
> index 000000000000..cdc3aa94de63
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh
> @@ -0,0 +1,459 @@
> +#!/bin/bash
> +# perf inject --aslr test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +set -o pipefail
> +
> +shelldir=$(dirname "$0")
> +# shellcheck source=lib/perf_has_symbol.sh
> +. "${shelldir}"/lib/perf_has_symbol.sh
> +
> +sym="noploop"
> +
> +skip_test_missing_symbol ${sym}
> +
> +# Create global temp directory
> +temp_dir=$(mktemp -d /tmp/perf-test-aslr.XXXXXXXXXX)
> +data="${temp_dir}/perf.data"
> +data2="${temp_dir}/perf.data2"
> +
> +prog="perf test -w noploop"
> +[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
> +err=0
> +
> +
> +
> +cleanup() {
> +  # Check if temp_dir is set and looks sane before removing
> +  if [[ "${temp_dir}" =~ ^/tmp/perf-test-aslr\. ]]; then
> +    rm -rf "${temp_dir}"
> +  fi
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +
> +trap cleanup EXIT
> +trap trap_cleanup TERM INT
> +
> +get_noploop_addr() {
> +  local file=$1
> +  perf script -i "$file" | awk '
> +    BEGIN { found=0 }
> +    {
> +      for (i=1; i<=NF; i++) {
> +        if ($i ~ /noploop\+/) {
> +          if (!found) {
> +            print $(i-1)
> +            found=1
> +          }
> +        }
> +      }
> +    }'
> +}
> +
> +test_basic_aslr() {
> +  echo "Test basic ASLR remapping"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.basic.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.basic.XXXXXX")
> +
> +  perf record -e task-clock:u -o "${data}" ${prog}
> +  perf inject -v --aslr -i "${data}" -o "${data2}"
> +
> +  orig_addr=$(get_noploop_addr "${data}")
> +  new_addr=$(get_noploop_addr "${data2}")
> +
> +  echo "Basic ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
> +
> +  if [ -z "$orig_addr" ]; then
> +    echo "Basic ASLR test [Failed - no noploop samples in original file]"
> +    err=1
> +  elif [ -z "$new_addr" ]; then
> +    echo "Basic ASLR test [Failed - could not find remapped address]"
> +    err=1
> +  elif [ "$orig_addr" = "$new_addr" ]; then
> +    echo "Basic ASLR test [Failed - addresses are not remapped]"
> +    err=1
> +  else
> +    echo "Basic ASLR test [Success]"
> +  fi
> +}
> +
> +test_pipe_aslr() {
> +  echo "Test pipe mode ASLR remapping"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.pipe.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.pipe.XXXXXX")
> +
> +  # Use tee to save the original pipe data for comparison
> +  perf record -e task-clock:u -o - ${prog} | tee "${data}" | perf inject --aslr -o "${data2}"
> +
> +  orig_addr=$(get_noploop_addr "${data}")
> +  new_addr=$(get_noploop_addr "${data2}")
> +
> +  echo "Pipe ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
> +
> +  if [ -z "$orig_addr" ]; then
> +    echo "Pipe ASLR test [Failed - no noploop samples in original file]"
> +    err=1
> +  elif [ -z "$new_addr" ]; then
> +    echo "Pipe ASLR test [Failed - could not find remapped address]"
> +    err=1
> +  elif [ "$orig_addr" = "$new_addr" ]; then
> +    echo "Pipe ASLR test [Failed - addresses are not remapped]"
> +    err=1
> +  else
> +    echo "Pipe ASLR test [Success]"
> +  fi
> +}
> +
> +test_callchain_aslr() {
> +  echo "Test Callchain ASLR remapping"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.callchain.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.callchain.XXXXXX")
> +
> +  perf record -g -e task-clock:u -o "${data}" ${prog}
> +  perf inject --aslr -i "${data}" -o "${data2}"
> +
> +  orig_addr=$(get_noploop_addr "${data}")
> +  new_addr=$(get_noploop_addr "${data2}")
> +
> +  echo "Callchain ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
> +
> +  if [ -z "$orig_addr" ]; then
> +    echo "Callchain ASLR test [Failed - no noploop samples in original file]"
> +    err=1
> +  elif [ -z "$new_addr" ]; then
> +    echo "Callchain ASLR test [Failed - could not find remapped address]"

Hi Ian,

This test fails on Arm. I believe it's because on Arm we request the 
link register to be sampled with frame pointer unwinds. Then the aslr 
tool drops all the samples because it sees that user regs were sampled:

   /* TODO: can this be less conservative? */
   pr_debug("Dropping regs user sample as possible ASLR leak\n");
   ret = 0;
   goto out_put;

I think maybe that comment is onto something. Perhaps the user regs can 
be zeroed instead of dropping the sample. Then the frame pointer unwind 
will still work on Arm and the aslr test will pass. We just won't be 
able to use the link register to add the leaf frame caller, but that's 
not a big deal.

James

> +    err=1
> +  elif [ "$orig_addr" = "$new_addr" ]; then
> +    echo "Callchain ASLR test [Failed - addresses are not remapped]"
> +    err=1
> +  else
> +    # Extract callchain addresses (indented lines starting with hex addresses)
> +    orig_callchain=$(perf script -i "${data}" | awk '/^[[:space:]]+[0-9a-f]+/ {print $1}')
> +    new_callchain=$(perf script -i "${data2}" | awk '/^[[:space:]]+[0-9a-f]+/ {print $1}')
> +
> +    if [ -z "$orig_callchain" ]; then
> +      echo "Callchain ASLR test [Failed - no callchain samples in original file]"
> +      err=1
> +    elif [ -z "$new_callchain" ]; then
> +      echo "Callchain ASLR test [Failed - callchain data was dropped]"
> +      err=1
> +    elif [ "$orig_callchain" = "$new_callchain" ]; then
> +      echo "Callchain ASLR test [Failed - callchain addresses were not remapped]"
> +      err=1
> +    else
> +      echo "Callchain ASLR test [Success]"
> +    fi
> +  fi
> +}
> +
> +test_report_aslr() {
> +  echo "Test perf report consistency"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.report.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.report.XXXXXX")
> +  local data_clean
> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> +
> +  perf record -e task-clock:u -o "${data}" ${prog}
> +  # Use -b to inject build-ids and force ordered events processing in both
> +  perf inject -b -i "${data}" -o "${data_clean}"
> +  perf inject -v -b --aslr -i "${data}" -o "${data2}"
> +
> +  local report1="${temp_dir}/report1"
> +  local report2="${temp_dir}/report2"
> +  local report1_clean="${temp_dir}/report1.clean"
> +  local report2_clean="${temp_dir}/report2.clean"
> +  local diff_file="${temp_dir}/diff"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${data2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
> +
> +  if [ ! -s "${report1_clean}" ]; then
> +    echo "Report ASLR test [Failed - no samples captured]"
> +    err=1
> +  elif [ -s "${diff_file}" ]; then
> +    echo "Report ASLR test [Failed - reports differ]"
> +    echo "Showing first 20 lines of diff:"
> +    head -n 20 "${diff_file}"
> +    err=1
> +  else
> +    echo "Report ASLR test [Success]"
> +  fi
> +}
> +
> +test_pipe_report_aslr() {
> +  echo "Test pipe mode perf report consistency"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.pipe_report.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.pipe_report.XXXXXX")
> +  local data_clean
> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> +
> +  # Use tee to save the original pipe data, then process it with inject -b
> +  perf record -e task-clock:u -o - ${prog} | \
> +    tee "${data}" | \
> +    perf inject -b --aslr -o "${data2}"
> +  perf inject -b -i "${data}" -o "${data_clean}"
> +
> +  local report1="${temp_dir}/report1"
> +  local report2="${temp_dir}/report2"
> +  local report1_clean="${temp_dir}/report1.clean"
> +  local report2_clean="${temp_dir}/report2.clean"
> +  local diff_file="${temp_dir}/diff"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${data2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
> +
> +  if [ ! -s "${report1_clean}" ]; then
> +    echo "Pipe Report ASLR test [Failed - no samples captured]"
> +    err=1
> +  elif [ -s "${diff_file}" ]; then
> +    echo "Pipe Report ASLR test [Failed - reports differ]"
> +    echo "Showing first 20 lines of diff:"
> +    head -n 20 "${diff_file}"
> +    err=1
> +  else
> +    echo "Pipe Report ASLR test [Success]"
> +  fi
> +}
> +
> +test_pipe_out_report_aslr() {
> +  echo "Test pipe output mode perf report consistency"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.pipe_out_report.XXXXXX")
> +  local data_clean
> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> +
> +  perf record -e task-clock:u -o "${data}" ${prog}
> +  perf inject -b -i "${data}" -o "${data_clean}"
> +
> +  local report1="${temp_dir}/report1"
> +  local report2="${temp_dir}/report2"
> +  local report1_clean="${temp_dir}/report1.clean"
> +  local report2_clean="${temp_dir}/report2.clean"
> +  local diff_file="${temp_dir}/diff"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf inject -b --aslr -i "${data}" -o - | perf report -i - --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
> +
> +  if [ ! -s "${report1_clean}" ]; then
> +    echo "Pipe Output Report ASLR test [Failed - no samples captured]"
> +    err=1
> +  elif [ -s "${diff_file}" ]; then
> +    echo "Pipe Output Report ASLR test [Failed - reports differ]"
> +    echo "Showing first 20 lines of diff:"
> +    head -n 20 "${diff_file}"
> +    err=1
> +  else
> +    echo "Pipe Output Report ASLR test [Success]"
> +  fi
> +}
> +
> +test_dropped_samples() {
> +  echo "Test dropped samples (phys-data)"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.dropped.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.dropped.XXXXXX")
> +
> +  # Check if --phys-data is supported by recording a short run
> +  if ! perf record -e task-clock:u --phys-data -o "${data}" -- sleep 0.1 > /dev/null 2>&1; then
> +    echo "Skipping dropped samples test as --phys-data is not supported"
> +    return
> +  fi
> +
> +  perf record -e task-clock:u --phys-data -o "${data}" ${prog}
> +  perf inject --aslr -i "${data}" -o "${data2}"
> +
> +  # Verify that the original file actually contained samples!
> +  orig_samples=$(perf script -i "${data}" | wc -l)
> +  if [ "$orig_samples" -eq 0 ]; then
> +    echo "Dropped samples test [Failed - no samples in original file]"
> +    err=1
> +  else
> +    # Verify that samples are dropped.
> +    samples_count=$(perf script -i "${data2}" | wc -l)
> +
> +    if [ "$samples_count" -gt 0 ]; then
> +      echo "Dropped samples test [Failed - samples were not dropped]"
> +      err=1
> +    else
> +      echo "Dropped samples test [Success]"
> +    fi
> +  fi
> +}
> +
> +test_kernel_aslr() {
> +  echo "Test kernel ASLR remapping"
> +  local kdata
> +  kdata=$(mktemp "${temp_dir}/perf.data.kernel.XXXXXX")
> +  local kdata2
> +  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel.XXXXXX")
> +  local log_file
> +  log_file=$(mktemp "${temp_dir}/kernel_record.log.XXXXXX")
> +
> +  # Try to record kernel samples
> +  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
> +    echo "Skipping kernel ASLR test as recording failed (maybe no permissions)"
> +    return
> +  fi
> +
> +  # Check for warning about kernel map restriction
> +  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
> +    echo "Skipping kernel ASLR test as kernel map could not be recorded (permissions restricted)"
> +    return
> +  fi
> +
> +  perf inject -v --aslr -i "${kdata}" -o "${kdata2}"
> +
> +  # Check if kernel addresses are remapped.
> +  # Find the field that ends with :k: (the event name) and take the next field!
> +  orig_addr=$(perf script -i "${kdata}" | awk '
> +    BEGIN { found=0 }
> +    {
> +      for (i=1; i<NF; i++) {
> +        if ($i ~ /:[k]+:?$/) {
> +          if (!found) {
> +            print $(i+1)
> +            found=1
> +          }
> +        }
> +      }
> +    }')
> +  new_addr=$(perf script -i "${kdata2}" | awk '
> +    BEGIN { found=0 }
> +    {
> +      for (i=1; i<NF; i++) {
> +        if ($i ~ /:[k]+:?$/) {
> +          if (!found) {
> +            print $(i+1)
> +            found=1
> +          }
> +        }
> +      }
> +    }')
> +
> +  echo "Kernel ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
> +
> +  if [ -z "$orig_addr" ]; then
> +    echo "Kernel ASLR test [Failed - no kernel samples in original file]"
> +    err=1
> +  elif [ -z "$new_addr" ]; then
> +    echo "Kernel ASLR test [Failed - could not find remapped address]"
> +    err=1
> +  elif [ "$orig_addr" = "$new_addr" ]; then
> +    echo "Kernel ASLR test [Failed - addresses are not remapped]"
> +    err=1
> +  else
> +    echo "Kernel ASLR test [Success]"
> +  fi
> +}
> +
> +test_kernel_report_aslr() {
> +  echo "Test kernel perf report consistency"
> +  local kdata
> +  kdata=$(mktemp "${temp_dir}/perf.data.kernel_report.XXXXXX")
> +  local kdata2
> +  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel_report.XXXXXX")
> +  local data_clean
> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> +  local log_file
> +  log_file=$(mktemp "${temp_dir}/kernel_report_record.log.XXXXXX")
> +
> +  # Try to record kernel samples
> +  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
> +    echo "Skipping kernel report test as recording failed (maybe no permissions)"
> +    return
> +  fi
> +
> +  # Check for warning about kernel map restriction
> +  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
> +    echo "Skipping kernel report test as kernel map could not be recorded (permissions restricted)"
> +    return
> +  fi
> +
> +  # Use -b to inject build-ids and force ordered events processing in both
> +  perf inject -b -i "${kdata}" -o "${data_clean}"
> +  perf inject -v -b --aslr -i "${kdata}" -o "${kdata2}"
> +
> +  local report1="${temp_dir}/report_kernel1"
> +  local report2="${temp_dir}/report_kernel2"
> +  local report1_clean="${temp_dir}/report_kernel1.clean"
> +  local report2_clean="${temp_dir}/report_kernel2.clean"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${kdata2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}" || true
> +
> +  # Normalize kernel DSOs and addresses in clean reports
> +  # This allows kernel modules to be either a module or kernel.kallsyms
> +  local report1_norm="${temp_dir}/report_kernel1.norm"
> +  local report2_norm="${temp_dir}/report_kernel2.norm"
> +  local diff_file="${temp_dir}/diff_kernel"
> +
> +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report1_clean}" | \
> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | sort > "${report1_norm}" || true
> +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report2_clean}" | \
> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | sort > "${report2_norm}" || true
> +
> +  diff -u -w "${report1_norm}" "${report2_norm}" > "${diff_file}" || true
> +
> +  if [ ! -s "${report1_norm}" ]; then
> +    echo "Kernel Report ASLR test [Failed - no samples captured]"
> +    err=1
> +  elif [ -s "${diff_file}" ]; then
> +    echo "Kernel Report ASLR test [Failed - reports differ]"
> +    echo "Showing first 20 lines of diff:"
> +    head -n 20 "${diff_file}"
> +    err=1
> +  else
> +    echo "Kernel Report ASLR test [Success]"
> +  fi
> +}
> +
> +test_basic_aslr
> +test_pipe_aslr
> +test_callchain_aslr
> +test_report_aslr
> +test_pipe_report_aslr
> +test_pipe_out_report_aslr
> +test_dropped_samples
> +test_kernel_aslr
> +test_kernel_report_aslr
> +
> +cleanup
> +exit $err

