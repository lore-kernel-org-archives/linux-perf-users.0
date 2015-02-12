From: Elazar Leibovich <elazar.leibovich@ravellosystems.com>
Subject: Despite exclude_host=1, I see PERF_RECORD_MISC_KERNEL samples
Date: Thu, 12 Feb 2015 15:37:05 +0200
Message-ID: <CAL2Y34BuNJ5Hiv-p5ZDJACzeimLa2jqC6i_H_=mbJ1+Vn-aP2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:43081 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbbBLNhG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Feb 2015 08:37:06 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so6582128igb.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2015 05:37:06 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>

Hi,

I'm using the perf_event_open() syscall with the cycle event.

Here is a description of the argument I give to perf_event_open:

"attr": {
  "type": "PERF_TYPE_HARDWARE",
  "config": "PERF_COUNT_HW_CPU_CYCLES",
  "sample_freq": 499,
  "exclude_idle": true,
  "exclude_host": true,
  "freq": true,
  "wakeup_events": 1,
  "sample_type": [
    "PERF_SAMPLE_IP",
    "PERF_SAMPLE_CPU",
    "PERF_SAMPLE_TIME"
  ]
}

While most of the samples I see have misc event of
PERF_RECORD_MISC_GUEST_KERNEL or PERF_RECORD_MISC_GUEST_USER, I still
see a very small amount of samples with PERF_RECORD_MISC_KERNEL
(1280/345161=0.38%).

I can see that the kernel is instructing the hardware to halt only inside guest

E.g., perf_event_intel.c:

    cpuc->intel_ctrl_guest_mask |= (1ull << hwc->idx);

and then

    wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL,
        x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask);

but I'm not sure if indeed the hardware PMUs guarantee never to
interrupt CPU when not in guest mode.

Is it expected? Is it a bug in my code?

(if needed, I can post the code that recreates this scenario).

Here is an example output, including all kind of samples, last line is
the MISC_KERNEL sample that shouldn't be there due to exclude_host in
perf_event_attr:

{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_GUEST_KERNEL","sample":{"ip":"ffffe8ff09853041","time":21195311625103,"cpu":3}}
{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_GUEST_KERNEL","sample":{"ip":"ffffe8ff0cbcfc60","time":21195312545321,"cpu":1}}
{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_GUEST_KERNEL","sample":{"ip":"ffffe8ff000107d4","time":21195313326630,"cpu":3}}
{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_GUEST_KERNEL","sample":{"ip":"ffffe8ff000698cb","time":21195314604935,"cpu":1}}
{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_GUEST_KERNEL","sample":{"ip":"ffffe8ff094e5ef0","time":21195315062329,"cpu":3}}
{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_GUEST_KERNEL","sample":{"ip":"ffffe8ff0006fd51","time":21195316464065,"cpu":1}}
{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_GUEST_KERNEL","sample":{"ip":"ffffe8ff000107c0","time":21195316880401,"cpu":3}}
{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_GUEST_USER","sample":{"ip":"416010","time":21195318316122,"cpu":1}}
{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_GUEST_KERNEL","sample":{"ip":"ffffe8ff00003201","time":21195318703803,"cpu":3}}
{"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_KERNEL","sample":{"ip":"ffffffffa083cf54","time":21195320183609,"cpu":1}}

Thanks,
Elazar
