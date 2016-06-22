From: Michael Petlan <Michael@redhat.com>
Subject: hwcache events and kernel/userspace event modifiers - bug?
Date: Wed, 22 Jun 2016 16:16:29 +0200 (CEST)
Message-ID: <alpine.LRH.2.20.1606221605280.5594@Diego>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54893 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbcFVOQc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 22 Jun 2016 10:16:32 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9581F78231
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jun 2016 14:16:31 +0000 (UTC)
Received: from [10.34.1.163] ([10.34.1.163])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5MEGT1E006102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jun 2016 10:16:30 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

when using the "k" and "u" event modifiers in order to exclude
kernel or userspace counting, the "hw" events print the modifier
along with the event names in results. When doing the same with
a "hwcache" event, the report shows events without modifiers.

$ perf stat -e cycles:u -e L1-dcache-loads:u -- true

  Performance counter stats for 'true':

            153,771      cycles:u
             24,457      L1-dcache-loads

        0.001813975 seconds time elapsed

While "cycles:u" has the ":u" modifier, "L1-dcache-loads" does
not. Despite that, the kernel/userspace excluding seem to work:

$ perf stat -e L1-dcache-loads:u -e L1-dcache-loads:k -e L1-dcache-loads:ku -- ls

  Performance counter stats for 'ls':

            146,714      L1-dcache-loads
            305,080      L1-dcache-loads
            451,794      L1-dcache-loads

        0.002221714 seconds time elapsed

Where 146714 + 305080 = 451794, so k+u is equal to ku.

This happens with the Arnaldo's latest perf/core perf, the same
as with the others.

Might that be a bug?
Thanks.

Michael
