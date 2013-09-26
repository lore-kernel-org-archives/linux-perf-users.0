From: caobenzhi <caobenzhi0915@gmail.com>
Subject: Re: how to see glibc symbol when using perf to profile programs
Date: Thu, 26 Sep 2013 09:04:55 +0000 (UTC)
Message-ID: <loom.20130926T110223-690@post.gmane.org>
References: <loom.20130926T032429-925@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36105 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471Ab3IZJFT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 26 Sep 2013 05:05:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1VP7Va-00028U-Jw
	for linux-perf-users@vger.kernel.org; Thu, 26 Sep 2013 11:05:15 +0200
Received: from 222.195.92.204 ([222.195.92.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2013 11:05:14 +0200
Received: from caobenzhi0915 by 222.195.92.204 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2013 11:05:14 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

caobenzhi <caobenzhi0915 <at> gmail.com> writes:


Now I solve this problem by using the following two commands:
sudo apt-get install libc6-dbg
sudo apt-get source libc6-dev
But I got another problem, how to know which code trigger page fault in 
Perf?
Thanks and regards~
Emily
