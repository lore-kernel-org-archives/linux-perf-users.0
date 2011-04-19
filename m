From: "Carl E. Love" <cel@us.ibm.com>
Subject: Non core PMU support
Date: Tue, 19 Apr 2011 13:47:21 -0700
Message-ID: <1303246041.6382.8.camel@carll-linux-laptop2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:40719 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822Ab1DSUrY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Apr 2011 16:47:24 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3JKPDmQ008823
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2011 16:25:13 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p3JKlNqJ217032
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2011 16:47:23 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3JKlNE5022881
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2011 17:47:23 -0300
Received: from [9.47.24.104] (carll-linux-laptop2.beaverton.ibm.com [9.47.24.104])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p3JKlMoW022834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2011 17:47:23 -0300
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Perf users:

I am working on the kernel support for a non CPU PMU.  I believe Intel
calls these uncore PMUs.  Lin Ming posted a patch to add uncore PMU
support last November or so.  It was not accepted.  It is my
understanding the thought on how to name the uncore PMUs was to add the
PMU to the /sys/devices tree.  The user would then give the complete
path to the PMU to identify the PMU.  The user tool would then look up
the PMU type using the specified PMU sysfs path.  The PMU type is then
passed to the kernel to open an event on the specified PMU.  

I don't see any support in the user perf tool for specifying an uncore
PMU.  There is kernel support for multiple PMUs.  

I have not found any recent work on adding uncore PMUs to perf.  Can
anyone tell me what the current approach is to supporting uncore PMUs?
Any pointers on how to add an uncore PMU would be appreciated.

Thanks in advance.

               Carl Love
