From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Mon, 21 Oct 2019 09:20:28 -0300
Message-ID: <20191021122028.GA10134@kernel.org>
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
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 	Please consider pulling,

<SNIP>

> >  tools/perf/util/header.c              |  4 +++-
> >  tools/perf/util/util.c                |  6 ++++--
> >  12 files changed, 65 insertions(+), 17 deletions(-)
 
> Pulled, thanks a lot Arnaldo!

Thanks!
 
> A minor bugreport:
 
> There's a new nuisance message that I noticed when 'perf top' is started: 
> a "vmlinux file has not been found" - with a "press any key" - but the 
> message doesn't actually wait for the keypress, it's cleared on the first 
> screen refresh...

I'll investigate the problems reported after pushing out the current
perf/core lot, thanks for the detailed report!

- Arnaldo
 
> I'd argue that both the keypress action and the warning message is 
> superfluous:
> 
>  - It annoys users while not actually giving any straightforward way to 
>    fix it. It's displayed on every startup of perf top, which is highly 
>    distracting.
> 
>  - At least on Ubuntu it appears to be wrong, because the vmlinux is 
>    available and symbol resolution/annotation appears to be working fine:
> 
> 	# uname -a
> 	Linux dagon 5.4.0-rc3-custom-00557-gb6c81ae120e0 #1 SMP PREEMPT Sun Oct 20 15:28:00 CEST 2019 x86_64 x86_64 x86_64 GNU/Linux
> 
> 	# dpkg -l | grep gb6c81ae120e
> 	ii  linux-headers-5.4.0-rc3-custom-00557-gb6c81ae120e0   5.4.0-rc3-custom-00557-gb6c81ae120e0-1                     amd64        Linux kernel headers for 5.4.0-rc3-custom-00557-gb6c81ae120e0 on amd64
> 	ii  linux-image-5.4.0-rc3-custom-00557-gb6c81ae120e0     5.4.0-rc3-custom-00557-gb6c81ae120e0-1                     amd64        Linux kernel, version 5.4.0-rc3-custom-00557-gb6c81ae120e0
> 	ii  linux-image-5.4.0-rc3-custom-00557-gb6c81ae120e0-dbg 5.4.0-rc3-custom-00557-gb6c81ae120e0-1                     amd64        Linux kernel debugging symbols for 5.4.0-rc3-custom-00557-gb6c81ae120e0
> 	ii  linux-libc-dev:amd64                                 5.4.0-rc3-custom-00557-gb6c81ae120e0-1                     amd64        Linux support headers for userspace development
> 
>    Note that the 'dbg' package is installed which includes the vmlinux, 
>    and perf does seem to find it:
> 
> 	# dpkg-query -L linux-image-5.4.0-rc3-custom-00557-gb6c81ae120e0-dbg | grep vmlinux$
> 	/usr/lib/debug/lib/modules/5.4.0-rc3-custom-00557-gb6c81ae120e0/vmlinux
> 
>    I can see annotated kernel functions just fine.
> 
>  - Finally, when I run perf as root then kallsyms and /proc/kcore is used 
>    to annotate the kernel. So the 'cannot resolve' message cannot even be 
>    true. :-)
> 
> Instead I believe some sort of explanation should be printed in the 
> natural flow when there's an unknown symbol or someone tries to enter a 
> kernel symbol that cannot be further resolved. Even there it probably 
> shouldn't be a 'warning' message, but something printed in-line where 
> usually we'd see the annotated output - to disrupt the normal workflow as 
> little as possible.
> 
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
> 
> Thanks,
> 
> 	Ingo

-- 

- Arnaldo
