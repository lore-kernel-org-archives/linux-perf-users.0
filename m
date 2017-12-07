From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf build failure on Fedora 27 and linux kernel 4.15.0-rc2
Date: Thu, 7 Dec 2017 11:43:22 -0300
Message-ID: <20171207144322.GA6458@kernel.org>
References: <5cb4b853-4114-6106-b795-b520c0745fbc@linux.vnet.ibm.com>
 <a15a874d-429f-7d8b-1376-54fa0d01e2b8@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753828AbdLGOnZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Dec 2017 09:43:25 -0500
Content-Disposition: inline
In-Reply-To: <a15a874d-429f-7d8b-1376-54fa0d01e2b8@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Thu, Dec 07, 2017 at 02:27:42PM +0100, Thomas-Mich Richter escreveu:
> On 12/07/2017 02:03 PM, Thomas-Mich Richter wrote:
> >  Maybe its me doing something wrong.
> > I just installed a KVM virtual machine on my x86 notebook (lenovo P50) with Fedora 27 workstation.
> > I then downloaded latest 4.15.0rc2 linux kernel and compiled and installed it.
> > This went fine, then I decided to build the perf tool and got this error:
> > 
> > 
> >  GEN      python/perf.so
> > /usr/bin/ld: perf-in.o: relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
> > /usr/bin/ld: libperf.a(libperf-in.o): relocation R_X86_64_32S against `.text' can not be used when making a shared object; recompile with -fPIC
> > /usr/bin/ld: final link failed: Nonrepresentable section on output
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [Makefile.perf:507: perf] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [Makefile.perf:210: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> > [root@localhost-live perf]# 
> > 
> > 
> > Any ideas? Is this just on a KVM guest? Thanks for any help.
> > 
> 
> To remedy above build issue, here is the fix:
> 
> root@localhost-live perf]# git diff
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ed65e82f034e..263611caaf7b 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -41,6 +41,7 @@ ifeq ($(SRCARCH),x86)
>      LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
>    endif
>    NO_PERF_REGS := 0
> +  CFLAGS += -fPIC
>  endif
>  
>  ifeq ($(SRCARCH),arm)
> [root@localhost-live perf]# 

This is what is in perf/core:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=c6707fdef7e2c1eb5458988b49c33497affdebbf

[acme@jouet linux]$ git log --oneline -1 c6707f
c6707fdef7e2 perf tools: Fix up build in hardnened environments

I'll put it into perf/urgent

- Arnaldo
