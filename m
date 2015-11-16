From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: timing information with perf
Date: Mon, 16 Nov 2015 13:08:15 -0500
Message-ID: <y0my4dxx1f4.fsf@fche.csb>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46111 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbbKPSIU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Nov 2015 13:08:20 -0500
In-Reply-To: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com> (Olga Kornievskaia's message of "Thu, 12 Nov 2015 21:07:20 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


Olga.Kornievskaia wrote:

> [...] say there are two tracepoints =FCfoobar_enter=FD and
> =FCfoobar_exit=FD. Each tracepoint logs a timestamp. I=F9d like to be=
 able
> to say that on average it takes that many time-units between =FCenter=
=FD
> and =FCexit=FD tracepoints. [...]

=46or completeness, a complete systemtap implementation of this could l=
ook like:

# stap -e '
   global s, t%
   probe kernel.trace("foobar_enter") {
       t[tid()]=3Dgettimeofday_us()=20
   }
   probe kernel.trace("foobar_exit") {
       if (tid() in t) { s <<< gettimeofday_us() - t[tid()] }=20
   }
   probe timer.s(5),end {
       printf("cumulative average us: %d\n", @avg(s))=20
   }=20
'


- FChE
