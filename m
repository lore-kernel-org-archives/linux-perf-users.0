From: "John O'Sullivan" <john.osullivan@cloudiumsystems.com>
Subject: Perf on Embedded Systemsp
Date: Fri, 15 May 2015 14:59:36 +0100
Message-ID: <5555FBC8.2090404@cloudiumsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from atl4mhob04.myregisteredsite.com ([209.17.115.42]:57097 "EHLO
	atl4mhob04.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946058AbbEON7j (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 15 May 2015 09:59:39 -0400
Received: from mailpod1.hostingplatform.com (atl4obmail02pod1.mgt.hosting.qts.netsol.com [10.30.71.114])
	by atl4mhob04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id t4FDxbUV009159
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2015 09:59:37 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,
I have been trying without success to get perf running on an arm board. 
I have written a sample application (called sample_static_application) 
and it links to a static library.
In linking the file I use the linker directive (as advised in 
https://perf.wiki.kernel.org/index.php/Tutorial)

After I generate my binary I do the following:
arm-xilinx-linux-gnueabi-objcopy --only-keep-debug 
./sample_static_application sample_static_application.debug

as suggested in 
(http://sourceware.org/gdb/onlinedocs/gdb/Separate-Debug-Files.html)
I copy both of these files to
/usr/bin
so that I have
/usr/bin/sample_static_application
and
/usr/bin/sample_static_application.debug
When I run perf I get:
Failed to open /usr/bin/sample_static_application, continuing without 
symbols

If I run perf buildid-cache and then run perf buildid-list I just get
5b52.....................................255a [kernel-kallsyms]

What do I need to do to be able to see the symbols for my 
sample_static_application? I have searched the web for days without any 
luck.
Is there some way to register the .debug files or should perf just find 
them, where does it look for them.

I know there is a command

perf-buildid-cache --add , but what format is this looking for and how would I add my application symbols using this command.


Just for the record I also copied sample_static_application.debug to /usr/bin/debug and /usr/bin/.debug but still I get the same message:
Failed to open /usr/bin/sample_static_application, continuing without symbols

Any suggestions?

regards
John
