Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8673451B5
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236937; cv=none; b=PNyxUnAdoUw5CgpWnf8ChimfeM5ZEPYT4Yx4OUN+YRpnYRX/H+2hATEO4Qv0WoeoknFW5xLdPwkCNGg9HYcBKEiLJFw2/B1NNS0SLn3wWTb8qAYRqsQPbD50KgFg67953GzWezqpoD+ByGMmW97nDLgXYoMLnZ8tUxf3OR4Py5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236937; c=relaxed/simple;
	bh=HHPsiHasls2tfutMtaniUt5kmSg9IOMGV+IPGuMJzS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ44unNn4GtHh0H8xzEY4b5G41PISHOgJxV8WKLDRfHqD02L51hTJObLGpjWW7PnucFx69aaLckB4hqnWoWlyoHq3VfgHPZzTpbE0uRqelgy1iC4NCtECZToEOwLwjt+8MaJ9CjDneMjPyhHdb/RYvOJFQ/oAOJsklemDVPN8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+t0fSVM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+t0fSVM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45297094718so1498840f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778236934; x=1778841734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCNrNWA+IdYsvYVXxZ/52ZYLXvFpeZHX1CYIY50H3bI=;
        b=d+t0fSVMLMQIETwcI9SXC5dmSvWHrEnigukdTwTiP7OAL2MWyWTkIBOFgzoO1bNLn9
         Xelry1oe4EqpadFEFHDZJGK6ysGP5BAxLjqZSyj2jT3LRvIPRsluQ83smVz9Pam50Ky6
         3h8zriOfruytKF543QL5al7mEPn3Gx6jjWEnFLxUEO455vrjPnumRF2WvnouvqYL9MEl
         TJP1i72R9i84001JmkEuztofpM8kImO6e/W+K/XPpLNumtIoXYb5YCy0448Vcg/H3Nau
         AN1bA2yRzJMG2uqcei6UHz/f8RNuHqhgY80HV2pdRUVZ8RMHIq6LCK6GTe3apZPpLwDT
         SXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236934; x=1778841734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCNrNWA+IdYsvYVXxZ/52ZYLXvFpeZHX1CYIY50H3bI=;
        b=H8sqDyQMDmmk6yIlP6mHWFx8ZPBQ7ti72MGqZzOKfCV+zadbkpU2YgXVgui+YP6W4e
         XDefC3l003OAYvYOMzFfW06ADoALaNIdUQG52R530bD7QoiaDbL5xAwblfsthCKqLud5
         whhIzB2FTOHqdY2wssg1/XUYrgGD10ZUlFSSmq+2ULE49N2xUUk+Sf8LdZspGBuG/e+m
         LQr9FtHZjSrPXTcnLGcmYkXgOk2v1SQIjGdCk6UqlsnUuvGCl51WJz74E6xdRtuDOPJX
         zH+/d82xKQmV9Pu2n679iLfrX3L27IzJNmMPGFImrFnlDk+PowPBNEJV3cEuAwzykN9M
         uq/A==
X-Forwarded-Encrypted: i=1; AFNElJ9P6mwB66UEC2cTZivTrUlrDKEU7zwSWZNdpkpwPa4eBDonwwnIid4oLKP8ycJzXrooo71FaTP+biZB70UDmN3f@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGMOxdI6/wE27BH5jOSCRSpMw5iECnZVCX73/ovuogEL2/KIY
	+pybDhWMNqcchZbGBESxHryHAyQRxyqJPRWLi/FYvpnPD/pjDbtZscLkpA+z59HYYVY=
X-Gm-Gg: Acq92OG6ZvhdsEVT6gkvmOd5rPsCVZvqwUyia0H7eaPEdKIqtDM086W212quJ2d++e6
	ayHlqnTEP/m3cxOAWkR6kDbxmCZntnHz96Q3oneyUcV7b7c5D+jUQt9wpNRFVKd6ypuXZbQb7sn
	cDFswpDIWmJFSLdAm/4N3U58Ixo2iuDcH04iqplzzy1oHooZq/d3Y6QSwMHJBTLdmpz6h2dYgAN
	eyX4KoHH3CDh482T+debmdbiJAw6szEa5rCWiSWIRZpjnk3kwHmxHJkoTvZaqgSP+IoveGFcOMr
	tNjyuUSvP2rNHz0NTysMoKnzXKMWz+27xjO+6iuuihjqo4vYZN9vsfwJdpsXOkxtpO6X7jU91ig
	cklK2cy+kut7oxEZ/o4YV7Ift+hscrACfvit0p2xLtDdulYnrAhPm4QGBxm/ajidysaBbgiE09C
	SamonQ7N0EULSfxT7/dz1gwnGumKjD
X-Received: by 2002:a05:6000:2902:b0:43d:50c:6f33 with SMTP id ffacd0b85a97d-4515cf11c1bmr19199412f8f.26.1778236933655;
        Fri, 08 May 2026 03:42:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm3850480f8f.6.2026.05.08.03.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:42:13 -0700 (PDT)
Message-ID: <a7bbad57-95eb-45dd-883c-1acf7f5d3020@linaro.org>
Date: Fri, 8 May 2026 11:42:12 +0100
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
 <d0ac5850-91e8-489b-be02-322c7c35fd07@linaro.org>
 <CAP-5=fV6XfGSSnCwi1MEcEj5TA5H8SoFRrkP7zU9C17Y9L-Bnw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fV6XfGSSnCwi1MEcEj5TA5H8SoFRrkP7zU9C17Y9L-Bnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/05/2026 5:17 pm, Ian Rogers wrote:
> On Thu, May 7, 2026 at 8:58 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 06/05/2026 1:45 am, Ian Rogers wrote:
>>> Add a new shell test `inject_aslr.sh` to verify the `perf inject --aslr`
>>> feature. The test covers:
>>> - Basic address remapping for user space samples.
>>> - Pipe mode coverage for `perf record` piped into `perf inject --aslr`.
>>> - Callchain address remapping.
>>> - Consistency of `perf report` output before and after injection.
>>> - Pipe mode report consistency.
>>> - Dropping of samples that leak ASLR info (physical addresses).
>>> - Kernel address remapping (skipping gracefully if permissions restrict
>>>     recording the kernel map).
>>> - Kernel report consistency with address normalization.
>>>
>>> The test suite is hardened with global 'set -o pipefail' assertions to catch
>>> pipeline failures, stream-consuming awk processors to handle SIGPIPE signals,
>>> and a dedicated pipe output scenario validating raw 'perf inject -o -' stdout
>>> streams.
>>>
>>> Assisted-by: Gemini-CLI:Google Gemini 3
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>> v5: Harden test suite verification pipelines by upgrading report checks to
>>>       strict sorted line-by-line diff comparisons to accommodate remapped pointer
>>>       shifts. Append || true fallback operators to grep-v filtering pipelines to
>>>       prevent the shell test from spuriously aborting under set -o pipefail on
>>>       empty inputs, ensuring graceful failure checks trigger correctly.
>>> v4: Reorder set -e/pipefail to prevent temp file leakage in root directory on
>>>       unprivileged record failures when run as root. Ensure grep report filters
>>>       have || true suffixes to avoid aborts under pipefail. Add comprehensive
>>>       pipe stdout injection attributes validation case.
>>> v3: Harden script with pipefail, SIGPIPE awk pipeline fixes, callchain empty
>>>       data asserts, baseline sample verification, and grep report abort
>>>       protections. Reorder set -e/pipefail to prevent stack leaks in mktemp
>>>       failures.
>>> v2: Add sum comparison for kernel overhead and 32-bit math corrections. Add
>>>       awk with gsub for trailing dots and brackets normalizations. Trap EXIT,
>>>       prevent race conditions and avoid hardcoded perf binary.
>>> ---
>>>    tools/perf/tests/shell/inject_aslr.sh | 459 ++++++++++++++++++++++++++
>>>    1 file changed, 459 insertions(+)
>>>    create mode 100755 tools/perf/tests/shell/inject_aslr.sh
>>>
>>> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
>>> new file mode 100755
>>> index 000000000000..cdc3aa94de63
>>> --- /dev/null
>>> +++ b/tools/perf/tests/shell/inject_aslr.sh
>>> @@ -0,0 +1,459 @@
>>> +#!/bin/bash
>>> +# perf inject --aslr test
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +set -e
>>> +set -o pipefail
>>> +
>>> +shelldir=$(dirname "$0")
>>> +# shellcheck source=lib/perf_has_symbol.sh
>>> +. "${shelldir}"/lib/perf_has_symbol.sh
>>> +
>>> +sym="noploop"
>>> +
>>> +skip_test_missing_symbol ${sym}
>>> +
>>> +# Create global temp directory
>>> +temp_dir=$(mktemp -d /tmp/perf-test-aslr.XXXXXXXXXX)
>>> +data="${temp_dir}/perf.data"
>>> +data2="${temp_dir}/perf.data2"
>>> +
>>> +prog="perf test -w noploop"
>>> +[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
>>> +err=0
>>> +
>>> +
>>> +
>>> +cleanup() {
>>> +  # Check if temp_dir is set and looks sane before removing
>>> +  if [[ "${temp_dir}" =~ ^/tmp/perf-test-aslr\. ]]; then
>>> +    rm -rf "${temp_dir}"
>>> +  fi
>>> +}
>>> +
>>> +trap_cleanup() {
>>> +  cleanup
>>> +  exit 1
>>> +}
>>> +
>>> +trap cleanup EXIT
>>> +trap trap_cleanup TERM INT
>>> +
>>> +get_noploop_addr() {
>>> +  local file=$1
>>> +  perf script -i "$file" | awk '
>>> +    BEGIN { found=0 }
>>> +    {
>>> +      for (i=1; i<=NF; i++) {
>>> +        if ($i ~ /noploop\+/) {
>>> +          if (!found) {
>>> +            print $(i-1)
>>> +            found=1
>>> +          }
>>> +        }
>>> +      }
>>> +    }'
>>> +}
>>> +
>>> +test_basic_aslr() {
>>> +  echo "Test basic ASLR remapping"
>>> +  local data
>>> +  data=$(mktemp "${temp_dir}/perf.data.basic.XXXXXX")
>>> +  local data2
>>> +  data2=$(mktemp "${temp_dir}/perf.data2.basic.XXXXXX")
>>> +
>>> +  perf record -e task-clock:u -o "${data}" ${prog}
>>> +  perf inject -v --aslr -i "${data}" -o "${data2}"
>>> +
>>> +  orig_addr=$(get_noploop_addr "${data}")
>>> +  new_addr=$(get_noploop_addr "${data2}")
>>> +
>>> +  echo "Basic ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
>>> +
>>> +  if [ -z "$orig_addr" ]; then
>>> +    echo "Basic ASLR test [Failed - no noploop samples in original file]"
>>> +    err=1
>>> +  elif [ -z "$new_addr" ]; then
>>> +    echo "Basic ASLR test [Failed - could not find remapped address]"
>>> +    err=1
>>> +  elif [ "$orig_addr" = "$new_addr" ]; then
>>> +    echo "Basic ASLR test [Failed - addresses are not remapped]"
>>> +    err=1
>>> +  else
>>> +    echo "Basic ASLR test [Success]"
>>> +  fi
>>> +}
>>> +
>>> +test_pipe_aslr() {
>>> +  echo "Test pipe mode ASLR remapping"
>>> +  local data
>>> +  data=$(mktemp "${temp_dir}/perf.data.pipe.XXXXXX")
>>> +  local data2
>>> +  data2=$(mktemp "${temp_dir}/perf.data2.pipe.XXXXXX")
>>> +
>>> +  # Use tee to save the original pipe data for comparison
>>> +  perf record -e task-clock:u -o - ${prog} | tee "${data}" | perf inject --aslr -o "${data2}"
>>> +
>>> +  orig_addr=$(get_noploop_addr "${data}")
>>> +  new_addr=$(get_noploop_addr "${data2}")
>>> +
>>> +  echo "Pipe ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
>>> +
>>> +  if [ -z "$orig_addr" ]; then
>>> +    echo "Pipe ASLR test [Failed - no noploop samples in original file]"
>>> +    err=1
>>> +  elif [ -z "$new_addr" ]; then
>>> +    echo "Pipe ASLR test [Failed - could not find remapped address]"
>>> +    err=1
>>> +  elif [ "$orig_addr" = "$new_addr" ]; then
>>> +    echo "Pipe ASLR test [Failed - addresses are not remapped]"
>>> +    err=1
>>> +  else
>>> +    echo "Pipe ASLR test [Success]"
>>> +  fi
>>> +}
>>> +
>>> +test_callchain_aslr() {
>>> +  echo "Test Callchain ASLR remapping"
>>> +  local data
>>> +  data=$(mktemp "${temp_dir}/perf.data.callchain.XXXXXX")
>>> +  local data2
>>> +  data2=$(mktemp "${temp_dir}/perf.data2.callchain.XXXXXX")
>>> +
>>> +  perf record -g -e task-clock:u -o "${data}" ${prog}
>>> +  perf inject --aslr -i "${data}" -o "${data2}"
>>> +
>>> +  orig_addr=$(get_noploop_addr "${data}")
>>> +  new_addr=$(get_noploop_addr "${data2}")
>>> +
>>> +  echo "Callchain ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
>>> +
>>> +  if [ -z "$orig_addr" ]; then
>>> +    echo "Callchain ASLR test [Failed - no noploop samples in original file]"
>>> +    err=1
>>> +  elif [ -z "$new_addr" ]; then
>>> +    echo "Callchain ASLR test [Failed - could not find remapped address]"
>>
>> Hi Ian,
>>
>> This test fails on Arm. I believe it's because on Arm we request the
>> link register to be sampled with frame pointer unwinds. Then the aslr
>> tool drops all the samples because it sees that user regs were sampled:
>>
>>     /* TODO: can this be less conservative? */
>>     pr_debug("Dropping regs user sample as possible ASLR leak\n");
>>     ret = 0;
>>     goto out_put;
>>
>> I think maybe that comment is onto something. Perhaps the user regs can
>> be zeroed instead of dropping the sample. Then the frame pointer unwind
>> will still work on Arm and the aslr test will pass. We just won't be
>> able to use the link register to add the leaf frame caller, but that's
>> not a big deal.
> 
> Thanks James. I'm working on a new version of the patches, but I'm
> having delays getting the AI to approve the changes.
> 
> ARM does what? Ah, I knew this and also it didn't really register. I'm
> wondering now if we can put the machinery behind "EM_HOST ==
> EM_AARCH64":
> https://lore.kernel.org/all/20211217154521.80603-2-german.gomez@arm.com/
> as it seems a mechanism that would benefit other architectures such as
> ARM32 :-) And I have my mission to make tools/perf/arch disappear as
> much as is humanly possible.

Yeah that makes sense, the change you sent looks good.

> I also imagine the problem the link register solves for perf happens
> for BPF, so perhaps this ability shouldn't be encouraged.

Not sure what you mean by this, do you mean adding the link register 
shoudln't be encouraged, or the compiler dropping the stack frame? Or 
just the weak function style?

> 
> I think rather than zeroing the register values it would be better to
> just remove them from the output events. I'll try to add that support
> as having this test break on ARM isn't desirable.
> 

Makes sense too. I suppose data being there but zeroed could be slightly 
more confusing than just dropping the sample.

I don't know if modifying the sample type to remove 
PERF_SAMPLE_REGS_USER and emitting the rest could be an option? It might 
be more robust to cases when things are auto added to the sample by 
Perf. For example all the aux stuff has custom setup functions that add 
who knows what options to the events.


> Thanks,
> Ian
> 
>> James
>>
>>> +    err=1
>>> +  elif [ "$orig_addr" = "$new_addr" ]; then
>>> +    echo "Callchain ASLR test [Failed - addresses are not remapped]"
>>> +    err=1
>>> +  else
>>> +    # Extract callchain addresses (indented lines starting with hex addresses)
>>> +    orig_callchain=$(perf script -i "${data}" | awk '/^[[:space:]]+[0-9a-f]+/ {print $1}')
>>> +    new_callchain=$(perf script -i "${data2}" | awk '/^[[:space:]]+[0-9a-f]+/ {print $1}')
>>> +
>>> +    if [ -z "$orig_callchain" ]; then
>>> +      echo "Callchain ASLR test [Failed - no callchain samples in original file]"
>>> +      err=1
>>> +    elif [ -z "$new_callchain" ]; then
>>> +      echo "Callchain ASLR test [Failed - callchain data was dropped]"
>>> +      err=1
>>> +    elif [ "$orig_callchain" = "$new_callchain" ]; then
>>> +      echo "Callchain ASLR test [Failed - callchain addresses were not remapped]"
>>> +      err=1
>>> +    else
>>> +      echo "Callchain ASLR test [Success]"
>>> +    fi
>>> +  fi
>>> +}
>>> +
>>> +test_report_aslr() {
>>> +  echo "Test perf report consistency"
>>> +  local data
>>> +  data=$(mktemp "${temp_dir}/perf.data.report.XXXXXX")
>>> +  local data2
>>> +  data2=$(mktemp "${temp_dir}/perf.data2.report.XXXXXX")
>>> +  local data_clean
>>> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
>>> +
>>> +  perf record -e task-clock:u -o "${data}" ${prog}
>>> +  # Use -b to inject build-ids and force ordered events processing in both
>>> +  perf inject -b -i "${data}" -o "${data_clean}"
>>> +  perf inject -v -b --aslr -i "${data}" -o "${data2}"
>>> +
>>> +  local report1="${temp_dir}/report1"
>>> +  local report2="${temp_dir}/report2"
>>> +  local report1_clean="${temp_dir}/report1.clean"
>>> +  local report2_clean="${temp_dir}/report2.clean"
>>> +  local diff_file="${temp_dir}/diff"
>>> +
>>> +  perf report -i "${data_clean}" --stdio > "${report1}"
>>> +  perf report -i "${data2}" --stdio > "${report2}"
>>> +
>>> +  # Strip headers and compare lines with percentages
>>> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
>>> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
>>> +
>>> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
>>> +
>>> +  if [ ! -s "${report1_clean}" ]; then
>>> +    echo "Report ASLR test [Failed - no samples captured]"
>>> +    err=1
>>> +  elif [ -s "${diff_file}" ]; then
>>> +    echo "Report ASLR test [Failed - reports differ]"
>>> +    echo "Showing first 20 lines of diff:"
>>> +    head -n 20 "${diff_file}"
>>> +    err=1
>>> +  else
>>> +    echo "Report ASLR test [Success]"
>>> +  fi
>>> +}
>>> +
>>> +test_pipe_report_aslr() {
>>> +  echo "Test pipe mode perf report consistency"
>>> +  local data
>>> +  data=$(mktemp "${temp_dir}/perf.data.pipe_report.XXXXXX")
>>> +  local data2
>>> +  data2=$(mktemp "${temp_dir}/perf.data2.pipe_report.XXXXXX")
>>> +  local data_clean
>>> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
>>> +
>>> +  # Use tee to save the original pipe data, then process it with inject -b
>>> +  perf record -e task-clock:u -o - ${prog} | \
>>> +    tee "${data}" | \
>>> +    perf inject -b --aslr -o "${data2}"
>>> +  perf inject -b -i "${data}" -o "${data_clean}"
>>> +
>>> +  local report1="${temp_dir}/report1"
>>> +  local report2="${temp_dir}/report2"
>>> +  local report1_clean="${temp_dir}/report1.clean"
>>> +  local report2_clean="${temp_dir}/report2.clean"
>>> +  local diff_file="${temp_dir}/diff"
>>> +
>>> +  perf report -i "${data_clean}" --stdio > "${report1}"
>>> +  perf report -i "${data2}" --stdio > "${report2}"
>>> +
>>> +  # Strip headers and compare lines with percentages
>>> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
>>> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
>>> +
>>> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
>>> +
>>> +  if [ ! -s "${report1_clean}" ]; then
>>> +    echo "Pipe Report ASLR test [Failed - no samples captured]"
>>> +    err=1
>>> +  elif [ -s "${diff_file}" ]; then
>>> +    echo "Pipe Report ASLR test [Failed - reports differ]"
>>> +    echo "Showing first 20 lines of diff:"
>>> +    head -n 20 "${diff_file}"
>>> +    err=1
>>> +  else
>>> +    echo "Pipe Report ASLR test [Success]"
>>> +  fi
>>> +}
>>> +
>>> +test_pipe_out_report_aslr() {
>>> +  echo "Test pipe output mode perf report consistency"
>>> +  local data
>>> +  data=$(mktemp "${temp_dir}/perf.data.pipe_out_report.XXXXXX")
>>> +  local data_clean
>>> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
>>> +
>>> +  perf record -e task-clock:u -o "${data}" ${prog}
>>> +  perf inject -b -i "${data}" -o "${data_clean}"
>>> +
>>> +  local report1="${temp_dir}/report1"
>>> +  local report2="${temp_dir}/report2"
>>> +  local report1_clean="${temp_dir}/report1.clean"
>>> +  local report2_clean="${temp_dir}/report2.clean"
>>> +  local diff_file="${temp_dir}/diff"
>>> +
>>> +  perf report -i "${data_clean}" --stdio > "${report1}"
>>> +  perf inject -b --aslr -i "${data}" -o - | perf report -i - --stdio > "${report2}"
>>> +
>>> +  # Strip headers and compare lines with percentages
>>> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
>>> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
>>> +
>>> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
>>> +
>>> +  if [ ! -s "${report1_clean}" ]; then
>>> +    echo "Pipe Output Report ASLR test [Failed - no samples captured]"
>>> +    err=1
>>> +  elif [ -s "${diff_file}" ]; then
>>> +    echo "Pipe Output Report ASLR test [Failed - reports differ]"
>>> +    echo "Showing first 20 lines of diff:"
>>> +    head -n 20 "${diff_file}"
>>> +    err=1
>>> +  else
>>> +    echo "Pipe Output Report ASLR test [Success]"
>>> +  fi
>>> +}
>>> +
>>> +test_dropped_samples() {
>>> +  echo "Test dropped samples (phys-data)"
>>> +  local data
>>> +  data=$(mktemp "${temp_dir}/perf.data.dropped.XXXXXX")
>>> +  local data2
>>> +  data2=$(mktemp "${temp_dir}/perf.data2.dropped.XXXXXX")
>>> +
>>> +  # Check if --phys-data is supported by recording a short run
>>> +  if ! perf record -e task-clock:u --phys-data -o "${data}" -- sleep 0.1 > /dev/null 2>&1; then
>>> +    echo "Skipping dropped samples test as --phys-data is not supported"
>>> +    return
>>> +  fi
>>> +
>>> +  perf record -e task-clock:u --phys-data -o "${data}" ${prog}
>>> +  perf inject --aslr -i "${data}" -o "${data2}"
>>> +
>>> +  # Verify that the original file actually contained samples!
>>> +  orig_samples=$(perf script -i "${data}" | wc -l)
>>> +  if [ "$orig_samples" -eq 0 ]; then
>>> +    echo "Dropped samples test [Failed - no samples in original file]"
>>> +    err=1
>>> +  else
>>> +    # Verify that samples are dropped.
>>> +    samples_count=$(perf script -i "${data2}" | wc -l)
>>> +
>>> +    if [ "$samples_count" -gt 0 ]; then
>>> +      echo "Dropped samples test [Failed - samples were not dropped]"
>>> +      err=1
>>> +    else
>>> +      echo "Dropped samples test [Success]"
>>> +    fi
>>> +  fi
>>> +}
>>> +
>>> +test_kernel_aslr() {
>>> +  echo "Test kernel ASLR remapping"
>>> +  local kdata
>>> +  kdata=$(mktemp "${temp_dir}/perf.data.kernel.XXXXXX")
>>> +  local kdata2
>>> +  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel.XXXXXX")
>>> +  local log_file
>>> +  log_file=$(mktemp "${temp_dir}/kernel_record.log.XXXXXX")
>>> +
>>> +  # Try to record kernel samples
>>> +  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
>>> +    echo "Skipping kernel ASLR test as recording failed (maybe no permissions)"
>>> +    return
>>> +  fi
>>> +
>>> +  # Check for warning about kernel map restriction
>>> +  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
>>> +    echo "Skipping kernel ASLR test as kernel map could not be recorded (permissions restricted)"
>>> +    return
>>> +  fi
>>> +
>>> +  perf inject -v --aslr -i "${kdata}" -o "${kdata2}"
>>> +
>>> +  # Check if kernel addresses are remapped.
>>> +  # Find the field that ends with :k: (the event name) and take the next field!
>>> +  orig_addr=$(perf script -i "${kdata}" | awk '
>>> +    BEGIN { found=0 }
>>> +    {
>>> +      for (i=1; i<NF; i++) {
>>> +        if ($i ~ /:[k]+:?$/) {
>>> +          if (!found) {
>>> +            print $(i+1)
>>> +            found=1
>>> +          }
>>> +        }
>>> +      }
>>> +    }')
>>> +  new_addr=$(perf script -i "${kdata2}" | awk '
>>> +    BEGIN { found=0 }
>>> +    {
>>> +      for (i=1; i<NF; i++) {
>>> +        if ($i ~ /:[k]+:?$/) {
>>> +          if (!found) {
>>> +            print $(i+1)
>>> +            found=1
>>> +          }
>>> +        }
>>> +      }
>>> +    }')
>>> +
>>> +  echo "Kernel ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
>>> +
>>> +  if [ -z "$orig_addr" ]; then
>>> +    echo "Kernel ASLR test [Failed - no kernel samples in original file]"
>>> +    err=1
>>> +  elif [ -z "$new_addr" ]; then
>>> +    echo "Kernel ASLR test [Failed - could not find remapped address]"
>>> +    err=1
>>> +  elif [ "$orig_addr" = "$new_addr" ]; then
>>> +    echo "Kernel ASLR test [Failed - addresses are not remapped]"
>>> +    err=1
>>> +  else
>>> +    echo "Kernel ASLR test [Success]"
>>> +  fi
>>> +}
>>> +
>>> +test_kernel_report_aslr() {
>>> +  echo "Test kernel perf report consistency"
>>> +  local kdata
>>> +  kdata=$(mktemp "${temp_dir}/perf.data.kernel_report.XXXXXX")
>>> +  local kdata2
>>> +  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel_report.XXXXXX")
>>> +  local data_clean
>>> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
>>> +  local log_file
>>> +  log_file=$(mktemp "${temp_dir}/kernel_report_record.log.XXXXXX")
>>> +
>>> +  # Try to record kernel samples
>>> +  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
>>> +    echo "Skipping kernel report test as recording failed (maybe no permissions)"
>>> +    return
>>> +  fi
>>> +
>>> +  # Check for warning about kernel map restriction
>>> +  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
>>> +    echo "Skipping kernel report test as kernel map could not be recorded (permissions restricted)"
>>> +    return
>>> +  fi
>>> +
>>> +  # Use -b to inject build-ids and force ordered events processing in both
>>> +  perf inject -b -i "${kdata}" -o "${data_clean}"
>>> +  perf inject -v -b --aslr -i "${kdata}" -o "${kdata2}"
>>> +
>>> +  local report1="${temp_dir}/report_kernel1"
>>> +  local report2="${temp_dir}/report_kernel2"
>>> +  local report1_clean="${temp_dir}/report_kernel1.clean"
>>> +  local report2_clean="${temp_dir}/report_kernel2.clean"
>>> +
>>> +  perf report -i "${data_clean}" --stdio > "${report1}"
>>> +  perf report -i "${kdata2}" --stdio > "${report2}"
>>> +
>>> +  # Strip headers and compare lines with percentages
>>> +  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}" || true
>>> +  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}" || true
>>> +
>>> +  # Normalize kernel DSOs and addresses in clean reports
>>> +  # This allows kernel modules to be either a module or kernel.kallsyms
>>> +  local report1_norm="${temp_dir}/report_kernel1.norm"
>>> +  local report2_norm="${temp_dir}/report_kernel2.norm"
>>> +  local diff_file="${temp_dir}/diff_kernel"
>>> +
>>> +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report1_clean}" | \
>>> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | sort > "${report1_norm}" || true
>>> +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report2_clean}" | \
>>> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | sort > "${report2_norm}" || true
>>> +
>>> +  diff -u -w "${report1_norm}" "${report2_norm}" > "${diff_file}" || true
>>> +
>>> +  if [ ! -s "${report1_norm}" ]; then
>>> +    echo "Kernel Report ASLR test [Failed - no samples captured]"
>>> +    err=1
>>> +  elif [ -s "${diff_file}" ]; then
>>> +    echo "Kernel Report ASLR test [Failed - reports differ]"
>>> +    echo "Showing first 20 lines of diff:"
>>> +    head -n 20 "${diff_file}"
>>> +    err=1
>>> +  else
>>> +    echo "Kernel Report ASLR test [Success]"
>>> +  fi
>>> +}
>>> +
>>> +test_basic_aslr
>>> +test_pipe_aslr
>>> +test_callchain_aslr
>>> +test_report_aslr
>>> +test_pipe_report_aslr
>>> +test_pipe_out_report_aslr
>>> +test_dropped_samples
>>> +test_kernel_aslr
>>> +test_kernel_report_aslr
>>> +
>>> +cleanup
>>> +exit $err
>>

