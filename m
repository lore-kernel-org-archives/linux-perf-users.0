From: HUMMEL Michel <michel.hummel@thalesgroup.com>
Subject: RE: Perf 2.6.32-220.el6.x86_64 problem when recording 2 counters
Date: Thu, 24 May 2012 09:23:51 +0200
Message-ID: <25544_1337844238_4FBDE20E_25544_549_1_932AC94CE5A51243A6F091BAFB3EE3E0028AB95713@THSONEA01CMS01P.one.grp>
References: <14480_1337789222_4FBD0B26_14480_3035_2_932AC94CE5A51243A6F091BAFB3EE3E0028AB9506D@THSONEA01CMS01P.one.grp>
 <87bole1k6w.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from thsbbfxrt01p.thalesgroup.com ([192.54.144.131]:38741 "EHLO
	thsbbfxrt01p.thalesgroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751013Ab2EXHYG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 May 2012 03:24:06 -0400
Received: from thsbbfxrt01p.thalesgroup.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 84BD059A391
	for <linux-perf-users@vger.kernel.org>; Thu, 24 May 2012 09:23:58 +0200 (CEST)
In-Reply-To: <87bole1k6w.fsf@sejong.aot.lge.com>
Content-Language: fr-FR
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


-----Message d'origine-----
De=A0: linux-perf-users-owner@vger.kernel.org [mailto:linux-perf-users-=
owner@vger.kernel.org] De la part de Namhyung Kim
Envoy=E9=A0: jeudi 24 mai 2012 02:45
=C0=A0: HUMMEL Michel
Cc=A0: linux-perf-users@vger.kernel.org
Objet=A0: Re: Perf 2.6.32-220.el6.x86_64 problem when recording 2 count=
ers

Hi,

On Wed, 23 May 2012 18:06:59 +0200, HUMMEL Michel wrote:
> Hello,
> I am testing the perf command of my new centos 6.2 server, and I don'=
t understand something.
> My Conf :
> ################################################################
> $ grep name /proc/cpuinfo
> model name      : Intel(R) Xeon(R) CPU           E5620  @ 2.40GHz
> $ uname -a
> Linux xxxxxxxx 2.6.32-220.el6.x86_64 #1 SMP Tue Dec 6 19:48:22 GMT 20=
11 x86_64 x86_64 x86_64 GNU/Linux
> $ perf --version
> perf version 2.6.32-220.el6.x86_64.debug
> $ perf test
>  1: vmlinux symtab matches kallsyms: FAILED!
>
>  2: detect open syscall event: Ok
>  3: detect open syscall event on all cpus: Ok
>  4: read samples using the mmap interface: Ok
> ################################################################
>
> I wrote a simple test case which is calling two functions.
> The first one "good_perfo"  does the same as the second "bad_perfo" b=
ut more efficiently (lesser cache miss ...).
>
> Gprof profile confirms this :
> ################################################################
> $ gprof -p ./test_perfo
> Flat profile:
>
> Each sample counts as 0.01 seconds.
>   %   cumulative   self              self     total
>  time   seconds   seconds    calls   s/call   s/call  name
>  76.14     38.75    38.75        1    38.75    38.75  bad_perfo
>  23.70     50.81    12.06        1    12.06    12.06  good_perfo
> ################################################################
>
> but perf don't want to give me the good answer when I asking for two =
events : cycles and instructions  :
> ################################################################
> $ perf record -e  cycles,instructions  -o perf.data.cycles.instructio=
ns ./test_perfo
> $ perf report -i perf.data.cycles.instructions --stdio
> # Events: 5K cycles
> #

One thing I noticed is the number of events in this run is much smaller
than others (5K to 51K). Probably it can be a reason of the inaccuracy,
but I'm not sure. Maybe increasing sampling freq (-F) or adding the 'u'
modifier on events can help.

Thanks,
Namhyung




Increasing the frequency doesn't change the profile :

$  perf record -F100000 -e  cycles,instructions  -o perf.data.cycles.in=
structions3 ./test_perfo

 [ perf record: Captured and wrote 2.015 MB perf.data.cycles.instructio=
ns3 (~88048 samples) ]
Processed 0 events and LOST 66!

Check IO/CPU overload!

$ perf report -i perf.data.cycles.instructions3 --stdio
Processed 0 events and LOST 66!

Check IO/CPU overload!

# Events: 22K cycles
#
# Overhead  Command      Shared Object                            Symbo=
l
# ........  .......  .................  ...............................=
=2E
#
    95.85%  test_perfo  test_perfo         [.] good_perfo
     2.73%  test_perfo  [kernel.kallsyms]  [k] clear_page_c
     0.23%  test_perfo  [kernel.kallsyms]  [k] page_fault
     0.06%  test_perfo  [kernel.kallsyms]  [k] __alloc_pages_nodemask

# Events: 21K instructions
#
# Overhead  Command      Shared Object                       Symbol
# ........  .......  .................  ...........................
#
    99.71%  test_perfo  test_perfo         [.] good_perfo
     0.03%  test_perfo  [kernel.kallsyms]  [k] clear_page_c
     0.03%  test_perfo  [kernel.kallsyms]  [k] get_page_from_freelist
     0.02%  test_perfo  [kernel.kallsyms]  [k] handle_mm_fault

#
# (For a higher level overview, try: perf report --sort comm,dso)
#


Michel Hummel
