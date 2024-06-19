Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DD6F303;
	Wed, 19 Jun 2024 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782454; cv=none; b=FxwY8ISmQN/8F1hSJsBdyzaroxV0y9rIevBjrFZUVtDNQ/EUxv2cn4i2BWFcKXqsokPfHQcFGNEPaY9BeyFNyijsW9rGfVXX8aw3ldJRRz0aYEx9Q+5Se8FIMHyn8kVGxWXV/r6XyT3lYBth07GsV13F/tQFw1DKrZnijz5YdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782454; c=relaxed/simple;
	bh=9tejraIUJb+cdOSvaUxsOHBh1IKP8D5VLyBuPPgYVxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1yrENtGb5F6wkbFiMzUB98HQt9pliepuvWpoMV0UGjc+Op1PHu2KCaKkC7VsBcQPWKVi/yUa6Ldy6HVpZFOc7TLzT4HHOATveeizGVfdWIgGD3f8aTF2IXvPe+bfhsstApNJFKJkfIZM2HVMmSCRmav+CVb0CXkexh8fwRVQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gN4sPz7H; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gN4sPz7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718782453; x=1750318453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9tejraIUJb+cdOSvaUxsOHBh1IKP8D5VLyBuPPgYVxk=;
  b=gN4sPz7HkqjC1RNiyoU2rE//AeOICoHSYNrzSnlE4XQJ7sufhxXFlo75
   nCmgWX29vi/S+6qKqemPMWxBuEHQ4jwVNLkEyT3AjkWRmTZEMNmBR76k0
   HweNzK+DS3qEJ5bbQoEpUm5J+yUjwqDma4r01XCCEGVpNi5SsidiI/aPA
   e54yPVdNoDYvgzbgJULlPNtQWEV/MNvjmFpOfW4R5mJcHfSBq6SrrY3/n
   nirMo2uL5/kiOqgzp3JUO5nPnfZn/0jOyCBR0Gyc1ypJ4Bbz2sbLvLqMf
   V+2oSQ8WELfwJ734YGJ8I4iukZxH+wQc52cZfhDew3QfIOCnwrtSZ6Bhs
   Q==;
X-CSE-ConnectionGUID: wsaqPF1VQW6/9gIuE4IiqQ==
X-CSE-MsgGUID: DALDzQx/RXuXbNFeGAyBTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26296862"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="26296862"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:31:11 -0700
X-CSE-ConnectionGUID: uymS4pKkQO+12FAUSikYiA==
X-CSE-MsgGUID: MHLfmacYQD+yjcjjWUwGAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="79296841"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:31:06 -0700
Message-ID: <efd9a44d-2b26-4749-bf77-7166e4c5d33d@intel.com>
Date: Wed, 19 Jun 2024 10:31:01 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] tools/perf: Fix the string match for
 "/tmp/perf-$PID.map" files in dso__load
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com,
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240618140354.5765-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240618140354.5765-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/24 17:03, Athira Rajeev wrote:
> Perf test for perf probe of function from different CU fails
> as below:
> 
> 	./perf test -vv "test perf probe of function from different CU"
> 	116: test perf probe of function from different CU:
> 	--- start ---
> 	test child forked, pid 2679
> 	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.Msa7iy89bx/testfile
> 	  Error: Failed to add events.
> 	--- Cleaning up ---
> 	"foo" does not hit any event.
> 	  Error: Failed to delete events.
> 	---- end(-1) ----
> 	116: test perf probe of function from different CU                   : FAILED!
> 
> The test does below to probe function "foo" :
> 
> 	# gcc -g -Og -flto -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.c
> 	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
> 	# gcc -g -Og -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.c
> 	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
> 	# gcc -g -Og -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
> 	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
> 	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
> 
> 	# ./perf probe -x /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile foo
> 	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
> 	   Error: Failed to add events.
> 
> Perf probe fails to find symbol foo in the executable placed in
> /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7
> 
> Simple reproduce:
> 
>  # mktemp -d /tmp/perf-checkXXXXXXXXXX
>    /tmp/perf-checkcWpuLRQI8j
> 
>  # gcc -g -o test test.c
>  # cp test /tmp/perf-checkcWpuLRQI8j/
>  # nm /tmp/perf-checkcWpuLRQI8j/test | grep foo
>    00000000100006bc T foo
> 
>  # ./perf probe -x /tmp/perf-checkcWpuLRQI8j/test foo
>    Failed to find symbol foo in /tmp/perf-checkcWpuLRQI8j/test
>       Error: Failed to add events.
> 
> But it works with any files like /tmp/perf/test. Only for
> patterns with "/tmp/perf-", this fails.
> 
> Further debugging, commit 80d496be89ed ("perf report: Add support
> for profiling JIT generated code") added support for profiling JIT
> generated code. This patch handles dso's of form
> "/tmp/perf-$PID.map" .
> 
> The check used "if (strncmp(self->name, "/tmp/perf-", 10) == 0)"
> to match "/tmp/perf-$PID.map". With this commit, any dso in
> /tmp/perf- folder will be considered separately for processing
> (not only JIT created map files ). Fix this by changing the
> string pattern to check for "/tmp/perf-%d.map". Add a helper
> function is_perf_pid_map_name to do this check.
> 
> With the fix,
> 	# ./perf test "test perf probe of function from different CU"
> 	117: test perf probe of function from different CU                   : Ok
> 
> Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
> v2 -> v3:
> Addressed review comment from Adrian and James.
> Added perf_pid_map_tid to save the tid and modified
> is_perf_pid_map_name to use this internally.
> 
> v1 -> v2:
> Addressed review comments from Adrian.
> Added helper function is_perf_pid_map_name to check
> dso name of form "/tmp/perf-%d.map". Used sscanf
> instead of regex comparison.
> 
>  tools/perf/util/dso.c    | 12 ++++++++++++
>  tools/perf/util/dso.h    |  4 ++++
>  tools/perf/util/symbol.c |  3 ++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index dde706b71da7..2340c4f6d0c2 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1652,3 +1652,15 @@ int dso__strerror_load(struct dso *dso, char *buf, size_t buflen)
>  	scnprintf(buf, buflen, "%s", dso_load__error_str[idx]);
>  	return 0;
>  }
> +
> +bool perf_pid_map_tid(const char *dso_name, int *tid)
> +{
> +	return sscanf(dso_name, "/tmp/perf-%d.map", tid) == 1;
> +}
> +
> +bool is_perf_pid_map_name(const char *dso_name)
> +{
> +	int tid;
> +
> +	return perf_pid_map_tid(dso_name, &tid);
> +}
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index df2c98402af3..d72f3b8c37f6 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -809,4 +809,8 @@ void reset_fd_limit(void);
>  u64 dso__find_global_type(struct dso *dso, u64 addr);
>  u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
>  
> +/* Check if dso name is of format "/tmp/perf-%d.map" */
> +bool perf_pid_map_tid(const char *dso_name, int *tid);
> +bool is_perf_pid_map_name(const char *dso_name);
> +
>  #endif /* __PERF_DSO */
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9e5940b5bc59..aee0a4cfb383 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1799,7 +1799,8 @@ int dso__load(struct dso *dso, struct map *map)
>  	const char *map_path = dso__long_name(dso);
>  
>  	mutex_lock(dso__lock(dso));
> -	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0;
> +	perfmap = is_perf_pid_map_name(map_path);

If intended, the change from dso__name(dso) to dso__long_name(dso)
needs explanation in the commit message

> +
>  	if (perfmap) {
>  		if (dso__nsinfo(dso) &&
>  		    (dso__find_perf_map(newmapname, sizeof(newmapname),

