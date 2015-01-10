From: William Cohen <wcohen@redhat.com>
Subject: Why the distinction between regular anon regions and hugepage anon
 regions for PERF_RECORD_MMAP entries?
Date: Fri, 09 Jan 2015 22:27:12 -0500
Message-ID: <54B09C10.6090008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbbAJD1P (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 9 Jan 2015 22:27:15 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0A3RDAR012106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-perf-users@vger.kernel.org>; Fri, 9 Jan 2015 22:27:14 -0500
Received: from [10.3.227.20] (vpn-227-20.phx2.redhat.com [10.3.227.20])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t0A3RDdL029238
	for <linux-perf-users@vger.kernel.org>; Fri, 9 Jan 2015 22:27:13 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi All,

Earlier this week I was examining why operf was not properly mapping samples from anonymous regions to Java methods when the JVM was using the older hugepage page mechanism which has a static pool of pages when the machine sets up.  I tracked the problem down to the the PERF_RECORD_MMAP entries being different between regular and hugepages.

A hugepage PERF_RECORD_MMAP entry from "perf report -D" when hugepages were used: 

0x125d60 [0x58]: event: 1
.
. ... raw event: size 88 bytes
.  0000:  01 00 00 00 02 00 58 00 36 29 00 00 37 29 00 00  ......X.6)..7)..
.  0010:  00 00 c0 aa aa 2a 00 00 00 00 00 03 00 00 00 00  .....*..........
.  0020:  00 00 00 00 00 00 00 00 2f 61 6e 6f 6e 5f 68 75  ......../anon_hu
.  0030:  67 65 70 61 67 65 20 28 64 65 6c 65 74 65 64 29  gepage (deleted)
.  0040:  00 00 00 00 00 00 00 00 36 29 00 00 37 29 00 00  ........6)..7)..
.  0050:  cd 0f 4c 7e a7 b2 00 00                          ..L~....
.
196432448196557 0x125d60 [0x58]: PERF_RECORD_MMAP 10550/10551: [0x2aaaaac00000(0x3000000) @ 0]: /anon_hugepage (deleted)


Below is a PERF_RECORD_MMAP for normal page sized pages anonymous region:

0xd8 [0x50]: event: 1
.
. ... raw event: size 80 bytes
.  0000:  01 00 00 00 01 00 50 00 ff ff ff ff 00 00 00 00  ......P.........
...skipping...
.  0020:  00 00 00 a9 f9 7f 00 00 2f 2f 61 6e 6f 6e 00 00  ........//anon..
.  0030:  3f 2a 00 00 40 2a 00 00 68 f9 4a f5 20 b3 00 00  ?*..@*..h.J. ...
.
196954135656808 0x1873c8 [0x40]: PERF_RECORD_MMAP 10815/10816: [0x7ff9a9000000(0x270000) @ 0x7ff9a9000000]: //anon


Why the distinction between the two memory mappings in this manner?  Why not just generate same output for the hugepage PERF_RECORD_MMAP?  Also why does it include the " (deleted)" suffix for the hugepage entry?  I don't think that the mapping had been removed when that entry was generated?

-Will
