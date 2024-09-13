Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87111DA60C;
	Fri, 13 Sep 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233650; cv=none; b=kWfWnggZG7bej3g4BuuR6oyf2IiCj4w0FExcx1MLy+9ujIs9FM5H7TNdP4849gg2UNzWv1AXTyHw/wGXIUdK6c2IDZoZ3e0j4mUNUZHQa5PSfWUmKTZyk/tFOiAZMEj8pE8ojUjj2ufZJDZ3jut/bnjycDXGtV15nfnaLsf5q0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233650; c=relaxed/simple;
	bh=Pux9vGJIxSvJffdRQ6pJ5IpXFb74LMLn76OPxBtyAOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSF9ZrDhqgj+gutHLWo18hKRzj0u6WPbxZBvs07WqiF8ojbllaObT/yAy5uuEtlYEezN7vLAF+y46tffPIzOj35vnE2fji8WMD2wP4QN0snHg+HX5NyHAS9FETAFdcix8N9nH/z57dJWPfbUJVGOAkZi6j8bHULxqDZmFb2Ep+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C5D13D5;
	Fri, 13 Sep 2024 06:21:17 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12E223F73B;
	Fri, 13 Sep 2024 06:20:44 -0700 (PDT)
Message-ID: <11bca9b1-7eb1-4a13-8f05-9ba5b9c46d24@arm.com>
Date: Fri, 13 Sep 2024 14:20:43 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] perf scripts python cs-etm: Add start and stop
 arguments
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
 <20240912151143.1264483-7-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240912151143.1264483-7-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 16:11, James Clark wrote:>
> Make it possible to only disassemble a range of timestamps or sample
> indexes. This will be used by the test to limit the runtime, but it's
> also useful for users.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   .../scripts/python/arm-cs-trace-disasm.py     | 22 +++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 02e957d037ea..a097995d8e7b 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -55,6 +55,11 @@ args.add_argument("-k", "--vmlinux",
>   args.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
>                    help="Show disassembly. Can also be used to change the objdump path"),
>   args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
> +args.add_argument("--start-time", type=int, help="Time of sample to start from")
> +args.add_argument("--stop-time", type=int, help="Time of sample to stop at")
> +args.add_argument("--start-sample", type=int, help="Index of sample to start from")
> +args.add_argument("--stop-sample", type=int, help="Index of sample to stop at")
> +

It is good to validate the ranges for time and sample indexes, in case
the user passes unexpected values and can directly report the error.

BTW, I think it is good to clarify the time is based on monotonic clock
but not wall-clock time.

With above changes, LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>

>   options = args.parse_args()
> 
>   # Initialize global dicts and regular expression
> @@ -63,6 +68,7 @@ cpu_data = dict()
>   disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
>   disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
>   cache_size = 64*1024
> +sample_idx = -1
> 
>   glb_source_file_name   = None
>   glb_line_number                = None
> @@ -151,10 +157,10 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
> 
>   def print_sample(sample):
>          print("Sample = { cpu: %04d addr: 0x%016x phys_addr: 0x%016x ip: 0x%016x " \
> -             "pid: %d tid: %d period: %d time: %d }" % \
> +             "pid: %d tid: %d period: %d time: %d index: %d}" % \
>                (sample['cpu'], sample['addr'], sample['phys_addr'], \
>                 sample['ip'], sample['pid'], sample['tid'], \
> -              sample['period'], sample['time']))
> +              sample['period'], sample['time'], sample_idx))
> 
>   def trace_begin():
>          print('ARM CoreSight Trace Data Assembler Dump')
> @@ -216,6 +222,7 @@ def print_srccode(comm, param_dict, sample, symbol, dso):
>   def process_event(param_dict):
>          global cache_size
>          global options
> +       global sample_idx
> 
>          sample = param_dict["sample"]
>          comm = param_dict["comm"]
> @@ -231,6 +238,17 @@ def process_event(param_dict):
>          ip = sample["ip"]
>          addr = sample["addr"]
> 
> +       sample_idx += 1
> +
> +       if (options.start_time and sample["time"] < options.start_time):
> +               return
> +       if (options.stop_time and sample["time"] > options.stop_time):
> +               exit(0)
> +       if (options.start_sample and sample_idx < options.start_sample):
> +               return
> +       if (options.stop_sample and sample_idx > options.stop_sample):
> +               exit(0)
> +
>          if (options.verbose == True):
>                  print("Event type: %s" % name)
>                  print_sample(sample)
> --
> 2.34.1
> 
