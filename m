From: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Subject: Event not supported
Date: Tue, 18 Feb 2014 13:51:46 -0300
Message-ID: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:38653 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218AbaBRQw1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Feb 2014 11:52:27 -0500
Received: by mail-ie0-f178.google.com with SMTP id ar20so3006514iec.9
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2014 08:52:26 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I'm still learning perf, so I apologize in advance if my questions are
too simple and not suited here. I did, however, searched the web and
tried to find a solution by myself before posting to this mailing
list.

From my manufacturer's manual, I chose an event I'm interested in
monitoring. They also list unit masks, as below:

UnitMask    Description
7                  From Local node to Node 7
6                  From Local node to Node 6
5                  From Local node to Node 5
4                  From Local node to Node 4
3                  From Local node to Node 3
2                  From Local node to Node 2
1                  From Local node to Node 1
0                  From Local node to Node 0

The event is "CPU to DRAM Requests to Target Node" (NUMA machine) and
it's number is 0x1E0. As I understood, I should precede the event with
the unit mask. So, for example, if I'm interested in unit mask 2, I
should type:

perf stat -e r21e0 /bin/ls

However, this results in a <not supported> message. This happened for
all events that have a unit mask that I tried. Other events worked
fine.

I'm not sure whether I'm giving the right command or this is a problem
with perf/kernel version. As it turned out, I'm running Ubuntu with
kernel 3.11.10-03111002, but the latest available perf version from
the repositories is 3.8.0-35, which is the one I'm using.

Any help is appreciated.

Thank you,
Martin
