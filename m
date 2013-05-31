From: Holger Brunck <holger.brunck@keymile.com>
Subject: perf top and multithreaded applications
Date: Fri, 31 May 2013 11:04:27 +0200
Message-ID: <51A8679B.9030405@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-de.keymile.com ([195.8.104.250]:57143 "EHLO
	mail-de.keymile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab3EaJEg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 31 May 2013 05:04:36 -0400
Received: from frodo.de.keymile.net ([10.9.1.54]:52250 helo=mailrelay.de.keymile.net)
	by mail-de.keymile.com with esmtp (Exim 4.76)
	(envelope-from <Holger.Brunck@keymile.com>)
	id 1UiLG8-0005I8-1Z
	for linux-perf-users@vger.kernel.org; Fri, 31 May 2013 11:04:28 +0200
Received: from srvdehan1003.de.keymile.net (srvdehan1003.de.keymile.net [10.9.1.108])
	by mailrelay.de.keymile.net (8.12.2/8.12.2) with ESMTP id r4V92Sxd019269
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2013 11:02:29 +0200 (MEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,
I have a question to use perf on a multithread application.

I am able to attach "perf top" to a specific TID with "-t" and then I see only
the symbols and performance of this specific thread.

Am I able to zoom into a specific thread if I start "perf top" in a system wide
mode? I am able to switch between different processes and see the performance
measured for this specific process. But if this process is multithreaded I am
unable to zoom further into one of his threads. The symbols which are shown are
always for the whole process.

So is this in general possible? Am I miss something?

I currently use perf taken from the 3.4 kernel on a embedded powerpc board
running a 3.0.40 kernel.

Many thanks in advance.

Regards
Holger
