Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ju7YylLq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3481410F;
	Mon,  4 Dec 2023 21:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701755064; x=1733291064;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Z6hy1gIp80vT4zLaK3KIOHDEPNxXXhNL4HF2amR4Ebo=;
  b=ju7YylLqerdvasVWFd3FV+EVmK+nL+UBAE+exh7+T+c/ilwz4HuwVc4f
   AT6t94NjLfMAm/S3n5RGYv4K2Its7kX+thKob9/SaJydWb94IaOFIZuOg
   vHJ3pJbjgEC/fnbum+8tQdgwxYsj1fcP/ABdPMX69bnUNJm6+wNyxTkPM
   xR8rFCYTGYzyrFnbcDAuaOH4BU24f4ohb9/vO32zpQswVeHUl1KAdr9AL
   LQSnzvDoy8h2aXGCo7zEhMdnVKE4KSXaRJyeECLzMRpdU7D7iZfnVBlZs
   do0uRP3SjIaF345wZ61GZVwb/QqnwezWLIUkd4YAB3SH9rWAadQU4bn5J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12562894"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="12562894"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 21:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="888803383"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="888803383"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.77])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 21:44:20 -0800
Message-ID: <ee68f32d-72a2-4e9f-aee1-7c195ad44765@intel.com>
Date: Tue, 5 Dec 2023 07:44:17 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Add basic perf diff test
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 atrajeev@linux.vnet.ibm.com
References: <20231120190408.281826-1-irogers@google.com>
 <CAP-5=fWvADeeHVQObwk-eVNeOSC=eTTv2q8Rz4j3UtL5-6Getw@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWvADeeHVQObwk-eVNeOSC=eTTv2q8Rz4j3UtL5-6Getw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/12/23 18:00, Ian Rogers wrote:
> On Mon, Nov 20, 2023 at 11:04 AM Ian Rogers <irogers@google.com> wrote:
>>
>> There are some old bug reports on perf diff crashing:
>> https://rhaas.blogspot.com/2012/06/perf-good-bad-ugly.html
>>
>> Happening across them I was prompted to add two very basic tests that
>> will give some perf diff coverage.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.
> 
> Thanks,
> Ian
> 
>> ---
>>  tools/perf/tests/shell/diff.sh | 101 +++++++++++++++++++++++++++++++++
>>  1 file changed, 101 insertions(+)
>>  create mode 100755 tools/perf/tests/shell/diff.sh
>>
>> diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
>> new file mode 100755
>> index 000000000000..213185763688
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/diff.sh
>> @@ -0,0 +1,101 @@
>> +#!/bin/sh
>> +# perf diff tests
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +set -e
>> +
>> +err=0
>> +perfdata1=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>> +perfdata2=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>> +perfdata3=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>> +testprog="perf test -w thloop"
>> +testsym="test_loop"

Could it benefit from skip_test_missing_symbol

>> +
>> +cleanup() {
>> +  rm -rf "${perfdata1}"
>> +  rm -rf "${perfdata1}".old
>> +  rm -rf "${perfdata2}"
>> +  rm -rf "${perfdata2}".old
>> +  rm -rf "${perfdata3}"
>> +  rm -rf "${perfdata3}".old
>> +
>> +  trap - EXIT TERM INT
>> +}
>> +
>> +trap_cleanup() {
>> +  cleanup
>> +  exit 1
>> +}
>> +trap trap_cleanup EXIT TERM INT
>> +
>> +make_data() {
>> +  file="$1"
>> +  if ! perf record -o "${file}" ${testprog} 2> /dev/null
>> +  then
>> +    echo "Workload record [Failed record]"
>> +    echo 1
>> +    return
>> +  fi
>> +  if ! perf report -i "${file}" -q | grep -q "${testsym}"
>> +  then
>> +    echo "Workload record [Failed missing output]"
>> +    echo 1
>> +    return
>> +  fi
>> +  echo 0
>> +}
>> +
>> +test_two_files() {
>> +  echo "Basic two file diff test"
>> +  err=$(make_data "${perfdata1}")
>> +  if [ $err != 0 ]
>> +  then
>> +    return
>> +  fi
>> +  err=$(make_data "${perfdata2}")
>> +  if [ $err != 0 ]
>> +  then
>> +    return
>> +  fi
>> +
>> +  if ! perf diff "${perfdata1}" "${perfdata2}" | grep -q "${testsym}"
>> +  then
>> +    echo "Basic two file diff test [Failed diff]"
>> +    err=1
>> +    return
>> +  fi
>> +  echo "Basic two file diff test [Success]"
>> +}
>> +
>> +test_three_files() {
>> +  echo "Basic three file diff test"
>> +  err=$(make_data "${perfdata1}")
>> +  if [ $err != 0 ]
>> +  then
>> +    return
>> +  fi
>> +  err=$(make_data "${perfdata2}")
>> +  if [ $err != 0 ]
>> +  then
>> +    return
>> +  fi
>> +  err=$(make_data "${perfdata3}")
>> +  if [ $err != 0 ]
>> +  then
>> +    return
>> +  fi
>> +
>> +  if ! perf diff "${perfdata1}" "${perfdata2}" "${perfdata3}" | grep -q "${testsym}"
>> +  then
>> +    echo "Basic three file diff test [Failed diff]"
>> +    err=1
>> +    return
>> +  fi
>> +  echo "Basic three file diff test [Success]"
>> +}
>> +
>> +test_two_files
>> +test_three_files
>> +
>> +cleanup
>> +exit $err
>> --
>> 2.43.0.rc1.413.gea7ed67945-goog
>>

