From: Kumar Ranjit-B04060 <B04060@freescale.com>
Subject: RE: Not able to profile a 64bit application
Date: Mon, 13 Jun 2011 04:21:50 +0000
Message-ID: <8CB5FB7FBAFD274A8E92A53BBAFE339D0D5295@039-SN1MPN1-003.039d.mgd.msft.net>
References: <20110511010305.GA4324@dev1756.snc6.facebook.com>
 <20110602192018.GA21739@ghostprotocols.net>
 <20110602192249.GB21739@ghostprotocols.net>
 <20110602192427.GC21739@ghostprotocols.net>
 <8CB5FB7FBAFD274A8E92A53BBAFE339D0D33F4@039-SN1MPN1-003.039d.mgd.msft.net>
 <20110603153545.GB23265@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:24503
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab1FMEVy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Jun 2011 00:21:54 -0400
In-Reply-To: <20110603153545.GB23265@ghostprotocols.net>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Thanks Arnaldo,
Actually I am trying to profile coremark benchmark. So for a 32-bit coremark application I use the commands as
$./perf record -e cycles ./cmark_32bit.exe
$./perf report > profling_coremark_32bit

This generates proper output as (Putting only top few lines).
# Samples: 486793933
#
# Overhead          Command        Shared Object  Symbol
# ........  ...............  ...................  ......
#
    40.65%  cmark_32bit.exe  cmark_32bit.exe      [.] core_bench_state
    29.21%  cmark_32bit.exe  cmark_32bit.exe      [.] core_bench_list
    21.97%  cmark_32bit.exe  cmark_32bit.exe      [.] core_bench_matrix
     3.69%  cmark_32bit.exe  cmark_32bit.exe      [.] crc16
     3.45%  cmark_32bit.exe  cmark_32bit.exe      [.] crcu32
     0.79%  cmark_32bit.exe  cmark_32bit.exe      [.] crcu16
     0.13%  cmark_32bit.exe  [kernel.kallsyms]    [k] .raw_local_irq_restore
     0.01%  cmark_32bit.exe  [kernel.kallsyms]    [k] .memset
     0.01%  cmark_32bit.exe  [kernel.kallsyms]    [k] .rpc_set_active
     0.01%  cmark_32bit.exe  cmark_32bit.exe      [.] main


But when I repeat the procedure for a 64-bit application then there is some problem. I am putting my steps and the results I see
$rm perf.data
$./perf record -e cycles ./cmark_64.exe
$./perf report > profling_coremark_64bit

# Samples: 570272263
#
# Overhead       Command                Shared Object  Symbol
# ........  ............  ...........................  ......
#
    99.79%  cmark_64.exe  cmark_64.exe                 [.] 00000011.plt_call.putchar@@GLIBC_2.3+0
     0.08%  cmark_64.exe  [kernel.kallsyms]            [k] .raw_local_irq_restore
     0.01%  cmark_64.exe  [kernel.kallsyms]            [k] .memset
     0.01%  cmark_64.exe  [kernel.kallsyms]            [k] .run_timer_softirq
     0.01%  cmark_64.exe  [kernel.kallsyms]            [k] .rpc_set_active
     0.01%  cmark_64.exe  [kernel.kallsyms]            [k] .nfs_set_page_tag_locked
     0.01%  cmark_64.exe  [kernel.kallsyms]            [k] .kref_get
     0.01%  cmark_64.exe  [kernel.kallsyms]            [k] .__rpc_execute

Which is not correct.

Please let me know if you see some problem in my steps

Other details(uname -a)
Linux p5020ds-64b 2.6.34.6 #4 SMP Thu Jun 2 12:40:34 IST 2011 ppc64 GNU/Linux

I am using not using elfutils currently. I am using libelf-0.8.12/ from http://www.mr511.de/software/.
From your mail it looks like it should be a elfutils issue. So I will get elfutils today and build it.
Regards
Ranjit



-----Original Message-----
From: linux-perf-users-owner@vger.kernel.org [mailto:linux-perf-users-owner@vger.kernel.org] On Behalf Of Arnaldo Carvalho de Melo
Sent: Friday, June 03, 2011 9:06 PM
To: Kumar Ranjit-B04060
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Not able to profile a 64bit application

Em Fri, Jun 03, 2011 at 09:21:41AM +0000, Kumar Ranjit-B04060 escreveu:

> I am able to do profiling using perf record and report for a 32 bit 
> application but for 64 bit application, its not able to resolve the 
> symbols.  Anyone faced similar problem??

> I am doing this for e5500 core.

Can you provide some more details?

. Which distro
. readelf -s /path/to/your/64-bit/app output . elfutils version

should be a good start.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
