Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE231282C
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237392; cv=none; b=al4pIzQbLqLUhNM5Y4JQ0Zmfq0X/s8s5+NNTe5T56IAFQuWhv/vWIUMXssVxwAlpKlp2W1Mwk1zd9ZzyN4h5OsggvuLqmlE9JuVyfW+FUKya4kAXTOOjhSKyRJ4P5cjrfUWj5Thyi5L7rUkGTPI4ktqd61Jon2l7DkQzBdkVpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237392; c=relaxed/simple;
	bh=ieck+fpTaiO2+SHCLvswO1VqFKYh19uVM3W4pLPLtvk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PEpDeyyjuge0FbY8KCjn9ELLZgj4H7Q6mNJD+kDqcBc9NFHupjjm6qRkwLm7h1jJ7Lr81mkcXf2Kqoe5SclLovkwAkOzI7AZxC9JnZFXyJ2gkDniG6awknpixmWA2rIhfT4iW9yADnlJ607hwQPCSz3PDMEV4UI7KQWbI+lj3IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrJSekG2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrJSekG2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so20696715e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778237388; x=1778842188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DuDhdvfrHPz42prxp/hzDgHH454JXddnKzYux0s9bUc=;
        b=qrJSekG2D4JiZISdOiyH8p1jKBxiK8QvQBGQJBOr5EvUOx9LBnv9v+6BT5taSwfgus
         wPwetKklqvlIufhSQ6PwezSC1/l1A3/EoLlX93dKpUyzY9h+wpbUf+q0d1GtOxkREOfN
         hjg6nzKi+Xuxi1ZvJ32W6Jgp3BnKdie3IZedmB9F/nQjACktY0dvYdNvKAOsgD+TU40i
         zQggl9zuz97h4liIv6R2dM7h5VzkIP7ZbkEQPzqZSRsLN15jFzuXgi3zWUusiPSzcbMC
         RO422ZF+xZ9uyeTBaViMLmrUbm0x1TW9dP49Nzvz7xa61468XP2E8ivac+94RMVHQsaX
         5TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778237388; x=1778842188;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuDhdvfrHPz42prxp/hzDgHH454JXddnKzYux0s9bUc=;
        b=X/VhMaN3qJSWIl8w2lZSwajefll5VTJC2w/zxe8QcwtYVltS9SNT+/nYGnTYxobC97
         qALJX2+NywClq0zcGBpIHlsdwX/PJxEbBzcstE6ZI2x5Jq+ZnFAWDQasDLRc1o8WibEi
         1kuklsFyVfw2n/hO8nu2FFZb52l8n6lhp0uIjYhskpzHVCDf6t9FVmpQm91QBRRDMpP0
         Gzg5HkHUVhxib7eYum8biE+LDYqSh+EsxFD8lC/MhCtvlaUzhDQhufB5lLvjRan+mgMo
         3zRBzQ0csAUgxaE4T0SQlGnBVUgz0B8VHIHc9HEJFAO6xZEbvdHWP9XRaBuMwlRY+n1a
         Ci3w==
X-Forwarded-Encrypted: i=1; AFNElJ8zof/v1m8DZfKQrKuUIu17qStIfRpCjxibxwnTXUut0Rzl8tW6YnIFdg8oJRCaKAciCWO5fUjXGmWM2q2MjYl8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9anBNsns92icmwIzJKyJQmuzBi0wGXCuIn24FIH1BtjFREhFm
	J/PjSHq3JEoqQ1Q9mwNwYdlbrezRjUhXw6G+Ye7YhClUF0nWIcQD0iCF366BCsqXUFA=
X-Gm-Gg: AeBDiet8NpfEJRZ9mBF/pysDQggAhspvh2iYPHReeRDlMBW4c6SJUhA5ltMuo0CNfyg
	pPyGmfvTV5C/7mX+gsTYHiaicUBPlasapVCh5qFSti8Vf/2x+7G5yhOXEyFJLnM++CseQypqaxG
	xs3oQcVAuRlOjbmPnetEcv5QOgv+zzFeImfn0N7ChNUQCCiNCj0ptS6vfqUrVdXfQHpU2H/9rJg
	l5/+2OOBxPKr9UiA4OhcytYJu7pRNbOC3q7SZHJIsIYuoWefqb2ElZHiAjGFO9WvzqJwdpoG7Yy
	JFtVVycq72c9Sk7exSYcQT1XLfBbBchf1+jPH/sic6pA3fX39cNpE9XCR3SFT6umC3geVTwog+3
	Wrd562mepQJjEJMcdCrF1d8K++8q/dvo6HNOu6ry3z0Q5uEsYJ/Ji0v0BmLNYpsnsLBsNQQYMqF
	4//lHweuu9pjpfX8UvHjr5h/FifSDXXLIWqAHlI08=
X-Received: by 2002:a05:600c:871b:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48e51f4652fmr196393395e9.29.1778237387606;
        Fri, 08 May 2026 03:49:47 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68ea1e40sm30461345e9.1.2026.05.08.03.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:49:47 -0700 (PDT)
Message-ID: <3e518ba4-9d6f-49e2-9789-a59bf7e08b7a@linaro.org>
Date: Fri, 8 May 2026 11:49:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] perf test: Add inject ASLR test
From: James Clark <james.clark@linaro.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 acme@kernel.org, gmx@google.com, namhyung@kernel.org
References: <20260504072937.2103453-1-irogers@google.com>
 <20260506004546.3140141-1-irogers@google.com>
 <20260506004546.3140141-6-irogers@google.com>
 <d0ac5850-91e8-489b-be02-322c7c35fd07@linaro.org>
 <CAP-5=fV6XfGSSnCwi1MEcEj5TA5H8SoFRrkP7zU9C17Y9L-Bnw@mail.gmail.com>
 <a7bbad57-95eb-45dd-883c-1acf7f5d3020@linaro.org>
Content-Language: en-US
In-Reply-To: <a7bbad57-95eb-45dd-883c-1acf7f5d3020@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/05/2026 11:42 am, James Clark wrote:
> 
> 
> On 07/05/2026 5:17 pm, Ian Rogers wrote:
>> On Thu, May 7, 2026 at 8:58 AM James Clark <james.clark@linaro.org> 
>> wrote:
>>>
>>>
>>>
>>> On 06/05/2026 1:45 am, Ian Rogers wrote:
>>>> Add a new shell test `inject_aslr.sh` to verify the `perf inject -- 
>>>> aslr`
>>>> feature. The test covers:
>>>> - Basic address remapping for user space samples.
>>>> - Pipe mode coverage for `perf record` piped into `perf inject --aslr`.
>>>> - Callchain address remapping.
>>>> - Consistency of `perf report` output before and after injection.
>>>> - Pipe mode report consistency.
>>>> - Dropping of samples that leak ASLR info (physical addresses).
>>>> - Kernel address remapping (skipping gracefully if permissions restrict
>>>>     recording the kernel map).
>>>> - Kernel report consistency with address normalization.
>>>>
>>>> The test suite is hardened with global 'set -o pipefail' assertions 
>>>> to catch
>>>> pipeline failures, stream-consuming awk processors to handle SIGPIPE 
>>>> signals,
>>>> and a dedicated pipe output scenario validating raw 'perf inject -o 
>>>> -' stdout
>>>> streams.
>>>>
>>>> Assisted-by: Gemini-CLI:Google Gemini 3
>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>> ---
>>>> v5: Harden test suite verification pipelines by upgrading report 
>>>> checks to
>>>>       strict sorted line-by-line diff comparisons to accommodate 
>>>> remapped pointer
>>>>       shifts. Append || true fallback operators to grep-v filtering 
>>>> pipelines to
>>>>       prevent the shell test from spuriously aborting under set -o 
>>>> pipefail on
>>>>       empty inputs, ensuring graceful failure checks trigger correctly.
>>>> v4: Reorder set -e/pipefail to prevent temp file leakage in root 
>>>> directory on
>>>>       unprivileged record failures when run as root. Ensure grep 
>>>> report filters
>>>>       have || true suffixes to avoid aborts under pipefail. Add 
>>>> comprehensive
>>>>       pipe stdout injection attributes validation case.
>>>> v3: Harden script with pipefail, SIGPIPE awk pipeline fixes, 
>>>> callchain empty
>>>>       data asserts, baseline sample verification, and grep report abort
>>>>       protections. Reorder set -e/pipefail to prevent stack leaks in 
>>>> mktemp
>>>>       failures.
>>>> v2: Add sum comparison for kernel overhead and 32-bit math 
>>>> corrections. Add
>>>>       awk with gsub for trailing dots and brackets normalizations. 
>>>> Trap EXIT,
>>>>       prevent race conditions and avoid hardcoded perf binary.
>>>> ---
>>>>    tools/perf/tests/shell/inject_aslr.sh | 459 +++++++++++++++++++++ 
>>>> +++++
>>>>    1 file changed, 459 insertions(+)
>>>>    create mode 100755 tools/perf/tests/shell/inject_aslr.sh
>>>>
>>>> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/ 
>>>> tests/shell/inject_aslr.sh
>>>> new file mode 100755
>>>> index 000000000000..cdc3aa94de63
>>>> --- /dev/null
>>>> +++ b/tools/perf/tests/shell/inject_aslr.sh
>>>> @@ -0,0 +1,459 @@
>>>> +#!/bin/bash
>>>> +# perf inject --aslr test
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +set -e
>>>> +set -o pipefail
>>>> +
>>>> +shelldir=$(dirname "$0")
>>>> +# shellcheck source=lib/perf_has_symbol.sh
>>>> +. "${shelldir}"/lib/perf_has_symbol.sh
>>>> +
>>>> +sym="noploop"
>>>> +
>>>> +skip_test_missing_symbol ${sym}
>>>> +
>>>> +# Create global temp directory
>>>> +temp_dir=$(mktemp -d /tmp/perf-test-aslr.XXXXXXXXXX)
>>>> +data="${temp_dir}/perf.data"
>>>> +data2="${temp_dir}/perf.data2"
>>>> +
>>>> +prog="perf test -w noploop"
>>>> +[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
>>>> +err=0
>>>> +
>>>> +
>>>> +
>>>> +cleanup() {
>>>> +  # Check if temp_dir is set and looks sane before removing
>>>> +  if [[ "${temp_dir}" =~ ^/tmp/perf-test-aslr\. ]]; then
>>>> +    rm -rf "${temp_dir}"
>>>> +  fi
>>>> +}
>>>> +
>>>> +trap_cleanup() {
>>>> +  cleanup
>>>> +  exit 1
>>>> +}
>>>> +
>>>> +trap cleanup EXIT
>>>> +trap trap_cleanup TERM INT
>>>> +
>>>> +get_noploop_addr() {
>>>> +  local file=$1
>>>> +  perf script -i "$file" | awk '
>>>> +    BEGIN { found=0 }
>>>> +    {
>>>> +      for (i=1; i<=NF; i++) {
>>>> +        if ($i ~ /noploop\+/) {
>>>> +          if (!found) {
>>>> +            print $(i-1)
>>>> +            found=1
>>>> +          }
>>>> +        }
>>>> +      }
>>>> +    }'
>>>> +}
>>>> +
>>>> +test_basic_aslr() {
>>>> +  echo "Test basic ASLR remapping"
>>>> +  local data
>>>> +  data=$(mktemp "${temp_dir}/perf.data.basic.XXXXXX")
>>>> +  local data2
>>>> +  data2=$(mktemp "${temp_dir}/perf.data2.basic.XXXXXX")
>>>> +
>>>> +  perf record -e task-clock:u -o "${data}" ${prog}
>>>> +  perf inject -v --aslr -i "${data}" -o "${data2}"
>>>> +
>>>> +  orig_addr=$(get_noploop_addr "${data}")
>>>> +  new_addr=$(get_noploop_addr "${data2}")
>>>> +
>>>> +  echo "Basic ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
>>>> +
>>>> +  if [ -z "$orig_addr" ]; then
>>>> +    echo "Basic ASLR test [Failed - no noploop samples in original 
>>>> file]"
>>>> +    err=1
>>>> +  elif [ -z "$new_addr" ]; then
>>>> +    echo "Basic ASLR test [Failed - could not find remapped address]"
>>>> +    err=1
>>>> +  elif [ "$orig_addr" = "$new_addr" ]; then
>>>> +    echo "Basic ASLR test [Failed - addresses are not remapped]"
>>>> +    err=1
>>>> +  else
>>>> +    echo "Basic ASLR test [Success]"
>>>> +  fi
>>>> +}
>>>> +
>>>> +test_pipe_aslr() {
>>>> +  echo "Test pipe mode ASLR remapping"
>>>> +  local data
>>>> +  data=$(mktemp "${temp_dir}/perf.data.pipe.XXXXXX")
>>>> +  local data2
>>>> +  data2=$(mktemp "${temp_dir}/perf.data2.pipe.XXXXXX")
>>>> +
>>>> +  # Use tee to save the original pipe data for comparison
>>>> +  perf record -e task-clock:u -o - ${prog} | tee "${data}" | perf 
>>>> inject --aslr -o "${data2}"
>>>> +
>>>> +  orig_addr=$(get_noploop_addr "${data}")
>>>> +  new_addr=$(get_noploop_addr "${data2}")
>>>> +
>>>> +  echo "Pipe ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
>>>> +
>>>> +  if [ -z "$orig_addr" ]; then
>>>> +    echo "Pipe ASLR test [Failed - no noploop samples in original 
>>>> file]"
>>>> +    err=1
>>>> +  elif [ -z "$new_addr" ]; then
>>>> +    echo "Pipe ASLR test [Failed - could not find remapped address]"
>>>> +    err=1
>>>> +  elif [ "$orig_addr" = "$new_addr" ]; then
>>>> +    echo "Pipe ASLR test [Failed - addresses are not remapped]"
>>>> +    err=1
>>>> +  else
>>>> +    echo "Pipe ASLR test [Success]"
>>>> +  fi
>>>> +}
>>>> +
>>>> +test_callchain_aslr() {
>>>> +  echo "Test Callchain ASLR remapping"
>>>> +  local data
>>>> +  data=$(mktemp "${temp_dir}/perf.data.callchain.XXXXXX")
>>>> +  local data2
>>>> +  data2=$(mktemp "${temp_dir}/perf.data2.callchain.XXXXXX")
>>>> +
>>>> +  perf record -g -e task-clock:u -o "${data}" ${prog}
>>>> +  perf inject --aslr -i "${data}" -o "${data2}"
>>>> +
>>>> +  orig_addr=$(get_noploop_addr "${data}")
>>>> +  new_addr=$(get_noploop_addr "${data2}")
>>>> +
>>>> +  echo "Callchain ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
>>>> +
>>>> +  if [ -z "$orig_addr" ]; then
>>>> +    echo "Callchain ASLR test [Failed - no noploop samples in 
>>>> original file]"
>>>> +    err=1
>>>> +  elif [ -z "$new_addr" ]; then
>>>> +    echo "Callchain ASLR test [Failed - could not find remapped 
>>>> address]"
>>>
>>> Hi Ian,
>>>
>>> This test fails on Arm. I believe it's because on Arm we request the
>>> link register to be sampled with frame pointer unwinds. Then the aslr
>>> tool drops all the samples because it sees that user regs were sampled:
>>>
>>>     /* TODO: can this be less conservative? */
>>>     pr_debug("Dropping regs user sample as possible ASLR leak\n");
>>>     ret = 0;
>>>     goto out_put;
>>>
>>> I think maybe that comment is onto something. Perhaps the user regs can
>>> be zeroed instead of dropping the sample. Then the frame pointer unwind
>>> will still work on Arm and the aslr test will pass. We just won't be
>>> able to use the link register to add the leaf frame caller, but that's
>>> not a big deal.
>>
>> Thanks James. I'm working on a new version of the patches, but I'm
>> having delays getting the AI to approve the changes.
>>
>> ARM does what? Ah, I knew this and also it didn't really register. I'm
>> wondering now if we can put the machinery behind "EM_HOST ==
>> EM_AARCH64":
>> https://lore.kernel.org/all/20211217154521.80603-2-german.gomez@arm.com/
>> as it seems a mechanism that would benefit other architectures such as
>> ARM32 :-) And I have my mission to make tools/perf/arch disappear as
>> much as is humanly possible.
> 
> Yeah that makes sense, the change you sent looks good.
> 
>> I also imagine the problem the link register solves for perf happens
>> for BPF, so perhaps this ability shouldn't be encouraged.
> 
> Not sure what you mean by this, do you mean adding the link register 
> shoudln't be encouraged, or the compiler dropping the stack frame? Or 
> just the weak function style?
> 
>>
>> I think rather than zeroing the register values it would be better to
>> just remove them from the output events. I'll try to add that support
>> as having this test break on ARM isn't desirable.
>>
> 
> Makes sense too. I suppose data being there but zeroed could be slightly 
> more confusing than just dropping the sample.
> 
> I don't know if modifying the sample type to remove 
> PERF_SAMPLE_REGS_USER and emitting the rest could be an option? It might 
> be more robust to cases when things are auto added to the sample by 
> Perf. For example all the aux stuff has custom setup functions that add 
> who knows what options to the events.

Nevermind, I see this is what is done on V6

> 
> 
>> Thanks,
>> Ian
>>
>>> James
>>>
>>>> +    err=1
>>>> +  elif [ "$orig_addr" = "$new_addr" ]; then
>>>> +    echo "Callchain ASLR test [Failed - addresses are not remapped]"
>>>> +    err=1
>>>> +  else
>>>> +    # Extract callchain addresses (indented lines starting with hex 
>>>> addresses)
>>>> +    orig_callchain=$(perf script -i "${data}" | awk '/ 
>>>> ^[[:space:]]+[0-9a-f]+/ {print $1}')
>>>> +    new_callchain=$(perf script -i "${data2}" | awk '/ 
>>>> ^[[:space:]]+[0-9a-f]+/ {print $1}')
>>>> +
>>>> +    if [ -z "$orig_callchain" ]; then
>>>> +      echo "Callchain ASLR test [Failed - no callchain samples in 
>>>> original file]"
>>>> +      err=1
>>>> +    elif [ -z "$new_callchain" ]; then
>>>> +      echo "Callchain ASLR test [Failed - callchain data was dropped]"
>>>> +      err=1
>>>> +    elif [ "$orig_callchain" = "$new_callchain" ]; then
>>>> +      echo "Callchain ASLR test [Failed - callchain addresses were 
>>>> not remapped]"
>>>> +      err=1
>>>> +    else
>>>> +      echo "Callchain ASLR test [Success]"
>>>> +    fi
>>>> +  fi
>>>> +}
>>>> +
>>>> +test_report_aslr() {
>>>> +  echo "Test perf report consistency"
>>>> +  local data
>>>> +  data=$(mktemp "${temp_dir}/perf.data.report.XXXXXX")
>>>> +  local data2
>>>> +  data2=$(mktemp "${temp_dir}/perf.data2.report.XXXXXX")
>>>> +  local data_clean
>>>> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
>>>> +
>>>> +  perf record -e task-clock:u -o "${data}" ${prog}
>>>> +  # Use -b to inject build-ids and force ordered events processing 
>>>> in both
>>>> +  perf inject -b -i "${data}" -o "${data_clean}"
>>>> +  perf inject -v -b --aslr -i "${data}" -o "${data2}"
>>>> +
>>>> +  local report1="${temp_dir}/report1"
>>>> +  local report2="${temp_dir}/report2"
>>>> +  local report1_clean="${temp_dir}/report1.clean"
>>>> +  local report2_clean="${temp_dir}/report2.clean"
>>>> +  local diff_file="${temp_dir}/diff"
>>>> +
>>>> +  perf report -i "${data_clean}" --stdio > "${report1}"
>>>> +  perf report -i "${data2}" --stdio > "${report2}"
>>>> +
>>>> +  # Strip headers and compare lines with percentages
>>>> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" 
>>>> || true
>>>> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" 
>>>> || true
>>>> +
>>>> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" 
>>>> || true
>>>> +
>>>> +  if [ ! -s "${report1_clean}" ]; then
>>>> +    echo "Report ASLR test [Failed - no samples captured]"
>>>> +    err=1
>>>> +  elif [ -s "${diff_file}" ]; then
>>>> +    echo "Report ASLR test [Failed - reports differ]"
>>>> +    echo "Showing first 20 lines of diff:"
>>>> +    head -n 20 "${diff_file}"
>>>> +    err=1
>>>> +  else
>>>> +    echo "Report ASLR test [Success]"
>>>> +  fi
>>>> +}
>>>> +
>>>> +test_pipe_report_aslr() {
>>>> +  echo "Test pipe mode perf report consistency"
>>>> +  local data
>>>> +  data=$(mktemp "${temp_dir}/perf.data.pipe_report.XXXXXX")
>>>> +  local data2
>>>> +  data2=$(mktemp "${temp_dir}/perf.data2.pipe_report.XXXXXX")
>>>> +  local data_clean
>>>> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
>>>> +
>>>> +  # Use tee to save the original pipe data, then process it with 
>>>> inject -b
>>>> +  perf record -e task-clock:u -o - ${prog} | \
>>>> +    tee "${data}" | \
>>>> +    perf inject -b --aslr -o "${data2}"
>>>> +  perf inject -b -i "${data}" -o "${data_clean}"
>>>> +
>>>> +  local report1="${temp_dir}/report1"
>>>> +  local report2="${temp_dir}/report2"
>>>> +  local report1_clean="${temp_dir}/report1.clean"
>>>> +  local report2_clean="${temp_dir}/report2.clean"
>>>> +  local diff_file="${temp_dir}/diff"
>>>> +
>>>> +  perf report -i "${data_clean}" --stdio > "${report1}"
>>>> +  perf report -i "${data2}" --stdio > "${report2}"
>>>> +
>>>> +  # Strip headers and compare lines with percentages
>>>> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" 
>>>> || true
>>>> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" 
>>>> || true
>>>> +
>>>> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" 
>>>> || true
>>>> +
>>>> +  if [ ! -s "${report1_clean}" ]; then
>>>> +    echo "Pipe Report ASLR test [Failed - no samples captured]"
>>>> +    err=1
>>>> +  elif [ -s "${diff_file}" ]; then
>>>> +    echo "Pipe Report ASLR test [Failed - reports differ]"
>>>> +    echo "Showing first 20 lines of diff:"
>>>> +    head -n 20 "${diff_file}"
>>>> +    err=1
>>>> +  else
>>>> +    echo "Pipe Report ASLR test [Success]"
>>>> +  fi
>>>> +}
>>>> +
>>>> +test_pipe_out_report_aslr() {
>>>> +  echo "Test pipe output mode perf report consistency"
>>>> +  local data
>>>> +  data=$(mktemp "${temp_dir}/perf.data.pipe_out_report.XXXXXX")
>>>> +  local data_clean
>>>> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
>>>> +
>>>> +  perf record -e task-clock:u -o "${data}" ${prog}
>>>> +  perf inject -b -i "${data}" -o "${data_clean}"
>>>> +
>>>> +  local report1="${temp_dir}/report1"
>>>> +  local report2="${temp_dir}/report2"
>>>> +  local report1_clean="${temp_dir}/report1.clean"
>>>> +  local report2_clean="${temp_dir}/report2.clean"
>>>> +  local diff_file="${temp_dir}/diff"
>>>> +
>>>> +  perf report -i "${data_clean}" --stdio > "${report1}"
>>>> +  perf inject -b --aslr -i "${data}" -o - | perf report -i - -- 
>>>> stdio > "${report2}"
>>>> +
>>>> +  # Strip headers and compare lines with percentages
>>>> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" 
>>>> || true
>>>> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" 
>>>> || true
>>>> +
>>>> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" 
>>>> || true
>>>> +
>>>> +  if [ ! -s "${report1_clean}" ]; then
>>>> +    echo "Pipe Output Report ASLR test [Failed - no samples captured]"
>>>> +    err=1
>>>> +  elif [ -s "${diff_file}" ]; then
>>>> +    echo "Pipe Output Report ASLR test [Failed - reports differ]"
>>>> +    echo "Showing first 20 lines of diff:"
>>>> +    head -n 20 "${diff_file}"
>>>> +    err=1
>>>> +  else
>>>> +    echo "Pipe Output Report ASLR test [Success]"
>>>> +  fi
>>>> +}
>>>> +
>>>> +test_dropped_samples() {
>>>> +  echo "Test dropped samples (phys-data)"
>>>> +  local data
>>>> +  data=$(mktemp "${temp_dir}/perf.data.dropped.XXXXXX")
>>>> +  local data2
>>>> +  data2=$(mktemp "${temp_dir}/perf.data2.dropped.XXXXXX")
>>>> +
>>>> +  # Check if --phys-data is supported by recording a short run
>>>> +  if ! perf record -e task-clock:u --phys-data -o "${data}" -- 
>>>> sleep 0.1 > /dev/null 2>&1; then
>>>> +    echo "Skipping dropped samples test as --phys-data is not 
>>>> supported"
>>>> +    return
>>>> +  fi
>>>> +
>>>> +  perf record -e task-clock:u --phys-data -o "${data}" ${prog}
>>>> +  perf inject --aslr -i "${data}" -o "${data2}"
>>>> +
>>>> +  # Verify that the original file actually contained samples!
>>>> +  orig_samples=$(perf script -i "${data}" | wc -l)
>>>> +  if [ "$orig_samples" -eq 0 ]; then
>>>> +    echo "Dropped samples test [Failed - no samples in original file]"
>>>> +    err=1
>>>> +  else
>>>> +    # Verify that samples are dropped.
>>>> +    samples_count=$(perf script -i "${data2}" | wc -l)
>>>> +
>>>> +    if [ "$samples_count" -gt 0 ]; then
>>>> +      echo "Dropped samples test [Failed - samples were not dropped]"
>>>> +      err=1
>>>> +    else
>>>> +      echo "Dropped samples test [Success]"
>>>> +    fi
>>>> +  fi
>>>> +}
>>>> +
>>>> +test_kernel_aslr() {
>>>> +  echo "Test kernel ASLR remapping"
>>>> +  local kdata
>>>> +  kdata=$(mktemp "${temp_dir}/perf.data.kernel.XXXXXX")
>>>> +  local kdata2
>>>> +  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel.XXXXXX")
>>>> +  local log_file
>>>> +  log_file=$(mktemp "${temp_dir}/kernel_record.log.XXXXXX")
>>>> +
>>>> +  # Try to record kernel samples
>>>> +  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > 
>>>> "${log_file}" 2>&1; then
>>>> +    echo "Skipping kernel ASLR test as recording failed (maybe no 
>>>> permissions)"
>>>> +    return
>>>> +  fi
>>>> +
>>>> +  # Check for warning about kernel map restriction
>>>> +  if grep -q "Couldn't record kernel reference relocation symbol" 
>>>> "${log_file}"; then
>>>> +    echo "Skipping kernel ASLR test as kernel map could not be 
>>>> recorded (permissions restricted)"
>>>> +    return
>>>> +  fi
>>>> +
>>>> +  perf inject -v --aslr -i "${kdata}" -o "${kdata2}"
>>>> +
>>>> +  # Check if kernel addresses are remapped.
>>>> +  # Find the field that ends with :k: (the event name) and take the 
>>>> next field!
>>>> +  orig_addr=$(perf script -i "${kdata}" | awk '
>>>> +    BEGIN { found=0 }
>>>> +    {
>>>> +      for (i=1; i<NF; i++) {
>>>> +        if ($i ~ /:[k]+:?$/) {
>>>> +          if (!found) {
>>>> +            print $(i+1)
>>>> +            found=1
>>>> +          }
>>>> +        }
>>>> +      }
>>>> +    }')
>>>> +  new_addr=$(perf script -i "${kdata2}" | awk '
>>>> +    BEGIN { found=0 }
>>>> +    {
>>>> +      for (i=1; i<NF; i++) {
>>>> +        if ($i ~ /:[k]+:?$/) {
>>>> +          if (!found) {
>>>> +            print $(i+1)
>>>> +            found=1
>>>> +          }
>>>> +        }
>>>> +      }
>>>> +    }')
>>>> +
>>>> +  echo "Kernel ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
>>>> +
>>>> +  if [ -z "$orig_addr" ]; then
>>>> +    echo "Kernel ASLR test [Failed - no kernel samples in original 
>>>> file]"
>>>> +    err=1
>>>> +  elif [ -z "$new_addr" ]; then
>>>> +    echo "Kernel ASLR test [Failed - could not find remapped address]"
>>>> +    err=1
>>>> +  elif [ "$orig_addr" = "$new_addr" ]; then
>>>> +    echo "Kernel ASLR test [Failed - addresses are not remapped]"
>>>> +    err=1
>>>> +  else
>>>> +    echo "Kernel ASLR test [Success]"
>>>> +  fi
>>>> +}
>>>> +
>>>> +test_kernel_report_aslr() {
>>>> +  echo "Test kernel perf report consistency"
>>>> +  local kdata
>>>> +  kdata=$(mktemp "${temp_dir}/perf.data.kernel_report.XXXXXX")
>>>> +  local kdata2
>>>> +  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel_report.XXXXXX")
>>>> +  local data_clean
>>>> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
>>>> +  local log_file
>>>> +  log_file=$(mktemp "${temp_dir}/kernel_report_record.log.XXXXXX")
>>>> +
>>>> +  # Try to record kernel samples
>>>> +  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > 
>>>> "${log_file}" 2>&1; then
>>>> +    echo "Skipping kernel report test as recording failed (maybe no 
>>>> permissions)"
>>>> +    return
>>>> +  fi
>>>> +
>>>> +  # Check for warning about kernel map restriction
>>>> +  if grep -q "Couldn't record kernel reference relocation symbol" 
>>>> "${log_file}"; then
>>>> +    echo "Skipping kernel report test as kernel map could not be 
>>>> recorded (permissions restricted)"
>>>> +    return
>>>> +  fi
>>>> +
>>>> +  # Use -b to inject build-ids and force ordered events processing 
>>>> in both
>>>> +  perf inject -b -i "${kdata}" -o "${data_clean}"
>>>> +  perf inject -v -b --aslr -i "${kdata}" -o "${kdata2}"
>>>> +
>>>> +  local report1="${temp_dir}/report_kernel1"
>>>> +  local report2="${temp_dir}/report_kernel2"
>>>> +  local report1_clean="${temp_dir}/report_kernel1.clean"
>>>> +  local report2_clean="${temp_dir}/report_kernel2.clean"
>>>> +
>>>> +  perf report -i "${data_clean}" --stdio > "${report1}"
>>>> +  perf report -i "${kdata2}" --stdio > "${report2}"
>>>> +
>>>> +  # Strip headers and compare lines with percentages
>>>> +  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}" || true
>>>> +  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}" || true
>>>> +
>>>> +  # Normalize kernel DSOs and addresses in clean reports
>>>> +  # This allows kernel modules to be either a module or 
>>>> kernel.kallsyms
>>>> +  local report1_norm="${temp_dir}/report_kernel1.norm"
>>>> +  local report2_norm="${temp_dir}/report_kernel2.norm"
>>>> +  local diff_file="${temp_dir}/diff_kernel"
>>>> +
>>>> +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report1_clean}" | \
>>>> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, 
>>>> "[kernel]", $0); print}' | sort > "${report1_norm}" || true
>>>> +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report2_clean}" | \
>>>> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, 
>>>> "[kernel]", $0); print}' | sort > "${report2_norm}" || true
>>>> +
>>>> +  diff -u -w "${report1_norm}" "${report2_norm}" > "${diff_file}" 
>>>> || true
>>>> +
>>>> +  if [ ! -s "${report1_norm}" ]; then
>>>> +    echo "Kernel Report ASLR test [Failed - no samples captured]"
>>>> +    err=1
>>>> +  elif [ -s "${diff_file}" ]; then
>>>> +    echo "Kernel Report ASLR test [Failed - reports differ]"
>>>> +    echo "Showing first 20 lines of diff:"
>>>> +    head -n 20 "${diff_file}"
>>>> +    err=1
>>>> +  else
>>>> +    echo "Kernel Report ASLR test [Success]"
>>>> +  fi
>>>> +}
>>>> +
>>>> +test_basic_aslr
>>>> +test_pipe_aslr
>>>> +test_callchain_aslr
>>>> +test_report_aslr
>>>> +test_pipe_report_aslr
>>>> +test_pipe_out_report_aslr
>>>> +test_dropped_samples
>>>> +test_kernel_aslr
>>>> +test_kernel_report_aslr
>>>> +
>>>> +cleanup
>>>> +exit $err
>>>
> 

