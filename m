Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D91137764;
	Tue, 25 Jun 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316950; cv=none; b=euEiQ8zmpm5jm9Gxz8yb8AmjD5F2E4CqeucuZPRh8yHLUrWLl6ldXvw81Akj+6ssVIIDgd6X8pIgqUc7llrqiYCrae895QDtB9CQ4dDV96gHJxKrCeNfYJ+oa5kdQQPby//xtzWUU/MCC9eEZBGho6CHSRKOzsGWLwDy/cDTFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316950; c=relaxed/simple;
	bh=B9l0BIayFtO54fFICK7mPu8xZAkJYHVx2FObwn9vcM8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b1l6z1h+zshGkheJZznzUfQNZ2jUCb3K3scmVTXx7KqAp/EWxwsOSB2RJWd5dgPEeFT/9Tr1mB0+5gyTt4ES6b96F5S9IbSHp9ABW0Y/725r3yBYCgli0P5Dx1uRmtUgNVQQlbmpHEOFDc/OJmX3tW1QWWXhVGaXWmThbHaU3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5lfA1qV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5lfA1qV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719316949; x=1750852949;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=B9l0BIayFtO54fFICK7mPu8xZAkJYHVx2FObwn9vcM8=;
  b=F5lfA1qV3RG0hxb99/oW/4Lu1KmgPGz+qEPMxSOiK7kdTYwEkSo94yVF
   u+N5dynhXrcoY7gJkz+BiNporo/SlmsY8HAHQhby/M5VPqYjA+NjNypuk
   dxkheHHsabD1JGF5121fnjQL1XDj6G6Ta70SZKXHq/Kc6dzDrxzQZxtXq
   wK09migvQaX19awpybVWn1yUFSVRlk7ZYyPRxwdw8yrAfm2dO2Yy9m/1E
   mJ4iEOsCeQwKzaZtPB1E5d4aXwvLHjiokkwD+f487HHgCziGKVm/8uApQ
   UMm55qZ4yBiEEkdXnL48g2SnI9k4ofIVtOu9+/1IJk8C4X710sCoHUS4G
   A==;
X-CSE-ConnectionGUID: Sl/2r9CDS7G7wU/xhFNf+Q==
X-CSE-MsgGUID: Ilo0QdrdTw2ZLozOlomrDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33784979"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="33784979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 05:02:19 -0700
X-CSE-ConnectionGUID: 63BfM6SNScqsG5vTAhBsww==
X-CSE-MsgGUID: yh+tJ62YRA2xCkNXkbfKtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43734681"
Received: from gcivario-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.191])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 05:02:15 -0700
Message-ID: <f65ff3cf-1724-45a1-ad88-200d72251042@intel.com>
Date: Tue, 25 Jun 2024 15:02:11 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] tools/perf: Fix the string match for
 "/tmp/perf-$PID.map" files in dso__load
From: Adrian Hunter <adrian.hunter@intel.com>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com,
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240623064850.83720-1-atrajeev@linux.vnet.ibm.com>
 <722cb4bc-89d4-4e03-a80d-ffe05be52c05@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <722cb4bc-89d4-4e03-a80d-ffe05be52c05@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/24 14:57, Adrian Hunter wrote:
> On 23/06/24 09:48, Athira Rajeev wrote:
>> Perf test for perf probe of function from different CU fails
>> as below:
>>
>> 	./perf test -vv "test perf probe of function from different CU"
>> 	116: test perf probe of function from different CU:
>> 	--- start ---
>> 	test child forked, pid 2679
>> 	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.Msa7iy89bx/testfile
>> 	  Error: Failed to add events.
>> 	--- Cleaning up ---
>> 	"foo" does not hit any event.
>> 	  Error: Failed to delete events.
>> 	---- end(-1) ----
>> 	116: test perf probe of function from different CU                   : FAILED!
>>
>> The test does below to probe function "foo" :
>>
>> 	# gcc -g -Og -flto -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.c
>> 	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
>> 	# gcc -g -Og -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.c
>> 	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
>> 	# gcc -g -Og -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
>> 	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
>> 	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
>>
>> 	# ./perf probe -x /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile foo
>> 	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
>> 	   Error: Failed to add events.
>>
>> Perf probe fails to find symbol foo in the executable placed in
>> /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7
>>
>> Simple reproduce:
>>
>>  # mktemp -d /tmp/perf-checkXXXXXXXXXX
>>    /tmp/perf-checkcWpuLRQI8j
>>
>>  # gcc -g -o test test.c
>>  # cp test /tmp/perf-checkcWpuLRQI8j/
>>  # nm /tmp/perf-checkcWpuLRQI8j/test | grep foo
>>    00000000100006bc T foo
>>
>>  # ./perf probe -x /tmp/perf-checkcWpuLRQI8j/test foo
>>    Failed to find symbol foo in /tmp/perf-checkcWpuLRQI8j/test
>>       Error: Failed to add events.
>>
>> But it works with any files like /tmp/perf/test. Only for
>> patterns with "/tmp/perf-", this fails.
>>
>> Further debugging, commit 80d496be89ed ("perf report: Add support
>> for profiling JIT generated code") added support for profiling JIT
>> generated code. This patch handles dso's of form
>> "/tmp/perf-$PID.map" .
>>
>> The check used "if (strncmp(self->name, "/tmp/perf-", 10) == 0)"
>> to match "/tmp/perf-$PID.map". With this commit, any dso in
>> /tmp/perf- folder will be considered separately for processing
>> (not only JIT created map files ). Fix this by changing the
>> string pattern to check for "/tmp/perf-%d.map". Add a helper
>> function is_perf_pid_map_name to do this check. In "struct dso",
>> dso->long_name holds the long name of the dso file. Since the
>> /tmp/perf-$PID.map check uses the complete name, use dso___long_name for
>> the string name.
>>
>> With the fix,
>> 	# ./perf test "test perf probe of function from different CU"
>> 	117: test perf probe of function from different CU                   : Ok
>>
>> Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 

Although it could use a Fixes tag

