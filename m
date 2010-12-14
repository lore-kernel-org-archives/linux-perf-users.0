From: "David S. Ahern" <daahern@cisco.com>
Subject: Re: [PATCH v3] perf tools: Add symfs option for off-box analysis
 using specified tree
Date: Tue, 14 Dec 2010 07:33:27 -0700
Message-ID: <4D078037.9060207@cisco.com>
References: <1291926427-28846-1-git-send-email-daahern@cisco.com> <20101214122428.GA13425@ghostprotocols.net> <20101214125245.GB13425@ghostprotocols.net> <20101214140604.GC13425@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:46343 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab0LNOd1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Dec 2010 09:33:27 -0500
In-Reply-To: <20101214140604.GC13425@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/14/10 07:06, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 14, 2010 at 10:52:45AM -0200, Arnaldo Carvalho de Melo escreveu:
>> Ok, there are still some problems:
>>
>> It is escaping the symfs jail for /home/acme/bin/perf, /lib64/libpthread-2.5.so
>> and kernel modules, investigating...
> 
> Those 'G' signals means DSO__ORIG_GUEST_KMODULE, since you were not
> prefixing that case with symfs, it was the jail leak point, fixed, doing
> some more testing before merging.

yuk. I did not touch the hypervisor paths.

So the 'guest' route is tried all the time because of the origin list --
even when it's not applicable.

David

> 
>> [acme@mica linux]$ find /tmp/bla
>> /tmp/bla
>> /tmp/bla/lib64
>> /tmp/bla/lib64/libc-2.5.so
>> [acme@mica linux]$ perf report -v -g none --stdio --symfs /tmp/bla
>> Failed to open [kernel.kallsyms], continuing without symbols
>> # Events: 503  cycles
>> #
>> # Overhead Command    Shared Object                                Symbol
>> # ........ .......... .....................................        ....................
>> #
>>    0.84%        perf  /home/acme/bin/perf                  0x26bf1 G [.] die_builtin
>>    0.21%        perf  /home/acme/bin/perf                  0x1db4b G [.] event__synthesize_kernel_mmap
>>    0.21%        perf  /home/acme/bin/perf                  0x4700  G [.] _init
>>    0.21%        perf  /home/acme/bin/perf                  0x1deca G [.] event__synthesize_comm
>>    0.21%        perf  /lib64/libpthread-2.5.so             0xd210  G [.] __write_nocancel
>>    0.21%        perf  /home/acme/bin/perf                  0xddbd  G [.] atexit_header
>>    0.03% kworker/0:1  /lib/modules/2.6.37-rc3/.../ixgbe.ko 0x605   G [k] ixgbe_update_stats
