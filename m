Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2E229B18;
	Fri, 27 Feb 2026 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177539; cv=none; b=c9+2OkscDglDC6I1WznOPpmo/p/O+MK2cssvrH/LOZvbh+ggDT0Ll17ciptIImShaXvu+1vtw5FmZZIb7bBb4H7fkfolKWtdW0c8Ujd7y4qWVpDdxILh7IDhP2zDSN8qH4eVT1KjYAOENsejnrhmgvxpuxS4CA4DbDcA9aXLkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177539; c=relaxed/simple;
	bh=kh/mTB9tq5QP25ttsXgdxceuKo/iLS8e1SOkP72u6Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4JK8+vzSQejtsiDx8tqs6I+iozSI3Sl7mTUAt5I6ZrlADI96aMZ4vmB7vm8qIuXohZHqM5pQh7xevV6VxMcI/I1NyyjeFdJM4iTtS9wfzTKGDqGC+lEqiGJiVxok0V0sjH9ydER9dP8MYnwubROfP8+hZA+cChmLt1micbhb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjoCo/hX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjoCo/hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961BFC116C6;
	Fri, 27 Feb 2026 07:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772177539;
	bh=kh/mTB9tq5QP25ttsXgdxceuKo/iLS8e1SOkP72u6Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjoCo/hX/eOIISKvKr13/j0jFspSjcGiQlp4VQP8vG9NAanzBiCs0IhLMNetuCAI+
	 k6dX1u0NgaB9VUSdubW5ldY/xT1cgJUqeCXzNalOhb/w1ou5orMPj5V6AWoV0tjly5
	 Mgaz20gMbYu0J9RO/YaCO5PpPP1mifHuMAO9w8I3g8DHIKSRR+H75vrHHMm0HCX/+2
	 iOr66/Dwq7ORZrnc8xgtFjG39FsbZjTZhacD/5laH5S5i0teRWNr8WaMZkqYHky6qK
	 6Hycve4Dfn1vy25WmE6J3UmuBHnFGYxaZ4bv9Jz6lmoIICu0dfyWMHMfRwi3WmWEeD
	 FSspim/43L8cg==
Date: Thu, 26 Feb 2026 23:32:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf kvm stat: Fix build error
Message-ID: <aaFIgR29wGYvHnVp@google.com>
References: <20260206-perf_fix_kvm_stat_error-v1-1-ad40115876be@arm.com>
 <aZ-oYb-FDLVT5MGq@google.com>
 <CAP-5=fVCdQZ584s_24wQc_+03xL2Npj2qDbqGSjE=Ms1-y8raQ@mail.gmail.com>
 <20260226095255.GF4184494@e132581.arm.com>
 <CAP-5=fUAK=vzeZWDXuun+wptSeBwUMhZuVqdh4zwLoXoV32VPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUAK=vzeZWDXuun+wptSeBwUMhZuVqdh4zwLoXoV32VPA@mail.gmail.com>

On Thu, Feb 26, 2026 at 08:44:51AM -0800, Ian Rogers wrote:
> On Thu, Feb 26, 2026 at 1:52 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > On Wed, Feb 25, 2026 at 10:36:26PM -0800, Ian Rogers wrote:
> >
> > [...]
> >
> > > Hmm.. it looks like something has gone screwy with the include paths.
> > > The header you've gotten is:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/include/uapi/asm/svm.h#n137
> > > rather than:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/arch/x86/include/uapi/asm/svm.h#n137
> > > where the value differs between -1ull and -1.
> > >
> > > In Leo's change he has the include path as:
> > >   #include "../../arch/x86/include/uapi/asm/svm.h"
> > >
> > > but I think that is off by one and should be:
> > >   #include "../../../arch/x86/include/uapi/asm/svm.h"
> >
> > Sorry I did not check the header path carefully.  A bit thoughts:
> >
> > The perf build will not include headers in relative paths as we
> > expected.
> >
> > It tries to find headers with appending search paths.  As Ian said,
> > I saw .kvm-stat-x86.o.cmd that includes kernel headers:
> >
> >   /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi/asm/svm.h \
> >   /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi/asm/vmx.h \
> >   /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi/asm/kvm.h \
> >
> > I'd suggest a fix in Makefile as below.  The idea is to give priority to
> > the lower level folders under perf, so that headers in the deeper perf
> > directories are searched first.  This avoids searching any kernel headers.

It fixes the problem, thanks!

Tested-by: Namhyung Kim <namhyung@kernel.org>

More comments below.

> 
> I'm not opposed to the change but I still think we should make the
> relative include be to the correct files. Some other thoughts below.
> 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index a8dc72cfe48e..47359f672b6a 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -388,8 +388,10 @@ ifeq ($(DEBUG),0)
> >    endif
> >  endif
> >
> > -INC_FLAGS += -I$(src-perf)/util/include
> 
> Not clear to me why we need a util/include on top of everything else.
> It seems somewhat random what is in util/include rather than just in
> util.

It seems it tries to override some kernel headers but I'm curious we can
move the files to the tools/include and get rid of the directory.

> 
> >  INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
> 
> Hopefully with the removal of the arch directory (and fixing of
> cross-platform profiling) in slow chunks by changes like:
> https://lore.kernel.org/lkml/20260224142938.26088-1-irogers@google.com/
> we can get rid of this one.
> 
> > +INC_FLAGS += -I$(src-perf)/util/include
> > +INC_FLAGS += -I$(src-perf)/util

I also hope to remove $(src-perf)/util too and use path relative to
$(src-perf) always for perf-specific headers.  But this is a separate
topic.


> > +INC_FLAGS += -I$(src-perf)
> 
> This:
> 
> >  INC_FLAGS += -I$(srctree)/tools/include/
> >  INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
> >  INC_FLAGS += -I$(srctree)/tools/include/uapi
> 
> to here means that we prefer linux headers over uapi headers, which I
> think is the opposite of what a user-land process would expect. I
> think we should move these headers into two libraries, build them with
> an `install_headers` rule, and make the include path pick up the
> headers from where they are installed. As the linux and uapi headers
> are licensed differently, this would clarify the dependencies and
> licensing implications.

Sounds good.

Thanks,
Namhyung

> 
> There's another can of worms regarding whether libperf is something
> useful, outside of declarations in event.h.
> 
> Thanks,
> Ian
> 
> > @@ -403,9 +405,6 @@ INC_FLAGS += -I$(obj-perf)/util
> >  INC_FLAGS += -I$(obj-perf)
> >  endif
> >
> > -INC_FLAGS += -I$(src-perf)/util
> > -INC_FLAGS += -I$(src-perf)
> > -
> >  CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_
> >
> > As a result, I can get the search paths in .kvm-stat-x86.o.cmd:
> >
> >   /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/uapi/asm/svm.h \
> >   /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/uapi/asm/vmx.h \
> >   /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/uapi/asm/kvm.h \
> >
> > Please let me know if this makes sense.
> >
> > Thanks,
> > Leo
