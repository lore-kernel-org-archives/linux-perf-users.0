Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9761684B6;
	Mon, 17 Jun 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632768; cv=none; b=a7nI14qgUrj8ifp1YzrD/u0NLBu+N6QRkU34nnaKY7AeJYpATjLXO/CLOcn1MVYjYnA8YU8XNppbcLVYwgatis3PH175Nh7ks2DExvxGwsYcbHErmwmmf/V3IUmIWPHvEu8yQx7iy+an8mlyeuEb5MuicKuH2flUeTw5qWsIwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632768; c=relaxed/simple;
	bh=qdz+/LRXQIV++o3JtvvYR+akKHKW8FT2nKWVuStn+Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6VfEABWlYrzVTkWgcaL+HMqLy0NO4gbKCyZqfTQItrVd0zral5OKABKMjcx64FCVcChlcd0dRQ8ddXcRFGSBZHulBcrGdOB1+LHpakWRE+ssp9dGi88EYx1KqRmQ4P8f/jGYvtJpxlDwP88D39xyDMQ0SwNvGLj3olEoL7itts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76244DA7;
	Mon, 17 Jun 2024 06:59:50 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 284DA3F6A8;
	Mon, 17 Jun 2024 06:59:24 -0700 (PDT)
Message-ID: <30cdabb5-4c36-40c6-a2c0-8059e4afb371@arm.com>
Date: Mon, 17 Jun 2024 14:59:22 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] tools/perf: Use is_perf_pid_map_name helper
 function to check dso's of pattern /tmp/perf-%d.map
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com,
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, acme@kernel.org,
 jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
 namhyung@kernel.org
References: <20240617130332.13427-1-atrajeev@linux.vnet.ibm.com>
 <20240617130332.13427-2-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240617130332.13427-2-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/06/2024 14:03, Athira Rajeev wrote:
> commit 80d496be89ed ("perf report: Add support for profiling JIT
> generated code") added support for profiling JIT generated code.
> This patch handles dso's of form "/tmp/perf-$PID.map".
> 
> Some of the references doesn't check exactly for same pattern.
> some uses "if (!strncmp(dso_name, "/tmp/perf-", 10))". Fix
> this by using helper function is_perf_pid_map_name which looks
> for proper pattern of form: "/tmp/perf-$PID.map" for these checks.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/dsos.c    | 2 +-
>  tools/perf/util/srcline.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index ab3d0c01dd63..23cd02aa701d 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -275,7 +275,7 @@ static void dso__set_basename(struct dso *dso)
>  	char *base, *lname;
>  	int tid;
>  
> -	if (sscanf(dso__long_name(dso), "/tmp/perf-%d.map", &tid) == 1) {
> +	if (is_perf_pid_map_name(dso__long_name(dso))) {
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

Duplicate of [1] but the latest version of the other one looks like it
might have a mistake in it.

For this one I get this compilation error:

util/dsos.c: In function ‘dso__set_basename’:
util/dsos.c:279:21: error: ‘tid’ may be used uninitialized
[-Werror=maybe-uninitialized]
  279 |                 if (asprintf(&base, "[JIT] tid %d", tid) < 0)



[1]:
https://lore.kernel.org/linux-perf-users/20240601125946.1741414-10-ChaitanyaS.Prakash@arm.com/
