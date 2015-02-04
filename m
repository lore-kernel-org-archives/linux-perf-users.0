From: Carl Love <cel@us.ibm.com>
Subject: PATCH[0/3 RFC]  PERF, Add remapping support for jit'ed code to perf
Date: Wed, 04 Feb 2015 09:15:26 -0800
Message-ID: <1423070126.7292.28.camel@oc0276584878.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:39357 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161071AbbBDRPe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 Feb 2015 12:15:34 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <cel@us.ibm.com>;
	Wed, 4 Feb 2015 12:15:32 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3AD7438C8039
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2015 12:15:30 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t14HFUYX23920700
	for <linux-perf-users@vger.kernel.org>; Wed, 4 Feb 2015 17:15:30 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t14HFSrZ021650
	for <linux-perf-users@vger.kernel.org>; Wed, 4 Feb 2015 12:15:28 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
Cc: cel@us.ibm.com, sukadev@linux.vnet.ibm.com, Pawel Moll <pawel.moll@arm.com>

Arnaldo:

I got my patch to work without causing perf to seg fault yesterday.  So,
I am now willing to post what I have as it appears to work.

Here is a patch series for the perf Java support as I have it today.  I
am posting it per your request so people can see what I have been
working on, the approach that I am taking etc.  I welcome feedback on
the overall approach and the patch.  It is a proof of concept patch set
showing the approach that I am using.  There is still plenty of work to
do.

  Work to do
1)  Jit call back library needs to store the jit source code
2)  Perf add source code annotation for the jit code.
3)  Rewrite the jit call back library to only request re-map when it is
    absolutely needed.  Currently it requests a call back for every
    symbol load just to exercise the perf code.

There are three parts to this work.  First is the patch that adds the
uevent functionality that was written by Pawel Moll.  Second is the
patch I wrote to take the uevent, which contains the remap request, and
process it.  Third is the jvmti callback library that gets built and run
with the java execution.  The library is compiled into java agent
library libjvm-perf.so.  The perf command is invoked with

perf record java -agentpath:libjvmti-perf.so test

where test is my java workload being profiled.

The following patches in this patch set are:

1/3   Patch by Pawel Moll
2/3   Perf remap patch by Carl Love
3/3   jvmti library source code for testing the perf patch

                     Carl Love
