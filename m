Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BB2D73A0;
	Fri, 17 Apr 2026 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406676; cv=none; b=slxj/4eIWRKi8c4SE3poGYKfJA8nYsQGj7HB4g/VK/0JnsEObzpGkGkyzIB7lZ08MaRpXLJvZR6iQW6npO8eo9MfS+rrAP4IJdP3nZt8LUglU8j4J8mMgMCX15RpY0NlZgCWXpNc4j3To6XOJqzkKZg0Ct4ywtkBQz99GmeIxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406676; c=relaxed/simple;
	bh=uO/lJ//U7kXZ1IFldsdT5KRdj+2XQ8peZcRIbI9Gstc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PAiSZtUZhaTT+JUEetxXNWVOULmztFFoY1FfV+2+fCbwIRbCJlEGZQ/le8tnJQ3ahfcZ/esxP3yvewm++x3mtbO0VhLLLfyvSPMIg1tZK9Pgm1irI7BfuQ5Q7f2MZGoWY3gh4PRFtNU6K+ZxWV+QWMeLjcwpDm2C8Dj2zJT3mn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DRSC9I4a; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DRSC9I4a"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vSnJsJOeCgcCgm2gAmOfdh0JncsYtTj/1lIO/Mqol8c=;
	b=DRSC9I4aLYTX6sTgOdxZLbeJAYsqwDIMjF04daOh+Il4DapmNFVFGalsvejReZaN6HaQIbWSQ
	GgTmXmM7HkN/T7Mui+N5tXGKXBmw/s9dkkoGD7WhW59R91EI7UFezAj+0FvrgJu/yEHGuItaj5n
	KWAH8KshHXnSXVWFe/uGLJI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fxkzQ04GqzmV66;
	Fri, 17 Apr 2026 14:11:30 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id EBA3340561;
	Fri, 17 Apr 2026 14:17:50 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 14:17:50 +0800
Message-ID: <932f808a-947f-48af-a9aa-ce200b76dd64@huawei.com>
Date: Fri, 17 Apr 2026 14:17:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [perf tools] 74e2dbe7be:
 RIP:cpuidle_enter_state
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <202604161630.4fec10e1-lkp@intel.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <202604161630.4fec10e1-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/4/16 16:24:37, kernel test robot <oliver.sang@intel.com> wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "RIP:cpuidle_enter_state" on:
> 
> commit: 74e2dbe7be5037a5e5eed6bc1ad562747ac88566 ("perf tools: Add --pmu-filter option for filtering PMUs")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979]
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
> test machine: 20 threads 1 sockets (Commet Lake) with 16G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202604161630.4fec10e1-lkp@intel.com
> 
> 
> 
> kern  :warn  : [  447.822940] [     C15]  common_interrupt (kbuild/src/consumer/arch/x86/kernel/irq.c:326 (discriminator 35))
> kern  :warn  : [  447.822946] [     C15]  </IRQ>
> kern  :warn  : [  447.822947] [     C15]  <TASK>
> kern  :warn  : [  447.822949] [     C15]  asm_common_interrupt (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:569)
> kern  :warn  : [  447.822953] [     C15] RIP: 0010:cpuidle_enter_state (kbuild/src/consumer/drivers/cpuidle/cpuidle.c:294)
> kern  :warn  : [  447.822957] [     C15] Code: ff 8b 73 04 bf ff ff ff ff 49 89 c6 e8 de 28 94 ff 31 ff e8 17 25 67 fe 45 84 ff 0f 85 34 01 00 00 e8 49 c0 86 fe fb 45 85 e4 <0f> 88 0e 01 00 00 4d 63 fc 4c 89 f7 4b 8d 04 7f 49 8d 04 87 4c 8d
> All code
> ========
>     0:	ff 8b 73 04 bf ff    	decl   -0x40fb8d(%rbx)
>     6:	ff                   	(bad)
>     7:	ff                   	(bad)
>     8:	ff 49 89             	decl   -0x77(%rcx)
>     b:	c6                   	(bad)
>     c:	e8 de 28 94 ff       	call   0xffffffffff9428ef
>    11:	31 ff                	xor    %edi,%edi
>    13:	e8 17 25 67 fe       	call   0xfffffffffe67252f
>    18:	45 84 ff             	test   %r15b,%r15b
>    1b:	0f 85 34 01 00 00    	jne    0x155
>    21:	e8 49 c0 86 fe       	call   0xfffffffffe86c06f
>    26:	fb                   	sti
>    27:	45 85 e4             	test   %r12d,%r12d
>    2a:*	0f 88 0e 01 00 00    	js     0x13e		<-- trapping instruction
>    30:	4d 63 fc             	movslq %r12d,%r15
>    33:	4c 89 f7             	mov    %r14,%rdi
>    36:	4b 8d 04 7f          	lea    (%r15,%r15,2),%rax
>    3a:	49 8d 04 87          	lea    (%r15,%rax,4),%rax
>    3e:	4c                   	rex.WR
>    3f:	8d                   	.byte 0x8d
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 88 0e 01 00 00    	js     0x114
>     6:	4d 63 fc             	movslq %r12d,%r15
>     9:	4c 89 f7             	mov    %r14,%rdi
>     c:	4b 8d 04 7f          	lea    (%r15,%r15,2),%rax
>    10:	49 8d 04 87          	lea    (%r15,%rax,4),%rax
>    14:	4c                   	rex.WR
>    15:	8d                   	.byte 0x8d
> kern  :warn  : [  447.822960] [     C15] RSP: 0018:ffff8881014e7d90 EFLAGS: 00000206
> kern  :warn  : [  447.822964] [     C15] RAX: 000000000068479b RBX: ffffe8ffffb81580 RCX: 0000000000000000
> kern  :warn  : [  447.822966] [     C15] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff82e3d547
> kern  :warn  : [  447.822968] [     C15] RBP: ffffffff85570820 R08: 0000000000000001 R09: 0000000000000000
> kern  :warn  : [  447.822970] [     C15] R10: ffffffff85a9b6a7 R11: 0000000000000000 R12: 0000000000000003
> kern  :warn  : [  447.822972] [     C15] R13: 0000000000000003 R14: 0000006843e122ac R15: 0000000000000000
> kern  :warn  : [  447.822980] [     C15]  ? cpuidle_enter_state (kbuild/src/consumer/arch/x86/include/asm/irqflags.h:42 kbuild/src/consumer/arch/x86/include/asm/irqflags.h:119 kbuild/src/consumer/drivers/cpuidle/cpuidle.c:292)
> kern  :warn  : [  447.822989] [     C15]  cpuidle_enter (kbuild/src/consumer/drivers/cpuidle/cpuidle.c:393 (discriminator 2))
> kern  :warn  : [  447.822995] [     C15]  cpuidle_idle_call (kbuild/src/consumer/kernel/sched/idle.c:161 kbuild/src/consumer/kernel/sched/idle.c:237)
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260416/202604161630.4fec10e1-lkp@intel.com
> 
> 
> 
Hello，
This kernel warning (irq 26 nobody cared) appears to be unrelated to my
perf userspace patch. It comes from the tps6598x Type-C controller
driver, which is likely a hardware or driver issue on the test machine.
All perf test cases passed successfully.
Please consider this as pre-existing test environment noise.

-- 
Thanks,
Qinxin

