From: Anton Danilov <littlesmilingcloud@gmail.com>
Subject: perf trace netdev-times issue
Date: Mon, 14 Sep 2015 15:00:12 +0300
Message-ID: <55f6b6cc.yswi6LHos+I8DGli%littlesmilingcloud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35317 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbbINMAP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Sep 2015 08:00:15 -0400
Received: by lbpo4 with SMTP id o4so66144794lbp.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2015 05:00:14 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: littlesmilingcloud@gmail.com

Hello everyone.

I have tried to use the perf trace netdev-times feature and have got the some issues.

At run the command from documentation I see the error message:
  danilov@danilov:~$ perf --version
  perf version 4.2.0
  danilov@danilov:~$ uname -a
  Linux danilov 4.2.0.61 #3 SMP PREEMPT Mon Sep 14 12:39:00 MSK 2015 x86_64 GNU/Linux
  danilov@danilov:~$ sudo perf trace record netdev-times rx
  Workload failed: No such file or directory

I'm stuck with this error. Please help.

--
With best regards, Anton Danilov
