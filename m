From: Ralph =?utf-8?B?QsO2aG1l?= <slow@samba.org>
Subject: Re: Callgraphs split at the kernel boundary
Date: Mon, 4 Sep 2017 19:01:27 +0200
Message-ID: <20170904170127.yuofaew6orzrxl5e@kazak>
References: <20170903094913.ddk52e4zd44zz3vn@kazak>
 <15526878.WJkr8vPO1G@milian-kdab2>
 <4314827.rDNsEPmXDr@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:39516 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753880AbdIDRIw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2017 13:08:52 -0400
Content-Disposition: inline
In-Reply-To: <4314827.rDNsEPmXDr@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

On Mon, Sep 04, 2017 at 06:44:23PM +0200, Milian Wolff wrote:
> In my case, it seems to help to remove the filter. I.e. by default perf 
> nowadays uses `cycles:uppp` on my system. If I instead specify `cycles:P` 
> explicitly at `perf record` time, the issue above seems to be reduced, albeit 
> not completely. Does this help in your situation too?

nope, I still mostly see split callgraphs, when recording with

# perf record -e cycles:P -g -p 30027

Eg (from perf script):

smbd 30027 66331.499304:     250000 cpu-clock:HG: 
                  9a8233 tcp_chrono_start (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  997565 skb_entail (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  99ba5d tcp_sendmsg (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  9c81c8 inet_sendmsg (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  920f08 sock_sendmsg (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  920fac sock_write_iter (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  463e72 __do_readv_writev (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  463fdc do_readv_writev (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  464260 vfs_writev (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  4642e1 do_writev (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  465510 sys_writev (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  a77737 entry_SYSCALL_64 (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  106680 __GI___writev (/usr/lib64/libc-2.25.so)
              c846d36d60 [unknown] ([unknown])
              c846d36f10 [unknown] ([unknown])
        65742f746e657665 [unknown] ([unknown])

Also wondering about the bottom three unresolved symbols... *scratches head*

Cheerio!
-slow
