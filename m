From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: make perf-targz-src-pkg or better approach to install perf?
Date: Wed, 22 Feb 2017 19:08:40 -0300
Message-ID: <20170222220840.GI20447@kernel.org>
References: <CAPe7T+-MO04yfoNSMy91F-z9F759Y8Moa_NUBs7KUJURmVrtJA@mail.gmail.com>
 <20170221231507.GI5052@kernel.org>
 <CAPe7T+-1ADZ+m7LYZpEGf9LnsCDo0oFvoPKjbdj5CqnAATa5HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932639AbdBVWIr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Feb 2017 17:08:47 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id C3C6A2012D
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2017 22:08:45 +0000 (UTC)
Received: from jouet.infradead.org (unknown [179.97.44.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F7EC2011B
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2017 22:08:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPe7T+-1ADZ+m7LYZpEGf9LnsCDo0oFvoPKjbdj5CqnAATa5HA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Davis <markdavisinboston@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org

Em Wed, Feb 22, 2017 at 05:04:19PM -0500, Mark Davis escreveu:
> Arnaldo, thanks for pushing that. I will try this with clang 4.0. Just
> so I'm clear, I'm assuming your fix does not address my other issue of
> "make perf-targz-src-pkg" no longer existing in this version of
> tools/perf, right? If that's true, any suggestions on how I get the
> dependencies for my system, other than via manual installation?

uh?

[acme@jouet linux]$ make help | grep perf
  perf-tar-src-pkg    - Build perf-4.10.0.tar source tarball
  perf-targz-src-pkg  - Build perf-4.10.0.tar.gz source tarball
  perf-tarbz2-src-pkg - Build perf-4.10.0.tar.bz2 source tarball
  perf-tarxz-src-pkg  - Build perf-4.10.0.tar.xz source tarball
[acme@jouet linux]$ 
[acme@jouet linux]$ ls -la *.tar.*
ls: cannot access '*.tar.*': No such file or directory
[acme@jouet linux]$ 
[acme@jouet linux]$ make perf-targz-src-pkg
  TAR
  PERF_VERSION = 4.10.g4c7c9c
[acme@jouet linux]$ ls -la *.tar.*
-rw-rw-r--. 1 acme acme 1620468 Feb 22 19:08 perf-4.10.0.tar.gz
[acme@jouet linux]$ 
 
> On Tue, Feb 21, 2017 at 6:15 PM, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > Em Tue, Feb 21, 2017 at 03:42:39PM -0500, Mark Davis escreveu:
> >> Hi all. I used to use
> >>
> >> make perf-targz-src-pkg
> >>
> >> to install perf from the linux/tools/perf source. I'm now trying to
> >> upgrade my perf installation from source again and I'm not seeing this
> >> make target. I'm having a bit of trouble with dependencies. Here's
> >> what I get when I try to build. (Note: my source is from github
> >> (https://github.com/torvalds/linux) at 772c8f6 (from a couple hours
> >
> > So, please pull again from that repo, I made changes to make tools/
> > build with clang 4.0, should be working and have the warnings addressed
> > below fixed.
> >
> >> ago). Is there a new / recommended approach to installing perf that is
> >> similar to the above approach? I don't have root on this machine and
> >> need to install either from source or a relatively recent package that
> >> I can install to an arbitrary directory. I'm using clang 3.8.0 as my
> >> compiler (note: I can change this or upgrade this if necessary). In
> >> particular I'm trying to get BPF in perf-record, which seems to be
> >> disabled based on the warnings that print out.
> >>
> >> I'm also getting this other compiler error:
> >>
> >> warning: optimization level '-O6' is not supported; using '-O3' instead
> >>
> >>   CC       pmu-events/pmu-events.o
> >>
> >> error: unknown warning option '-Wstrict-aliasing=3'; did you mean
> >> '-Wstring-plus-int'?
> >>
> >>       [-Werror,-Wunknown-warning-option]
> >>
> >>
> >
> > - Arnaldo
