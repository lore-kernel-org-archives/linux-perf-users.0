From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test shell: Fix check open filename arg using 'perf
 trace'
Date: Wed, 6 Dec 2017 13:34:43 -0300
Message-ID: <20171206163443.GA16781@kernel.org>
References: <alpine.LRH.2.20.1711291656270.9416@Diego>
 <84d4a40a-dfbf-6d9b-9eb2-6912dc6f57e4@linux.vnet.ibm.com>
 <20171130155642.GA2893@redhat.com>
 <20171130155922.GB2893@redhat.com>
 <20171205153949.GA4370@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdLFQet (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Dec 2017 11:34:49 -0500
Content-Disposition: inline
In-Reply-To: <20171205153949.GA4370@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Arnaldo de Melo <acme@redhat.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>

Em Tue, Dec 05, 2017 at 04:39:49PM +0100, Hendrik Brueckner escreveu:
> On Thu, Nov 30, 2017 at 01:59:22PM -0200, Arnaldo de Melo wrote:
> > So someone needs to implement syscalltbl__strglobmatch_next() for arches
> > that don't HAVE_SYSCALL_TABLE, which is basically at this stage !x86.

> > Shouldn't be that difficult, but remains to be done.
 
> Thanks for pointing in that direction.  I looked at it and will post a
> patch to add syscall tables for s390 too.

Will you do it the way I did for x86? That would be the best, as we
would then reduce the need for audit-libs to be linked with perf.

We really need to reduce the number of libraries that perf links to :-\

- Arnaldo
