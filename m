Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CB15B102;
	Wed, 24 Jul 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721833217; cv=none; b=Dj780ZSL1QRmiBiUsIKvA4F1VzJNcrJBOYby47/ztVij5ew+oj0rr9VliuCWUISE00M64ixgDfn5JZv7j0S0L2Tuatc0Jziny8plvRX3bom18hjbvkfjAbPluXnYpF7n1cUKypSEJOeDkMYrH/Jyy/qCzb5bQ33kyg73jSoW0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721833217; c=relaxed/simple;
	bh=KWCJxcf4xQgapZbwc32HUC6Ya6NEazSoaFZXlfS3T3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmbDx5TIMk5Ow/cqxKxaHOzqv78SVr76hzdk6KWmYvuRcGXhWx3CH8HJtO4z5KLghvU2HoDY/u02XOX5nCKWB8RgAp78VZ7u9qH54CTZkk1+ySOpWD95LyuZk8JA/QzXi2TqyIytQLHvdoxpEVl8MZP9SZbJfpznze1vDv9xsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9226E106F;
	Wed, 24 Jul 2024 08:00:39 -0700 (PDT)
Received: from [10.1.25.15] (PF4Q20KV.arm.com [10.1.25.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B27823F766;
	Wed, 24 Jul 2024 08:00:11 -0700 (PDT)
Message-ID: <225ff37c-0e50-48d5-bb4c-e8a63e72991a@arm.com>
Date: Wed, 24 Jul 2024 16:00:04 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python: cs-etm: Update example to provide
 vmlinux path to Perf
To: James Clark <james.clark@linaro.org>, coresight@lists.linaro.org,
 gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
 suzuki.poulose@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Ruidong Tian <tianruidong@linux.alibaba.com>,
 Benjamin Gray <bgray@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240724143319.169745-1-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240724143319.169745-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/2024 3:33 PM, James Clark wrote:
> 
> The example shows the vmlinux path being given to the script, but this
> only works when running on the target. If the script is run off the
> target, then confusingly the vmlinux argument also needs to be given to
> Perf as well.
> 
> Without going into too much detail in the example about when it is or
> isn't required, just include it. It doesn't do any harm even when
> running on the target. Now the example command works in both places.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

The change makes senses to me.  Just check a bit, does it need to add the same
option for the command "only source line and symbols"?

Thanks,
Leo

> ---
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 7aff02d84ffb..4aeb9b497f7a 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -19,10 +19,10 @@ from perf_trace_context import perf_set_itrace_options, \
>  # Below are some example commands for using this script.
>  #
>  # Output disassembly with objdump:
> -#  perf script -s scripts/python/arm-cs-trace-disasm.py \
> +#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
>  #              -- -d objdump -k path/to/vmlinux
>  # Output disassembly with llvm-objdump:
> -#  perf script -s scripts/python/arm-cs-trace-disasm.py \
> +#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
>  #              -- -d llvm-objdump-11 -k path/to/vmlinux
>  # Output only source line and symbols:
>  #  perf script -s scripts/python/arm-cs-trace-disasm.py
> --
> 2.34.1
> 
