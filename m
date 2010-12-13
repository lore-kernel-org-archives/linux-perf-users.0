From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 12:21:59 -0200
Message-ID: <20101213142159.GF5407@ghostprotocols.net>
References: <m2pqtb9ekn.fsf@gmail.com>
 <20101209153548.GA11820@ghostprotocols.net>
 <m2wrnernw3.fsf@gmail.com>
 <20101213125837.GB5407@ghostprotocols.net>
 <m2sjy1stuf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62682 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757797Ab0LMOWH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 09:22:07 -0500
Received: by gyb11 with SMTP id 11so2992853gyb.19
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2010 06:22:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2sjy1stuf.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Em Mon, Dec 13, 2010 at 02:08:56PM +0100, Francis Moreau escreveu:
> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
> > Em Mon, Dec 13, 2010 at 11:02:52AM +0100, Francis Moreau escreveu:
> >> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
> >> > Em Thu, Dec 09, 2010 at 04:00:08PM +0100, Francis Moreau escreveu:
> >> >> I'm trying to use perf-probe(1) with the latest F14 kernel
> >> >> (2.6.35.9-64.fc14.x86_64).
> >> >> I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
> >> >> contains the running vmlinux image AFAICT.
> >> > Can you try using:

> >> > $ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux <rest of the probe definition>

> >> > So that it tries it directly instead of looking into the buildid cache?

> >> Does anybody know where I can report this issue to Fedora community ?

> > Please create a ticket at:

> > http://bugzilla.redhat.com

> Hmm, I don't think that any patches recently posted in response of this
> thread will solve the problem.
> 
> The primarily concern here, is that the running kernel has a different
> build-id than the debug image installed by the corresponding debug
> package.

So? The problem for me is that:

1. looks at /sys/kernel/notes and gets the running kernel build-id
2. fails to locate a vmlinux with a matching build-id
3. ignores the -k specified path
4. The mentioned patch makes it consider the -k specified path

So it should look at the -k specified path and make sure that it has a
matching build-id, if it has, problem solved, no?
 
> I think it's a distrib issue, hence my question about Fedora report.

Well, here I have fedora 14 and:

[root@felicio /]# uname -r
2.6.35.9-64.fc14.x86_64
[root@felicio /]# rpm -qa | grep kernel-debuginfo
kernel-debuginfo-2.6.35.9-64.fc14.x86_64
kernel-debuginfo-common-x86_64-2.6.35.9-64.fc14.x86_64
[root@felicio /]# perf probe -L icmp_rcv
Failed to open net/ipv4/icmp.c: No such file or directory
  Error: Failed to show lines. (-2)
<icmp_rcv:0>
[root@felicio /]# rpm -ql kernel-debuginfo-common-x86_64 | grep net/ipv4/icmp.c
/usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64/net/ipv4/icmp.c
[root@felicio /]# cd /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64/
[root@felicio linux-2.6.35.x86_64]# perf probe -L icmp_rcv | head -30
Source file is shorter than expected.
<icmp_rcv:0>
      0  int icmp_rcv(struct sk_buff *skb)
      1  {
         	struct icmphdr *icmph;
         	struct rtable *rt = skb_rtable(skb);
         	struct net *net = dev_net(rt->u.dst.dev);
         
      6  	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
         		struct sec_path *sp = skb_sec_path(skb);
         		int nh;
         
     10  		if (!(sp && sp->xvec[sp->len - 1]->props.flags &
         				 XFRM_STATE_ICMP))
         			goto drop;
         
     14  		if (!pskb_may_pull(skb, sizeof(*icmph) + sizeof(struct iphdr)))
         			goto drop;
         
         		nh = skb_network_offset(skb);
         		skb_set_network_header(skb, sizeof(*icmph));
         
     20  		if (!xfrm4_policy_check_reverse(NULL, XFRM_POLICY_IN, skb))
         			goto drop;
         
         		skb_set_network_header(skb, nh);
         	}
         
     26  	ICMP_INC_STATS_BH(net, ICMP_MIB_INMSGS);

[root@felicio linux-2.6.35.x86_64]# cat /proc/net/snmp | grep Icmp:
Icmp: InMsgs InErrors InDestUnreachs InTimeExcds InParmProbs InSrcQuenchs InRedirects InEchos InEchoReps InTimestamps InTimestampReps InAddrMasks InAddrMaskReps OutMsgs OutErrors OutDestUnreachs OutTimeExcds OutParmProbs OutSrcQuenchs OutRedirects OutEchos OutEchoReps OutTimestamps OutTimestampReps OutAddrMasks OutAddrMaskReps
Icmp: 4 1 2 0 0 0 0 1 1 0 0 0 0 119 0 116 0 0 0 0 3 0 0 0 0 0
[root@felicio linux-2.6.35.x86_64]# perf probe icmp_rcv:26
Add new event:
  probe:icmp_rcv       (on icmp_rcv:26)

You can now use it on all perf tools, such as:

	perf record -e probe:icmp_rcv -aR sleep 1

[root@felicio linux-2.6.35.x86_64]# perf record -e probe:icmp_rcv -ag
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.535 MB perf.data (~23357 samples) ]

[root@felicio linux-2.6.35.x86_64]# perf report
# Events: 3  cycles
#
# Overhead          Command      Shared Object  Symbol
# ........  ...............  .................  ......
#
    66.67%          swapper  [kernel.kallsyms]  [k] icmp_rcv
                    |
                    --- icmp_rcv
                        ip_local_deliver_finish
                        NF_HOOK.clone.8
                        ip_local_deliver
                        ip_rcv_finish
                        NF_HOOK.clone.8
                        ip_rcv
                        __netif_receive_skb
                        netif_receive_skb
                        napi_skb_finish
                        napi_gro_receive
                        igb_poll
                        net_rx_action
                        __do_softirq
                        call_softirq
                        do_softirq
                        irq_exit
                        do_IRQ
                        common_interrupt
                        default_idle
                        cpu_idle
                        start_secondary

    33.33%              ssh  [kernel.kallsyms]  [k] icmp_rcv
                        |
                        --- icmp_rcv
                            ip_local_deliver_finish
                            NF_HOOK.clone.8
                            ip_local_deliver
                            ip_rcv_finish
                            NF_HOOK.clone.8
                            ip_rcv
                            __netif_receive_skb
                            netif_receive_skb
                            napi_skb_finish
                            napi_gro_receive
                            igb_poll
                            net_rx_action
                            __do_softirq
                            call_softirq
[root@felicio linux-2.6.35.x86_64]#
[root@felicio linux-2.6.35.x86_64]# cat /proc/net/snmp | grep Icmp:
Icmp: InMsgs InErrors InDestUnreachs InTimeExcds InParmProbs InSrcQuenchs InRedirects InEchos InEchoReps InTimestamps InTimestampReps InAddrMasks InAddrMaskReps OutMsgs OutErrors OutDestUnreachs OutTimeExcds OutParmProbs OutSrcQuenchs OutRedirects OutEchos OutEchoReps OutTimestamps OutTimestampReps OutAddrMasks OutAddrMaskReps
Icmp: 7 1 2 0 0 0 0 4 1 0 0 0 0 123 0 117 0 0 0 0 3 3 0 0 0 0
[root@felicio linux-2.6.35.x86_64]#



All seems to work, right?

There are two problems here:

on the 'report' header, as we didn't collect "cycles", but
"probe:icmp_rcv" events, that is another fix that needs to be backported to
fedora, but a minor one.

Also 'perf probe -L' should look use
/usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64 as a prefix to look for
sources.

That can be found using:

[root@felicio linux-2.6.35.x86_64]# readelf -wi /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux | grep DW_AT_comp_dir | head -5
    <2e>   DW_AT_comp_dir    : /usr/src/debug////////kernel-2.6.35.fc14/linux-2.6.35.x86_64	
    <95>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
    <75e8>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
    <900e>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
    <16670>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
[root@felicio linux-2.6.35.x86_64]# 

 <0><8b>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <8c>   DW_AT_producer    : (indirect string, offset: 0x22f4): GNU C 4.5.1 20100924 (Red Hat 4.5.1-4)        
    <90>   DW_AT_language    : 1        (ANSI C)
    <91>   DW_AT_name        : (indirect string, offset: 0x37a): arch/x86/kernel/head64.c       
    <95>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64 
    <99>   DW_AT_low_pc      : 0x0      
    <a1>   DW_AT_entry_pc    : 0x0      
    <a9>   DW_AT_ranges      : 0x340    
    <ad>   DW_AT_stmt_list   : 0x114

I.e. using the DW_AT_comp_dir attribute in the DW_TAG_compile_unit DWARF tags,
Masami?

All this with:

[root@felicio linux-2.6.35.x86_64]# type perf
perf is hashed (/usr/bin/perf)
[root@felicio linux-2.6.35.x86_64]# rpm -qf /usr/bin/perf
perf-2.6.35.9-64.fc14.x86_64
[root@felicio linux-2.6.35.x86_64]# 

I.e. the perf binary shipping in fedora, without the recent patches.

To finish the session:

[root@felicio linux-2.6.35.x86_64]# perf probe --list
  probe:icmp_rcv       (on icmp_rcv:26@ipv4/icmp.c)
[root@felicio linux-2.6.35.x86_64]# perf probe --del icmp_rcv
Remove event: probe:icmp_rcv
[root@felicio linux-2.6.35.x86_64]# perf probe --list
[root@felicio linux-2.6.35.x86_64]# 

And if you run it in verbose mode we can see what was the vmlinux file used:

[root@felicio linux-2.6.35.x86_64]# perf probe -v icmp_rcv:26
probe-definition(0): icmp_rcv:26 
symbol:icmp_rcv file:(null) line:26 offset:0 return:0 lazy:(null)
0 arguments
Looking at the vmlinux_path (6 entries long)
Using /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux for symbols
Try to open /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux
Probe line found: line[571]:999 addr:0xffffffff81416655
Probe point found: icmp_rcv+208
find 1 kprobe_trace_events.
Opening /sys/kernel/debug/tracing/kprobe_events write=1
Add new event:
Writing event: p:probe/icmp_rcv icmp_rcv+208
  probe:icmp_rcv       (on icmp_rcv:26)

You can now use it on all perf tools, such as:

	perf record -e probe:icmp_rcv -aR sleep 1

[root@felicio linux-2.6.35.x86_64]#

It was /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux, that is present on:

[root@felicio linux-2.6.35.x86_64]# rpm -qf /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux
kernel-debuginfo-2.6.35.9-64.fc14.x86_64

And...

[root@felicio linux-2.6.35.x86_64]# perf buildid-list
882b1b53eb1d653200e8fa7100273aa8493896c4 [kernel.kallsyms]

This is the build-id of the running kernel, and:

[root@felicio linux-2.6.35.x86_64]# perf buildid-cache -v --add /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux
Adding 882b1b53eb1d653200e8fa7100273aa8493896c4 /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux: FAIL
/usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux already in the cache
[root@felicio linux-2.6.35.x86_64]# 

The running kernel build-id matches the build-id in the vmlinux file found in
the kernel-debuginfo package.

So can you please give us the versions for the kernel, kernel-debuginfo package?
Perhaps you have a new debuginfo package and is running an older kernel?

Use the perf buildid-list trick to get the build-id in readable format.

Thanks,

- Arnaldo
