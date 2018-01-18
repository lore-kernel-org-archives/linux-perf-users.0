From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/5] perf util: Introduce architecture specific
 errno/name mapping
Date: Thu, 18 Jan 2018 12:33:20 +0100
Message-ID: <20180118113320.GC4600@linux.vnet.ibm.com>
References: <1516095991-16337-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1516095991-16337-4-git-send-email-brueckner@linux.vnet.ibm.com>
 <20180118100733.GA18567@krava>
 <20180118104953.GA18383@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750841AbeARLd2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Jan 2018 06:33:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0IBVkRm159917
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jan 2018 06:33:27 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fjtk2rve8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jan 2018 06:33:27 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Thu, 18 Jan 2018 11:33:25 -0000
Content-Disposition: inline
In-Reply-To: <20180118104953.GA18383@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>

On Thu, Jan 18, 2018 at 07:49:53AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 18, 2018 at 11:07:33AM +0100, Jiri Olsa escreveu:
> > On Tue, Jan 16, 2018 at 10:46:29AM +0100, Hendrik Brueckner wrote:
> > 
> > SNIP
> > 
> > > index 12dec6e..90ce14f 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -249,7 +249,7 @@ INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
> > >  INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/
> > >  INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/
> > >  
> > > -# $(obj-perf)      for generated common-cmds.h
> > > +# $(obj-perf)      for generated common-cmds.h and errno-names.c
> > >  # $(obj-perf)/util for generated bison/flex headers
> > >  ifneq ($(OUTPUT),)
> > >  INC_FLAGS += -I$(obj-perf)/util
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 9fdefd7..332b4b4 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -518,6 +518,9 @@ $(OUTPUT)common-cmds.h: util/generate-cmdlist.sh command-list.txt
> > >  $(OUTPUT)common-cmds.h: $(wildcard Documentation/perf-*.txt)
> > >  	$(QUIET_GEN). util/generate-cmdlist.sh > $@+ && mv $@+ $@
> > >  
> > > +$(OUTPUT)util/errno-names.c: util/generate-errno-names.sh
> > > +	$(QUIET_GEN). util/generate-errno-names.sh "$(CC)" "$(srctree)/tools" > $@+ && mv $@+ $@
> > 
> > so this generates errno-names.c with following code:
> > 
> > const char *arch_errno_to_name(const char *arch, int err)
> > {
> >         if (!strcmp(arch, "alpha"))
> >                 return errno_to_name__alpha(err);
> >         if (!strcmp(arch, "arm"))
> >                 return errno_to_name__arm(err);
> >         if (!strcmp(arch, "arm64"))
> >                 return errno_to_name__arm64(err);
> > 
> > 
> > is there a reason why we want all archs compiled in?
> > I'd think we just need the arch perf is built in
> 
> think about:
> 
> On an arm64 system:
> 
> 	perf trace record -a sleep 1
> 
> scp that to an x86_64 system and do:
> 
> 	perf trace -i perf.data
> 
> But doing that strcmp per call seems excessive, perhaps we could have
> something like:
> 
> 	trace->arch = arch_syscalls__init(arch_name);
> 
> 	char *s = arch_syscalls__strerrno(trace->arch, err);
> 
> Have to look at the code to find the right naming according to what we
> already have.

Another idea to get rid of the strcmp's is to introduce an arch enum
and let normalize_arch() in util/env.c return an enum number and handle
the arch stuff then on the enum.  Where necessary, the arch string can
be used.  But for "internal" purposes, an enum would be better.

Thanks and kind regards,
  Hendrik
