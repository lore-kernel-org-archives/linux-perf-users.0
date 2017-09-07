From: Jason Teplitz <jason@tensyr.com>
Subject: Prevent Kernel from resetting cycle counter
Date: Wed, 6 Sep 2017 17:36:36 -0700
Message-ID: <CALk3wS2cEFTnMXoyhrzyC1R_np159B4evzDRBMNK7MsAsc8UFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36470 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbdIGAgi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Sep 2017 20:36:38 -0400
Received: by mail-qt0-f178.google.com with SMTP id b52so19497784qtb.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Sep 2017 17:36:37 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm reading the armv8 PMU cycle counter from userspace and noticing
that it gets periodically reset by something. Does anything inside the
kernel reset these counters? I am not using perf, so I'm not sure why
anything else would be touching them.

-Jason
