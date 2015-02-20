From: Paul Clarke <pc@us.ibm.com>
Subject: uprobe symbols with @GLIBC...
Date: Fri, 20 Feb 2015 09:29:03 -0600
Message-ID: <54E752BF.50309@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:38886 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755095AbbBTP3I (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Feb 2015 10:29:08 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
	Fri, 20 Feb 2015 10:29:07 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9F597C90042
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 10:20:15 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1KFT44026935356
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 15:29:04 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1KFT4ig000487
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 10:29:04 -0500
Received: from oc3241255568.ibm.com ([9.80.97.206])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t1KFT4Kh000450
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 10:29:04 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Greetings,

(New user for perf probe -x...)

How does one set a dynamic tracepoint for user-mode symbols with "@" 
qualifiers?

# perf probe -F -x /lib/libpthread.so.0 --filter='pthread_create*'
pthread_create@@GLIBC_2.1
pthread_create@GLIBC_2.0

# perf probe -v -x /lib/libpthread.so.0 pthread_create@GLIBC_2.0
probe-definition(0): pthread_create@GLIBC_2.0
symbol:pthread_create file:GLIBC_2.0 line:0 offset:0 return:0 lazy:(null)
0 arguments
Failed to open debuginfo file.
   Error: Failed to add events. (-2)

# perf probe -v -x /lib/libpthread.so.0 pthread_create
probe-definition(0): pthread_create
symbol:pthread_create file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Could not open debuginfo. Try to use symbols.
no symbols found in /usr/lib/libpthread-2.18.so, maybe install a debug 
package?
Failed to find symbol pthread_create in /usr/lib/libpthread-2.18.so
   Error: Failed to add events. (-2)

Symbols without such qualifiers work fine:

# perf probe -F -x /lib/libpthread.so.0 --filter='pthread_detach*'
pthread_detach

# perf probe -v -x /lib/libpthread.so.0 pthread_detach
probe-definition(0): pthread_detach
symbol:pthread_detach file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Could not open debuginfo. Try to use symbols.
Opening /sys/kernel/debug/tracing/uprobe_events write=1
Added new event:
Writing event: p:probe_libpthread/pthread_detach 
/usr/lib/libpthread-2.18.so:0x8b30
   probe_libpthread:pthread_detach (on pthread_detach in 
/usr/lib/libpthread-2.18.so)

You can now use it in all perf tools, such as:

         perf record -e probe_libpthread:pthread_detach -aR sleep 1

--
Regards,
Paul Clarke, IBM
