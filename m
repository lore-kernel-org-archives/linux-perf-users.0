From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf test shell: Fix check open filename arg using
 'perf trace
Date: Tue, 12 Dec 2017 14:12:59 -0300
Message-ID: <20171212171259.GQ3958@kernel.org>
References: <alpine.LRH.2.20.1712081845230.9416@Diego>
 <20171211154312.GC2221@redhat.com>
 <20171211170750.GE3958@kernel.org>
 <alpine.LRH.2.20.1712120133380.9416@Diego>
 <20171212145707.GL3958@kernel.org>
 <20171212151948.GN3958@kernel.org>
 <alpine.LRH.2.20.1712121723290.9416@Diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbdLLRNK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Dec 2017 12:13:10 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1712121723290.9416@Diego>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

Em Tue, Dec 12, 2017 at 05:24:43PM +0100, Michael Petlan escreveu:
> Hey Arnaldo, this one did not remove the s390x hack and also, won't work
> on arm. Please use the one I just have sent, few seconds ago...

Ok, I have you latest in, with the cset log I wrote, which clarifies
that this is not a arch issue, but a glibc one, its only that some
arches have distros where glibc was already at 2.26, where open() calls
are mapped to openat() syscalls.

- Arnaldo
 
> On Tue, 12 Dec 2017, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Dec 12, 2017 at 11:57:07AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > So the patch below does the trick for me, can you please check if does
> > > for you?
> > 
> > So I've put this with a long explanation at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=ba15be2acc9e35dc9f034fef3aa292406b518b04
> > 
> > - Arnaldo
> > 
