From: Thorsten Schuett <schuett@gmail.com>
Subject: perf with gnuplot
Date: Wed, 23 Jan 2013 13:38:00 +0100
Message-ID: <50FFD9A8.5000500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:60072 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab3AWMn5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Jan 2013 07:43:57 -0500
Received: by mail-la0-f42.google.com with SMTP id fe20so8774899lab.29
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jan 2013 04:43:56 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I record three different events for my test-program:
perf record -s -e cycles,instructions,LLC-load-misses ./test-program

I want to plot the occurences of the different events over time, i.e. 
x-axis is time and y-axis is event count.

With
perf report -D
I can dump perf.data to ASCII. However, I could not figure out how to 
extract different event types from the ASCII output.

0x1edb88 [0x30]: event: 9
.
. ... raw event: size 48 bytes
.  0000:  09 00 00 00 02 00 30 00 43 b6 2f e7 52 2b 00 00 ......0.C./.R+..
.  0010:  2b 20 01 00 2f 20 01 00 2e 21 8e 48 b4 a9 26 00  + ../ ...!.H..&.
.  0020:  f6 6d 00 00 00 00 00 00 6b 60 63 00 00 00 00 00 .m......k`c.....
.
10882640891486510 0x1edb88 [0x30]: PERF_RECORD_SAMPLE(IP, 2): 
73771/73775: 0x2b52e72fb643 period: 6512747 addr: 0

I figured out how to parse the timestamp, pid and pid and I guess period 
says how often an event happened in the period. However I do not know 
which event occured. Is this only encoded in the raw event or am I 
missing something?

Thorsten
