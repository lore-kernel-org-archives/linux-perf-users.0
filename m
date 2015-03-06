From: =?UTF-8?B?Sm9zw6kgU2ltw6Nv?= <jose.m.simao@gmail.com>
Subject: event power/energy-dram/
Date: Fri, 6 Mar 2015 11:45:41 +0000
Message-ID: <CAJ38vxvP3wJ8tBKoithLa6T7CztVrjiWuRYVDO8s1s5vMD8++w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:41951 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbbCFLpm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 6 Mar 2015 06:45:42 -0500
Received: by wevm14 with SMTP id m14so58918404wev.8
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2015 03:45:41 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear all,

I have a system with an SandyBridge family CPU (i7-2600K), on a Ubuntu
server with kernel 3.16.0-31-generic, and perf version 3.16.7-ckt5.

I would like to access the event power/energy-dram/ but its not
available in the event list (and in fact the stat command cannot read
from it).

The available power events are:
power/energy-cores/
power/energy-gpu/
power/energy-pkg/

The documentation on this counters says "servers only"
(http://lwn.net/Articles/573602/).

Can anyone tell me how if I can read this counter on my system and how?

Best regards,
Jose Simao
