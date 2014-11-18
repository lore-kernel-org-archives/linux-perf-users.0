From: David Ahern <dsahern@gmail.com>
Subject: Re: Is it possible to get (or compute) the consummed CPU with perf
 ?
Date: Tue, 18 Nov 2014 11:08:05 -0700
Message-ID: <546B8B05.5000102@gmail.com>
References: <loom.20141111T083453-589@post.gmane.org> <loom.20141118T183130-762@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090009060909070805060702"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63816 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208AbaKRSIK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Nov 2014 13:08:10 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so10501642pab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2014 10:08:09 -0800 (PST)
In-Reply-To: <loom.20141118T183130-762@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jerome Correnoz <jerome.correnoz@st.com>, linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------090009060909070805060702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/14, 10:31 AM, Jerome Correnoz wrote:
> Jerome Correnoz <jerome.correnoz <at> st.com> writes:
>
>>
>> Hi,
>>
>> We're interested to know the CPU load/usage on our ARMv7 embedded system
>> when running some use cases (e.g. simple video decode, double video
>> decode, etc.). By CPU load, I mean a way to measure the time when the
>> system was doing something else than Idle.
>>
>> I've tried to get it from the performance counter statistics but
> couldn't
>> find a way to get it, do I miss something ?
>>
>> Also tried to use perf for profiling the system (e.g. perf record -a).
> It
>> report very useful percentage for the running processes that we exploit
> to
>> detect hot spots. But It reports X% of the used CPU (nothing related to
>> Idle or "rest of CPU").
>>
>> So, any way with perf to get this information (directly or indirectly
> with
>> few calculation) ?


Not exactly what you want but might be close:

   git clone https://github.com/dsahern/linux
   git checkout perf-full-monty
   make -C tools/perf

perf sched record -ag -- sleep 1
perf sched timehist -S

shows the grains of sand (each sample) and then a runtime summary byt 
task. Example report attached for box just running a few VMs.

David

--------------090009060909070805060702
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="timehist-ex"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="timehist-ex"

           time  cpu  task name              b/n time  sch delay   run time
                      [tid/pid]                (msec)     (msec)     (msec)
--------------- ----  --------------------  ---------  ---------  ---------
 5945680.837926 [11]  <idle>                    0.000      0.000      0.000 
 5945680.837967 [02]  perf[25909]               0.000      0.000      0.000    poll_schedule_timeout do_sys_poll sys_poll system_call_fastpath __poll
 5945680.838017 [11]  perf[25910]               0.000      0.011      0.091    __cond_resched _cond_resched wait_for_common wait_for_completion stop_one_cpu
 5945680.838035 [11]  migration/11[60]          0.000      0.010      0.017    cpu_stopper_thread kthread kernel_thread_helper
 5945680.838071 [10]  <idle>                    0.000      0.000      0.000 
 5945680.838627 [11]  <idle>                    0.109      0.000      0.591 
 5945680.838675 [11]  kworker/11:0[2387]        0.000      0.007      0.047    worker_thread kthread kernel_thread_helper
 5945680.838822 [10]  sleep[25910]              0.053      0.000      0.750    do_nanosleep hrtimer_nanosleep sys_nanosleep system_call_fastpath __GI___libc_nanosleep
 5945680.838836 [10]  kworker/10:1[25017]       0.000      0.270      0.013    worker_thread kthread kernel_thread_helper
 5945680.839650 [02]  <idle>                    0.000      0.000      1.683 
 5945680.839653 [10]  <idle>                    0.764      0.000      0.817 
 5945680.839669 [02]  kworker/2:0[24394]        0.000      0.008      0.019    worker_thread kthread kernel_thread_helper
 5945680.839670 [10]  kworker/10:1[25017]       0.817      0.012      0.016    worker_thread kthread kernel_thread_helper
 5945680.839672 [11]  <idle>                    0.047      0.000      0.997 
 5945680.839684 [11]  kworker/11:0[2387]        0.997      0.005      0.012    worker_thread kthread kernel_thread_helper
 5945680.843522 [05]  <idle>                    0.000      0.000      0.000 
 5945680.843720 [05]  qemu-system-x86[10648/10642]      0.000      0.012      0.198    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945680.843737 [05]  kworker/5:2[1822]                 0.000      0.165      0.017    worker_thread kthread kernel_thread_helper
 5945680.849210 [07]  <idle>                            0.000      0.000      0.000 
 5945680.849271 [07]  qemu-system-x86[26110/26103]      0.000      0.014      0.060    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945680.849583 [07]  <idle>                            0.060      0.000      0.312 
 5945680.849662 [11]  <idle>                            0.012      0.000      9.978 
 5945680.849677 [11]  kworker/11:0[2387]                9.978      0.010      0.014    worker_thread kthread kernel_thread_helper
 5945680.849758 [01]  <idle>                            0.000      0.000      0.000 
 5945680.849774 [07]  qemu-system-x86[26110/26103]      0.312      0.008      0.190    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945680.849912 [01]  qemu-system-x86[26111/26103]      0.000      0.088      0.153    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945680.853973 [03]  <idle>                            0.000      0.000      0.000 
 5945680.854193 [09]  <idle>                            0.000      0.000      0.000 
 5945680.854211 [03]  qemu-system-x86[10886/10882]      0.000      0.014      0.237    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945680.854296 [09]  qemu-system-x86[10887/10882]      0.000      0.091      0.103    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945680.860643 [00]  <idle>                            0.000      0.000      0.000 
 5945680.860655 [00]  kworker/0:0[9363]                 0.000      0.031      0.012    worker_thread kthread kernel_thread_helper
 5945680.872267 [06]  <idle>                            0.000      0.000      0.000 
 5945680.872366 [06]  sendmail[1939]                    0.000      0.013      0.098    poll_schedule_timeout do_select core_sys_select sys_select system_call_fastpath
 5945680.872645 [06]  <idle>                            0.098      0.000      0.279 
 5945680.872660 [06]  kworker/6:2[31603]                0.000      0.012      0.015    worker_thread kthread kernel_thread_helper
 5945680.908105 [03]  <idle>                            0.237      0.000     53.893 
 5945680.908884 [03]  irqbalance[1228]                  0.000      0.012      0.779    do_nanosleep hrtimer_nanosleep sys_nanosleep system_call_fastpath [unknown]
 5945680.908900 [03]  kworker/3:1[98]                   0.000      0.365      0.015    worker_thread kthread kernel_thread_helper
 5945680.909630 [03]  <idle>                            0.794      0.000      0.730 
 5945680.909642 [03]  kworker/3:1[98]                   0.730      0.007      0.012    worker_thread kthread kernel_thread_helper
 5945680.999567 [00]  <idle>                            0.012      0.000    138.911 
 5945680.999581 [00]  kworker/0:0[9363]               138.911      0.023      0.014    worker_thread kthread kernel_thread_helper
 5945681.016550 [00]  <idle>                            0.014      0.000     16.969 
 5945681.016564 [00]  kworker/0:0[9363]                16.969      0.013      0.013    worker_thread kthread kernel_thread_helper
 5945681.039607 [11]  <idle>                            0.014      0.000    189.929 
 5945681.039620 [11]  kworker/11:0[2387]              189.929      0.036      0.013    worker_thread kthread kernel_thread_helper
 5945681.051961 [06]  <idle>                            0.015      0.000    179.300 
 5945681.052128 [06]  qemu-system-x86[10646/10642]      0.000      0.020      0.166    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.057602 [15]  <idle>                            0.000      0.000      0.000 
 5945681.057617 [15]  kworker/15:1[110]                 0.000      0.041      0.014    worker_thread kthread kernel_thread_helper
 5945681.100411 [04]  <idle>                            0.000      0.000      0.000 
 5945681.100642 [05]  <idle>                            0.215      0.000    256.905 
 5945681.100684 [04]  qemu-system-x86[10647/10642]      0.000      0.028      0.273    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.100703 [04]  kworker/4:0[26137]                0.000      0.244      0.018    worker_thread kthread kernel_thread_helper
 5945681.100722 [05]  qemu-system-x86[10648/10642]    256.922      0.023      0.079    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.145671 [04]  <idle>                            0.291      0.000     44.968 
 5945681.145796 [04]  qemu-system-x86[10647/10642]     44.986      0.012      0.124    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.166463 [00]  <idle>                            0.013      0.000    149.898 
 5945681.166474 [00]  watchdog/0[9]                     0.000      0.020      0.011    watchdog kthread kernel_thread_helper
 5945681.182513 [04]  <idle>                            0.124      0.000     36.717 
 5945681.182609 [04]  qemu-system-x86[10647/10642]     36.717      0.012      0.095    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.197559 [02]  <idle>                            0.019      0.000    357.889 
 5945681.197574 [02]  kworker/2:0[24394]              357.889      0.040      0.014    worker_thread kthread kernel_thread_helper
 5945681.227502 [11]  <idle>                            0.013      0.000    187.881 
 5945681.227517 [11]  kworker/11:0[2387]              187.881      0.026      0.014    worker_thread kthread kernel_thread_helper
 5945681.240472 [01]  <idle>                            0.153      0.000    390.560 
 5945681.240483 [01]  watchdog/1[14]                    0.000      0.032      0.011    watchdog kthread kernel_thread_helper
 5945681.255471 [02]  <idle>                            0.014      0.000     57.896 
 5945681.255482 [02]  watchdog/2[19]                    0.000      0.012      0.010    watchdog kthread kernel_thread_helper
 5945681.270451 [03]  <idle>                            0.012      0.000    360.809 
 5945681.270463 [03]  watchdog/3[24]                    0.000      0.030      0.011    watchdog kthread kernel_thread_helper
 5945681.277390 [06]  <idle>                            0.166      0.000    225.261 
 5945681.277399 [06]  kworker/6:2[31603]              404.729      0.045      0.009    worker_thread kthread kernel_thread_helper
 5945681.277583 [06]  qemu-system-x86[10646/10642]    225.270      0.083      0.184    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.285441 [04]  <idle>                            0.095      0.000    102.832 
 5945681.285452 [04]  watchdog/4[29]                    0.000      0.015      0.010    watchdog kthread kernel_thread_helper
 5945681.289473 [11]  <idle>                            0.014      0.000     61.956 
 5945681.289488 [11]  kworker/11:0[2387]               61.956      0.024      0.014    worker_thread kthread kernel_thread_helper
 5945681.301421 [05]  <idle>                            0.079      0.000    200.699 
 5945681.301433 [05]  watchdog/5[34]                    0.000      0.020      0.011    watchdog kthread kernel_thread_helper
 5945681.316432 [06]  <idle>                            0.193      0.000     38.848 
 5945681.316444 [06]  watchdog/6[39]                    0.000      0.011      0.011    watchdog kthread kernel_thread_helper
 5945681.331400 [07]  <idle>                            0.190      0.000    481.626 
 5945681.331411 [07]  watchdog/7[44]                    0.000      0.037      0.011    watchdog kthread kernel_thread_helper
 5945681.334129 [07]  <idle>                            0.011      0.000      2.717 
 5945681.334174 [07]  qemu-system-x86[26110/26103]    484.354      0.010      0.045    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.334256 [07]  <idle>                            0.045      0.000      0.082 
 5945681.334357 [07]  qemu-system-x86[26110/26103]      0.082      0.005      0.101    __cond_resched _cond_resched kvm_resched kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl
 5945681.334375 [07]  kworker/7:0[31118]                0.000      0.044      0.017    worker_thread kthread kernel_thread_helper
 5945681.334466 [07]  qemu-system-x86[26110/26103]      0.017      0.000      0.091    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.343901 [05]  <idle>                            0.011      0.000     42.468 
 5945681.344019 [05]  qemu-system-x86[10648/10642]    243.179      0.012      0.118    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.347412 [08]  <idle>                            0.000      0.000      0.000 
 5945681.347422 [08]  watchdog/8[49]                    0.000      0.043      0.010    watchdog kthread kernel_thread_helper
 5945681.349075 [01]  <idle>                            0.011      0.000    108.591 
 5945681.349119 [01]  qemu-system-x86[26111/26103]    499.163      0.016      0.044    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.349205 [01]  <idle>                            0.044      0.000      0.086 
 5945681.349347 [01]  qemu-system-x86[26111/26103]      0.086      0.005      0.142    __cond_resched _cond_resched kvm_resched kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl
 5945681.349360 [03]  <idle>                            0.011      0.000     78.897 
 5945681.349361 [01]  kworker/1:1[23960]                0.000      0.044      0.013    worker_thread kthread kernel_thread_helper
 5945681.349448 [01]  qemu-system-x86[26111/26103]      0.013      0.000      0.087    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.349553 [03]  qemu-system-x86[26108/26103]      0.000      0.086      0.192    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.353894 [09]  <idle>                            0.103      0.000    499.597 
 5945681.354003 [01]  <idle>                            0.243      0.000      4.554 
 5945681.354116 [09]  qemu-system-x86[10887/10882]    499.597      0.039      0.222    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.354175 [01]  qemu-system-x86[10888/10882]      0.000      0.022      0.172    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.363371 [09]  <idle>                            0.222      0.000      9.254 
 5945681.363383 [09]  watchdog/9[54]                    0.000      0.009      0.011    watchdog kthread kernel_thread_helper
 5945681.378430 [10]  <idle>                            0.016      0.000    538.760 
 5945681.378441 [10]  watchdog/10[59]                   0.000      0.040      0.010    watchdog kthread kernel_thread_helper
 5945681.387738 [00]  <idle>                            0.011      0.000    221.264 
 5945681.387795 [00]  dnsmasq[1845]                     0.000      0.026      0.056    poll_schedule_timeout do_select core_sys_select sys_select system_call_fastpath
 5945681.393356 [11]  <idle>                            0.014      0.000    103.867 
 5945681.393367 [11]  watchdog/11[64]                   0.000      0.016      0.011    watchdog kthread kernel_thread_helper
 5945681.408382 [12]  <idle>                            0.000      0.000      0.000 
 5945681.408393 [12]  watchdog/12[69]                   0.000      0.020      0.011    watchdog kthread kernel_thread_helper
 5945681.413414 [03]  <idle>                            0.192      0.000     63.860 
 5945681.413426 [03]  kworker/3:1[98]                 503.771      0.025      0.012    worker_thread kthread kernel_thread_helper
 5945681.419302 [01]  <idle>                            0.172      0.000     65.126 
 5945681.419312 [01]  kworker/1:1[23960]               69.941      0.034      0.009    worker_thread kthread kernel_thread_helper
 5945681.419329 [03]  <idle>                            0.012      0.000      5.902 
 5945681.419373 [01]  qemu-system-x86[26111/26103]     69.863      0.065      0.060    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.419812 [03]  qemu-system-x86[26108/26103]     69.776      0.010      0.483    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.424370 [13]  <idle>                            0.000      0.000      0.000 
 5945681.424381 [13]  watchdog/13[74]                   0.000      0.045      0.011    watchdog kthread kernel_thread_helper
 5945681.437452 [15]  <idle>                            0.014      0.000    379.835 
 5945681.437511 [15]  qemu-system-x86[10885/10882]      0.000      0.032      0.058    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.438350 [15]  <idle>                            0.058      0.000      0.839 
 5945681.439062 [15]  qemu-system-x86[10885/10882]      0.839      0.008      0.712    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.439313 [15]  <idle>                            0.712      0.000      0.250 
 5945681.439328 [14]  <idle>                            0.000      0.000      0.000 
 5945681.439339 [14]  watchdog/14[79]                   0.000      0.047      0.011    watchdog kthread kernel_thread_helper
 5945681.439391 [15]  qemu-system-x86[10885/10882]      0.250      0.008      0.078    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.440277 [15]  <idle>                            0.078      0.000      0.886 
 5945681.440325 [15]  qemu-system-x86[10885/10882]      0.886      0.008      0.047    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.441288 [15]  <idle>                            0.047      0.000      0.962 
 5945681.441341 [15]  qemu-system-x86[10885/10882]      0.962      0.009      0.053    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.442277 [15]  <idle>                            0.053      0.000      0.935 
 5945681.442323 [15]  qemu-system-x86[10885/10882]      0.935      0.008      0.046    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.443287 [15]  <idle>                            0.046      0.000      0.964 
 5945681.443360 [15]  qemu-system-x86[10885/10882]      0.964      0.009      0.072    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.454313 [15]  <idle>                            0.072      0.000     10.953 
 5945681.454325 [15]  watchdog/15[84]                   0.000      0.009      0.011    watchdog kthread kernel_thread_helper
 5945681.539360 [11]  <idle>                            0.011      0.000    145.992 
 5945681.539373 [11]  kworker/11:0[2387]              249.871      0.032      0.013    worker_thread kthread kernel_thread_helper
 5945681.541346 [01]  <idle>                            0.070      0.000    121.973 
 5945681.541360 [01]  kworker/1:1[23960]              122.034      0.023      0.013    worker_thread kthread kernel_thread_helper
 5945681.548783 [06]  <idle>                            0.011      0.000    232.339 
 5945681.548977 [06]  qemu-system-x86[10646/10642]    271.200      0.023      0.193    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.549755 [06]  <idle>                            0.193      0.000      0.778 
 5945681.549836 [06]  qemu-system-x86[10646/10642]      0.778      0.008      0.080    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.550729 [06]  <idle>                            0.080      0.000      0.893 
 5945681.550772 [06]  qemu-system-x86[10646/10642]      0.893      0.008      0.043    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.551783 [06]  <idle>                            0.043      0.000      1.011 
 5945681.551832 [06]  qemu-system-x86[10646/10642]      1.011      0.010      0.048    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.551890 [06]  <idle>                            0.048      0.000      0.058 
 5945681.551953 [06]  qemu-system-x86[10646/10642]      0.058      0.005      0.062    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.552752 [06]  <idle>                            0.062      0.000      0.799 
 5945681.552807 [06]  qemu-system-x86[10646/10642]      0.799      0.008      0.054    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.553765 [06]  <idle>                            0.054      0.000      0.958 
 5945681.553825 [06]  qemu-system-x86[10646/10642]      0.958      0.009      0.060    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.577342 [07]  <idle>                            0.209      0.000    242.875 
 5945681.577355 [07]  kworker/7:0[31118]              242.966      0.035      0.013    worker_thread kthread kernel_thread_helper
 5945681.577398 [01]  <idle>                            0.013      0.000     36.037 
 5945681.577418 [01]  kworker/u:0[26844]                0.000      0.081      0.020    worker_thread kthread kernel_thread_helper
 5945681.593314 [01]  <idle>                            0.020      0.000     15.896 
 5945681.593329 [01]  kworker/1:1[23960]               51.954      0.019      0.014    worker_thread kthread kernel_thread_helper
 5945681.593387 [03]  <idle>                            0.483      0.000    173.574 
 5945681.593405 [03]  kworker/u:0[26844]               15.968      0.084      0.018    worker_thread kthread kernel_thread_helper
 5945681.599969 [05]  <idle>                            0.118      0.000    255.949 
 5945681.600116 [02]  <idle>                            0.010      0.000    344.634 
 5945681.600142 [05]  qemu-system-x86[10648/10642]    255.949      0.025      0.172    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.600284 [08]  <idle>                            0.010      0.000    252.861 
 5945681.600355 [02]  qemu-system-x86[10645/10642]      0.000      0.028      0.238    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.600373 [02]  kworker/2:0[24394]              402.781      0.168      0.017    worker_thread kthread kernel_thread_helper
 5945681.600844 [08]  qemu-system-x86[10642]            0.000      0.031      0.560    poll_schedule_timeout do_sys_poll sys_poll system_call_fastpath [unknown]
 5945681.683080 [04]  <idle>                            0.010      0.000    397.627 
 5945681.683282 [04]  qemu-system-x86[10647/10642]    500.470      0.033      0.202    kvm_vcpu_block kvm_arch_vcpu_ioctl_run kvm_vcpu_ioctl do_vfs_ioctl sys_ioctl
 5945681.683300 [04]  kworker/4:0[26137]              582.579      0.138      0.017    worker_thread kthread kernel_thread_helper
 5945681.727334 [12]  <idle>                            0.011      0.000    318.940 
 5945681.727349 [12]  kworker/12:2[545]                 0.000      0.070      0.015    worker_thread kthread kernel_thread_helper
 5945681.757251 [11]  <idle>                            0.013      0.000    217.877 
 5945681.757267 [11]  kworker/11:0[2387]              217.877      0.032      0.016    worker_thread kthread kernel_thread_helper
 5945681.789235 [01]  <idle>                            0.014      0.000    195.905 
 5945681.789251 [01]  kworker/1:1[23960]              195.905      0.032      0.016    worker_thread kthread kernel_thread_helper
 5945681.789283 [03]  <idle>                            0.018      0.000    195.877 
 5945681.789298 [11]  <idle>                            0.016      0.000     32.030 
 5945681.789301 [03]  kworker/u:0[26844]              195.877      0.071      0.018    worker_thread kthread kernel_thread_helper
 5945681.789316 [11]  kworker/11:0[2387]               32.030      0.025      0.018    worker_thread kthread kernel_thread_helper
 5945681.805203 [00]  <idle>                            0.056      0.000    417.407 
 5945681.805219 [00]  kworker/0:0[9363]               788.638      0.051      0.016    worker_thread kthread kernel_thread_helper
 5945681.838566 [10]  <idle>                            0.010      0.000    460.125 
 5945681.838682 [10]  sleep[25910]                    999.744      0.035      0.115    io_schedule sleep_on_page __wait_on_bit wait_on_page_bit filemap_fdatawait_range
 5945681.838746 [10]  kworker/10:1[25017]             999.012      0.017      0.064    worker_thread kthread kernel_thread_helper
 5945681.842209 [00]  <idle>                            0.016      0.000     36.989 
 5945681.842250 [00]  kworker/0:0[9363]                36.989      0.038      0.040    worker_thread kthread kernel_thread_helper
 5945681.842304 [10]  <idle>                            0.180      0.000      3.557 
 5945681.842347 [10]  sleep[25910]                      3.622      0.073      0.042    do_exit do_group_exit sys_exit_group system_call_fastpath
 5945681.842362 [02]  <idle>                            0.256      0.000    241.989 
 5945681.843243 [10]  <idle>                            0.042      0.000      0.896 
 5945681.843257 [10]  kworker/10:1[25017]               4.496      0.023      0.014    worker_thread kthread kernel_thread_helper

Runtime summary
                          comm  parent   sched-in     run-time    min-run     avg-run     max-run  stddev
                                          (count)       (msec)     (msec)      (msec)      (msec)       %
---------------------------------------------------------------------------------------------------------
                 watchdog/0[9]      -1          1        0.011      0.011       0.011       0.011    0.00
                watchdog/1[14]      -1          1        0.011      0.011       0.011       0.011    0.00
                watchdog/2[19]      -1          1        0.010      0.010       0.010       0.010    0.00
                watchdog/3[24]      -1          1        0.011      0.011       0.011       0.011    0.00
                watchdog/4[29]      -1          1        0.010      0.010       0.010       0.010    0.00
                watchdog/5[34]      -1          1        0.011      0.011       0.011       0.011    0.00
                watchdog/6[39]      -1          1        0.011      0.011       0.011       0.011    0.00
                watchdog/7[44]      -1          1        0.011      0.011       0.011       0.011    0.00
                watchdog/8[49]      -1          1        0.010      0.010       0.010       0.010    0.00
                watchdog/9[54]      -1          1        0.011      0.011       0.011       0.011    0.00
               watchdog/10[59]      -1          1        0.010      0.010       0.010       0.010    0.00
              migration/11[60]      -1          1        0.017      0.017       0.017       0.017    0.00
               watchdog/11[64]      -1          1        0.011      0.011       0.011       0.011    0.00
               watchdog/12[69]      -1          1        0.011      0.011       0.011       0.011    0.00
               watchdog/13[74]      -1          1        0.011      0.011       0.011       0.011    0.00
               watchdog/14[79]      -1          1        0.011      0.011       0.011       0.011    0.00
               watchdog/15[84]      -1          1        0.011      0.011       0.011       0.011    0.00
               kworker/3:1[98]      -1          3        0.040      0.012       0.013       0.015    7.74
             kworker/15:1[110]      -1          1        0.014      0.014       0.014       0.014    0.00
             kworker/12:2[545]      -1          1        0.015      0.015       0.015       0.015    0.00
              irqbalance[1228]      -1          1        0.779      0.779       0.779       0.779    0.00
             kworker/5:2[1822]      -1          1        0.017      0.017       0.017       0.017    0.00
                 dnsmasq[1845]      -1          1        0.056      0.056       0.056       0.056    0.00
                sendmail[1939]      -1          1        0.098      0.098       0.098       0.098    0.00
            kworker/11:0[2387]      -1          9        0.165      0.012       0.018       0.047   20.06
             kworker/0:0[9363]      -1          5        0.098      0.012       0.019       0.040   27.10
        qemu-system-x86[10642]      -1          1        0.560      0.560       0.560       0.560    0.00
  qemu-system-x86[10645/10642]      -1          1        0.238      0.238       0.238       0.238    0.00
  qemu-system-x86[10646/10642]      -1          9        0.894      0.043       0.099       0.193   21.06
  qemu-system-x86[10647/10642]      -1          4        0.695      0.095       0.173       0.273   23.01
  qemu-system-x86[10648/10642]      -1          4        0.568      0.079       0.142       0.198   18.74
  qemu-system-x86[10885/10882]      -1          7        1.068      0.046       0.152       0.712   61.19
  qemu-system-x86[10886/10882]      -1          1        0.237      0.237       0.237       0.237    0.00
  qemu-system-x86[10887/10882]      -1          2        0.325      0.103       0.162       0.222   36.53
  qemu-system-x86[10888/10882]      -1          1        0.172      0.172       0.172       0.172    0.00
            kworker/1:1[23960]      -1          5        0.067      0.009       0.013       0.016    7.95
            kworker/2:0[24394]      -1          3        0.051      0.014       0.017       0.019    7.63
           kworker/10:1[25017]      -1          4        0.109      0.013       0.027       0.064   45.52
                   perf[25909]      -1          1        0.000      0.000       0.000       0.000    0.00
  qemu-system-x86[26108/26103]      -1          2        0.675      0.192       0.337       0.483   43.09
  qemu-system-x86[26110/26103]      -1          5        0.488      0.045       0.097       0.190   25.87
  qemu-system-x86[26111/26103]      -1          5        0.488      0.044       0.097       0.153   22.11
            kworker/4:0[26137]      -1          2        0.036      0.017       0.018       0.018    2.21
            kworker/u:0[26844]      -1          3        0.057      0.018       0.019       0.020    2.55
            kworker/7:0[31118]      -1          2        0.031      0.013       0.015       0.017   12.08
            kworker/6:2[31603]      -1          2        0.025      0.009       0.012       0.015   25.10

Terminated tasks:
                  sleep[25910]      -1          4        1.000      0.042       0.250       0.750   66.95

Idle stats:
    CPU  0 idle for    981.440  msec
    CPU  1 idle for    938.732  msec
    CPU  2 idle for   1004.093  msec
    CPU  3 idle for    933.546  msec
    CPU  4 idle for    582.145  msec
    CPU  5 idle for    756.022  msec
    CPU  6 idle for    680.527  msec
    CPU  7 idle for    727.613  msec
    CPU  8 idle for    252.861  msec
    CPU  9 idle for    508.852  msec
    CPU 10 idle for   1004.157  msec
    CPU 11 idle for    951.103  msec
    CPU 12 idle for    318.940  msec
    CPU 13 idle for      0.000  msec
    CPU 14 idle for      0.000  msec
    CPU 15 idle for    395.627  msec

    Total number of unique tasks: 47
Total number of context switches: 202
           Total run time (msec):  9.278 

--------------090009060909070805060702--
