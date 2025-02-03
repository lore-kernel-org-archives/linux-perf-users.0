Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B01F92A;
	Mon,  3 Feb 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621183; cv=none; b=raNDUqi//XqTXmk11acFBRhI8eHmFWdCGZnhc5LjVjKNID2S7taGmIE5xnu1qdeV+Wrw+aq845PHDY8B4OZJ1mOI5oT/XaQzzJPgQM0rVI8+OZHhQMkUbjWjpAM3j54usI4yNlVyOu5ZSpPppOCbzrOel4pCnf/HOrMP4P9NGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621183; c=relaxed/simple;
	bh=giaijWcNkRzjj6qgspJb+qrKbWsq04W28Ju8Hev8uDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh0MjXOrIR1sHRsbKvTX9SQujKpJeBY+6cTCew9uabsQKJh6e82NF3yAaJvnG/ojArIJRNAMRMRh1bY2futezLUJU83DeL9K4os69j7tfou8oQxKKW+eVDTR7sTNoNfi5i4XH+9CVb39qTCcKxoyThboLSWr46h7Y8x3akv4Mh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs6Fq4Iy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs6Fq4Iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9842C4CED2;
	Mon,  3 Feb 2025 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738621182;
	bh=giaijWcNkRzjj6qgspJb+qrKbWsq04W28Ju8Hev8uDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bs6Fq4IyNDGPhgzRuTbnBSX44+k0YEZu6VeXRMVJPaxrMs81Zfb/B8yQ8A7Kuj5g1
	 k/iqXfLwM5fxD8kf2jKTHVJfyu5nBvzNfDv6+PfGHBrnIIm6Bc/Fk2d9+DdjO717Zw
	 Fx60J8qBSb8TN5rYrA/WqTodX/fL6vGzW+hZkCcXZs0hHv3eIxQGbQawtClrjbw63Q
	 +Hfi4pPbn1vBOcQdhriTTL1/FNFWVjnzv0ngE+8hz677fY9h3TlfvN/49pcBhQHGne
	 DkyKFuAf6hDJv0kNJUOCfDRW/5YbyBex2wkEsEc4W+OqBaxLEoKWh0VHLN2MZ+QgN9
	 26TEOEdY43DvQ==
Date: Mon, 3 Feb 2025 14:19:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH FOR-NEXT] perf tools: Expose quiet/verbose variables in
 Makefile.perf
Message-ID: <Z6FA_IEt3QN3aX3l@google.com>
References: <20250114-perf_make_test-v1-1-decc1c517b11@rivosinc.com>
 <Z6CMg7uNReyGTq4y@krava>
 <Z6ERcG6ZAqL1cFAo@ghost>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6ERcG6ZAqL1cFAo@ghost>

Hello,

On Mon, Feb 03, 2025 at 10:56:48AM -0800, Charlie Jenkins wrote:
> On Mon, Feb 03, 2025 at 10:29:39AM +0100, Jiri Olsa wrote:
> > On Tue, Jan 14, 2025 at 11:35:44AM -0800, Charlie Jenkins wrote:
> > > The variables to make builds silent/verbose live inside
> > > tools/build/Makefile.build. Move those variables to the top-level
> > > Makefile.perf to be generally available.
> > > 
> > > Committer testing:
> > > 
> > > See the SYSCALL lines, now they are consistent with the other
> > > operations in other lines:
> > >   SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
> > >   SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
> > >   GEN     /tmp/build/perf-tools-next/common-cmds.h
> > >   GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
> > >   PERF_VERSION = 6.13.rc2.g3d94bb6ed1d0
> > >   GEN     perf-archive
> > >   MKDIR   /tmp/build/perf-tools-next/jvmti/
> > >   MKDIR   /tmp/build/perf-tools-next/jvmti/
> > >   MKDIR   /tmp/build/perf-tools-next/jvmti/
> > >   MKDIR   /tmp/build/perf-tools-next/jvmti/
> > >   GEN     perf-iostat
> > >   CC      /tmp/build/perf-tools-next/jvmti/libjvmti.o
> > > 
> > > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/build/Makefile.build                | 20 -----------------
> > >  tools/perf/Makefile.perf                  | 37 ++++++++++++++++++++++++++++++-
> > >  tools/perf/tests/shell/coresight/Makefile |  2 +-
> > >  3 files changed, 37 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > > index 5fb3fb3d97e0fd114e245805809e4fc926b4343e..e710ed67a1b49d9fda11db02821bbd8d36066b44 100644
> > > --- a/tools/build/Makefile.build
> > > +++ b/tools/build/Makefile.build
> > > @@ -12,26 +12,6 @@
> > >  PHONY := __build
> > >  __build:
> > >  
> > > -ifeq ($(V),1)
> > > -  quiet =
> > > -  Q =
> > > -else
> > > -  quiet=quiet_
> > > -  Q=@
> > > -endif
> > > -
> > > -# If the user is running make -s (silent mode), suppress echoing of commands
> > > -# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> > > -ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > > -short-opts := $(firstword -$(MAKEFLAGS))
> > > -else
> > > -short-opts := $(filter-out --%,$(MAKEFLAGS))
> > > -endif
> > > -
> > > -ifneq ($(findstring s,$(short-opts)),)
> > > -  quiet=silent_
> > > -endif
> > > -
> > >  build-dir := $(srctree)/tools/build
> > 
> > hi,
> > if we move this out of here, we need to fix other tools that rely on that,
> > bpftool and resolve_btfids do not build quietly now

Sorry about the trouble.  I should've checked other builds.

> > 
> > but not sure what was the reason of moving it out, the code in Makefile.perf
> > seems same as the one above
> 
> perf/Makefile.syscalls wanted to support quiet building. Makefile.perf
> imports both Makefile.syscalls and Makefile.build, so I moved this quiet
> infrastructure into Makefile.perf so that both of these files could use
> it.
> 
> I was trying to move the quiet infrastructure higher up in the callchain
> so that the code did not need to be duplicated. Perhaps it is better to
> move this into a separate file that exports "quiet" and "Q" and then can
> be imported from bpf/Makefile, perf/Makefile.perf, and any other tool
> that wants to have quiet builds?

Makes sense.  Can you please send a patch for that?

Thanks,
Namhyung

