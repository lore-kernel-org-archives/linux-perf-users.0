From: Arun Sharma <asharma@fb.com>
Subject: Trouble parsing trace events
Date: Tue, 22 Nov 2011 22:51:23 -0800
Message-ID: <4ECC97EB.1040008@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36980 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755592Ab1KWGv3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Nov 2011 01:51:29 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>, Andrew Vagin <avagin@gmail.com>


I'm using a 3.2-rc1 based kernel and perf userspace built from 
tip/auto-latest (commit id e471db8) + Andrew Vagin's sleep profiling 
patches.

# perf record -agT -e sched:sched_switch -F 100 -- sleep 3
[ perf record: Woken up 9 times to write data ]
[ perf record: Captured and wrote 4.044 MB perf.data (~176664 samples) ]

# perf script
   Warning: Error: expected type 5 but read 4
   Warning: Error: expected type 4 but read 0
   Fatal: bad op token {

Is there a known incompatibility between kernel and userspace that could 
explain this?

I don't see this problem with other trace points (eg: kmem:kmalloc).

  -Arun
