From: Vivek Nair <vivekaxl@gmail.com>
Subject: Task Clock (Cgroup)
Date: Sat, 2 Nov 2013 22:00:12 -0400
Message-ID: <CAOWdYyV+BuOMmfFurrC-gHhMDVA7ZOe4hy8UcwJ+nKq_U1vGZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:65532 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab3KCCAe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 2 Nov 2013 22:00:34 -0400
Received: by mail-vb0-f49.google.com with SMTP id w20so582922vbb.22
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2013 19:00:34 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hello All,

I am trying to find the task clock of a cgroup(containing hadoop) in
the counting mode but I see that the task clock is always 4 (number of
cores in the system). I did the following tests on it

1. Ran a empty cgroup and found the task clock (always constant value of 4)
2. Ran a infinite loop inside the cgroup (still 4).

Could you please help me understand what could be going wrong?

Regards,
Vivek Nair
