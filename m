Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292CC1DA318;
	Fri, 13 Sep 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234513; cv=none; b=mG4A8n8tcOyWFGGkz0ji+cqxU3j3HtELUj7gM2h8mMBQQ8ll8px5DeXlLZZeIDjc/VbRzI1aCO6dD1HNJSxtVC9i/rE1h2m4N9QNDUVS5XtydLGf4k1xOolgOaiFRHnuFH6bitHcifnRv9+Qrc/mp3TzCcT+JZCGGiDNkU3oYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234513; c=relaxed/simple;
	bh=S+rR3ivhe3t3xEBNPwDuDi45Uhrw68HH6I3Ap16DZpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rru71NFYP7lUWyUBWQQdAvzY2LtQKXmWY0iYTQrG3tmvtmKbUscHDUoAPp9qvzaEqZVpf/kHaRQjA0c8oVRhAbKMWDwvIfcAPyDr+s+10hSRQCavmQ5eM93/8TIkjlXSK1bKSJSGqTddhNXf4a86BxR/l80g4LndxWK0UnqsVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C65A613D5;
	Fri, 13 Sep 2024 06:35:40 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 787033F73B;
	Fri, 13 Sep 2024 06:35:08 -0700 (PDT)
Message-ID: <42bfbda0-3b4a-496f-a96a-8f16d3e108f7@arm.com>
Date: Fri, 13 Sep 2024 14:35:07 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] perf test: cs-etm: Test Coresight disassembly
 script
To: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <20240912151143.1264483-8-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240912151143.1264483-8-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/24 16:11, James Clark wrote:
> 
> Run a few samples through the disassembly script and check to see that
> at least one branch instruction is printed.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   .../tests/shell/test_arm_coresight_disasm.sh  | 63 +++++++++++++++++++
>   1 file changed, 63 insertions(+)
>   create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> new file mode 100755
> index 000000000000..6d004bf29f80
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +# Check Arm CoreSight disassembly script completes without errors
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# The disassembly script reconstructs ranges of instructions and gives these to objdump to
> +# decode. objdump doesn't like ranges that go backwards, but these are a good indication
> +# that decoding has gone wrong either in OpenCSD, Perf or in the range reconstruction in
> +# the script. Test all 3 parts are working correctly by running the script.
> +
> +skip_if_no_cs_etm_event() {
> +       perf list | grep -q 'cs_etm//' && return 0
> +
> +       # cs_etm event doesn't exist
> +       return 2
> +}
> +
> +skip_if_no_cs_etm_event || exit 2
> +
> +# Assume an error unless we reach the very end
> +set -e
> +glb_err=1
> +
> +perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
> +perfdata=${perfdata_dir}/perf.data
> +file=$(mktemp /tmp/temporary_file.XXXXX)
> +
> +cleanup_files()
> +{
> +       set +e
> +       rm -rf ${perfdata_dir}
> +       rm -f ${file}
> +       trap - EXIT TERM INT
> +       exit $glb_err
> +}
> +
> +trap cleanup_files EXIT TERM INT
> +
> +# Ranges start and end on branches, so check for some likely branch instructions
> +sep="\s\|\s"
> +branch_search="\sbl${sep}b${sep}b.ne${sep}b.eq${sep}cbz\s"
> +
> +## Test kernel ##
> +if [ -e /proc/kcore ]; then
> +       echo "Testing kernel disassembly"
> +       perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
> +       perf script -i ${perfdata} -s python:tools/perf/scripts/python/arm-cs-trace-disasm.py -- \
> +               -d --stop-sample=30 2> /dev/null > ${file}

This is fine for self test. But for a CI test in a distro, will it fail to
find script with prefix 'tools/perf/...'?

Thanks,
Leo

> +       grep -q -e ${branch_search} ${file}
> +       echo "Found kernel branches"
> +else
> +       # kcore is required for correct kernel decode due to runtime code patching
> +       echo "No kcore, skipping kernel test"
> +fi
> +
> +## Test user ##
> +echo "Testing userspace disassembly"
> +perf record -o ${perfdata} -e cs_etm//u -- touch $file > /dev/null 2>&1
> +perf script -i ${perfdata} -s python:tools/perf/scripts/python/arm-cs-trace-disasm.py -- \
> +       -d --stop-sample=30 2> /dev/null > ${file}
> +grep -q -e ${branch_search} ${file}
> +echo "Found userspace branches"
> +
> +glb_err=0
> --
> 2.34.1
> 
