From: Jack Wang <jack.wang.usish@gmail.com>
Subject: How to read the perf report output
Date: Fri, 17 Apr 2015 12:52:53 +0200
Message-ID: <CA+res+Qw26_URgzDGWOriDDqpc6G6tqqEYfHe-9nO1gonOzkWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34955 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbbDQKwy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Apr 2015 06:52:54 -0400
Received: by iejt8 with SMTP id t8so69313961iej.2
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Apr 2015 03:52:53 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I'm tring to profile the system using perf, need help to under
standard the output better.

I'm running perf from linux-tools-3.16 from debian testing.

I use perf record -a -g -F 99 fio /dev/sdx to record a perf data, and
perf report -g show:

+   84.85%     0.11%         swapper  [kernel.kallsyms]   [k] cpu_startup_entry
+   84.17%     0.05%         swapper  [kernel.kallsyms]   [k] arch_cpu_idle
+   84.08%     0.06%         swapper  [kernel.kallsyms]   [k] cpuidle_idle_call
+   81.46%     0.00%         swapper  [kernel.kallsyms]   [k] start_secondary
+   75.25%     0.21%         swapper  [kernel.kallsyms]   [k]
cpuidle_enter_state
+   66.33%    66.29%         swapper  [kernel.kallsyms]   [k]
acpi_idle_enter_simple
+    9.60%     0.00%             fio  [kernel.kallsyms]   [k]
system_call_fastpath
+    7.74%     0.05%             fio  libaio.so.1.0.1     [.] io_submit
+    7.58%     0.00%             fio  [kernel.kallsyms]   [k] sys_io_submit
+    7.55%     0.05%             fio  [kernel.kallsyms]   [k] do_io_submit
+    7.38%     0.03%         swapper  [kernel.kallsyms]   [k] irq_exit
+    7.04%     0.02%             fio  [kernel.kallsyms]   [k] blkdev_aio_read
+    7.04%     0.15%         swapper  [kernel.kallsyms]   [k] __do_softirq
+    7.00%     0.03%             fio  [kernel.kallsyms]   [k]
generic_file_aio_read
+    6.96%     0.01%             fio  [kernel.kallsyms]   [k] blkdev_direct_IO
+    6.73%     0.53%             fio  [kernel.kallsyms]   [k]
__blockdev_direct_IO
+    6.09%     0.28%         swapper  [kernel.kallsyms]   [k]
call_function_single_interrupt
+    5.90%     0.01%         swapper  [kernel.kallsyms]   [k] acpi_idle_enter_c1
+    5.81%     0.01%         swapper  [kernel.kallsyms]   [k]
smp_call_function_single_interrupt
+    5.38%     0.13%         swapper  [kernel.kallsyms]   [k] scsi_softirq_done
+    5.31%     0.02%         swapper  [kernel.kallsyms]   [k] blk_done_softirq
+    5.22%     0.04%         swapper  [kernel.kallsyms]   [k]
scsi_finish_command


I know the first number is overhead percentage , but what's the second
one? it's looks new to me, anyone could give me a hint?

Thanks,

Regards,
Jack
