From: Donitta <sabra_gr@yahoo.fr>
Subject: How to monitor sampling over time with Perf
Date: Sun, 28 Apr 2013 12:01:24 +0000 (UTC)
Message-ID: <loom.20130428T132842-381@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37080 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755821Ab3D1MBg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 28 Apr 2013 08:01:36 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1UWQIQ-0004Hb-Io
	for linux-perf-users@vger.kernel.org; Sun, 28 Apr 2013 14:01:34 +0200
Received: from 82.220.1.207 ([82.220.1.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Apr 2013 14:01:34 +0200
Received: from sabra_gr by 82.220.1.207 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Apr 2013 14:01:34 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,
I would like to monitor perf results over time. For example, I would like to 
have all the occurrences of an event and their timestamp of occurrence.
How can I have those infos? I read somewhere in the documentation that perf 
script command provides timestamps for each occurrence, but when I tried this 
command I didn't understand it's output, and there is no documentation. 
Could someone plead provide me examples on how to use perf utilities to answer 
my needs?

Many thnaks
