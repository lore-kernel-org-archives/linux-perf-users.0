From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test: fix test case probe libc's inet_pton on s390x
Date: Tue, 14 Nov 2017 11:58:37 -0300
Message-ID: <20171114145837.GR8836@kernel.org>
References: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
 <20171114071847.2381-2-tmricht@linux.vnet.ibm.com>
 <20171114132625.GM8836@kernel.org>
 <20171114133409.GN8836@kernel.org>
 <20171114134724.GP8836@kernel.org>
 <b44439ef-9852-c132-ea8a-d16e7b6b6ab8@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbdKNO6j (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 09:58:39 -0500
Content-Disposition: inline
In-Reply-To: <b44439ef-9852-c132-ea8a-d16e7b6b6ab8@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Em Tue, Nov 14, 2017 at 02:55:48PM +0100, Thomas-Mich Richter escreveu:
> On 11/14/2017 02:47 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 14, 2017 at 10:34:09AM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> Different name, same contents, need to look at the inode... ;-\
> >>
> >> Nah, lets ask the kernel how is it that it sees libc, please test the
> >> following, works for me:
> 
> works for me too.
> 
> > 
> > BTW, this is what I sticked on that cset:
> > 
> >     Committer changes:
> >     
> >     We can't really use ldd for libc, as in some systems, such as x86_64, it
> >     has hardlinks and then ldd sees one and the kernel the other, so grep
> >     for libc in /proc/self/maps to get the one we'll receive from
> >     PERF_RECORD_MMAP.
> > 
> > - Arnaldo
> > 
> 
> Yes I am fine with this changes.
> Go ahead.

Thanks for checking, committed.

- Arnaldo
