From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1 02/15] perf, tools: Tighten detection of BPF events
Date: Wed, 2 Aug 2017 16:10:40 -0300
Message-ID: <20170802191040.GM12201@kernel.org>
References: <20170724234015.5165-1-andi@firstfloor.org>
 <20170724234015.5165-3-andi@firstfloor.org>
 <20170802073518.GC13890@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbdHBTKo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Aug 2017 15:10:44 -0400
Content-Disposition: inline
In-Reply-To: <20170802073518.GC13890@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Andi Kleen <ak@linux.intel.com>

CCing eBPF guys and linux-perf-users, as it shows an example of
attaching a eBPF proggie to a tracepoint and reading its result with the
default BPF tracepoint beautifier in a simple, compact 'perf trace'
command line, together with asking for the 'write' syscall to be as well
beautified.x

Em Wed, Aug 02, 2017 at 09:35:18AM +0200, Jiri Olsa escreveu:
> On Mon, Jul 24, 2017 at 04:40:02PM -0700, Andi Kleen wrote:
> > perf stat -e cpu/uops_executed.core,cmask=1/

> > would be detected as a BPF source event because the .c matches the .c
> > source BPF pattern.

> > Add lookahead to the BPF patterns and reject them if they are followed
> > by more letters.
 
> I don't have the llvm/bpf toolchain, so can't test that side,
> but Arnaldo will run it for sure ;-) anyway looks ok to me:
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Sure, it regresses:

Before the patch:

  # perf trace -e write -e /home/acme/bpf/tracepoint.c cat /etc/passwd
  <SNIP>
     0.000 ( 0.010 ms): cat/6676 write(fd: 1, buf: 0x7f5fe3065000, count: 3494) ...
     0.010 (         ): raw_syscalls:sys_enter:NR 1 (1, 7f5fe3065000, da6, 7f5fe3064010, ffffffffffffffff, 0))
     0.013 (         ): perf_bpf_probe:_write:(ffffffffa625ea60))
     0.000 ( 0.208 ms): cat/6676  ... [continued]: write()) = 3494
  #

And after:

  # perf trace -e write -e /home/acme/bpf/tracepoint.c cat /etc/passwd
  invalid or unsupported event: '/home/acme/bpf/tracepoint.c'
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events
  #

For testing, please install clang and then use that proggie:

# cat /home/acme/bpf/tracepoint.c 
#include <uapi/linux/bpf.h>
#define SEC(NAME) __attribute__((section(NAME), used))
SEC("raw_syscalls:sys_enter")
int func(void *ctx)
{
      /*
       * /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/format:
       * ...
       * field:long id;	offset:8;	size:8;	signed:1;
       * ...
       * ctx + 8 select 'id'
       */
      u64 id = *((u64 *)(ctx + 8));
      if (id == 1)
      	return 1;
      return 0;
}
SEC("_write=sys_write")
int _write(void *ctx)
{
      return 1;
}
char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;
#

BTW, count: 3494 = 0xda6 :-)

Cheers,

- Arnaldo
