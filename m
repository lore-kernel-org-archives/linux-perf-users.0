From: Arnav <arnav.gupta06@live.in>
Subject: sampling and reading
Date: Tue, 4 Nov 2014 20:27:08 +0000 (UTC)
Message-ID: <loom.20141104T212325-617@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47726 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbaKDU10 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Nov 2014 15:27:26 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1XlkhF-0004Yz-JH
	for linux-perf-users@vger.kernel.org; Tue, 04 Nov 2014 21:27:24 +0100
Received: from host-128-227-37-204.xlate.ufl.edu ([128.227.37.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2014 21:27:21 +0100
Received: from arnav.gupta06 by host-128-227-37-204.xlate.ufl.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2014 21:27:21 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

i am working on a project where i need to find program counters for every 100M 
instructions.

i have used the  following command to record the event

perf record -e instructions -c 100000000 ./filename

now, since counters are counted every 100M instructions, i read file using 
'perf report'. But i get results in some percentage form and not in numerical 
numbers format.

i wish to read the file and gather the perforamance counter statistics. 
Plz suggest how to get the desired results.

thanks
