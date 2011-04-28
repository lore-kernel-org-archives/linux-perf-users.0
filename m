From: Francis Moreau <francis.moro@gmail.com>
Subject: vmlinux buildid doesn't match the running one (/sys/kernel/notes)
Date: Thu, 28 Apr 2011 19:04:13 +0200
Message-ID: <BANLkTim+kr6TYdkuh=bugJaNmSnLE0h-8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:58320 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab1D1REO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Apr 2011 13:04:14 -0400
Received: by pxi2 with SMTP id 2so173739pxi.10
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2011 10:04:13 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I'm trying to use perf-probe, but it fails.

Basically it's due to the buildid of the running kernel (the one which
can be read from /sys/kernel/notes) and the one in vmlinx (which I
compiled my self).

I did this:

  $ make
  $ make modules_install install
  $ ls vmlinux
  vmlinux

reboot

  $ perf probe -k vmlinux -L schedule
  Failed to find path of kernel module.
  Failed to open debuginfo file.
  Error: Failed to show lines. (-2)

So my question is why the buildids doesn't match ?

I guess I did something wrong since it's pretty a standard use case
but I don't see why...

Thanks
-- 
Francis
