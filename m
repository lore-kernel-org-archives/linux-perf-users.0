Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF84137764;
	Tue, 25 Jun 2024 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316994; cv=none; b=OB2HpquowOWCIs6DW8rvB0nRmSVArp5SEjtWRcSkOLx8v00LzOY+kWf5Enl33G8OXWjVp6fqcslQW8yLg0U05XkMQftG6YCEMc4SZqjEqncXn/tquoefqnplH7QGbpC6l7tYX0zFrZAVXkpaLoj8eUwdlyZ+QegpT4S7kGHU8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316994; c=relaxed/simple;
	bh=h1KG9pjOD+gw+c5c48eLlcq9j1rbDh8dqvwli2CL5+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBWmpwOc998JVFCd8xRyfzdvNBy9WV0zsp6yMzJWFqDwiSi56OjX0CO22o38Q4mXEhI7S6TxIXeu7vqp1VtOLqLbKu/l6iQn+T81WOCTmaB8HuiRtrDvWhFWb214DWPsVc6ZVyGxaD39nvlpdB1CpTKZsYc2Fy1ePMdLmC6Lnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0oqfWjm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0oqfWjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719316993; x=1750852993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h1KG9pjOD+gw+c5c48eLlcq9j1rbDh8dqvwli2CL5+8=;
  b=H0oqfWjmlZisiEIh6jsbA3SNCJOe2rz3EFe0Kmb6y3vai04gGaTmFy9w
   GrCbpk9CNZ3WHwGfE+1M7IX5uInqfkCJv7T+GoBG3n70fp7DfytqiRLCf
   KxKnud5awvwDPCnRtuSi3Q0LE4e0SYB4bdxJXtCDlEw0Hch3VYuVK9sdK
   GoR6KHZkcDI22EsrwU05RDXw2kYywIsaGZYG91B6mES8iktYy1/GLtmXS
   WR0FidHWt1n4IjCvX87+GmTsc5JoEGRTTRqE6RM/RXaeiWTHN5z6uOHlg
   la7s3c5HrMn73EHkuuD5SlRY/Sk4+pJBXXqa8tDBY2OVvDvnUi3XY6+FO
   w==;
X-CSE-ConnectionGUID: V9JtiP+lQiiw2MkqCzurUQ==
X-CSE-MsgGUID: l4eoIs+ATyK3b2aZcYy60w==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33785104"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="33785104"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 05:03:12 -0700
X-CSE-ConnectionGUID: Fl7H6VkYRwCwXQezshTHBA==
X-CSE-MsgGUID: CL+4CBugRJeEpvzlDHDz4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43734896"
Received: from gcivario-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.191])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 05:03:08 -0700
Message-ID: <536ccca7-278c-4d50-9c24-bf4409cd75dc@intel.com>
Date: Tue, 25 Jun 2024 15:03:03 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/3] tools/perf: Use is_perf_pid_map_name helper
 function to check dso's of pattern /tmp/perf-%d.map
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com,
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240623064850.83720-1-atrajeev@linux.vnet.ibm.com>
 <20240623064850.83720-2-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240623064850.83720-2-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/06/24 09:48, Athira Rajeev wrote:
> commit 80d496be89ed ("perf report: Add support for profiling JIT
> generated code") added support for profiling JIT generated code.
> This patch handles dso's of form "/tmp/perf-$PID.map".
> 
> Some of the references doesn't check exactly for same pattern.
> some uses "if (!strncmp(dso_name, "/tmp/perf-", 10))". Fix
> this by using helper function perf_pid_map_tid and
> is_perf_pid_map_name which looks for proper pattern of
> form: "/tmp/perf-$PID.map" for these checks.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Add a Fixes tag, then

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/dsos.c    | 2 +-
>  tools/perf/util/srcline.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index ab3d0c01dd63..846828ea1f00 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -275,7 +275,7 @@ static void dso__set_basename(struct dso *dso)
>  	char *base, *lname;
>  	int tid;
>  
> -	if (sscanf(dso__long_name(dso), "/tmp/perf-%d.map", &tid) == 1) {
> +	if (perf_pid_map_tid(dso__long_name(dso), &tid)) {
>  		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
>  			return;
>  	} else {
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 9d670d8c1c08..51eb78993fe2 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -39,7 +39,7 @@ static const char *srcline_dso_name(struct dso *dso)
>  	if (dso_name[0] == '[')
>  		return NULL;
>  
> -	if (!strncmp(dso_name, "/tmp/perf-", 10))
> +	if (is_perf_pid_map_name(dso_name))
>  		return NULL;
>  
>  	return dso_name;

