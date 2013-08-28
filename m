From: Chris Freehill <cfreehill@gmail.com>
Subject: help with porting perf lkm to later kernel
Date: Wed, 28 Aug 2013 17:53:24 -0500
Message-ID: <CANFySve_0Mw48knK-1ueWjibBQfzfgLQzOhJde5zWL9OZO3iYw@mail.gmail.com>
Reply-To: cfreehill@alumni.utexas.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:35318 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab3H1WxZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 28 Aug 2013 18:53:25 -0400
Received: by mail-we0-f178.google.com with SMTP id u54so5862835wes.9
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2013 15:53:24 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Another way to ask this, is why are these symbols no longer exported
(previously exported in core.c with EXPORT_SYMBOL_GPL), and how are
people who built lkm's using the previously existing interface
supposed to port them? Is it perhaps documented somewhere? I have not
been able to find this via google or in git comments.

Is this the wrong forum for this question (which I grant may be a
"newbie" question), or is there just no good answer?

thanks,
chris


> I am trying to get my linux kernel module that extends perf support to work
> in a later kernel version. The lkm had been working in 3.0.51.
>
> In the new target kernel to which I am trying to port, 3.8.13, I get
> warnings at the modpost stage complaining about symbols that can no longer
> be found. If I attempt to load that module, I get errors saying the same
> thing (those symbols can't be found).
>
> The symbols that can't be found are
>
> ".perf_pmu_enable"
>
> ".perf_event_update_userpage"
>
> ".perf_pmu_disable"
>
> ".perf_event_overflow"
>
> ".perf_pmu_unregister"
>
> ".perf_pmu_register"
>
> Does anyone have any tips or advice as to how code that calls these
> previously working functions should now be handled when built against later
> kernels?
