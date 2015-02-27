From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Ftrace reading binary
Date: Fri, 27 Feb 2015 07:41:25 +0000 (UTC)
Message-ID: <loom.20150227T083753-972@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42660 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbbB0HpH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Feb 2015 02:45:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YRFbb-0003Hs-HJ
	for linux-perf-users@vger.kernel.org; Fri, 27 Feb 2015 08:45:04 +0100
Received: from 121.244.210.162.static-Banglore.vsnl.net.in ([121.244.210.162.static-Banglore.vsnl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2015 08:45:03 +0100
Received: from sahil.agg15 by 121.244.210.162.static-Banglore.vsnl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2015 08:45:03 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,
I am trying to read binary of format struct of an event enabled. When i enable 
binary by bin > trace_options it was giving binary but binary of what i used to 
get by enabling raw > trace_options. I was wondering if there is any way to get 
binary of struct of format associated with events. 

With this it will be easy to use it C by simply setting the offset to access the 
value instead of parsing text from trace_pipe. 

Thanks
Regards
