Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189D23F37E;
	Fri, 28 Feb 2025 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787148; cv=none; b=M6xoUsEIwU+JLug5UOTdZWg5XEJUuHypMUFlsk9AGIWIJpFQLpDNv4Lh5F8vMCkMOIpffKXtJB+vlH/QXW4D1yMBcY8C5Ic1bVMRMx7I7yRbXJ4fSjhguG5WpKOJVYtY9+0IWCvST8fWth90VSBPi6QRa4/kgEjUuJPf3kdRLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787148; c=relaxed/simple;
	bh=/WRkCTtYXh1ybFkJl4MN82rEMEE7Dqv4CfKN/PIu86I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdbdnkaZgbE3K35n5I49dYB7+UArWddNPL+fnIlprpQLIUns1cPAdDGWx9jSjrt35r5rU7FaxVxjn5qbrysu6fGYExSzQvyAWTF7YQITY27ORE3bjxohY7abZWgqDJQ7r4PW8fGERPIiS8OxD6qSL2G9/Rnu4xiDGQp7EXIGMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDCS2Rhg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDCS2Rhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19EFC4CED6;
	Fri, 28 Feb 2025 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740787147;
	bh=/WRkCTtYXh1ybFkJl4MN82rEMEE7Dqv4CfKN/PIu86I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDCS2RhgJ3XeJ8PwYBssIw14ioLDPLOzgCLtMmdCB/92m8kx9w8Xp7CE3M4Eupfuj
	 VKOWY/Ow6UH5d1+LhjbIfYE9i34Czsxav+qaG1ZQoE2pFApwgI0qx9jn0kuYEgh65f
	 82zvZkbSPPv6OEc1rMc6XuHQMkSrw3QQeIJLekaaAOwXHQmDWl25oJyuCFcUqi7qKQ
	 D9nCvcLpu0i9lKiHSzg6+f1yo+FL8vhiKtJuVsELx1ZayO4iHc5fCGuoc23KvEuwLp
	 lerDaBOk4jTCbct9GOtKbzOppoGw+K6wdIOCeFWJC4FSHxLwQOKdnvwu9vFrklrHLs
	 4xnA4cN4clrFw==
Date: Fri, 28 Feb 2025 15:59:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <Z8JNybh8i7OKMyhb@google.com>
References: <20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com>
 <Z8Iz2JPpqer00aZ_@ghost>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8Iz2JPpqer00aZ_@ghost>

Hello,

On Fri, Feb 28, 2025 at 02:08:24PM -0800, Charlie Jenkins wrote:
> On Fri, Jan 24, 2025 at 02:06:08PM +0100, Luca Ceresoli wrote:
> > Building perf in-tree is broken after commit 890a1961c812 ("perf tools:
> > Create source symlink in perf object dir") which added a 'source' symlink
> > in the output dir pointing to the source dir.
> > 
> > With in-tree builds, the added 'SOURCE = ...' line is executed multiple
> > times (I observed 2 during the build plus 2 during installation). This is a
> > minor inefficiency, in theory not harmful because symlink creation is
> > assumed to be idempotent. But it is not.
> > 
> > Considering with in-tree builds:
> > 
> >   srctree=/absolute/path/to/linux
> >    OUTPUT=/absolute/path/to/linux/tools/perf
> > 
> > here's what happens:
> > 
> >  1. ln -sf $(srctree)/tools/perf $(OUTPUT)/source
> >     -> creates /absolute/path/to/linux/tools/perf/source
> >        link to /absolute/path/to/linux/tools/perf
> >     => OK, that's what was intended
> >  2. ln -sf $(srctree)/tools/perf $(OUTPUT)/source   # same command as 1
> >     -> creates /absolute/path/to/linux/tools/perf/perf
> >        link to /absolute/path/to/linux/tools/perf
> >     => Not what was intended, not idempotent
> >  3. Now the build _should_ create the 'perf' executable, but it fails
> > 
> > The reason is the tricky 'ln' command line. At the first invocation 'ln'
> > uses the 1st form:
> > 
> >        ln [OPTION]... [-T] TARGET LINK_NAME
> > 
> > and creates a link to TARGET *called LINK_NAME*.
> > 
> > At the second invocation $(OUTPUT)/source exists, so 'ln' uses the 3rd
> > form:
> > 
> >        ln [OPTION]... TARGET... DIRECTORY
> > 
> > and creates a link to TARGET *called TARGET* inside DIRECTORY.
> > 
> > Fix by adding --no-dereference to "treat LINK_NAME as a normal file if it
> > is a symbolic link to a directory", as the manpage says.
> > 
> > Link: https://lore.kernel.org/all/20241125182506.38af9907@booty/
> > Fixes: 890a1961c812 ("perf tools: Create source symlink in perf object dir")
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  tools/perf/Makefile.perf | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index d74241a151313bd09101aabb5d765a5a0a6efc84..bbd799a0fd544db220f29d1e250a819a765d04f3 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -164,7 +164,7 @@ ifneq ($(OUTPUT),)
> >  VPATH += $(OUTPUT)
> >  export VPATH
> >  # create symlink to the original source
> > -SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
> > +SOURCE := $(shell ln -sf --no-dereference $(srctree)/tools/perf $(OUTPUT)/source)
> 
> The kernel Makefile has:
> 	$(Q)ln -fsn $(srcroot) source
> 
> So for parity the --no-dereference could become `n`, but it doesn't
> really matter.

I can make the change.

> 
> >  endif
> >  
> >  ifeq ($(V),1)
> > 
> > ---
> > base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> > change-id: 20250124-perf-fix-intree-build-fbd97f560254
> > 
> > Best regards,
> > -- 
> > Luca Ceresoli <luca.ceresoli@bootlin.com>
> > 
> 
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
 
Thanks for your review!
Namhyung

