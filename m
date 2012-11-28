From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: Queries on using PERF tool
Date: Wed, 28 Nov 2012 16:16:50 +0900
Message-ID: <50B5BA62.6080207@core.kaist.ac.kr>
References: <loom.20121128T064019-497@post.gmane.org> <CAD15agZ1Q5RZ=LLnJ5d1t7WURL+C=S_KZ+Hn_NxukyYKaX12Vw@mail.gmail.com> <CA+wByoUyv8LGA_rZXV=xgLXQWG=s3jAXq9m_38tE9DjY94DC0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:42553 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab2K1HR2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 28 Nov 2012 02:17:28 -0500
In-Reply-To: <CA+wByoUyv8LGA_rZXV=xgLXQWG=s3jAXq9m_38tE9DjY94DC0w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Shahina Rabbani <shahinarabbani.shaik@gmail.com>
Cc: Ritesh Harjani <ritesh.harjani@gmail.com>, linux-perf-users@vger.kernel.org



2012-11-28 =EC=98=A4=ED=9B=84 3:36, Shahina Rabbani =EC=93=B4 =EA=B8=80=
:
> Hi kim and Ritesh,
>
> *kim:*
> Thanks for ur reply. But i didnt understand how to profile a particul=
ar
> function of a process. Can u give the details with example please .
>

Have you used "perf-top"?
It will be a good reference to you.

This is my perf-top result when i execute SPEC CPU 2006.



    PerfTop:     424 irqs/sec  kernel: 5.2%  exact:  0.0% [1000Hz=20
cycles],  (all, 12 CPUs)
-----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-----------------------------------------------------------------=20


              samples  pcnt function        DSO
              _______ _____ _______________=20
_______________________________________________________________________=
___________________________________________________________________=20


               105.00 12.7% quantum_toffoli=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0004/libquantum_base.amd64-m64-gcc41-=
nn
                96.00 11.6% quantum_toffoli=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0007/libquantum_base.amd64-m64-gcc41-=
nn
                89.00 10.8% quantum_toffoli=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0005/libquantum_base.amd64-m64-gcc41-=
nn
                84.00 10.2% quantum_toffoli=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0001/libquantum_base.amd64-m64-gcc41-=
nn
                62.00  7.5% quantum_toffoli=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0003/libquantum_base.amd64-m64-gcc41-=
nn
                51.00  6.2% quantum_toffoli=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0002/libquantum_base.amd64-m64-gcc41-=
nn
                45.00  5.4% quantum_toffoli=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0008/libquantum_base.amd64-m64-gcc41-=
nn
                45.00  5.4% quantum_sigma_x=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0005/libquantum_base.amd64-m64-gcc41-=
nn
                42.00  5.1% quantum_toffoli=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0010/libquantum_base.amd64-m64-gcc41-=
nn
                37.00  4.5% quantum_sigma_x=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0001/libquantum_base.amd64-m64-gcc41-=
nn
                28.00  3.4% quantum_cnot=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0007/libquantum_base.amd64-m64-gcc41-=
nn
                26.00  3.1% quantum_cnot=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0004/libquantum_base.amd64-m64-gcc41-=
nn
                20.00  2.4% quantum_sigma_x=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0010/libquantum_base.amd64-m64-gcc41-=
nn
                16.00  1.9% quantum_sigma_x=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0008/libquantum_base.amd64-m64-gcc41-=
nn
                11.00  1.3% quantum_sigma_x=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0002/libquantum_base.amd64-m64-gcc41-=
nn
                10.00  1.2% format_decode   [kernel.kallsyms]=20
=20

                 8.00  1.0% memcpy          /usr/bin/perf_3.0.0-12=20
=20

                 7.00  0.8% vsnprintf       [kernel.kallsyms]=20
=20

                 6.00  0.7% quantum_cnot=20
/root/mnmate_3rd/cma_sched/spec2006/benchspec/CPU2006/462.libquantum/ru=
n/run_base_ref_amd64-m64-gcc41-nn.0002/libquantum_base.amd64-m64-gcc41-=
nn
                 5.00  0.6% update_iter     [kernel.kallsyms]




Sorry for the broken format.

But, you can see there is the column called "function".

If your program is compiled with SYMBOLs (gcc, -g option),
Perf reports the event counts corresponding to the symbols.

You can parse "perf-top" result directly.
Or,
there might be other ways if you look into the manual/help of Perf.



> *Ritesh* :
> @ present i did the experiments on ubuntu intel pc.
> Actually these are the questions asked to me when i gave presentation=
 on
> perf tool.
> Even i have to check the statistics on the board.
> I am in the process of  setting up the board to work with the perf to=
ol.
> I am facing some problems in the set up. Once i am done with it. then
> will check the perf tool statistics and share the results with u for =
sure.
>
> Keep sharing the info if u got any.
>
> Thanks.
> Shahina
>
> On Wed, Nov 28, 2012 at 11:45 AM, Ritesh Harjani
> <ritesh.harjani@gmail.com <mailto:ritesh.harjani@gmail.com>> wrote:
>
>     Hi Sahina,
>
>     I am also new to perf. Saw your mail on perf mailing list.
>     Can you please tell me the statistics on what extent of profiling
>     have you achieved through perf.
>
>     Reason for asking this is that I need to compare between perf and
>     some other profiling tool.
>     If possible can you please share your results and also on what
>     platform you are testing this?
>
>     Thank you
>     Ritesh
>
>
>     On Wed, Nov 28, 2012 at 11:17 AM, Shahina Rabbani
>     <shahinarabbani.shaik@gmail.com
>     <mailto:shahinarabbani.shaik@gmail.com>> wrote:
>
>         Hi,
>
>         I am a new user of PERF tool. I have few questions to ask abo=
ut
>         the PERF tool.
>         Please help me with the answers.
>
>         Q1. Is it possible to use PERF tool on a piece of code? Say i
>         have a process P1
>         and the process has several functions F1, F2, F3. Is it possi=
ble
>         to perform
>         profilng only on F1 Function ??
>
>         Q2. Say i am using the PERF tool to counts some events depend=
ing
>         on the clock
>         value. If i change the clock value in between, then PERF tool
>         can be able to
>         understand the situation and generate the event counts accord=
ing
>         to the old and
>         new clock values??
>
>
>         Please Help.
>
>         Thanks,
>         Shahina Rabbani
>
>         --
>         To unsubscribe from this list: send the line "unsubscribe
>         linux-perf-users" in
>         the body of a message to majordomo@vger.kernel.org
>         <mailto:majordomo@vger.kernel.org>
>         More majordomo info at http://vger.kernel.org/majordomo-info.=
html
>
>
>
