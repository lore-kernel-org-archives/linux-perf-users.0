Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457CD158520;
	Mon, 16 Sep 2024 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502993; cv=none; b=BXX/0debf1KpwZIK1XFFsgyclcCTBu31Xbprl1P8InE8q2+gr10bhSsVdNYSOgMx2eBzHOQN4Nrv2S20HoyiRJp685KdNOOV92iYdp2JxWix6bUxnuefS5p/E/r/k9AvZc4L3423Awfs2jzdnNhbU9Ilji4TMQn94auaqI0T0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502993; c=relaxed/simple;
	bh=hBDaRTqfYJoNsB4SuIU6Ydd3vwt1hxsVkBJIvwoGnjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XugDKU0Jb6Qanwp2vBlcxDlMj+72MQQRB3E/FBn+mtLPiIss93bATe7YwU8tPJLav0PqcruaetY0Y62WqLv0EQH3ZbAf8iICGCcxEzGG5ZkQNR7Ht1d49V0HMQTPOHaU57DFZqzCFTgpdFwAZnzFZjWG3NKwTGmq9YtE33orF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A999C11FB;
	Mon, 16 Sep 2024 09:10:19 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3934D3F66E;
	Mon, 16 Sep 2024 09:09:47 -0700 (PDT)
Message-ID: <9b6426d9-b30f-4dea-aacf-99b991b34919@arm.com>
Date: Mon, 16 Sep 2024 17:09:45 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] perf test: cs-etm: Test Coresight disassembly
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
References: <20240916135743.1490403-1-james.clark@linaro.org>
 <20240916135743.1490403-8-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240916135743.1490403-8-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/16/24 14:57, James Clark wrote:
> 
> Run a few samples through the disassembly script and check to see that
> at least one branch instruction is printed.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>   .../tests/shell/test_arm_coresight_disasm.sh  | 65 +++++++++++++++++++
>   1 file changed, 65 insertions(+)
>   create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> new file mode 100755
> index 000000000000..af63e3757cb0
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> @@ -0,0 +1,65 @@
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
> +# Relative path works whether it's installed or running from repo
> +script_path=$(dirname "$0")/../../scripts/python/arm-cs-trace-disasm.py
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
> +       perf script -i ${perfdata} -s python:${script_path} -- \
> +               -d --stop-sample=30 2> /dev/null > ${file}
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
> +perf script -i ${perfdata} -s python:${script_path} -- \
> +       -d --stop-sample=30 2> /dev/null > ${file}
> +grep -q -e ${branch_search} ${file}
> +echo "Found userspace branches"
> +
> +glb_err=0
> --
> 2.34.1
> 
