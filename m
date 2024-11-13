Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F771FDF92;
	Wed, 13 Nov 2024 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525250; cv=none; b=ssCVh18Ayz9zmMJh3rVkGCG1ZEKsUrInK0JFCcHO4TxK5DdiWx02tVqgxJ95TB0riyWHwYpZjMgpuhLK6oFdORUHR0MQd77mg8KKslO5amb6bE6aCbMRl9m5NSH7YtCC5wgySZxU3G8lbXBMYg+t0yU1hC5PFIyrYeiflwEOJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525250; c=relaxed/simple;
	bh=X0B5BwRo1Ll8jmjISkq3vaqfLRX1I+AaJWZTRqGvuCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdN65NUN4kszszB/R5dOzliqJIkpQibCqoPrAYU5RV4HG8Ga89D/ofQEfYwJM87gI6ChoTPPUvq1ziE4D3sgH1HVDX9iazEMLvLq8/amKkBCZq1c2U9ISSYUz3I3ZqU2ZWOMTay39SMGGRfWyg5YNP20NYnwjneMtvmd8igG5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuJ0Yoti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuJ0Yoti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF507C4CECF;
	Wed, 13 Nov 2024 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731525249;
	bh=X0B5BwRo1Ll8jmjISkq3vaqfLRX1I+AaJWZTRqGvuCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuJ0YotivKJ+VQ4sajW+RO1hALygNjNDHC3Y8mf1OIu61C7E5G/IRhHQjVgcqaOWN
	 3eqM8+kV3c6SFqA1juTw3JORad3Pe271w325D8EYh/OoOhy9xVOfxDe4z7+aLTqNr8
	 4vxoW8kGCRdaf3AaLZTQGN5i8fRjteEGMSn+iU4+WHPwj54X2z1KGFIpoaeEhktyks
	 GkEkq+Axgk4fbAXZXMFCBM2w1j/WM2o5GVgPbtAij3q8DfyQv0cjSIrq0VR+qlrdBz
	 /QsCJiuuLSpCSbeRpE+OIWmrPgG6cWezvX34sHY0uWs8wBG8dzCQd+e69QviOLPxC4
	 PuY3xlLD8ab5A==
Date: Wed, 13 Nov 2024 16:14:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] perf disasm: Allow configuring what disassemblers to
 use
Message-ID: <ZzT6fjDSUlPzUt0U@x1>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-4-acme@kernel.org>
 <CAP-5=fW7teKmRfGtjkvk1=PArt7M-v=CBF2EjdY0SbgdU6DtqQ@mail.gmail.com>
 <ZzI90g83cGIKSUDu@x1>
 <ZzSiEXgijZXkhIoP@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzSiEXgijZXkhIoP@google.com>

On Wed, Nov 13, 2024 at 01:56:49PM +0100, Steinar H. Gunderson wrote:
> On Mon, Nov 11, 2024 at 02:24:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > On my todo list, and here Steinar could help, is to check if we an have
> > source code intermixed with the llvm based disassembler, like we have
> > with the objdump based one.
> 
> I am no LLVM expert; the only time I ever touched it was for perf :-)

Expert enough to get some more LLVM based features in perf ;-)
 
> TBH I'm not entirely sure what functionality this is, though; I don't
> think I've ever gotten perf to list source code for me, ever (in the ~15
> years I've used it).

I mean this:

root@number:~# uname -r
6.11.6-200.fc40.x86_64
root@number:~# rpm -q kernel-debuginfo
package kernel-debuginfo is not installed
root@number:~# rpm -qa | grep kernel-debuginfo
root@number:~# perf probe -L icmp_rcv
<icmp_rcv@/root/.cache/debuginfod_client/365ce5a0ccb899e5b203f81ed386764b3e8a6c2e/source-e181e220-#usr#src#debug#kernel-6.11.6#linux-6.11.6-200.fc40.x86_64#net#ipv4#icmp.c:0>
      0  int icmp_rcv(struct sk_buff *skb)
         {
      2  	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
         	struct rtable *rt = skb_rtable(skb);
         	struct net *net = dev_net(rt->dst.dev);
         	struct icmphdr *icmph;
         
         	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
      8  		struct sec_path *sp = skb_sec_path(skb);
      9  		int nh;
         
         		if (!(sp && sp->xvec[sp->len - 1]->props.flags &
         				 XFRM_STATE_ICMP)) {
         			reason = SKB_DROP_REASON_XFRM_POLICY;
         			goto drop;
         		}
<SNIP>
                /*
                 *      Parse the ICMP message
                 */
         
     73         if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST)) {
                        /*
                         *      RFC 1122: 3.2.2.6 An ICMP_ECHO to broadcast MAY be
                         *        silently ignored (we let user decide with a sysctl).
                         *      RFC 1122: 3.2.2.8 An ICMP_TIMESTAMP MAY be silently
                         *        discarded if to broadcast/multicast.
                         */
     80                 if ((icmph->type == ICMP_ECHO ||
                             icmph->type == ICMP_TIMESTAMP) &&
     82                     READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_broadcasts)) {
                                reason = SKB_DROP_REASON_INVALID_PROTO;
                                goto error;
                        }
     86                 if (icmph->type != ICMP_ECHO &&
                            icmph->type != ICMP_TIMESTAMP &&
                            icmph->type != ICMP_ADDRESS &&
                            icmph->type != ICMP_ADDRESSREPLY) {
                                reason = SKB_DROP_REASON_INVALID_PROTO;
                                goto error;
                        }
                }
<SNIP>

So, source code, automatically obtained from a debuginfod server and
places where one can put a probe.

Also in annotation:

root@number:~# perf record ping -f 127.0.0.1
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
^C 
--- 127.0.0.1 ping statistics ---
552924 packets transmitted, 552924 received, 0% packet loss, time 2192ms
rtt min/avg/max/mdev = 0.001/0.001/0.204/0.000 ms, ipg/ewma 0.003/0.002 ms
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.424 MB perf.data (8509 samples) ]

root@number:~#

root@number:~# perf config annotate.disassemblers=objdump
root@number:~# perf annotate  --stdio2 icmp_rcv | head -20
Samples: 1  of event 'cpu_atom/cycles/P', 4000 Hz, Event count (approx.): 2993537, [percent: local period]
icmp_rcv() /proc/kcore
Percent          
                 
                 
              Disassembly of section load0:
                 
              ffffffffaff60220 <load0>:
                endbr64         
                nop             
                push    %r15    
                xor     %esi,%esi
                push    %r14    
                push    %r13    
                push    %r12    
                push    %rbp    
                push    %rbx    
                mov     %rdi,%rbx
                sub     $0x8,%rsp
                mov     0x58(%rdi),%rbp

No source code, but then its objdump that is running and we don't have
the debuginfo file, i.e. the objdump tool doesn't link with libdebuginfo
to use the debuginfod server, so we need to install the huge
kernel-debuginfo packages:

root@number:~# dnf debuginfo-install kernel

And then it works:

root@number:~# perf annotate  --stdio2 icmp_rcv
Samples: 53  of event 'cpu_core/cycles/P', 4000 Hz, Event count (approx.): 73399213, [percent: local period]
icmp_rcv() /usr/lib/debug/lib/modules/6.11.6-200.fc40.x86_64/vmlinux
Percent          
                 
                 
              Disassembly of section .text:
                 
              ffffffff81f60220 <icmp_rcv>:
                 
              /*          
              *       Deal with incoming ICMP packets.
              */          
              int icmp_rcv(struct sk_buff *skb)
              {           
                endbr64         
              → call    __fentry__
                push    %r15    
              __xfrm_policy_check(sk, ndir, skb, family);
              }           
                 
              static inline int xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb, unsigned short family)
              {           
              return __xfrm_policy_check2(sk, dir, skb, family, 0);
                xor     %esi,%esi
                push    %r14    
                push    %r13    
                push    %r12    
   3.74         push    %rbp    
                push    %rbx    
                mov     %rdi,%rbx
                sub     $0x8,%rsp
              * rcu_read_lock section
              */          
              WARN_ON((skb->_skb_refdst & SKB_DST_NOREF) &&
              !rcu_read_lock_held() &&
              !rcu_read_lock_bh_held());
              return (struct dst_entry *)(skb->_skb_refdst & SKB_DST_PTRMASK);
   3.74         mov     0x58(%rdi),%rbp
                and     $0xfffffffffffffffe,%rbp
              }           
<SKIP some inlines used in icmp_rcv that don't have samples in this perf.data>
             skb_set_network_header(skb, nh);
              }           
                 
              __ICMP_INC_STATS(net, ICMP_MIB_INMSGS);
          f1:   mov     0x1f0(%r13),%rax
   9.35         incq    %gs:0x8(%rax)
              return ((skb->ip_summed == CHECKSUM_UNNECESSARY) ||
                movzbl  0x80(%rbx),%ecx
                 
              if (skb_checksum_simple_validate(skb))
                movzbl  0x83(%rbx),%eax
                mov     %ecx,%edx
                and     $0xfffffffe,%eax
                and     $0x60,%edx
                mov     %al,0x83(%rbx)
              skb->csum_valid ||
                cmp     $0x20,%dl
              ↓ je      2e5     
   1.87         cmp     $0x60,%dl
              ↓ je      2a2     
              if (skb->ip_summed == CHECKSUM_COMPLETE) {
                cmp     $0x40,%dl
              ↓ je      26e     
              skb->csum = psum;
         134:   movl    $0x0,0x8c(%rbx)
              csum = __skb_checksum_complete(skb);
                mov     %rbx,%rdi
   6.59       → call    __skb_checksum_complete
              skb->csum_valid = !csum;
                movzbl  0x83(%rbx),%edx
                test    %ax,%ax 
                sete    %cl     
   5.61         and     $0xfffffffe,%edx
<SKIP some more>

This kind of thing.

> I can give --line-numbers (and optionally --inlines)
> to objdump and then look up the line numbers by hand with an editor,
> but the actual source? Is there some way perf can attribute the samples
> back to individual source code lines the way some other profilers can
> (i.e., showing the source instead of instructions)?

You can show just instructions or instructions + source code.

There were requests but no attempt that I know of of doing just source
code.

Please take a look at 'perf config --help', or directly at tools/perf/Documentation/perf-config.txt
to see what you can configure to govern the annotation process, for
instance:

-------
        annotate.hide_src_code::
                If a program which is analyzed has source code,
                this option lets 'annotate' print a list of assembly code with the source code.
                For example, let's see a part of a program. There're four lines.
                If this option is 'true', they can be printed
                without source code from a program as below.

                │        push   %rbp
                │        mov    %rsp,%rbp
                │        sub    $0x10,%rsp
                │        mov    (%rdi),%rdx

                But if this option is 'false', source code of the part
                can be also printed as below. Default is 'false'.

                │      struct rb_node *rb_next(const struct rb_node *node)
                │      {
                │        push   %rbp
                │        mov    %rsp,%rbp
                │        sub    $0x10,%rsp
                │              struct rb_node *parent;
                │
                │              if (RB_EMPTY_NODE(node))
                │        mov    (%rdi),%rdx
                │              return n;

                This option works with tui, stdio2 browsers.
-------
 
> I would assume that LLVM has some way of outputting line numbers
> (presumably by parsing debug information), since llvm-objdump supports
> --line-numbers, but that's perhaps not what you're asking about?

So, this is the command line that perf hands to objdump:

root@number:~# perf annotate  -vv --stdio2 icmp_rcv  |& grep objdump
Executing: objdump  --start-address=0xffffffff81f60220 --stop-address=0xffffffff81f605cb  -d --no-show-raw-insn -S      -C "$1"
Disassembled with objdump
annotate.disassemblers=objdump

root@number:~# strace -f -s512 -e execve -- perf annotate  -vv --stdio2 icmp_rcv |& grep objdump
[pid 24768] execve("/usr/bin/objdump", ["objdump", "--start-address=0xffffffff81f60220", "--stop-address=0xffffffff81f605cb", "-d", "--no-show-raw-insn", "-S", "-C", "/usr/lib/debug/lib/modules/6.11.6-200.fc40.x86_64/vmlinux"], 0x55efca837c50 /* 39 vars */) = 0
^C
root@number:~#

⬢ [acme@toolbox perf-tools-next]$ objdump --help |& grep -- -S
  -S, --source             Intermix source code with disassembly
      --file-start-context       Include context from start of file (with -S)
      --prefix=PREFIX            Add PREFIX to absolute paths for -S
      --prefix-strip=LEVEL       Strip initial directory names for -S
⬢ [acme@toolbox perf-tools-next]$ objdump --help |& grep -- -S
  -S, --source             Intermix source code with disassembly
      --file-start-context       Include context from start of file (with -S)
      --prefix=PREFIX            Add PREFIX to absolute paths for -S
      --prefix-strip=LEVEL       Strip initial directory names for -S
⬢ [acme@toolbox perf-tools-next]$

And llvm-objdump _has_ it:

⬢ [acme@toolbox perf-tools-next]$ llvm-objdump --help |& grep -- --source
  --source                When disassembling, display source interleaved with the disassembly. Implies --disassemble
  -S                      Alias for --source
⬢ [acme@toolbox perf-tools-next]$

And perf allows to use llvm-objdump in the "objdump" disassembler:

⬢ [acme@toolbox perf-tools-next]$ perf annotate -h objdump

 Usage: perf annotate [<options>]

        --objdump <path>  objdump binary to use for disassembly and annotations

⬢ [acme@toolbox perf-tools-next]$

Also via perf-config:

root@number:~# perf config annotate.objdump=llvm-objdump
root@number:~# cat ~/.perfconfig 
# this file is auto-generated.
[annotate]
	disassemblers = objdump
	objdump = llvm-objdump
root@number:~# 

And it works:

root@number:~# perf annotate --stdio2 icmp_rcv
Samples: 53  of event 'cpu_core/cycles/P', 4000 Hz, Event count (approx.): 73399213, [percent: local period]
icmp_rcv() /usr/lib/debug/lib/modules/6.11.6-200.fc40.x86_64/vmlinux
Percent          
                 
              Disassembly of section .text:
                 
              ffffffff81f60220 <icmp_rcv>:
              ; {         
                endbr64         
              → callq   __fentry__
                pushq   %r15    
              ;       return __xfrm_policy_check2(sk, dir, skb, family, 0);
                xorl    %esi,%esi
              ; {         
                pushq   %r14    
                pushq   %r13    
                pushq   %r12    
   3.74         pushq   %rbp    
                pushq   %rbx    
                movq    %rdi,%rbx
                subq    $0x8,%rsp
              ;       return (struct dst_entry *)(skb->_skb_refdst & SKB_DST_PTRMASK);
   3.74         movq    0x58(%rdi),%rbp
                andq    $-0x2,%rbp
              ;       return rcu_dereference_protected(pnet->net, true);
                movq    (%rbp),%rax
                movq    0x118(%rax),%r13
              ;       return __xfrm_policy_check2(sk, dir, skb, family, 0);
              → callq   __xfrm_policy_check2.constprop.0


The output is different, but same instructions on a quick scan.

To double check:

root@number:~# strace -f -s512 -e execve -- perf annotate  -vv --stdio2 icmp_rcv |& grep -m3 objdump
Executing: llvm-objdump  --start-address=0xffffffff81f60220 --stop-address=0xffffffff81f605cb  -d --no-show-raw-insn -S      -C "$1"
[pid 26113] execve("/bin/sh", ["/bin/sh", "-c", "llvm-objdump  --start-address=0xffffffff81f60220 --stop-address=0xffffffff81f605cb  -d --no-show-raw-insn -S      -C \"$1\"", "--", "/usr/lib/debug/lib/modules/6.11.6-200.fc40.x86_64/vmlinux"], 0x157fa1d0 /* 39 vars */) = 0
[pid 26113] execve("/usr/bin/llvm-objdump", ["llvm-objdump", "--start-address=0xffffffff81f60220", "--stop-address=0xffffffff81f605cb", "-d", "--no-show-raw-insn", "-S", "-C", "/usr/lib/debug/lib/modules/6.11.6-200.fc40.x86_64/vmlinux"], 0x559f670e7bd0 /* 39 vars */) = 0
root@number:~#

So, in symbol__disassemble_llvm() it should look at
args->options->hide_src_code and use that to ask the llvm lib to have
that source code in the disasm somehow.

- Arnaldo
