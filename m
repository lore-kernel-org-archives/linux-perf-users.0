Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99660FC1D;
	Sun, 16 Jun 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718552229; cv=none; b=UamqiqSGUwG66sHny8sFnbief7MpQCxBYaOxYmPf3mQDj62i2DM2LLLlsLEtrZe+QtSsmJrK00/4qfuVvzBFpnBlaF6ctm9bnCxENS6g3y1Y/NhDDlXraWLtdQVMvEACRT3+aSlgteMQ7/o5iTnpnDG+k7RM3GPgTSVw9CCiqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718552229; c=relaxed/simple;
	bh=grOLrtXokBRxCb602pJ2qqigELqTN7tvSkwUgOFBVHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2hqzxhdxxozP0YSqoeJCCxZUhOmxVHM31PO28LgCAxf2PqILN9pW9uT8Z5fVVfzl4VM6RmYPN2c3OrTZsZ+m9f/W1OPCwhizrAWCciv4UaqXGMq3vpiMhlB7uKcMDb6FCQAA3LOJnrGZboY45K0YRyV1innua1S+viLMv3mVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvNoz0JE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvNoz0JE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718552228; x=1750088228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=grOLrtXokBRxCb602pJ2qqigELqTN7tvSkwUgOFBVHc=;
  b=KvNoz0JEJnWKGTNXTSmRCfYKIWF94F/TTB7cJVtbQTbEPKmn0gEr5s0z
   xFldNIepPmH9Q7SAkboXlgxeu/9EXQluV+1IG9vESQho1ovJMrI0PTIyH
   syJ8PhfCnKXXbc4E//2sDrL/9P7VVvcbucY3C2TGy3aXBsLxxQ4lf7sbV
   JBNgAP9mkjHkZ3bLmZ4GYCe5veADeYdJtMk1tgyTWnSaB4nMkaZZ4OGwi
   9Y+Kj2iWEM/ea3Cy77giWVIfNGHuWvi1J994lnYyvy+to9uY/tf0DQCTj
   bLCjnNy8A2azzSd3NQNvdIS5AtfYnzJBSdfGFd+Cq94StcTNU7IBcO5bg
   A==;
X-CSE-ConnectionGUID: UwO1IabZS6GBr3WsgPWmkQ==
X-CSE-MsgGUID: Re4ydOO3QDeLCo/vJCV+iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19213772"
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="19213772"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 08:37:07 -0700
X-CSE-ConnectionGUID: 7N5rMaRiSTmnktZf+InDXg==
X-CSE-MsgGUID: MCBI5qRfTkqf3EKk0KW+UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="72185210"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 08:37:03 -0700
Message-ID: <5d9a9842-9b8a-428c-898f-e1ff866a6e66@intel.com>
Date: Sun, 16 Jun 2024 18:37:01 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools/perf: Fix the string match for
 "/tmp/perf-$PID.map" files in dso__load
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com,
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240614172742.56976-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240614172742.56976-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/24 20:27, Athira Rajeev wrote:
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
> string pattern to check for regex of form "/tmp/perf-*.map"
> 
> With the fix,
> 	# ./perf test "test perf probe of function from different CU"
> 	117: test perf probe of function from different CU                   : Ok
> 
> Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/symbol.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9e5940b5bc59..bfb88a4b0987 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -41,6 +41,7 @@
>  #include <limits.h>
>  #include <symbol/kallsyms.h>
>  #include <sys/utsname.h>
> +#include <regex.h>
>  
>  static int dso__load_kernel_sym(struct dso *dso, struct map *map);
>  static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
> @@ -1797,9 +1798,18 @@ int dso__load(struct dso *dso, struct map *map)
>  	struct nscookie nsc;
>  	char newmapname[PATH_MAX];
>  	const char *map_path = dso__long_name(dso);
> +	regex_t    regex;
> +	const char *pattern =  "(^/tmp/perf-).*(map)";
>  
>  	mutex_lock(dso__lock(dso));
> -	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0;
> +	if (regcomp(&regex, pattern, REG_EXTENDED)) {
> +		pr_debug("regcomp() failed in dso__load\n");
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	perfmap = !regexec(&regex, dso__name(dso), 0, NULL, 0);

This isn't the only place that checks for that name.  Perhaps
create a helper function:

bool is_perf_pid_map_name(const char *name);

Regex looks over complicated.  Maybe sscanf

	int tid;

	return sscanf(name, "/tmp/perf-%d.map", &tid) == 1;

> +
>  	if (perfmap) {
>  		if (dso__nsinfo(dso) &&
>  		    (dso__find_perf_map(newmapname, sizeof(newmapname),

