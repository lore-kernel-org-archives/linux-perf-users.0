Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721101D54F7;
	Fri, 20 Jun 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417650; cv=none; b=ewMDxNef4iBYija4hIpAf02vwuKMkcmUWXZSro5LyaNUpI+RANspjkvHkOsnEC39zAFyUyrzMu31ugIAY24yzloZnrX5hRHUPAlmPlT0tl0cJ/gp0quko/2wZ04zjA3neNMotVYFmAlMhcMFWT0ehIA1LeKao2VjP8J5ZlDWslg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417650; c=relaxed/simple;
	bh=+HTW5cIDvo8IAG6aiQYuN48DPa/RWR2A0W293CkQHck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPvOUGSCzxkHz5r2JSMRdRqV1Ak7aqNwfNXhmZd3V9/8ZLx0mugrd3Yfrv26Hw1rN/amP0y/4AnRudbc2vvFVi2ShII9FRrQ39JagUlXKHhIDHOxDEV93YCHKatW5D/6bXENNdHtnQtFGYW4MToJKtd0LfjFthD7b5C1YHwPiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoQZAAEx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoQZAAEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750417649; x=1781953649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+HTW5cIDvo8IAG6aiQYuN48DPa/RWR2A0W293CkQHck=;
  b=QoQZAAEx4K0ITCBgR4mdnBriW6PypdaYwHriwoCJ3wBx+shIHv60Juie
   RZLKvYX2k7y833vGx7o6AupnelynaEGLsbQxCcl1NSlC8VcDATcKKXcDt
   yE9rpoWlMgOza24Pq1CX/q6G7QnKKxymZnrmhCofSPIJxPtiQKikbwQK2
   bEByK/BmA8wQrgIOaTv0U5/0EryRllXCTBwWLroRQ8wxopRWSfa5veeLp
   ey2AYzyN+MwleOt3bhP/7u/AwTru+F8f+p7y/FY8zB9apIWoDKeYoY7AN
   FWzbbpc0cwnyhvviUvfN7KljAuiwzEpraURaeCreL4zSzJCT8aXqT3SQy
   w==;
X-CSE-ConnectionGUID: 9xmWpfFHTd+uizR7IrOPZw==
X-CSE-MsgGUID: GUl470yLQD2YxXiZYAa99w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="64108345"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="64108345"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 04:07:28 -0700
X-CSE-ConnectionGUID: A6lRc777R0WmLxgikMZ64Q==
X-CSE-MsgGUID: yLMctGcSTPWGvLUM2uK/Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="156696525"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 04:07:28 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A090C20B5736;
	Fri, 20 Jun 2025 04:07:25 -0700 (PDT)
Message-ID: <ef72c8cd-5bed-44ce-b950-d64dc1c22baa@linux.intel.com>
Date: Fri, 20 Jun 2025 07:07:24 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu>
 <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com>
 <7e8bb736-3955-c479-99de-e08efb494bdd@maine.edu>
 <8739c2c6-a27c-4ab6-ad74-8b95e258737e@linux.intel.com>
 <c04824b5-5697-1de5-0003-f2c5b73ed006@maine.edu>
 <52656281-ab73-baf7-0a80-ebcbe79dfca2@maine.edu>
 <9aee2b65-e43a-4fcd-a929-a98269621315@linux.intel.com>
 <d12d4300-9926-5e58-6515-a53cb5c7bee0@maine.edu>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <d12d4300-9926-5e58-6515-a53cb5c7bee0@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vince,

On 2025-06-19 4:10 p.m., Vince Weaver wrote:
> On Thu, 19 Jun 2025, Liang, Kan wrote:
> 
>>
>>
>> On 2025-06-19 11:17 a.m., Vince Weaver wrote:
>>> On Wed, 18 Jun 2025, Vince Weaver wrote:
>>>
>>>> On Wed, 18 Jun 2025, Liang, Kan wrote:
>>>>
>>>>> No, the error message doesn't say it. Just want to check if you have
>>>>> extra information. Because the Topdown perf metrics is only supported on
>>>>> p-core. I want to understand whether the code messes up with e-core.
>>>>
>>>> I can't easily tell from the fuzzer as it intentionally switches cores 
>>>> often.  I guess I could patch the kernel to report CPU when the WRMSR 
>>>> error triggers.
>>>
>>> I've patched the kernel to get rid of the warn_once() and added a printk
>>> for smp_processor_id()  (is that what I want to print?)  In any case that 
>>> reports the warning is happening on CPU1 which is actually a P core, not 
>>> an atom core.
>>
>> Thanks for the confirmation.
>> I've tried fuzzer in some newer machines (later than raptor-lake), but I
>> haven't reproduce it yet. I will try to find a raptor-lake for more tests.
> 
> I've managed to use the perf_fuzzer tools to create a small reproducible 
> test case that can trigger the bug.  It's included below.

Thanks very much for the reproducer! The issue has been root-caused.
I've sent a patch to fix it. Please give it a try.
https://lore.kernel.org/lkml/20250620110406.3782402-1-kan.liang@linux.intel.com/

Thanks,
Kan>
> Vince
> 
> ---
> 
> 
> /* WRMSR top-down reproducer */
> /* by Vince Weaver <vincent.weaver _at_ maine.edu> */
> 
> #define _GNU_SOURCE 1
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <string.h>
> #include <signal.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/ioctl.h>
> #include <sys/prctl.h>
> #include <sys/wait.h>
> #include <poll.h>
> #include <linux/hw_breakpoint.h>
> #include <linux/perf_event.h>
> #include <sched.h>
> 
> static int fd[1024];
> static struct perf_event_attr pe[1024];
> 
> FILE *fff;
> static int result;
> 
> int perf_event_open(struct perf_event_attr *hw_event_uptr,
> 	pid_t pid, int cpu, int group_fd, unsigned long flags) {
> 
> 	return syscall(__NR_perf_event_open,hw_event_uptr, pid, cpu,
> 		group_fd, flags);
> }
> 
> int main(int argc, char **argv) {
> 
> 	int i;
> 	for(i=0;i<1024;i++) fd[i]=-1;
> 
> /* 1 */
> /* fd = 72 */
> 
> 	memset(&pe[72],0,sizeof(struct perf_event_attr));
> 	pe[72].type=PERF_TYPE_RAW;
> 	pe[72].config=0xffff880000008000ULL;
> 	pe[72].sample_freq=0x49ULL;
> 	pe[72].sample_type=PERF_SAMPLE_TID|PERF_SAMPLE_ADDR|PERF_SAMPLE_READ|PERF_SAMPLE_CPU; /* 9a */
> 	pe[72].read_format=PERF_FORMAT_ID|PERF_FORMAT_GROUP|0x10ULL; /* 1c */
> 	pe[72].exclude_user=1;
> 	pe[72].exclude_kernel=1;
> 	pe[72].mmap=1;
> 	pe[72].comm=1;
> 	pe[72].freq=1;
> 	pe[72].enable_on_exec=1;
> 	pe[72].watermark=1;
> 	pe[72].precise_ip=1; /* constant skid */
> 	pe[72].sample_id_all=1;
> 	pe[72].exclude_callchain_user=1;
> 	pe[72].comm_exec=1;
> 	pe[72].wakeup_watermark=-1970634752;
> 	pe[72].bp_type=HW_BREAKPOINT_R|HW_BREAKPOINT_W; /*3*/
> 	pe[72].bp_addr=0x0ULL;
> 	pe[72].bp_len=0x2ULL;
> 	pe[72].branch_sample_type=PERF_SAMPLE_BRANCH_HV|PERF_SAMPLE_BRANCH_ANY|PERF_SAMPLE_BRANCH_ANY_CALL|PERF_SAMPLE_BRANCH_ANY_RETURN|PERF_SAMPLE_BRANCH_IND_JUMP|PERF_SAMPLE_BRANCH_ABORT_TX|PERF_SAMPLE_BRANCH_COND|0xbcbcbca800ULL;
> 	pe[72].sample_regs_user=4294967253ULL;
> 	pe[72].sample_stack_user=0x23008000;
> 
> 	fd[72]=perf_event_open(&pe[72],
> 				0, /* current thread */
> 				1, /* Only cpu 1 */
> 				fd[114], /* 114 is group leader */
> 				PERF_FLAG_FD_NO_GROUP /*1*/ );
> 
> 
> /* 2 */
> 	prctl(PR_TASK_PERF_EVENTS_DISABLE);
> /* 3 */
> // a 0 1 1
> // which=0,num=1,cpi=1
> 
> #define MAX_CPUS 1024
> 
> 	pid_t pid=0;    /* current thread */
>         static cpu_set_t *cpu_mask;
>         int max_cpus=MAX_CPUS;
>         size_t set_size;
> 
> 	cpu_mask=CPU_ALLOC(max_cpus);
> 	set_size=CPU_ALLOC_SIZE(max_cpus);
> 
> 
> 	CPU_ZERO_S(set_size,cpu_mask);
> 	CPU_SET_S(1,set_size,cpu_mask);
> 
> 	result=sched_setaffinity(pid,max_cpus,cpu_mask);
> 
> /* 4 */
> 	prctl(PR_TASK_PERF_EVENTS_ENABLE);
> /* 5 */
> /* fd = 38 */
> 
> 	memset(&pe[38],0,sizeof(struct perf_event_attr));
> 	pe[38].type=PERF_TYPE_HARDWARE;
> 	pe[38].size=112;
> 	pe[38].config=PERF_COUNT_HW_BRANCH_MISSES;
> 	pe[38].sample_type=0; /* 0 */
> 	pe[38].read_format=PERF_FORMAT_ID|PERF_FORMAT_GROUP|0x10ULL; /* 1c */
> 	pe[38].disabled=1;
> 	pe[38].precise_ip=0; /* arbitrary skid */
> 	pe[38].wakeup_events=0;
> 	pe[38].bp_type=HW_BREAKPOINT_EMPTY;
> 
> 	fd[38]=perf_event_open(&pe[38],
> 				getpid(), /* current thread */
> 				22, /* Only cpu 22 */
> 				-1, /* New Group Leader */
> 				PERF_FLAG_FD_NO_GROUP /*1*/ );
> 
> 
> 
> 
> 	/* Replayed 4 syscalls */
> 	return 0;
> }
> 

