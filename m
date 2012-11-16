From: Animesh K Trivedi1 <ZRLATR@ch.ibm.com>
Subject: cboxes on NehalemEX
Date: Fri, 16 Nov 2012 15:46:36 +0100
Message-ID: <OF1ABEA8BA.B758F3D3-ONC1257AB8.00507893-C1257AB8.00512F18@ch.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:40695 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab2KPOqt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 16 Nov 2012 09:46:49 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <zrlatr@ch.ibm.com>;
	Fri, 16 Nov 2012 14:46:47 -0000
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com [9.149.37.250])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id qAGEkbOr34078918
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Nov 2012 14:46:37 GMT
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id qAGEkjC3001898
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Nov 2012 07:46:45 -0700
Received: from d06ml359.portsmouth.uk.ibm.com (d06ml359.portsmouth.uk.ibm.com [9.149.76.147])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id qAGEkjSk001895
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Nov 2012 07:46:45 -0700
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Bernard Metzler <BMT@zurich.ibm.com>


Hi all,

I'm testing/using uncore support on a dual socket NehalemEX (Xeon E7520)
box on 3.7-rc1.
It shows me only 4 CBOXes under devices. Although the document (Uncore
programming
for 7500) says that there should be 8 CBOXes. Am I missing something?

Also, I have a dual socket configuration, in which I assume each processor
has its own set of
CBOXes. How are number of CBOXes related to number of physical processors?
In order to
get a global view of LLC behaviour shouldn't I have to sum up the count of
events from all
physical processor's CBOXes.

Thanks,
--
Animesh
