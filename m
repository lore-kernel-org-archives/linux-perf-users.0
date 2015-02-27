From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Perf API vs Ftrace
Date: Fri, 27 Feb 2015 08:05:04 +0000 (UTC)
Message-ID: <loom.20150227T085458-261@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43507 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbbB0IFP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Feb 2015 03:05:15 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YRFv7-00069C-2J
	for linux-perf-users@vger.kernel.org; Fri, 27 Feb 2015 09:05:13 +0100
Received: from 121.244.210.162.static-Banglore.vsnl.net.in ([121.244.210.162.static-Banglore.vsnl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2015 09:05:13 +0100
Received: from sahil.agg15 by 121.244.210.162.static-Banglore.vsnl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2015 09:05:13 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I am trying to write an application to do complete process profiling.
Currently i am following the way of using ftrace. 
I enable some events and  parse the text from trace_pipe. 
i create csv of all the stats which i will use later to create graphs. 
But recently i came across Perf API.
Is Perf API better option than writing something over ftrace.?

Thanks
Regards
