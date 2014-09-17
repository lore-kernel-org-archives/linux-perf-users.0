From: david lerner <dlernerdroid@gmail.com>
Subject: Is perf userspace probe supported on mips
Date: Wed, 17 Sep 2014 10:12:01 -0500
Message-ID: <CANq2XvEt-vu0mR9cL3nRxuifOdi_cG+X+UPqSZ6qBUE_YnhmLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35937 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbaIQPMC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 17 Sep 2014 11:12:02 -0400
Received: by mail-oi0-f66.google.com with SMTP id u20so256006oif.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2014 08:12:01 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Is there perf uprobe support for mips?   I don't see
ARCH_SUPPORTS_UPROBE in my 3.14 version of Kconfig fragments and there
isn't the expected mips-specific mips/kernel/uprobes.c implementation.
Thanks,
Dave
