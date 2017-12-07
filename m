From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf test shell: Fix check open filename arg using 'perf
 trace'
Date: Thu, 7 Dec 2017 08:39:12 +0100
Message-ID: <20171207073912.GB4889@linux.vnet.ibm.com>
References: <alpine.LRH.2.20.1711291656270.9416@Diego>
 <84d4a40a-dfbf-6d9b-9eb2-6912dc6f57e4@linux.vnet.ibm.com>
 <20171130155642.GA2893@redhat.com>
 <20171130155922.GB2893@redhat.com>
 <20171205153949.GA4370@linux.vnet.ibm.com>
 <20171206163443.GA16781@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750807AbdLGHjV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Dec 2017 02:39:21 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB77bB71115643
        for <linux-perf-users@vger.kernel.org>; Thu, 7 Dec 2017 02:39:20 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2epyhrc9rq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2017 02:39:19 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Thu, 7 Dec 2017 07:39:17 -0000
Content-Disposition: inline
In-Reply-To: <20171206163443.GA16781@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Arnaldo de Melo <acme@redhat.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>

On Wed, Dec 06, 2017 at 01:34:43PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 05, 2017 at 04:39:49PM +0100, Hendrik Brueckner escreveu:
> > On Thu, Nov 30, 2017 at 01:59:22PM -0200, Arnaldo de Melo wrote:
> > > So someone needs to implement syscalltbl__strglobmatch_next() for arches
> > > that don't HAVE_SYSCALL_TABLE, which is basically at this stage !x86.
> 
> > > Shouldn't be that difficult, but remains to be done.
> 
> > Thanks for pointing in that direction.  I looked at it and will post a
> > patch to add syscall tables for s390 too.
> 
> Will you do it the way I did for x86? That would be the best, as we
> would then reduce the need for audit-libs to be linked with perf.

It looks similar to x86 but at the time being, s390 does not have a
system call table like x86.  So the input is different, the output
will follow what x86 provides to perf.

> 
> We really need to reduce the number of libraries that perf links to :-\

I have prepared two patches to get rid of the auditlibs dependency for
those arch's that have system call tables.  Going to post this today.

Thanks and kind regards,
  Hendrik
