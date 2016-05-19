From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Getting PEBS to work
Date: Thu, 19 May 2016 15:29:49 -0700
Message-ID: <CAE40pdfx+LMiwXMZNaLVkT_XsaYFmQQqW5iOr63JnCfOhkFBmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34027 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbcESWaU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 May 2016 18:30:20 -0400
Received: by mail-io0-f195.google.com with SMTP id d197so5257540ioe.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2016 15:30:19 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day perf-users,

Different Q than my previous email... This is a physical system (Linux
3.13, Sandy Bridge) that's I think is supposed to have PEBS, but it
doesn't work. Eg:

# perf record -e r412e:p -c 10000 -a -- sleep 1
Error:
'precise' request may not be supported. Try removing 'p' modifier.
sleep: Terminated

Maybe I'm doing it wrong? Here's -vv:

# perf record -vv -e r412e:p -c 10000 -a -- sleep 1
------------------------------------------------------------
perf_event_attr:
  type                4
  size                96
  config              0x412e
  sample_period       10000
  sample_freq         10000
  sample_type         0x87
  read_format         0
  disabled            1    inherit             1
  pinned              0    exclusive           0
  exclude_user        0    exclude_kernel      0
  exclude_hv          0    exclude_idle        0
  mmap                1    comm                1
  freq                0    inherit_stat        0
  enable_on_exec      0    task                0
  watermark           0    precise_ip          1
  mmap_data           0    sample_id_all       1
  exclude_host        0    exclude_guest       1
  excl.callchain_kern 0    excl.callchain_user 0
  mmap2               0
  wakeup_events       0
  wakeup_watermark    0
  bp_type             0
  bp_addr             0
  config1             0
  bp_len              0
  config2             0
  branch_sample_type  0
  sample_regs_user    0
  sample_stack_user   0
------------------------------------------------------------
perf_event_open: pid -1  cpu 0  group_fd -1  flags 0
perf_event_open failed, error -95
Error:
'precise' request may not be supported. Try removing 'p' modifier.
sleep: Terminated

This CPU does have DS:

# cpuid -1 | gerp 'debug store'
      debug store                            = true
      64-bit debug store                      = true
      CPL-qualified debug store               = true

And bit 12 of IA32_MISC_ENABLE is 0, which should mean PEBS is supported:

# rdmsr 0x1a0 -f 12:12
0

Any other way to debug?

I see x86_pmu_hw_config() has been updated since 3.13, so maybe I
should upgrade the kernel... Thanks,

Brendan
