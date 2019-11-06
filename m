From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Wed, 6 Nov 2019 16:10:51 -0300
Message-ID: <20191106191051.GE3636@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
 <20191021062354.GA22042@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191021062354.GA22042@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, Thomas Richter <tmricht@linux.ibm.com>, Yunfeng Ye <yeyunfeng@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Oct 21, 2019 at 08:23:54AM +0200, Ingo Molnar escreveu:
> Secondly, there also appears to be a TUI weirdness when the annotated 
> kernel functions are small (or weird): the blue cursor is stuck at the 
> top and I cannot move between the annotated instructions with the down/up 
> arrow:
> 
> Samples: 13M of event 'cycles', 4000 Hz, Event count (approx.): 1272420588851
> clear_page_rep  /usr/lib/debug/boot/vmlinux-5.4.0-rc3-custom-00557-gb6c81ae120e0 [Percent: local period]
>   0.01 │     mov  $0x200,%ecx                                                                                                                                                                      ▒
>        │   xorl %eax,%eax                                                                                                                                                                          ▒
>   0.01 │     xor  %eax,%eax                                                                                                                                                                        ▒
>        │   rep stosq                                                                                                                                                                               ▒
>  99.27 │     rep  stos %rax,%es:(%rdi)                                                                                                                                                             ▒
>        │   ret                                                                                                                                                                                     ▒
>   0.71 │   ← retq                         
> 
> I can still exit the screen with 'q', and can move around in larger 
> annotated kernel functions. Not sure whether it's related to function 
> size, or perhaps to the 'hottest' instruction that the cursor is normally 
> placed at.

I couldn't reproduce this one so far, with another small function,
clear_page_erms, what happens is that the cursor seems to be hidden at the
bottom, if you press the "magic" 'D' hotkey it will tell (at the bottom of the
screen) that the idx is at 18, which  for a function with just 8 output lines
doesn't make sense:

Samples: 12K of event 'cycles', 4000 Hz, Event count (approx.): 2219443843
clear_page_erms  /proc/kcore [Percent: local period]
Percent│                                                                 ◆
       │                                                                 ▒
       │                                                                 ▒
       │    Disassembly of section load0:                                ▒
       │                                                                 ▒
       │    ffffffffab9d17c0 <load0>:                                    ▒
       │      mov  $0x1000,%ecx                                          ▒
       │      xor  %eax,%eax                                             ▒
100.00 │      rep  stos %al,%es:(%rdi)                                   ▒
       │    ← retq                                                       ▒
                                                                         ▒
1: nr_ent=20, height=35, idx=18, top_idx=1, nr_asm_entries=8

Doesn't make sense, there aren't 20 entries nor the idx is 18, the
nr_asm_entries is right, I'll try to follow up on this one...

But you can in these cases try to go on pressin the up arrow till the cursor
appears, etc.
 
> Thanks,
> 
> 	Ingo

-- 

- Arnaldo
