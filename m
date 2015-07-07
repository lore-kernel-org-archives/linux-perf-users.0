From: Daniel Ortiz <daniel.ortiz@tum.de>
Subject: perf top for memory access profiling
Date: Tue, 7 Jul 2015 12:20:57 +0000 (UTC)
Message-ID: <mngg78$ft9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42907 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbbGGMVG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Jul 2015 08:21:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1ZCRs0-0003sS-Eo
	for linux-perf-users@vger.kernel.org; Tue, 07 Jul 2015 14:21:04 +0200
Received: from host198-2.natpool.mwn.de ([138.246.2.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jul 2015 14:21:04 +0200
Received: from daniel.ortiz by host198-2.natpool.mwn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jul 2015 14:21:04 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello

Right now I am interested in profiling memory accesses. So far I have
used perf mem record (perf mem record -W -d -e "cpu/mem-loads/pp") and
then perf mem report to get information about the address being
accessed, the access latency and the type of access such as l1,l2,l3 and
remote hit or miss. This information would correspon to the fields
"Local", "Weight, "Memory access" and "Data symbol" that are shown by
the default in perf mem report.

I need to move to solution that shows the sampled information right as
it is retrived from the hardware without user intervention, just like
perf top does. Howewer, it seems that perf top does not show such
information with memory access sampling, I have tried doiing the
following :

I started trying to run perf mem record -W -d -e "cpu/mem-loads/pp" but
then I realized that perf top does not support the -d and -W option in
the same way perf record does, what I did was changing the top struct in
the cmd_top functions more specifically the
top.record_opts.sample_address and top.record_opts.sample_weight fields
but the required information is still not shown.

The question is whether you know if perf top is capable in any way of
showing the same information that perf mem report shows even if some
tweaks are necessary.

Kind regards...

Daniel Ortiz
