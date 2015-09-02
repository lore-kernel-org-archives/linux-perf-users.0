From: Daniel Ortiz <daniel.ortiz@tum.de>
Subject: Meaning of weight and source fields in perf mem samples
Date: Wed, 2 Sep 2015 06:22:40 +0000 (UTC)
Message-ID: <ms64jg$cfo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57482 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbbIBGWw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 02:22:52 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1ZX1RZ-00062D-Gn
	for linux-perf-users@vger.kernel.org; Wed, 02 Sep 2015 08:22:49 +0200
Received: from host198-2.natpool.mwn.de ([138.246.2.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2015 08:22:49 +0200
Received: from daniel.ortiz by host198-2.natpool.mwn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2015 08:22:49 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello everyone

I am using perf on an Intel Sandy Bridge Numa System and I have a question about the samples taken with perf mem record:

What is the meaning of the weight value and source of a sample?

Since the measurement is made using Intel's event CDH, umask 01H (Table 19-7 of the manual),
 I would expect this value to be as what is described in the manual:
 
"The load latency provides software a means to characterize the average load latency to different levels of cache/memory hierarchy ... This field measures the load latency from load's first dispatch of till final data writeback from the memory subsystem. The latency is reported for retired demand load operations and in core cycles (it accounts for re-dispatches)" (18.9.4.2).

But I have not found any source that confirms whether perf is taking
this value or not. Could anyone confirm me if these are the values
that perf is putting on the samples or point me to the place in the
code where it is being done?
