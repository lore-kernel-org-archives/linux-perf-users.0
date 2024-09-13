Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC41DA2E2;
	Fri, 13 Sep 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231485; cv=none; b=ih9SBfqbHirzwaUEBxYvhQb4BgjXIn7w6T1w7cgs2n62YjzXjQLHOTg3jSHGRDEsQcItyDdnWQIAwYdYZoYwyA1MxNRlkWcKz9wHFScR6kaZ0loa91FTLPKP4doVnOz5dRAx1W2UwNG6vrgRu5fXVi7rhMwH2a5NCD1QmvOngmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231485; c=relaxed/simple;
	bh=+Yu26Ap/E2dYF9Wp5czg3NjI7K/MwWiFHbzvmh2PxyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtAffcJde/PZAs0kVdKgHX/4R7JKmggU60pNWwHbtTz465PFJHm9hrMHGcMcvfYS6HkgoY+pxbx2gGcNuWaxqT4RPP3zwoPJFb/KxMJX9j30EfPqQdoVlfUHnFEnmA42V7e1qE4KIgjZgP6oApcr5wpTImuHN7ie3icKZU52wLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B54913D5;
	Fri, 13 Sep 2024 05:45:11 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 739873F64C;
	Fri, 13 Sep 2024 05:44:38 -0700 (PDT)
Message-ID: <7ddea4df-9fe7-4cb8-998d-88e8c46ffcf8@arm.com>
Date: Fri, 13 Sep 2024 13:44:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] perf scripts python cs-etm: Update to use argparse
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
 <20240912151143.1264483-5-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240912151143.1264483-5-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 16:11, James Clark wrote:> 
> optparse is deprecated and less flexible than argparse so update it.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>   .../scripts/python/arm-cs-trace-disasm.py     | 28 +++++++------------
>   1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 7aff02d84ffb..45f682a8b34d 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -11,7 +11,7 @@ import os
>   from os import path
>   import re
>   from subprocess import *
> -from optparse import OptionParser, make_option
> +import argparse
> 
>   from perf_trace_context import perf_set_itrace_options, \
>          perf_sample_insn, perf_sample_srccode
> @@ -28,19 +28,11 @@ from perf_trace_context import perf_set_itrace_options, \
>   #  perf script -s scripts/python/arm-cs-trace-disasm.py
> 
>   # Command line parsing.
> -option_list = [
> -       # formatting options for the bottom entry of the stack
> -       make_option("-k", "--vmlinux", dest="vmlinux_name",
> -                   help="Set path to vmlinux file"),
> -       make_option("-d", "--objdump", dest="objdump_name",
> -                   help="Set path to objdump executable file"),
> -       make_option("-v", "--verbose", dest="verbose",
> -                   action="store_true", default=False,
> -                   help="Enable debugging log")
> -]
> -
> -parser = OptionParser(option_list=option_list)
> -(options, args) = parser.parse_args()
> +args = argparse.ArgumentParser()
> +args.add_argument("-k", "--vmlinux", help="Set path to vmlinux file")
> +args.add_argument("-d", "--objdump", help="Set path to objdump executable file"),
> +args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
> +options = args.parse_args()
> 
>   # Initialize global dicts and regular expression
>   disasm_cache = dict()
> @@ -65,8 +57,8 @@ def get_offset(perf_dict, field):
> 
>   def get_dso_file_path(dso_name, dso_build_id):
>          if (dso_name == "[kernel.kallsyms]" or dso_name == "vmlinux"):
> -               if (options.vmlinux_name):
> -                       return options.vmlinux_name;
> +               if (options.vmlinux):
> +                       return options.vmlinux;
>                  else:
>                          return dso_name
> 
> @@ -92,7 +84,7 @@ def read_disam(dso_fname, dso_start, start_addr, stop_addr):
>          else:
>                  start_addr = start_addr - dso_start;
>                  stop_addr = stop_addr - dso_start;
> -               disasm = [ options.objdump_name, "-d", "-z",
> +               disasm = [ options.objdump, "-d", "-z",
>                             "--start-address="+format(start_addr,"#x"),
>                             "--stop-address="+format(stop_addr,"#x") ]
>                  disasm += [ dso_fname ]
> @@ -256,7 +248,7 @@ def process_event(param_dict):
>                  print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>                  return
> 
> -       if (options.objdump_name != None):
> +       if (options.objdump != None):
>                  # It doesn't need to decrease virtual memory offset for disassembly
>                  # for kernel dso and executable file dso, so in this case we set
>                  # vm_start to zero.
> --
> 2.34.1
> 
