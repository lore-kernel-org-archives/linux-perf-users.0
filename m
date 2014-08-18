From: "Jen-Cheng(Tommy) Huang" <tommy24@gatech.edu>
Subject: Problems with perf "event grouping" on Java apps
Date: Mon, 18 Aug 2014 14:46:00 -0400
Message-ID: <CABooUW2QDE_zRMyNzSEvWMEy+c-yrMvm+rSoASsx7ctBTijvFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:44161 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbaHRSqB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 18 Aug 2014 14:46:01 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so4964144qgf.6
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2014 11:46:00 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi

I am trying to use perf with event grouping to profile Java apps.
My kernel is 3.16.1-1.el6.elrepo.x86_64
perf version 3.16.1-1.el6.elrepo.x86_64
The Java app I use is hadoop TaskTracker, which spawns multiple child JVMs.
There seems to be something wrong with event group, since very few
samples were collected if I use more than one event in a group.
The following shows an example

I used
perf record -e '{instructions}:S' -c 100000 [TaskTracker command]
This one works fine and it collects a reasonable amount of samples and
several threads are sampled.

However, the following command does not work.
perf record -e '{instructions,cycles}:S' -c 100000 [TaskTracker command]
Less than 1000 samples were collected and only one thread was sampled

If I don't use :S to read samples, the sample counts are reasonable,
but the event grouping is gone. (both events were sampled, no leader
event.)
perf record -e '{instructions,cycles}' -c 100000 [TaskTracker command]

I tested single-threaded app, such as SPEC CPU.
Everything works fine. The event grouping works fine, so as the :S flag.
However, the Java app that I tested does not.
Please let me know if any suggestions on this issue.

Thanks.
