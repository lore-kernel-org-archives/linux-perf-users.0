From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf test shell: Fix check open filename arg using 'perf
 trace'
Date: Tue, 5 Dec 2017 16:39:49 +0100
Message-ID: <20171205153949.GA4370@linux.vnet.ibm.com>
References: <alpine.LRH.2.20.1711291656270.9416@Diego>
 <84d4a40a-dfbf-6d9b-9eb2-6912dc6f57e4@linux.vnet.ibm.com>
 <20171130155642.GA2893@redhat.com>
 <20171130155922.GB2893@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752515AbdLEPj4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Dec 2017 10:39:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB5Fb79x077982
        for <linux-perf-users@vger.kernel.org>; Tue, 5 Dec 2017 10:39:56 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2envb5perb-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Dec 2017 10:39:54 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Tue, 5 Dec 2017 15:39:52 -0000
Content-Disposition: inline
In-Reply-To: <20171130155922.GB2893@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo de Melo <acme@redhat.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>

Hi Arnaldo,

On Thu, Nov 30, 2017 at 01:59:22PM -0200, Arnaldo de Melo wrote:
> Em Thu, Nov 30, 2017 at 01:56:42PM -0200, Arnaldo de Melo escreveu:
> > Em Thu, Nov 30, 2017 at 11:28:33AM +0100, Thomas-Mich Richter escreveu:
> > > On 11/29/2017 06:27 PM, Michael Petlan wrote:
> > [acme@jouet linux]$ git log -1 27702bcfe8a125a1feeeb5f07526d63b20cac47f --oneline
> > 27702bcfe8a1 perf trace: Support syscall name globbing
> > [acme@jouet linux]$
> > 
> > Is in v4.14 final.
> > 
> > Testing with/without those quotes:
> > 
> > [root@jouet ~]# perf trace -e open* touch /etc/passwd
> >      0.000 ( 0.007 ms): touch/17246 open(filename: 0x99747e37, flags: CLOEXEC                             ) = 3
> >      0.022 ( 0.004 ms): touch/17246 open(filename: 0x9994b640, flags: CLOEXEC                             ) = 3
> >      0.189 ( 0.004 ms): touch/17246 open(filename: 0x994f1c70, flags: CLOEXEC                             ) = 3
> >      0.224 ( 0.056 ms): touch/17246 open(filename: 0xaa80a32a, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
> > [root@jouet ~]# perf trace -e 'open*' touch /etc/passwd
> >      0.000 ( 0.039 ms): touch/17250 open(filename: 0xf1445e37, flags: CLOEXEC                             ) = 3
> >      0.107 ( 0.030 ms): touch/17250 open(filename: 0xf1649640, flags: CLOEXEC                             ) = 3
> >      0.976 ( 0.009 ms): touch/17250 open(filename: 0xf11efc70, flags: CLOEXEC                             ) = 3
> >      1.032 ( 0.008 ms): touch/17250 open(filename: 0x9357432a, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
> > [root@jouet ~]#
> > 
> > What differs from x86 to others is that x86 uses syscalltbl, not requiring
> > audit-libs to map syscall numbers to names, so perhaps it is something in there...
> 
> Yeah :-\
> 
> int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
>                                   const char *syscall_glob __maybe_unused, int *idx __maybe_unused)
> {
>         return -1;
> }
> 
> int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char
> *syscall_glob, int *idx)
> {
>         return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
> }
> #endif /* HAVE_SYSCALL_TABLE */
> 
> -----
> 
> So someone needs to implement syscalltbl__strglobmatch_next() for arches
> that don't HAVE_SYSCALL_TABLE, which is basically at this stage !x86.
> 
> Shouldn't be that difficult, but remains to be done.

Thanks for pointing in that direction.  I looked at it and will post a
patch to add syscall tables for s390 too.

Kind regards,
  Hendrik
