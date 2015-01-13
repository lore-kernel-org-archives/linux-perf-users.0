From: David Ahern <dsahern@gmail.com>
Subject: Re: Why the distinction between regular anon regions and hugepage
 anon regions for PERF_RECORD_MMAP entries?
Date: Tue, 13 Jan 2015 08:30:00 -0700
Message-ID: <54B539F8.2070107@gmail.com>
References: <54B09C10.6090008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:56136 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbbAMPaC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 13 Jan 2015 10:30:02 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so4233981pac.11
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2015 07:30:02 -0800 (PST)
In-Reply-To: <54B09C10.6090008@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 1/9/15 8:27 PM, William Cohen wrote:
> Hi All,
>
> Earlier this week I was examining why operf was not properly mapping samples from anonymous regions to Java methods when the JVM was using the older hugepage page mechanism which has a static pool of pages when the machine sets up.  I tracked the problem down to the the PERF_RECORD_MMAP entries being different between regular and hugepages.
>
> A hugepage PERF_RECORD_MMAP entry from "perf report -D" when hugepages were used:
>
> 0x125d60 [0x58]: event: 1
> .
> . ... raw event: size 88 bytes
> .  0000:  01 00 00 00 02 00 58 00 36 29 00 00 37 29 00 00  ......X.6)..7)..
> .  0010:  00 00 c0 aa aa 2a 00 00 00 00 00 03 00 00 00 00  .....*..........
> .  0020:  00 00 00 00 00 00 00 00 2f 61 6e 6f 6e 5f 68 75  ......../anon_hu
> .  0030:  67 65 70 61 67 65 20 28 64 65 6c 65 74 65 64 29  gepage (deleted)
> .  0040:  00 00 00 00 00 00 00 00 36 29 00 00 37 29 00 00  ........6)..7)..
> .  0050:  cd 0f 4c 7e a7 b2 00 00                          ..L~....
> .
> 196432448196557 0x125d60 [0x58]: PERF_RECORD_MMAP 10550/10551: [0x2aaaaac00000(0x3000000) @ 0]: /anon_hugepage (deleted)
>
>
> Below is a PERF_RECORD_MMAP for normal page sized pages anonymous region:
>
> 0xd8 [0x50]: event: 1
> .
> . ... raw event: size 80 bytes
> .  0000:  01 00 00 00 01 00 50 00 ff ff ff ff 00 00 00 00  ......P.........
> ...skipping...
> .  0020:  00 00 00 a9 f9 7f 00 00 2f 2f 61 6e 6f 6e 00 00  ........//anon..
> .  0030:  3f 2a 00 00 40 2a 00 00 68 f9 4a f5 20 b3 00 00  ?*..@*..h.J. ...
> .
> 196954135656808 0x1873c8 [0x40]: PERF_RECORD_MMAP 10815/10816: [0x7ff9a9000000(0x270000) @ 0x7ff9a9000000]: //anon
>
>
> Why the distinction between the two memory mappings in this manner?  Why not just generate same output for the hugepage PERF_RECORD_MMAP?  Also why does it include the " (deleted)" suffix for the hugepage entry?  I don't think that the mapping had been removed when that entry was generated?

perf is just passing on the information given to it.

The "anon" versus "anon_hugepage" comes from the filename used in the 
mapping (e.g, see references to HUGETLB_ANON_FILE for the latter). And 
as I recall file references for hugepages are typically deleted after 
opening so that the pages are released even if the process terminates 
abnormally.

David
