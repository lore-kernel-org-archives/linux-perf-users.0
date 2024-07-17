Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246817FAC1;
	Wed, 17 Jul 2024 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236686; cv=none; b=exIPH0+v/lXm28kyiSqZMWUUJxZhT9XfBbLWX831LqoYzd0JitylHoxPy7JAFFwrWJUQzqjQ6Z/7Ry6y5/Xpu5uc3mU5pKr8U1AZI2tCHZESjF5Wr5IwC3Q+IgunlCILzRTl/UUQaTUPVMrrrJDuu6+P80T0PadU98K07Hwm/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236686; c=relaxed/simple;
	bh=85xHJDWXASmD2vs3L0MTseBCXAa4JFynGkAoFVSNVFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbgyo1HiO8RK6qUrNNHotx9pNyQ1hESVMng5t3r1HI3UscwFQHiqWI+hCYmElcfvHbEHBa+N2PMjtre8k7U/xi8QhuC7uZxTK+xXaWSgXdNkz9EQOavqusFMqyu7VX29eMRHsOzQiatsR+eZE77Lo6EuOpCX/uVIswdPjjzpwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Wed, 17 Jul 2024 19:18:10 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] perf build: libtraceevent, libtracefs feature
 check with pkg-config
Message-ID: <Zpf80mCx03GKOXzE@gentoo.org>
References: <CAM9d7ciLGP_w9YYOb-2U2ESg8kQx_knQXuB6_2JZVZ2ktL+bzg@mail.gmail.com>
 <20240712194511.3973899-1-amadio@gentoo.org>
 <CAM9d7cgG5WvyEu1ECNht1z=bZ7MSsrPyBjokcY95SXmxgnzwsA@mail.gmail.com>
 <20240717123147.17169873@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240717123147.17169873@rorschach.local.home>

On Wed, Jul 17, 2024 at 12:31:47PM -0400, Steven Rostedt wrote:
> On Wed, 17 Jul 2024 09:27:58 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hello,
> > 
> > On Fri, Jul 12, 2024 at 12:45 PM Guilherme Amadio <amadio@gentoo.org> wrote:
> > >
> > > Hi Namhyung, Arnaldo,
> > >
> > > Here is version 3 of the patchset. I see the change to send output to devnull
> > > has already been applied, so I am submitting the remaining work only.
> > >
> > > The difference with previous changes is that in v3 rather than add tests with
> > > pkg-config to check if dependencies are actually installed, we just set the
> > > flags and send any warning to devnull. The change that remains in this patchset
> > > is the fix for the other tools, which were inadvertently broken when the include
> > > for libtracefs changed from #include <tracefs/tracefs.h> to #include <tracefs.h>
> > > since the flags for the feature check are not set in the other tools Makefiles,
> > > it currently only works for perf. I recommend to either take at least patch 2/5
> > > that moves setting the flags to tools/build/Makefile.feature or to revert the two
> > > patches that have been applied. You can easily test the fix with the commands below:
> > >
> > > make -B -C tools/verification/rv VF=1
> > > make -B -C tools/tracing/latency VF=1
> > > make -B -C tools/tracing/rtla VF=1
> > >
> > > from the root of the repository. Only after the feature check flags are moved to
> > > Makefile.feature that it also fixes the other tools. Apologies for the breakage
> > > there.  
> > 
> > Steve, are you ok with having this patchset in the perf-tools tree?
> > 
> 
> I don't know as this is the first I've seen it. If you could have this
> resend with me Cc'd and/or Cc linux-trace-devel@vger.kernel.org then I
> can review and possibly ack it.

I will resend with the extra CC suggestions shortly and a cover letter
explaining everything.

Best regards,
-Guilherme
