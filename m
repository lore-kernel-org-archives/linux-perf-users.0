From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test shell: Fix check open filename arg using 'perf
 trace'
Date: Fri, 1 Dec 2017 12:16:28 -0300
Message-ID: <20171201151628.GB3298@kernel.org>
References: <alpine.LRH.2.20.1711291656270.9416@Diego>
 <84d4a40a-dfbf-6d9b-9eb2-6912dc6f57e4@linux.vnet.ibm.com>
 <20171130155642.GA2893@redhat.com>
 <20171201023314.GC30867@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbdLAPQc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Dec 2017 10:16:32 -0500
Content-Disposition: inline
In-Reply-To: <20171201023314.GC30867@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo de Melo <acme@redhat.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com

Em Fri, Dec 01, 2017 at 11:33:14AM +0900, Namhyung Kim escreveu:
> On Thu, Nov 30, 2017 at 01:56:42PM -0200, Arnaldo de Melo wrote:
> > Em Thu, Nov 30, 2017 at 11:28:33AM +0100, Thomas-Mich Richter escreveu:
> > > On 11/29/2017 06:27 PM, Michael Petlan wrote:
> > > > The commit f231af789b11a2f1a3795acc3228a3e178a80c21 adds an exception for s390x to
> > > > use openat() syscall instead of open(). This exception is not s390x-only, thus I
> > > > adjusted the test to accept both open and openat syscalls, no matter which arch it
> > > > runs on. Does it sound reasonable to you?
 
> It seems glibc 2.26 changed the behavior:
 
>   https://lwn.net/Articles/738694/

interesting
 
> > What differs from x86 to others is that x86 uses syscalltbl, not requiring
> > audit-libs to map syscall numbers to names, so perhaps it is something in there...
 
> If it only needs to consider open or openat, why not specifying the
> both directly?
 
>   # perf trace -e open -e openat touch /etc/passwd

Same effect, works with other perf trace versions, but one suggestion to
make it shorter:

	perf trace -e open,openat touch /etc/passwd

Does the same thing :-)

Michael, can you please take that into account and resubmit the patch?

- Arnaldo
