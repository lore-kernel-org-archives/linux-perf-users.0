From: Donitta <sabra_gr@yahoo.fr>
Subject: No tracepoint event in the perf list output
Date: Mon, 8 Apr 2013 09:51:32 +0000 (UTC)
Message-ID: <loom.20130408T113553-844@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59317 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762735Ab3DIGuH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 9 Apr 2013 02:50:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1UPSNX-0000dL-Bo
	for linux-perf-users@vger.kernel.org; Tue, 09 Apr 2013 08:50:03 +0200
Received: from 82.220.1.207 ([82.220.1.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Apr 2013 08:50:03 +0200
Received: from sabra_gr by 82.220.1.207 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Apr 2013 08:50:03 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

 According to the perf documentation, when running "perf list" command we 
should have all pre-defined events that could be hardware, software, hardware 
cache, raw hardware event descriptor, hardware breakpoint or tracepoint event.
In my case, when I executed the perf list command I had all type of events 
listed except the tracepoint event. 
What does this mean?

PS: I'm using perf on an embedded OS on ARM cortex 9 core.

Best regards
