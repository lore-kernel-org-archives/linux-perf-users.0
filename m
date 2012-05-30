From: Joy Arulraj <prabhu.link@gmail.com>
Subject: Is sampling in perf spread across the program ?
Date: Wed, 30 May 2012 02:19:01 +0000 (UTC)
Message-ID: <loom.20120530T040734-241@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56131 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756197Ab2E3CTM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 May 2012 22:19:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1SZYVC-0004Np-7Z
	for linux-perf-users@vger.kernel.org; Wed, 30 May 2012 04:19:10 +0200
Received: from angua.cs.wisc.edu ([128.105.7.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 30 May 2012 04:19:10 +0200
Received: from prabhu.link by angua.cs.wisc.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 30 May 2012 04:19:10 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

 I understand that sampling in perf is done by raising interrupts based on user
specified sampling rate. Also, though the sampling rate can change dynamically
over the execution, the overall sampling rate is maintained to closely match the
user specified sampling rate.

 But, will the samples collected by repeatedly sampling the same program differ
across runs ?

 Like, if the sampling rate is "collect 1 sample every 500 events". And say in
run 1 of a program, perf collects the 500th, 1000th, 1500th .. events. And say
in run 2 of the same program with same sampling rate, perf collects the 499th,
1002th, 1501th .. events. Will Perf ever sample some midway events like 250th or
750th events in the program with the same sampling rate ? 

 ie. Is the sampling *spread* over the entire program across multiple runs ? If
not, how can we achieve something like that - maybe some initial offset after
which perf starts collecting events ?

Thanks,
Joy 
