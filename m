Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E481DF725;
	Tue, 28 Jan 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089076; cv=none; b=KcSFqb0Y0Q12OBBHsQxI8ruqwFzAot5CEbjvY5LhrLqSQCkVYCSDDhh8QF5elnfSpOQiphUmrpwrOJ0dcc92jL0ESVZo0TvePCnShRq100dHz95oUHNgYPj154fEAnybSYXp1Ca6d9RQCh5qFl4/TW27PzDp0d/WzxyWe4kGRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089076; c=relaxed/simple;
	bh=15HeAI6DdGorNatwFpioUx0BZ9HG723Ock9S8WXd1vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTg9H4Kv1w1LQ/DVTC+mMEYmEBgT9vrfigEpYJimILl9PaDAwRuPi56bTHTw38284SJzxQ8dk91d/GTfT6DKeP0CpJrrxmsom1IC7+O1s5og3yZ8wcsDoRRtgbtEZJRoklH4fLuBtNoQOu1a+KPOMYlxH0O9zvgG4iiBbOoNfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlXJechc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlXJechc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D66C4CED3;
	Tue, 28 Jan 2025 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738089075;
	bh=15HeAI6DdGorNatwFpioUx0BZ9HG723Ock9S8WXd1vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HlXJechcmm6SPFJr9Jp7MZhuzNVpL4KkcoQymNCGuArV1GcYC/zPMQyGsVjfkmz0Q
	 zd6llgibNYoAVyfSHhwNKBdgiUQwyQM5Hjt5sVdVm6uugELw1Ccud+4+yzP2x9o4MB
	 tjRnY9Mz4nqo+FgqNjJQ94senB9YLguLdnd4xOYz20EcRQHfnsyb62z9swlg0hl2BP
	 9xjOKa6PTfnWkwq7+h01r+3oCuARMzWsTkRA1x09TvhtPBRNl1LuA4zNk/P9MHef+r
	 AC6UNWNlv/2FWbsOeebxw2X42a3e1ma9gwLLH+t5BQAFFK01lef5u2EYJO9yyIUxXR
	 jxk2wpzFr2eKw==
Date: Tue, 28 Jan 2025 10:31:14 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: fix in-tree build
Message-ID: <Z5kiciNxDk-G-Zhr@google.com>
References: <20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com>
 <Z5aiWiqJbkNaVG2Y@google.com>
 <20250127144849.744ec7e0@booty>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250127144849.744ec7e0@booty>

On Mon, Jan 27, 2025 at 02:48:49PM +0100, Luca Ceresoli wrote:
> Hello Namhyung Kim, 
> 
> thanks for having a look!
> 
> On Sun, 26 Jan 2025 13:00:10 -0800
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hello,
> > 
> > On Fri, Jan 24, 2025 at 02:06:08PM +0100, Luca Ceresoli wrote:
> > > Building perf in-tree is broken after commit 890a1961c812 ("perf tools:
> > > Create source symlink in perf object dir") which added a 'source' symlink
> > > in the output dir pointing to the source dir.  
> > 
> > I cannot reproduce it - both `make -C tools/perf` and `cd tools/perf; make`
> > work well for me.  What do you mean by in-tree build exactly?  Can you
> > please share your command line and the error messages?
> 
> I have narrowed down my reproducer script from the initial report to a
> fairly minimal one, and here it is:
> 
> ------------------------8<------------------------
> #!/bin/sh
> 
> set -eu
> 
> OUT_DIR=${1:-$(pwd)/tools/perf}
> DESTDIR=/tmp/aaa
> 
> RET=0
> 
> echo "Kernel version: $(git describe)"
> echo "OUT_DIR = ${OUT_DIR}"
> echo "DESTDIR = ${DESTDIR}"
> echo
> 
> git clean -xdfq
> rm -fr ${DESTDIR}/
> 
> # Only for out of tree builds: clear the build dir
> if ! echo ${OUT_DIR} | grep -q "tools/perf"; then
>     rm -fr ${OUT_DIR}
>     mkdir -p ${OUT_DIR}
> fi
> 
> LINUX_MAKE_FLAGS="\
>     -C tools/perf \
>     O=${OUT_DIR} \
>     DESTDIR=${DESTDIR} \
> "
> 
> make ${LINUX_MAKE_FLAGS}
> make ${LINUX_MAKE_FLAGS} install
> 
> echo
>     
> if [ -h ${OUT_DIR}/perf ]; then
>     echo "*** ERROR: ${OUT_DIR}/perf is a symlink, should be an exectuable file: ***" >&2
>     ls -l ${OUT_DIR}/perf
>     RET=255
> fi
> 
> if ! find ${DESTDIR}/ -name perf -not -type d | xargs file | grep 'ELF.*executable'; then
>     echo "*** ERROR: perf executable not preseint in install dir ${DESTDIR} ***" >&2
>     RET=255
> fi
> 
> exit $RET
> ------------------------8<------------------------
> 
> Just put it outside of your kernel dir (or it will be removed by the
> 'git clean' command) and run it in your kernel source dir. E.g. right
> now I'm doing:
> 
> cd <kernel dir>
> git checkout v6.13
> ../build-perf
> 
> You should see it failing as:
> 
> *** ERROR: /.../linux/tools/perf/perf is a symlink, should be an exectuable file: ***
> lrwxrwxrwx 1 user user 39 Jan 27 14:10 /.../linux/tools/perf/perf -> /.../linux/tools/perf
> *** ERROR: perf executable not preseint in install dir /tmp/aaa ***
> 
> Note that in the broken case the kernel build continues and returns 0,
> but there is no perf exectuable.

Thanks for sharing this.  I've reproduced it and found it had a
symlink to a directory rather than an executable.

> 
> PS:
> 
> And after having come up with the above script, I also found that the
> build succeeds with the following change:
> 
> ------------------------8<------------------------
> @@ -24,11 +24,10 @@
>  LINUX_MAKE_FLAGS="\
>      -C tools/perf \
>      O=${OUT_DIR} \
> -    DESTDIR=${DESTDIR} \
>  "
>  
>  make ${LINUX_MAKE_FLAGS}
> -make ${LINUX_MAKE_FLAGS} install
> +make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR} install
> ------------------------8<------------------------
> 
> In other words:
> 
>  * This fails:
>      make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR}
>      make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR} install
>  * This succeeds:
>      make ${LINUX_MAKE_FLAGS}
>      make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR} install
> 
> The only difference is the presence of 'DESTDIR' in the compile command.
> 
> My understanding and expectation is that DESTDIR has no effect on the
> make process except in the 'install' target. This is clearly not
> happening here.
> 
> I have not yet found an obvious reason why 'DESTDIR' is special in the
> compilation stage, after a quick look.

Interesting, maybe some install commands were called internally.  I'll
take a look.

Thanks,
Namhyung

