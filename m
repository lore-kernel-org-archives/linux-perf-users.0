From: Hemant Jain <hemu.mits@gmail.com>
Subject: "perf top" what does high CPU use in _schedule means?
Date: Thu, 15 Feb 2018 16:28:10 +0530
Message-ID: <CAOrc50R1iVsqXGBF+L_WnYrXsb82mY0JLDaMPhCsSjUX4=fJDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:37696 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966589AbeBOK6b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Feb 2018 05:58:31 -0500
Received: by mail-ua0-f170.google.com with SMTP id q8so15559663uae.4
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2018 02:58:31 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

In one of my test env I am setting perf top is showing ~20% time CPU
spent in _schedule function.
What does means ?

In my setup I have 6 cores and lot of threads are running.
CPU usage is also very less during this time.(~10%)
My application has some data to process but is not doing any processing.

I am new to this mailing list. Hope I am using correct mailing list alias :).
