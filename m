From: Jerome Correnoz <jerome.correnoz@st.com>
Subject: Re: Is it possible to get (or compute) the consummed CPU with perf ?
Date: Sun, 30 Nov 2014 20:37:19 +0000 (UTC)
Message-ID: <loom.20141130T212144-298@post.gmane.org>
References: <loom.20141111T083453-589@post.gmane.org> <loom.20141118T183130-762@post.gmane.org> <546B8B05.5000102@gmail.com> <loom.20141126T191243-557@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60138 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbaK3Uhh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 30 Nov 2014 15:37:37 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1XvBFM-0005d1-Qj
	for linux-perf-users@vger.kernel.org; Sun, 30 Nov 2014 21:37:33 +0100
Received: from 77.242.202.229 ([77.242.202.229])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sun, 30 Nov 2014 21:37:32 +0100
Received: from jerome.correnoz by 77.242.202.229 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sun, 30 Nov 2014 21:37:32 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

It seems possible to compute the CPU load by exploiting the 'perf stat'
results, in particular the GHz reported with "cycles" when using 'perf stat
-a sleep x'

For our use case example, it reports "CPU cycles 0.132 GHZ".
Knowing that the cpu frequency is 1.2 GHz (from
/sys/devices/system/cpu/cpu[01]/cpufreq/cpuinfo_cur_freq)
We can deduce the CPU load: 0.132/1.2*100=11% 

In our system, we've checked with different use cases for which we know the
expected values and using the above method allows to get very accurate values.

Can someone confirm that this method is reliable and a good way to get
accurate CPU load figures ?

Regards,
  Jerome
