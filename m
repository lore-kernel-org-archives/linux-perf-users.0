From: Keno Fischer <kfischer@college.harvard.edu>
Subject: Sampling hardware counter values with timers
Date: Fri, 13 May 2016 00:00:16 -0400
Message-ID: <CAEoGj_-43BRwknevsRtZWpwLuF5sh=mYs5J36swowB17FwkWxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35004 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbcEMEAh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 00:00:37 -0400
Received: by mail-oi0-f49.google.com with SMTP id x19so152319866oix.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2016 21:00:36 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello everyone,

I was wondering if it is possible (either using the `perf` user space
tool or using the perf_events API) to periodically sample the value of
a hardware counter (in my particular case I'd like to sample the
retired-branch-counter). I know it is possible to do the opposite
(i.e. sample a timestamp every specified number of branches), but I
wasn't able to see an easy way to sample the hardware counter at a
specified frequency. Is this possible?

Thanks,
Keno
