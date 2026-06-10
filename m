Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2C3C872A
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097979; cv=none; b=IfWg+yDzN/YcYRDJfHlXtUHTQlKeDcQXwD5q5FUpyG123dxXPL73LbI9q3hhJA37gF3S6oFM8pQranJlhwIFahN8FZRQ9XwA4HZkitTbn31CSJJjIw5KM7SW9Ngl0sJxL8/6M+Mt7ABNwSwtFzDAjdr9zDLa6fRnU/f+IrzrPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097979; c=relaxed/simple;
	bh=lGYQSCqMGee7jEJi5kvZVzi+khofwf5NkWWjWys0t9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms770LpBn3mJVnC4HXRhMofbBrgmv4Enrf1DOrCrgf4Ad2vpcJOqcSJr3rl74Olx9e079df5Yl8Hb54gjuSKgunD8b0681RHW0DZToIGate56MKsFmPL4mF/sArXntcG5JQ7+UjV2aTww8HOVaidh97CvqzLJi9wexNgwI+xSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RhiZ0W2s; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhiZ0W2s"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef4223be7so3714846f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781097975; x=1781702775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tM+qOsh+HRmOOLgCZwCh9nOf1i+TfnwgH+Y2ClXHQ2s=;
        b=RhiZ0W2swOmTSaS6ZAa70CzDx5ZJO0JxiwBiamSl0gxnMA1KyGJn4OVCxerO05ax+S
         aEAuBaETz6r3FSHZRLHdqMcxU8v0TGfZX8mgq+xwcfPBuINiyoKjZUfHdy2qBXPx9jum
         cymT5GNs7B5DxXS4igNkoiEMAV6Nc0+BCcKl4QJWtUtidkRink9bLwmX9ETdihwS+b/3
         gRj1xImolzO6iwAn1x2K/zsAelaCz+RBVdjPm/k8JwcRDawrcOG82s0JtubgMoKRVPz6
         oyXQN029JDYTPtv8ZG+CqU+XWxnm9w+iLli2XFz8s5D49I1EpqmvLr8ZSSYJ521UI6cc
         EICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097975; x=1781702775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tM+qOsh+HRmOOLgCZwCh9nOf1i+TfnwgH+Y2ClXHQ2s=;
        b=RtiO1fzr0pmHeNMAWXQtEWuK4q6nYCHosqCkVUyYmok9V0gnpk+6oZyCsDFrhkdwtl
         EH2T697fUBkQoJYHUjRj4meERd3BtsJrpd05ipJImSzCF9CorMiG0tSQ4n/va6Ta2psQ
         wVdbY8AlH3TCuC6beaMzlBlu3idwyosgDQzj8h+P+8jwuMt8fRBBCAYVTh8OTa0b1+2L
         ie4n4dbaImjsfxo08iH58fop4k/5M1GW97hsDHXugh+7FEdVUkieH0gvrLX50yDU9c41
         iOo3y5omMIBaoiOPDYT76t6fbZyCgVa12/08+MaBhievW2UJxOuI7OIEKpJcK4vJjzjU
         hqow==
X-Forwarded-Encrypted: i=1; AFNElJ8mjEgW6CLtXpWowEQVuCmXQyRjMPKd7wrTh9PjDTIzhvjIIEiXOsYD6SeMMT9Q8gJYDDx0pCzV13hHdwLSN/Ng@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPjhDFDj5kwCu3/alZQv5Mpy8ZVKzs9IUznv8oggED41fBc7o
	kwtZmKqWDvxFJJXNSXoi9238Q4JhUATgy6+IZRBjMBcyoaQTk4q32JM5epBCD/yEs74=
X-Gm-Gg: Acq92OFmr0HHaY0WqVRhuYtiVhPZbmc/K3th7eLK2xbOoxvROeCsIM2aH42JqsSW7Py
	CrR/4hjKcR9lE7NokrZERKLgr1oaQogtMLdj0UexGX5kg0uI5RFI+yQK12lDkbPkx106b2BcHkq
	Nl4clNEOYz5Mqnaf5SfOivpjRsysTtF109Knix/926orKE3uYBXptK+9UZg2JCUASB+KCx14pNk
	1IIEmRLcxtHNHgWR0/naSB0y5ITmJ+QPsXcu9oGIOfKkuVDwFteXrs4vyavqDdsDQB3snAjKWxk
	+V/wA6A164fEvstBEH0td3598pI1wB1OCNQjDoekSpqIk2oqxKVQ7cFKIPYaDuKFjIHrKzV7zy5
	Iq3QaDDgJkm/kWrgOZ880j17ZAbqNwApt5cUtD74oApDIZF9tOe3atURttpbtlP43kxPBmB3dmF
	CSInDHSlbDuZYEl31haa/HWTJabFY2uyddZg+q19U=
X-Received: by 2002:a05:6000:2210:b0:45e:fa7b:a7db with SMTP id ffacd0b85a97d-46056680dcdmr9683845f8f.8.1781097974508;
        Wed, 10 Jun 2026 06:26:14 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm71687347f8f.20.2026.06.10.06.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:26:13 -0700 (PDT)
Message-ID: <7e5d283f-2df7-42c0-8997-88d3359cd7a8@linaro.org>
Date: Wed, 10 Jun 2026 14:26:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 5/5] perf test: Add inject ASLR test
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, gmx@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mingo@redhat.com, peterz@infradead.org, acme@kernel.org, namhyung@kernel.org
References: <20260607213700.3563842-1-irogers@google.com>
 <20260608054841.3856224-1-irogers@google.com>
 <20260608054841.3856224-6-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260608054841.3856224-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/06/2026 6:48 am, Ian Rogers wrote:
> Add a new shell test  to verify the feature. The test covers:
> - Basic address remapping for user space samples.
> - Pipe mode coverage for piped into.
> - Callchain address remapping.
> - Consistency of output before and after injection.
> - Pipe mode report consistency.
> - Dropping of samples that leak ASLR info (physical addresses).
> - Kernel address remapping (utilizing a dedicated kernel-intensive VFS
>    dd workload to guarantee continuous timer interrupts sampling flow
>    inside kernel privilege states).
> - Kernel report consistency with address normalization.
> 
> The test suite is hardened with global 'set -o pipefail' assertions
> to catch pipeline failures, stream-consuming awk processors to handle
> SIGPIPE signals, and a dedicated pipe output scenario validating raw
> 'perf inject -o -' stdout streams.
> 
> Note on kernel DSO normalization in the test script:
> The test script deliberately normalizes all kernel DSOs to a generic
> [kernel] tag before diffing, as obfuscating physical kernel addresses
> forces perf report to occasionally shift samples between individual
> modules and [kernel.kallsyms] due to the lack of valid host module
> boundary maps.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.1-pro

Hi Ian,

All the tests pass for me now on x86, and the previous Arm failures are 
fixed. But I still have the slowness issue  on Arm (takes almost an hour 
to complete) and one new test failure.

I narrowed the slowness issue down to check_invariants(). If I compile 
without DEBUG=1 then it's the same speed as x86. Here's the stack where 
it spends all of its time:

   maps__split_kallsyms() at util/symbol.c:1105
   __dso__load_kallsyms() at util/symbol.c:1649
   dso__load_kallsyms() at util/symbol.c:1655
   dso__load_kernel_sym() at util/symbol.c:2244
   dso__load() at util/symbol.c:1840
   map__load() at util/map.c:351
   thread__find_map() at util/event.c:744
   machine__resolve()at util/event.c:818
   process_sample_event() at builtin-script.c:2695
   evlist__deliver_sample() at util/session.c:1807
   machines__deliver_event() at util/session.c:1995
   perf_session__deliver_event() at util/session.c:2226
   ordered_events__deliver_event() at util/session.c:134
   do_flush() at util/ordered-events.c:245
   __ordered_events__flush()at util/ordered-events.c:324
   ordered_events__flush() at util/ordered-events.c:342
   __perf_session__process_events() at util/session.c:3578
   perf_session__process_events() at util/session.c:3745
   __cmd_script() at builtin-script.c:3255
   cmd_script() at builtin-script.c:4603
   run_builtin() at perf.c:348
   handle_internal_command() at perf.c:398
   run_argv() at perf.c:442
   main() at perf.c:549

The other issue is that test_kernel_report_aslr() fails. 
report_kernel1.clean looks like:

       66.72%  dd       [kernel.kallsyms]  [k] chacha_permute
      7.75%  dd       [kernel.kallsyms]  [k] chacha_block_generic
      6.14%  dd       [kernel.kallsyms]  [k] _copy_to_iter
      3.88%  dd       [kernel.kallsyms]  [k] lock_acquire
      2.91%  dd       [kernel.kallsyms]  [k] lock_release
      2.75%  dd       [kernel.kallsyms]  [k] rcu_is_watching
      2.58%  dd       [kernel.kallsyms]  [k] __arch_copy_to_user
      2.26%  dd       [kernel.kallsyms]  [k] __might_resched
      1.94%  dd       [kernel.kallsyms]  [k] get_random_bytes_user
      1.29%  dd       [kernel.kallsyms]  [k] __might_fault
      0.81%  dd       [kernel.kallsyms]  [k] debug_lockdep_rcu_enabled
      0.48%  dd       [kernel.kallsyms]  [k] __might_sleep
      0.16%  dd       [kernel.kallsyms]  [k] kmem_cache_free
      0.16%  dd       [kernel.kallsyms]  [k] seqcount_lockdep_reader_access
      0.16%  dd       [kernel.kallsyms]  [k] set_pte_range

But report_kernel2.clean is maybe 10x longer and doesn't have any symbols:

      8.08%  dd       [unknown]          [k] 0xffff8000108416ec
      2.75%  dd       [unknown]          [k] 0xffff80001084170c
      1.94%  dd       [unknown]          [k] 0xffff800010176360
      1.94%  dd       [unknown]          [k] 0xffff80001084156c
      1.45%  dd       [unknown]          [k] 0xffff8000101be4bc
      ...

I think this could be related to why it gets stuck in 
maps__split_kallsyms() doing check_invariants(). I'm not sure if I can 
do anything to help debug, or if it's working for you on Arm so we can 
compare our setups?

> ---
>   tools/perf/tests/shell/inject_aslr.sh | 525 ++++++++++++++++++++++++++
>   1 file changed, 525 insertions(+)
>   create mode 100755 tools/perf/tests/shell/inject_aslr.sh
> 
> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
> new file mode 100755
> index 000000000000..4af21ed2ce9a
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh
> @@ -0,0 +1,525 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# perf inject --aslr test
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
> +
> +prog="perf test -w noploop"
> +[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
> +err=0
> +kprog="dd if=/dev/urandom of=/dev/null bs=1M count=50"
> +
> +cleanup() {
> +  local exit_code=${1:-$?}
> +  trap - EXIT TERM INT
> +  if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
> +    echo "Test failed! Preserving temp directory: ${temp_dir}"
> +    return
> +  fi
> +  # Check if temp_dir is set and looks sane before removing
> +  if [[ "${temp_dir}" =~ ^/tmp/perf-test-aslr\. ]]; then
> +    rm -rf "${temp_dir}"
> +  fi
> +}
> +
> +trap_cleanup() {
> +  local exit_code=$?
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cleanup ${exit_code}
> +  exit ${exit_code}
> +}
> +trap trap_cleanup EXIT TERM INT
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
> +  local report1="${temp_dir}/report1_basic"
> +  local report2="${temp_dir}/report2_basic"
> +  local report1_clean="${temp_dir}/report1_basic.clean"
> +  local report2_clean="${temp_dir}/report2_basic.clean"
> +  local diff_file="${temp_dir}/diff_basic"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${data2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | \
> +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | \
> +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report2_clean}" || true
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
> +  local report1="${temp_dir}/report1_pipe"
> +  local report2="${temp_dir}/report2_pipe"
> +  local report1_clean="${temp_dir}/report1_pipe.clean"
> +  local report2_clean="${temp_dir}/report2_pipe.clean"
> +  local diff_file="${temp_dir}/diff_pipe"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${data2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | \
> +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | \
> +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report2_clean}" || true
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
> +  local report1="${temp_dir}/report1_pipe_out"
> +  local report2="${temp_dir}/report2_pipe_out"
> +  local report1_clean="${temp_dir}/report1_pipe_out.clean"
> +  local report2_clean="${temp_dir}/report2_pipe_out.clean"
> +  local diff_file="${temp_dir}/diff_pipe_out"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf inject -b --aslr -i "${data}" -o - | perf report -i - --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | \
> +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | \
> +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report2_clean}" || true
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
> +  if ! perf record -e task-clock:k -o "${kdata}" ${kprog} > "${log_file}" 2>&1; then
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
> +  if ! perf record -e task-clock:k -o "${kdata}" ${kprog} > "${log_file}" 2>&1; then
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
> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | \
> +    sort > "${report1_norm}" || true
> +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report2_clean}" | \
> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | \
> +    sort > "${report2_norm}" || true
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
> +test_regs_stripping() {
> +  echo "Test user register stripping"
> +  local rdata="${temp_dir}/perf.data.regs"
> +  local rdata2="${temp_dir}/perf.data.regs.injected"
> +  local rdata_clean="${temp_dir}/perf.data.regs.clean"
> +
> +  if ! perf record -e cycles:u --user-regs -o "${rdata}" ${prog} > /dev/null 2>&1; then
> +    echo "Skipping user registers test as recording failed (unsupported flag/platform)"
> +    return
> +  fi
> +
> +  perf inject -b -i "${rdata}" -o "${rdata_clean}"
> +  perf inject -v -b --aslr -i "${rdata}" -o "${rdata2}"
> +
> +  local report1="${temp_dir}/report_regs1"
> +  local report2="${temp_dir}/report_regs2"
> +  local report1_clean="${temp_dir}/report_regs1.clean"
> +  local report2_clean="${temp_dir}/report_regs2.clean"
> +  local diff_file="${temp_dir}/diff_regs"
> +
> +  perf report -i "${rdata_clean}" --stdio > "${report1}" 2>/dev/null || true
> +  perf report -i "${rdata2}" --stdio > "${report2}" 2>/dev/null || true
> +
> +  grep '%' "${report1}" | grep -v '^#' | \
> +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | \
> +    sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | \
> +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | \
> +    sort > "${report2_clean}" || true
> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
> +
> +  if [ ! -s "${report1_clean}" ]; then
> +    echo "User registers stripping test [Failed - profile trace starved/empty]"
> +    err=1
> +    return
> +  elif [ -s "${diff_file}" ]; then
> +    echo "User registers stripping test [Failed - report parsing differs]"
> +    echo "Showing first 20 lines of diff:"
> +    head -n 20 "${diff_file}"
> +    err=1
> +    return
> +  fi
> +
> +  local script_dump="${temp_dir}/script_regs_dump"
> +  perf script -D -i "${rdata2}" > "${script_dump}" 2>/dev/null || true
> +  if grep -q "user regs:" "${script_dump}"; then
> +    echo "User registers stripping test [Failed - register dumps still present]"
> +    err=1
> +  else
> +    echo "User registers stripping test [Success]"
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
> +test_regs_stripping
> +
> +cleanup ${err}
> +exit $err

