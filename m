Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8D46A5F2;
	Wed, 23 Sep 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154014; cv=none; b=rco0eagjohKOqghsQhjzw1ibevUwJzsXKkqUNe0AMUnswqY/kIONWCck1vgQenfUvukJNxkV85lneDj31ucFvudibcJ/MQQSO+TeEdlOrEQzdIqDMEaJC+Co2ua2rj81Y33XfTayXDuw3Y4s4dEuz9I3/FdRJIOi5T40vWdSr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154014; c=relaxed/simple;
	bh=79aqT9q797MP2m+MAGONuSLqP1NcK9sSbxzyRFu8S0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuToRdO94fTdeMchMpGI+nYjh6RymmRecEnxi1WrWu6odoUgQxAmAAmhSY+F1NP35vRqnhsV80UeFf4rYRMa0BAO4cPRBhCQPtPc4GNxs0Yeu3HD+bd1pB303EUX4Fthb9QhTGkL8uncFWCkVTqKRptcJLmfX3qTOCYRhxnqNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FIiEDW6U; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FIiEDW6U"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43DE91570;
	Wed, 23 Sep 2026 02:00:06 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 666373F86C;
	Wed, 23 Sep 2026 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790154009; bh=79aqT9q797MP2m+MAGONuSLqP1NcK9sSbxzyRFu8S0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIiEDW6UvtcRTIKtEaoDVP5V3Qme+5oNbMo9m4lskSVh+UJxNR3MSQshFQkky1a94
	 KKzn2f9+KCjKbza8KBEzAzisxMd6zofhbPTRVHmQsqdOwhTLDFrZD45sMyBdnawozp
	 sBzN+B7WJt2IeYepqZye5aouyJV49E4xXoZ/mlG8=
Date: Wed, 23 Sep 2026 10:00:07 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, alice.mei.rogers@gmail.com,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	adrian.hunter@intel.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, leo.yan@linux.dev,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v2 38/49] perf python: Port arm-cs-trace-disasm to perf
 module
Message-ID: <20260923090007.GJ200420@e132581.arm.com>
References: <cover.1789966896.git.irogers@google.com>
 <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>

On Sun, Sep 20, 2026 at 10:06:56PM -0700, Ian Rogers wrote:

[...]

> ---
>  tools/perf/python/arm-cs-trace-disasm.py      | 356 ++++++++++++++++++

A new script is added under tools/perf/python/, but I don't see the
legacy script under tools/perf/scripts/python/ being removed.

Should we maintain two copies of the script for the same purpose?

> --- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
> +++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh

> @@ -44,8 +56,8 @@ branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)
>  if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
>  	echo "Testing kernel disassembly"
>  	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file > /dev/null 2>&1
> -	perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
> -		-d --stop-sample=2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
> +	$PYTHON ${script_path} -i ${perfdata} --itrace=b -d --stop-sample=2 \
> +		-k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
>  	grep -q -E ${branch_search} ${file}
>  	echo "Found kernel branches"
>  else
> @@ -56,8 +68,8 @@ fi
>  ## Test user ##
>  echo "Testing userspace disassembly"
>  perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/null 2>&1
> -perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
> -	-d --stop-sample=2 2> /dev/null > ${file}
> +perf inject --itrace=b -i ${perfdata} -o ${perfdata2}
> +$PYTHON ${script_path} -i ${perfdata2} -d --stop-sample=2 2> /dev/null > ${file}

The perf script command is replaced with perf inject and a Python
command. I learned from the above that we can pass the itrace option to
the Python script.

This is fine with me. I'm just curious why we don't use a single Python
command here.

>  grep -q -E ${branch_search} ${file}
>  echo "Found userspace branches"
>  
> diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/tests/shell/lib/setup_python.sh
> index 2173215a0517..220d9663f81a 100644
> --- a/tools/perf/tests/shell/lib/setup_python.sh
> +++ b/tools/perf/tests/shell/lib/setup_python.sh
> @@ -18,6 +18,10 @@ fi
>  # Set PYTHONPATH to find the in-tree built perf.so first, avoiding system-wide perf.so
>  if [ -n "$PERF_EXEC_PATH" ] && [ -d "$PERF_EXEC_PATH/python" ]; then
>    PYTHONPATH_DIR="$PERF_EXEC_PATH/python"
> +elif [ -n "${BASH_SOURCE[0]}" ] && [ -d "$(dirname "${BASH_SOURCE[0]}")/../../../python" ]; then
> +  PYTHONPATH_DIR="$(dirname "${BASH_SOURCE[0]}")/../../../python"
> +elif [ -d "$(dirname "$0")/../../../python" ]; then
> +  PYTHONPATH_DIR="$(dirname "$0")/../../../python"

Not sure if this is specific to arm-cs-trace-disasm.py. Would this be a
common change?

Thanks,
Leo
