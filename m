From: Chao Xu <caesarxuchao@gmail.com>
Subject: Re: perf record always record the same kernel symbol
Date: Fri, 10 May 2013 15:43:49 -0500
Message-ID: <CAKZq+rfLcUP26UxW2xdtKTqanfQHjc497Z6Ddcpe+7b9gBc6SQ@mail.gmail.com>
References: <CAKZq+rfUO070Ph38EeOzGGxG3CtWiLZ4-eH=PLgby62Ugk3w1w@mail.gmail.com>
	<518D46AA.1000006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:61420 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888Ab3EJUnu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 May 2013 16:43:50 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so2507341oag.9
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2013 13:43:50 -0700 (PDT)
In-Reply-To: <518D46AA.1000006@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Thanks David. This indeed gave more samples. Do you know why the
symbol  [k] 0xffffffff81043fea occured so often? As shown in the
pasted result, both "swapper" and "perf" had this symbol. And if I
"perf record dd if=/dev/zero of=/dev/null" or "perf record ping", they
all showed this symbol. I pasted these results in the end of this
email.
I guess my real concern is the symbols cannot be mapped into
meaningful function names. These symbols cannot be found in either
/proc/kallsyms nor the vmlinux I built from the kernel source tree.
Any idea? Thanks.

result of sudo perf record -a -- sleep 1
# Samples: 104  of event 'cycles'
# Event count (approx.): 61197061

#
# Overhead          Command               Shared Object  Symbol
# ........  ...............  ..........................  ......
#
    47.49%          swapper  [kernel.kallsyms]           [k] 0xffffffff81043fea
    11.78%  chromium-browse  [kernel.kallsyms]           [k] 0xffffffff81095950
    11.46%  chromium-browse  chromium-browser            [.] 0x000000000160d0a6
     4.07%  chromium-browse  perf-5594.map               [.] 0x00000bb86b1cb70a
     4.07%             perf  [kernel.kallsyms]           [k] 0xffffffff81043fea
     2.38%            sleep  perf                        [.] 0x00000000000459da
     2.29%            sleep  [kernel.kallsyms]           [k] 0xffffffff813548c3
     2.05%             java  perf-3109.map               [.] 0x00007f84d5206071
     2.05%  indicator-cpufr  libgobject-2.0.so.0.3200.3  [.] 0x0000000000031787
     2.05%           compiz  libc-2.15.so                [.] 0x0000000000082fa6
     2.02%  chromium-browse  libflashplayer.so           [.] 0x0000000000803fe7
     1.88%             java  libglib-2.0.so.0.3200.3     [.] 0x0000000000045619
     1.72%  chromium-browse  libglib-2.0.so.0.3200.3     [.] 0x0000000000019930
     1.64%  chromium-browse  libpthread-2.15.so          [.] 0x000000000000cd60
     1.02%             Xorg  [kernel.kallsyms]           [k] 0xffffffff81044c1d
     0.62%          swapper  [i915]                      [k] 0x0000000000000ce5
     0.62%             Xorg  [i915]                      [k] 0x0000000000018a80
     0.51%             Xorg  Xorg                        [.] 0x000000000013a619
     0.29%      kworker/0:1  [kernel.kallsyms]           [k] 0xffffffff81096afc

result of sudo perf record dd if=/dev/zero of=/dev/null:
# Overhead  Command      Shared Object  Symbol
# ........  .......  .................  ......
#
    76.89%       dd  [kernel.kallsyms]  [k] 0xffffffff81043fea
    13.91%       dd  libc-2.15.so       [.] 0x000000000014815f
     9.21%       dd  dd                 [.] 0x0000000000004889

result of sudo perf record ping 10.0.0.1:
# Overhead  Command      Shared Object  Symbol
# ........  .......  .................  ......
#
    64.59%     ping  ld-2.15.so         [.] 0x00000000000188d2
    35.41%     ping  [kernel.kallsyms]  [k] 0xffffffff81043fea

--
Regards,
Chao Xu
