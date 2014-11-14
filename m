From: Meng Wang <meng@tupleapes.com>
Subject: error: failed mmap with 25
Date: Fri, 14 Nov 2014 17:24:53 -0500
Message-ID: <CAP3VVE0gVpfPypBvQto8r4rad-Na1Py_V5UoieZroNDATE0w4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:41266 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422727AbaKNWYx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Nov 2014 17:24:53 -0500
Received: by mail-oi0-f50.google.com with SMTP id a141so4569751oig.9
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2014 14:24:53 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,
I am trying to use perf in one ARM board. The Linux kernel is 3.8.
When I used the following command, error happens:

$ perf record -c 100000 -e '{instructions,cache-misses}:S' ./nonloop 1000
    failed to mmap with 25 (Inappropriate ioctl for device)
    nonloop: Terminated

Could anyone tell me how to fix the problem? Thanks in advance.

Regards,
wm
