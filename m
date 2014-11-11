From: Jerome Correnoz <jerome.correnoz@st.com>
Subject: Is it possible to get (or compute) the consummed CPU with perf ?
Date: Tue, 11 Nov 2014 08:03:44 +0000 (UTC)
Message-ID: <loom.20141111T083453-589@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39865 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705AbaKKIFI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 11 Nov 2014 03:05:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Xo6Rj-0001TF-TW
	for linux-perf-users@vger.kernel.org; Tue, 11 Nov 2014 09:05:04 +0100
Received: from 77.242.202.227 ([77.242.202.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2014 09:05:03 +0100
Received: from jerome.correnoz by 77.242.202.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2014 09:05:03 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

We're interested to know the CPU load/usage on our ARMv7 embedded system 
when running some use cases (e.g. simple video decode, double video 
decode, etc.). By CPU load, I mean a way to measure the time when the 
system was doing something else than Idle.

I've tried to get it from the performance counter statistics but couldn't 
find a way to get it, do I miss something ?

Also tried to use perf for profiling the system (e.g. perf record -a). It 
report very useful percentage for the running processes that we exploit to 
detect hot spots. But It reports X% of the used CPU (nothing related to 
Idle or "rest of CPU"). 

So, any way with perf to get this information (directly or indirectly with 
few calculation) ?

Thanks by advance,
  Jerome
