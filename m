From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: perf segfault in docker container
Date: Thu, 9 Jun 2016 14:14:11 -0700
Message-ID: <CAE40pdfWpz6rreOCMJCs1P8WXfOXO_B5zZoeOyC_5usYGp8xRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:32835 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcFIVOl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 9 Jun 2016 17:14:41 -0400
Received: by mail-it0-f66.google.com with SMTP id u203so6741314itc.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2016 14:14:41 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>

G'Day,

Default docker container, in Linux 4.7-rc2, with latest perf from perf/core:

docker# ./perf record -F 99 -a
Segmentation fault

The segfault is in perf_event__synthesize_kernel_mmap(). I know
symbol__read_kptr_restrict() has been updated recently to fix similar
segfaults, hence getting perf/core.

I think the problem is this:

docker# id
uid=0(root) gid=0(root) groups=0(root)
docker# cat /proc/sys/kernel/kptr_restrict
1

(I'd previously set "echo -1 > /proc/sys/kernel/perf_event_paranoid")

The current (May 24) code has, symbol__read_kptr_restrict():

                if (fgets(line, sizeof(line), fp) != NULL)
                        value = (geteuid() != 0) ?
                                        (atoi(line) != 0) :
                                        (atoi(line) == 2);

assumes that if euid is 0 && kptr_restrict isn't 2, then we're aren't
restricted. But we are. Maybe the code should check for CAP_SYS_ADMIN,
instead of euid == 0?

Brendan
