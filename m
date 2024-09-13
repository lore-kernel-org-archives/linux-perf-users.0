Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672781BAEF9;
	Fri, 13 Sep 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232481; cv=none; b=t40xsIYOVDbWW1WUhhK589jbu1q5BGas2RGvjGwwXEusVNQUBKtbFDrcVhD66tv+HIwWkzrRL/4/ZW4BJWQtGmSK3IEMQJTAyZ2bo8pSuM0ffx3hLXzbwGGUxv5MHHk2YdgGFjG60IiTpdhkfCmexnm6Oq1cxNG7V7++DO3mQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232481; c=relaxed/simple;
	bh=piM6Nw0pbD1EUSxyijwuZApjQHVlC932mIggFz+3xN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/Xa5UDbovhf0peOPk9kHuYtF96x7btJMOQ2mATFf+TGXwNzpfAB5YEyKO4hBhp/kun8gzZ1O5eMebljgjrxxvTC/d3nc0yzwcrjFDXkw0HU042ihjhe0D5xVLQLEkYJvaT5PBMi/KCwdjvF0NztRMsqj/4IOYIiSTrQrHhWUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01E4413D5;
	Fri, 13 Sep 2024 06:01:48 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6E6C3F73B;
	Fri, 13 Sep 2024 06:01:15 -0700 (PDT)
Message-ID: <3bc1a619-07da-4014-945f-5fb173f1092b@arm.com>
Date: Fri, 13 Sep 2024 14:01:14 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] perf scripts python cs-etm: Improve arguments
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
 <20240912151143.1264483-6-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240912151143.1264483-6-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/24 16:11, James Clark wrote:
> 
> Make vmlinux detection automatic and use Perf's default objdump
> when -d is specified. This will make it easier for a test to use the
> script without having to provide arguments. And similarly for users.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>   .../scripts/python/arm-cs-trace-disasm.py     | 63 ++++++++++++++++---
>   1 file changed, 55 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 45f682a8b34d..02e957d037ea 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -12,25 +12,48 @@ from os import path
>   import re
>   from subprocess import *
>   import argparse
> +import platform
> 
> -from perf_trace_context import perf_set_itrace_options, \
> -       perf_sample_insn, perf_sample_srccode
> +from perf_trace_context import perf_sample_srccode, perf_config_get
> 
>   # Below are some example commands for using this script.
> +# Note a --kcore recording is required for accurate decode
> +# due to the alternatives patching mechanism. However this
> +# script only supports reading vmlinux for disassembly dump,
> +# meaning that any patched instructions will appear
> +# as unpatched, but the instruction ranges themselves will
> +# be correct. In addition to this, source line info comes
> +# from Perf, and when using kcore there is no debug info. The
> +# following lists the supported features in each mode:
> +#
> +# +-----------+-----------------+------------------+------------------+
> +# | Recording | Accurate decode | Source line dump | Disassembly dump |
> +# +-----------+-----------------+------------------+------------------+
> +# | --kcore   | yes             | no               | yes              |
> +# | normal    | no              | yes              | yes              |
> +# +-----------+-----------------+------------------+------------------+
> +#
> +# Output disassembly with objdump and auto detect vmlinux
> +# (when running on same machine.)
> +#  perf script -s scripts/python/arm-cs-trace-disasm.py -d
>   #
> -# Output disassembly with objdump:
> -#  perf script -s scripts/python/arm-cs-trace-disasm.py \
> -#              -- -d objdump -k path/to/vmlinux
>   # Output disassembly with llvm-objdump:
>   #  perf script -s scripts/python/arm-cs-trace-disasm.py \
>   #              -- -d llvm-objdump-11 -k path/to/vmlinux
> +#
>   # Output only source line and symbols:
>   #  perf script -s scripts/python/arm-cs-trace-disasm.py
> 
> +def default_objdump():
> +       config = perf_config_get("annotate.objdump")
> +       return config if config else "objdump"
> +
>   # Command line parsing.
>   args = argparse.ArgumentParser()
> -args.add_argument("-k", "--vmlinux", help="Set path to vmlinux file")
> -args.add_argument("-d", "--objdump", help="Set path to objdump executable file"),
> +args.add_argument("-k", "--vmlinux",
> +                 help="Set path to vmlinux file. Omit to autodetect if running on same machine")
> +args.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
> +                 help="Show disassembly. Can also be used to change the objdump path"),
>   args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
>   options = args.parse_args()
> 
> @@ -45,6 +68,17 @@ glb_source_file_name = None
>   glb_line_number                = None
>   glb_dso                        = None
> 
> +kver = platform.release()
> +vmlinux_paths = [
> +       f"/usr/lib/debug/boot/vmlinux-{kver}.debug",
> +       f"/usr/lib/debug/lib/modules/{kver}/vmlinux",
> +       f"/lib/modules/{kver}/build/vmlinux",
> +       f"/usr/lib/debug/boot/vmlinux-{kver}",
> +       f"/boot/vmlinux-{kver}",
> +       f"/boot/vmlinux",
> +       f"vmlinux"
> +]
> +
>   def get_optional(perf_dict, field):
>          if field in perf_dict:
>                  return perf_dict[field]
> @@ -55,12 +89,25 @@ def get_offset(perf_dict, field):
>                  return "+%#x" % perf_dict[field]
>          return ""
> 
> +def find_vmlinux():
> +       if hasattr(find_vmlinux, "path"):
> +               return find_vmlinux.path
> +
> +       for v in vmlinux_paths:
> +               if os.access(v, os.R_OK):
> +                       find_vmlinux.path = v
> +                       break
> +       else:
> +               find_vmlinux.path = None
> +
> +       return find_vmlinux.path
> +
>   def get_dso_file_path(dso_name, dso_build_id):
>          if (dso_name == "[kernel.kallsyms]" or dso_name == "vmlinux"):
>                  if (options.vmlinux):
>                          return options.vmlinux;
>                  else:
> -                       return dso_name
> +                       return find_vmlinux() if find_vmlinux() else dso_name
> 
>          if (dso_name == "[vdso]") :
>                  append = "/vdso"
> --
> 2.34.1
> 
