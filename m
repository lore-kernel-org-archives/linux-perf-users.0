Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD911CBD;
	Sun, 16 Jun 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718550215; cv=none; b=DAfkS4poMdAR3zuBJQ5JKdq/LPjtbQM7NaWCqfpRFXESm6lcggFMDR73DeXRFC8fctu8+TBVkXzl4BV5e71AwWQefp61WzipKrvS8lVVmC/JKCHrZJyVNCzAgRGo8oNJ+H+GW2q2F2BCIy3jaXz+Z/2s/mNCI72ouLQNsm4igb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718550215; c=relaxed/simple;
	bh=RWheu7VAcDlHrib9HA+6p1vteQzNNj1dxDCy688RrHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERtYE15+lfIy9wCfvwCTnimHPQKvyAImLze8YfFUMCavb6EXI40kDkUGAc4PSCiwXg4UemrsUvNF4XYJ6dtq4cf8XluvQmLXseViUKxtspM+iwY28UpbqcxQh+B7OIIVBA/d79deHRKhU0KMIjK5AxCHknlzJ3+qMFs6qx9JmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+Bx6Rr8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+Bx6Rr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718550214; x=1750086214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RWheu7VAcDlHrib9HA+6p1vteQzNNj1dxDCy688RrHk=;
  b=Q+Bx6Rr8W0pI3fncQaFRAIcBuSKq05XwSJWjKjCZ5LuJWmMLowV6ylgY
   LmVvYrRqgbIoSwQ9fV/HDrwIQtbCAiyQKAmK7Cz2iuj9268TtTNdSvE3q
   tlP2abCv2FcAUG05lqjSZUyEXuUb5OB54cIs1n+PwVkF08ozM+GHrpQPg
   RYkJCFVZx90RZJiqqYg4y43qj6MYBsyhMZEirwWiVNf7QdCjS2JeVi5pS
   +mJYL8mLjTtYgTfU9f42fWtOCc80KJb5XxSAD4TOEssLT0nRgH03Pz5Wu
   9NGFoaz9j10LiiXJIibtEy/XNCHuJRmkApivDwOtwWl+MDIBOnUfMOJDJ
   w==;
X-CSE-ConnectionGUID: IfY2iVmtQymU9SfV6JI1Hg==
X-CSE-MsgGUID: Yhgc4QGgTde9+y/a1Mw5Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26502453"
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="26502453"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 08:03:33 -0700
X-CSE-ConnectionGUID: M4u5m4CsTUadu4ql+ZHPdg==
X-CSE-MsgGUID: VWZ21rksQNyma9+/+fwpIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="46083612"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 08:03:30 -0700
Message-ID: <802a5260-8d74-4a5e-85fc-c9b86460d4c5@intel.com>
Date: Sun, 16 Jun 2024 18:03:28 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools/perf: Fix parallel-perf python script to
 replace new python syntax ":=" usage
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com,
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240614172742.56976-1-atrajeev@linux.vnet.ibm.com>
 <20240614172742.56976-2-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240614172742.56976-2-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/24 20:27, Athira Rajeev wrote:
> perf test "perf script tests" fails as below in systems
> with python 3.6
> 
> 	File "/home/athira/linux/tools/perf/tests/shell/../../scripts/python/parallel-perf.py", line 442
> 	if line := p.stdout.readline():
>              ^
> 	SyntaxError: invalid syntax
> 	--- Cleaning up ---
> 	---- end(-1) ----
> 	92: perf script tests: FAILED!
> 
> This happens because ":=" is a new syntax that assigns values
> to variables as part of a larger expression. This is introduced
> from python 3.8 and hence fails in setup with python 3.6

According to below python 3.6 is end-of-life

	https://devguide.python.org/versions/

What was still using python 3.6?

> Address this by splitting the large expression and check the
> value in two steps:
> Previous line: if line := p.stdout.readline():
> Current change:
> 	line = p.stdout.readline()
> 	if line:
> 
> With patch
> 
> 	./perf test "perf script tests"
> 	 93: perf script tests:  Ok
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/scripts/python/parallel-perf.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/scripts/python/parallel-perf.py
> index 21f32ec5ed46..be85fd7f6632 100755
> --- a/tools/perf/scripts/python/parallel-perf.py
> +++ b/tools/perf/scripts/python/parallel-perf.py
> @@ -439,7 +439,8 @@ def ProcessCommandOutputLines(cmd, per_cpu, fn, *x):
>  	pat = re.compile(r"\s*\[[0-9]+\]")
>  	p = subprocess.Popen(cmd, stdout=subprocess.PIPE)
>  	while True:
> -		if line := p.stdout.readline():
> +		line = p.stdout.readline()
> +		if line:
>  			line = line.decode("utf-8")
>  			if pat.match(line):
>  				line = line.split()

