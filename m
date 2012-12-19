From: Shahina Rabbani <shahinarabbani.shaik@gmail.com>
Subject: perf listed events are not supported when tested
Date: Wed, 19 Dec 2012 14:54:09 +0000 (UTC)
Message-ID: <loom.20121219T155022-994@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57435 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab2LSOy0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 19 Dec 2012 09:54:26 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1TlL2Z-0001ip-2t
	for linux-perf-users@vger.kernel.org; Wed, 19 Dec 2012 15:54:35 +0100
Received: from 106.51.156.173 ([106.51.156.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Dec 2012 15:54:35 +0100
Received: from shahinarabbani.shaik by 106.51.156.173 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Dec 2012 15:54:35 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am working on perf tool from last 1 month. 
I am using arndale board.
I did native compilation of perf tool on arndale target board. 
I set up the target board by following the steps from
 
https://wiki.linaro.org/Boards/Arndale/Setup/EnterpriseUbuntuServer 

I took the same kernel source code to target board and 
did perf compiling and got the perf tool.

Now the  problem is that :
perf list shows a list of pre-deifned events,
but when i tried to count on those events it gives error message.

Example:

perf record -e cycles ls : it works well
perf record -e instructions ls : it gives error saying 
"The instructions event is not supported.  ls: Terminated"

But perf list shows all thse events.

Please help me.


Thanks,
Shahina Rabbani
