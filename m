From: Viktor Rosenfeld <listuser36@gmail.com>
Subject: Performance counter to measure data transfer between RAM and CPU
Date: Fri, 4 Jan 2013 13:54:09 +0000 (UTC)
Message-ID: <loom.20130104T144700-615@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51976 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724Ab3ADN7w (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Jan 2013 08:59:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Tr7oa-0007Ni-Bj
	for linux-perf-users@vger.kernel.org; Fri, 04 Jan 2013 15:00:04 +0100
Received: from dh1949412-22.wlan.hu-berlin.de ([194.94.12.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Jan 2013 15:00:04 +0100
Received: from listuser36 by dh1949412-22.wlan.hu-berlin.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Jan 2013 15:00:04 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

is there a performance counter that allows me to measure the amount of data
that is transferred from RAM to the CPU during a computation? I'm only
interested in relative values to compare two different programs.  I'm currently
using cache-references for this. My assumption is that data that goes from RAM
to the CPU has to pass through the LLC. Is this a reasonable assumption? Or is
there maybe a better way? The computation consumes the data in a single pass.

Thanks,
Viktor
