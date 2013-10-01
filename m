From: Yuanfang Chen <cyfmxc@gmail.com>
Subject: measure uncore events
Date: Tue, 1 Oct 2013 13:34:49 -0400
Message-ID: <CAJh9x3o3au3ouwn4TTPt+CGyh3bo_u0Qo5LiKshe3HmSY7er4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:60937 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab3JAReu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Oct 2013 13:34:50 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so7526123wgg.34
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2013 10:34:49 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello all,

I'm trying to measure uncore events. After reading [1], I tried "perf
stat -a -e "uncore_imc_0/event=0xff,umask=0x00/" /bin/ls", it says
"invalid or unsupported event".

The machine is Intel Ivy Bridge i5-3320M with ArchLinux 3.11.2-1-ARCH.
'perf --version'  is 'perf version 3.11.0'
In '/sys/bus/event_source/devices/uncore_cbox_0/events', there is only
one event 'clockticks'.

Did I miss something?

thanks,
yuanfang


[1] http://web.eece.maine.edu/~vweaver/projects/perf_events/faq.html#q1c
