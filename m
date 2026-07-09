Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419AA3EBF13;
	Thu,  9 Jul 2026 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587857; cv=none; b=aQYwKW2WVja3hF4NdtUzybG3iVhJtNeBe+vUkBZZykzJ2ejgwdP1N6pDDZ5sPnkC+HiFwMbcC9KWfMy5RDvcSzsSHxNix6MpO96+0mgdlAgZaasfa2wo5UYraikztnjrcZMHF+m+DTatKPUFtWRBjMXIGWoO+r+A3dOjlTUM3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587857; c=relaxed/simple;
	bh=cwDXyfRyi2yVYLK6uOkGnDGkTf5g4+GjzKkoU94fd2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtFJ3lc++K8qcl3AN0j46PE2nMAgshYHITWmd0UlDvTYT2H56zUq6W3CwMhtQwqNxw9ZZTae2VaULgf/ngjKZpgzQbSyZxosnZV9hLFJe2EZlkJA8T2Jnki+g3OOlcGGUFT8e/s8bsioWALCkEFF4iNvQJ30/wsCtg90y++Mm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boFSyBf+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boFSyBf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783587856; x=1815123856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cwDXyfRyi2yVYLK6uOkGnDGkTf5g4+GjzKkoU94fd2c=;
  b=boFSyBf+/n31uD7k5lRWgcqE3M+2eyd4TNrVBOiJ4e37qImronkRat3U
   qTXFWBcOKW0fMTit4obRVUhAIxh/uauvweTZyfeOTgk1lWFedRcPRq18A
   6CS/RsC8coCDkRm0oqlxvIYmvNB5z3G6+lP1GnK+POPT2SpKSy2rDc+pZ
   xI79sCB2+0zVvon8ep05YCFRTJNIS6a32p6XAeKRBN+jpIVdqvYn+z7eP
   SsIqtNbGzg5ynIyzH2jIq44kRXEQ5pUvv1Qn3pBlnJsIxEiRHRs+SVDRT
   RPzIRG/tgJ9hPWvWwdcUZMMEabT1Et8NJs5kxBAHgMOa1Pv24i61j0uia
   g==;
X-CSE-ConnectionGUID: 5/Q7+MrGT66ET+RmWpg/4w==
X-CSE-MsgGUID: uH/SrWDCQK+e1r2JwbTmWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84120044"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84120044"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:04:15 -0700
X-CSE-ConnectionGUID: SyNm9DffSX+COb1qXsQ/sw==
X-CSE-MsgGUID: kQQa/vd3TC+ySgoBEDuLDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255186024"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:04:14 -0700
Message-ID: <56069e78-7006-4569-add0-6ccdf88c746b@linux.intel.com>
Date: Thu, 9 Jul 2026 17:04:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:perf/core] [perf/core] 166f10836a:
 perf-sanity-tests.Object_code_reading.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linux-perf-users@vger.kernel.org
References: <202607091054.7c96d6c6-lkp@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <202607091054.7c96d6c6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

It looks the direct reason causing the test case failure is the "0" sampled
IP. This is expected. The commit 166f10836a653dfa280d4335603b52f685b8b1ef
("perf/core: Fix kernel register info leak via hardware skid") mitigates a
security hole and may lead to the sampled IP could be 0. 

What user right is used to run this command, root or normal user? If it's a
root user, suppose it should not generate such kind of error. Could you
please add "-vvv" option and rerun this test? The "-vvv" option would print
more  verbose log.

Thanks!

-Dapeng


On 7/9/2026 12:36 PM, kernel test robot wrote:
>
> Hello,
>
> kernel test robot noticed "perf-sanity-tests.Object_code_reading.fail" on:
>
> commit: 166f10836a653dfa280d4335603b52f685b8b1ef ("perf/core: Fix kernel register info leak via hardware skid")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core
>
>
> in testcase: perf-sanity-tests
> version: 
> with following parameters:
>
> 	perf_compiler: clang
> 	group: group-00
>
>
>
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-14
> test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202607091054.7c96d6c6-lkp@intel.com
>
>
> 2026-07-07 00:10:32 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -v
>  23: Object code reading                                 : Running (1 active)
> ---- start ----
> ...
> Bytes read match those read by objdump
> Reading object code for memory address: 0x7feb8f2134fa
> File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
> On file address is: 0x204fa
> Objdump command is: objdump -z -d --start-address=0x204fa --stop-address=0x2057a /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
> Bytes read match those read by objdump
> Reading object code for memory address: 0
> thread__find_map failed
> ---- end(-1) ----
>  23: Object code reading                                 : FAILED!
>
> === Test Summary ===
> Passed main tests : 0
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 1
> List of failed tests:
>    23: Object code reading
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260709/202607091054.7c96d6c6-lkp@intel.com
>
>
>
