From: Chris Freehill <cfreehill@gmail.com>
Subject: help with porting perf lkm to later kernel
Date: Tue, 27 Aug 2013 21:14:09 -0500
Message-ID: <CANFySvdsmSyd7QK61biOKMWwcR_QHVA1Xcwz9NTybGoY_2eqGw@mail.gmail.com>
Reply-To: cfreehill@alumni.utexas.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:57301 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab3H1COK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 27 Aug 2013 22:14:10 -0400
Received: by mail-wi0-f169.google.com with SMTP id l12so6187414wiv.2
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2013 19:14:09 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I am trying to get my linux kernel module that extends perf support to
work in a later kernel version. The lkm had been working in 3.0.51.

In the new target kernel to which I am trying to port, 3.8.13, I get
warnings at the modpost stage complaining about symbols that can no
longer be found. If I attempt to load that module, I get errors saying
the same thing (those symbols can't be found).

The symbols that can't be found are

".perf_pmu_enable"
".perf_event_update_userpage"
".perf_pmu_disable"
".perf_event_overflow"
".perf_pmu_unregister"
".perf_pmu_register"

Does anyone have any tips or advice as to how code that calls these
previously working functions should now be handled when built against
later kernels?

Chris
