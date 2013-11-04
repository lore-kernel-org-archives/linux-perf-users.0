From: caobenzhi <caobenzhi0915@gmail.com>
Subject: how to trace to the source code
Date: Mon, 4 Nov 2013 13:54:09 +0000 (UTC)
Message-ID: <loom.20131104T145013-347@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36519 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031Ab3KDN51 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Nov 2013 08:57:27 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1VdKeY-0003fi-Jj
	for linux-perf-users@vger.kernel.org; Mon, 04 Nov 2013 14:57:17 +0100
Received: from 222.195.92.204 ([222.195.92.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2013 14:57:14 +0100
Received: from caobenzhi0915 by 222.195.92.204 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2013 14:57:14 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,everyone.
Recently I use perf to see the performance problem of my programs. But I 
cannot see the source code, what I see are all assembly code.I have already 
compile with -g option, and I use command "perf opannotate --source prime" to 
the the source code of prime function, unfortunately what I got are assembly 
code.Does anyone know how to solve it?Thanks a lot~
Best
Emily
