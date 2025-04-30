Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1C214232;
	Wed, 30 Apr 2025 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746056077; cv=none; b=WjqIZDxPvRAPjFR3ZfZLJZsi029RaO8vqEOHr84wdzptxgklbY/yubZdRg60xBq7Sx7jbk4eNsBFeClkeYIQ3XRZ7NLo0g3INTKpPjoGUf+u4IKfL+BIWusKTXlaxPFDw+ukZ9USvXLWCliANI+h2uxGtlQNvqhcaPxJnBQQFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746056077; c=relaxed/simple;
	bh=t2o8/vITjJ4c0EvOAK4tHPIZKFznT3jfoyWLhCY3ngM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mF0n9Mxr3Zp7J5uzEBh8APC/pRc7lRSuoR9hi/7DxH4fK6JqOYeTrdnVtWVAItz379M4dyEKdVvR3sKiGqf167OajFAlyplwHfv45/pcocfBNWAzRWe39hO0N+aorv+bOPw7AIbK6kXrrS31cd289DfB7I10sPbrWAGlFFAppS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIp1kfbK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIp1kfbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46DEC4CEE7;
	Wed, 30 Apr 2025 23:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746056077;
	bh=t2o8/vITjJ4c0EvOAK4tHPIZKFznT3jfoyWLhCY3ngM=;
	h=Date:From:To:Cc:Subject:From;
	b=fIp1kfbKF9BKWNHJomJ0IMnsnPkWGCnKRhJiBKmXRIEczCtPSs/+s1S9OfDTp26BE
	 SP3BbtLDlPDikUaCFdn6QSeEkt0bdE70+4XBe1DaP3CvVtb9vOQrp/yd/Bdh/yU8A8
	 sVntpiidVgsfybfU3J/L8OvcS8MlVe467hV1N9RJyfafposHiQq5h7t38yyVj8R67G
	 0sPNRiKnU5NDdXIJGZ2h7dvIaIM9+rkntlNB3/H8GBjTqESFIyh3z8n6Y0W4LS8aSu
	 kXEVQb9IttEnZsLeGGaCHp1z8UASUPScqu1ECjuUYv69R625o5pIvkBFj1IB/YxGf+
	 vFZayjFs/MdpA==
Date: Wed, 30 Apr 2025 20:34:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Joe Mario <jmario@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: DW_AT_comp_dir and O= usage not working with objdump -dS, perf
 probe, etc
Message-ID: <aBKziq9dr_EsWLuZ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

	I noticed recently while testing some other patches that
disassembling with objdump -dS didn't work when building the kernel with
O= as it sets it to the build dir, not to where the sources are, for
instance:

Make sure perf uses objdump to disassembly:

root@number:~# rm -f ~/.perfconfig 
root@number:~# perf config annotate.disassemblers=objdump
root@number:~# perf record -a sleep 5 
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.012 MB perf.data (6307 samples) ]
root@number:~# pahole --running_kernel_vmlinux
/lib/modules/6.15.0-rc4+/build/vmlinux
root@number:~# readelf -wi /lib/modules/6.15.0-rc4+/build/vmlinux | grep -m1 DW_AT_comp_dir
    <17>   DW_AT_comp_dir    : (indirect line string, offset: 0): /home/acme/git/build/v6.15.0-rc4+
root@number:~# 

root@number:~# readelf -wi /lib/modules/6.15.0-rc4+/build/vmlinux | grep -m1 DW_AT_comp_dir
    <17>   DW_AT_comp_dir    : (indirect line string, offset: 0): /home/acme/git/build/v6.15.0-rc4+
root@number:~# perf report | grep -v ^# | head -10
    16.53%  swapper          [kernel.kallsyms]                  [k] poll_idle
    11.21%  swapper          [kernel.kallsyms]                  [k] acpi_os_read_port
     1.39%  swapper          [kernel.kallsyms]                  [k] io_idle
     0.92%  swapper          [kernel.kallsyms]                  [k] switch_mm_irqs_off
     0.87%  swapper          [kernel.kallsyms]                  [k] __update_load_avg_cfs_rq
     0.84%  swapper          [kernel.kallsyms]                  [k] read_tsc
     0.76%  swapper          [kernel.kallsyms]                  [k] psi_group_change
     0.76%  swapper          [kernel.kallsyms]                  [k] menu_select
     0.67%  swapper          [kernel.kallsyms]                  [k] native_sched_clock
     0.53%  Isolated Web Co  libxul.so                          [.] mozilla::EventListenerManager::AddEventListenerInternal(mozilla::dom::CallbackObjectHolder<mozilla::dom::EventListener, nsIDOMEventListener>, mozilla::EventMessage, nsAtom*, mozilla::EventListenerFlags const&, bool, bool, mozilla::dom::AbortSignal*)
root@number:~#
root@number:~# perf probe -L icmp_rcv
Failed to find source file path.
  Error: Failed to show lines.
root@number:~# perf probe -v -L icmp_rcv
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/6.15.0-rc4+/build/vmlinux for symbols
Open Debuginfo file: /lib/modules/6.15.0-rc4+/build/vmlinux
fname: net/ipv4/icmp.c, lineno:1198
New line range: 1198 to 2147483647
path: net/ipv4/icmp.c
Search /home/acme/git/build/v6.15.0-rc4+/net/ipv4/icmp.c from debuginfod -> -2
Failed to find /home/acme/git/build/v6.15.0-rc4+/net/ipv4/icmp.c in debuginfod (d391f0e79126801bc8a8f907e763de7979941712)
Failed to find source file path.
  Error: Failed to show lines. Reason: No such file or directory (Code: -2)
root@number:~#

In 'perf probe' we have the old --source that allows us to override that
DW_AT_comp_dir pointing to the build dir (O= one) and then it works:

root@number:~# perf probe --source /home/acme/git/linux/ -L icmp_rcv | head -20
<icmp_rcv@/home/acme/git/linux//net/ipv4/icmp.c:0>
      0  int icmp_rcv(struct sk_buff *skb)
         {
      2  	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
         	struct rtable *rt = skb_rtable(skb);
         	struct net *net = dev_net_rcu(rt->dst.dev);
         	struct icmphdr *icmph;
         
         	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
      8  		struct sec_path *sp = skb_sec_path(skb);
      9  		int nh;
         
         		if (!(sp && sp->xvec[sp->len - 1]->props.flags &
         				 XFRM_STATE_ICMP)) {
         			reason = SKB_DROP_REASON_XFRM_POLICY;
         			goto drop;
         		}
         
     17  		if (!pskb_may_pull(skb, sizeof(*icmph) + sizeof(struct iphdr)))
         			goto drop;
root@number:~#

But objdump has no override and thus doesn't work:

root@number:~# objdump --disassemble=icmp_rcv -S /lib/modules/6.15.0-rc4+/build/vmlinux | head -40

/lib/modules/6.15.0-rc4+/build/vmlinux:     file format elf64-x86-64


Disassembly of section .text:

ffffffff8231a6f0 <icmp_rcv>:
ffffffff8231a6f0:	f3 0f 1e fa          	endbr64
ffffffff8231a6f4:	e8 97 bf 05 ff       	call   ffffffff81376690 <__fentry__>
ffffffff8231a6f9:	41 56                	push   %r14
ffffffff8231a6fb:	31 f6                	xor    %esi,%esi
ffffffff8231a6fd:	41 54                	push   %r12
ffffffff8231a6ff:	55                   	push   %rbp
ffffffff8231a700:	53                   	push   %rbx
ffffffff8231a701:	48 89 fb             	mov    %rdi,%rbx
ffffffff8231a704:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8231a708:	48 8b 6f 58          	mov    0x58(%rdi),%rbp
ffffffff8231a70c:	48 83 e5 fe          	and    $0xfffffffffffffffe,%rbp
ffffffff8231a710:	48 8b 45 00          	mov    0x0(%rbp),%rax
ffffffff8231a714:	4c 8b a0 08 01 00 00 	mov    0x108(%rax),%r12
ffffffff8231a71b:	e8 d0 e4 ff ff       	call   ffffffff82318bf0 <__xfrm_policy_check2.constprop.0>
ffffffff8231a720:	85 c0                	test   %eax,%eax
ffffffff8231a722:	0f 85 c9 00 00 00    	jne    ffffffff8231a7f1 <icmp_rcv+0x101>
ffffffff8231a728:	f6 43 7f 02          	testb  $0x2,0x7f(%rbx)
ffffffff8231a72c:	0f 84 bc 01 00 00    	je     ffffffff8231a8ee <icmp_rcv+0x1fe>
ffffffff8231a732:	48 8b 83 e0 00 00 00 	mov    0xe0(%rbx),%rax
ffffffff8231a739:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffffffff8231a73d:	c1 e2 03             	shl    $0x3,%edx
ffffffff8231a740:	48 63 d2             	movslq %edx,%rdx
ffffffff8231a743:	48 01 c2             	add    %rax,%rdx
ffffffff8231a746:	0f 84 a2 01 00 00    	je     ffffffff8231a8ee <icmp_rcv+0x1fe>
ffffffff8231a74c:	8b 02                	mov    (%rdx),%eax
ffffffff8231a74e:	83 e8 01             	sub    $0x1,%eax
ffffffff8231a751:	48 98                	cltq
ffffffff8231a753:	48 83 f8 06          	cmp    $0x6,%rax
ffffffff8231a757:	0f 83 3b 03 00 00    	jae    ffffffff8231aa98 <icmp_rcv+0x3a8>
ffffffff8231a75d:	48 8b 44 c2 10       	mov    0x10(%rdx,%rax,8),%rax
ffffffff8231a762:	f6 80 01 01 00 00 10 	testb  $0x10,0x101(%rax)
ffffffff8231a769:	0f 84 7f 01 00 00    	je     ffffffff8231a8ee <icmp_rcv+0x1fe>
ffffffff8231a76f:	8b 53 70             	mov    0x70(%rbx),%edx
root@number:~#

I haven't checked, ran out of time today, but I think this may be
involved:

commit 97282e6d380db8a07120fe1b794ac969ee4a3b5c
Author: Thomas Weiﬂschuh <linux@weissschuh.net>
Date:   Sat Mar 22 10:03:16 2025 +0100

    x86: drop unnecessary prefix map configuration

wdyt?

I'll continue tomorrow,

Cheers,

- Arnaldo
