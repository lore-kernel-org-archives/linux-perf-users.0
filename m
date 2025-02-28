Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC41DE2C2
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780265; cv=none; b=J3uRSsmP0vWTtwjqPR8LENJ7Cmgld/T2knLjxT1/2ljl/lM/IuyNN7FAgvXwb/N/MIpYkvnb1XwQYTxANRvqkpJ+eKqEs8Xf1uKdy185MZ2xJ+nodEGOPCWjGrW/uZzCkRdFJMoSAetViCDSR31c0UQx7mmhHMHfaCw8R2j1w0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780265; c=relaxed/simple;
	bh=Fo6uieF8MXdJzXCugekRoPLeDJUAd1zdyezMwe0l+uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgcOSCzwVW9Lxg9XbEfEAc8RlSX0gqPTtYGi+ak7q9g6RuHYpm1gSWorhOlbCMzVym9pST6xGT/gwOLj8C8UXfLjiTPLwG+4lNT71LDmx+IHACctmZz2eEgtxZU9H14Uq6+QcStMVk+OKbBpUQvsr3guT2fpT9P2+2JPzZEyOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ykg1RMsj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ykg1RMsj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2234e5347e2so55192955ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740780263; x=1741385063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvBb60p0YFoTjTiPiAgHCEPC4ZPe5DmOOF4kiX3lFYA=;
        b=ykg1RMsjjafwoubApT2ctFXAHDRgB6NhpaI9rysm2gHnhArk2MiGuW2p06JZdNVZAW
         hdfJdyB7aCvFbogFlg8x21vbf4sk+J0enovfNQeWNRNRPluRyX4rAcYnn0ZvYCYVFtWR
         /vq+c/FIZJAguriA2PLf0PoAft6HKqiGRzan907JtQu+e32dbOqVWHC0dDieQC2w8Cfl
         SHMEizAKqKkIhmPJufQMGAxlApgb1XvRUutpoB0EJbrHNYCXw2QHtWqmHX6uLvjwDtmJ
         ppy3nFpsHKzpYI/Zx4ONscXQQ+/LaVUTtMEmpLZnW1C9EQ+D6nseLkJzhykAZrsShC1i
         du6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740780263; x=1741385063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvBb60p0YFoTjTiPiAgHCEPC4ZPe5DmOOF4kiX3lFYA=;
        b=wcpP2zVLIycHhB7GpQl4ne/TcJ0IcrIMxWNlZZtZvLl7JMMR7cBPtWzmr4Q9pQYRUr
         t/gWOr2xFWTlkRg/kJ6erGCSC3SsGey7L/CCqC3H5HEAPHyMxnZKaSYDCA92odXIkAVR
         oZwCLNcWO3IH7Azq9lRk4szqYyBH3WsHBr6c0WHG9N/3/oGj7k5ZnpLf3xc9XS2Ad0zs
         sT0jXewMK0M9G8wOqgZnXSIO1XjWI5V8E7ARGQo7yOJn/LEZ/BF3F4mThgtFyM3wgUdB
         gxYgHqqRy1Y3YfFRy3MFMzZPQo8sbkqBdVkd8/S4exJUzJDmxCjmO0Ci25o+ZjsY04hE
         y2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWzbViPkWC29M0o6BiLFC/1gm7kFDe3Scp+67zNrkhCkyxpb8Xqbcimq4Akyr5PMQds2ffmPHL2A1H6CfbnGJ8+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DY8sqdZykhKKJh05zb2m4PytcFsP5EYDzCYcLo7UAs8Y41Vl
	g9gXGfZvTfIaxWA3d0w0d3ysDF/syrqrc4lVdApR1sthEI1EYoSKBqfZDwpT3NE=
X-Gm-Gg: ASbGncvmSFbk/Zd8PnF1yurh5SVBVVPC5HmW8Vi9pw7/UI/shIyqlx4xvwTww2XvEDX
	qCb9b3O5uwsf7b1RYqLYHwUsBvHKkDcHLnnFj5uOsap7uPgMgrIaPBLl5/A5ejkCHjHbL0xZDMQ
	wHQK7Y7NH35bE3Nrb2CN2AytXeB0/vApzcmDkSz7RJFxSt7xZ7M26WAZP8yK7OalUMzDfMVN8RO
	ymYRRoxqMR4nM5Pv/buHUHPZisf5VYcnWsylBfTrWHnqrFyBv+Ro/iTlAZQBlDNMwc+gZ9sVC8t
	688WShNhjwwayKPeB9L+Ib9pm4zrNIyacUhZ8FEc
X-Google-Smtp-Source: AGHT+IF1QDsfmU6kmcYv7uzPjWuC1iLO4lRd8c/iGKm7GSHoOaILCCiPIv6ibpYJAXqGx4HnKypQ0w==
X-Received: by 2002:a05:6a00:1a8f:b0:730:76a1:3935 with SMTP id d2e1a72fcca58-734ac37b211mr8440748b3a.6.1740780263400;
        Fri, 28 Feb 2025 14:04:23 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:6935:f301:4e47:2b68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024d40sm4424794b3a.93.2025.02.28.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 14:04:22 -0800 (PST)
Date: Fri, 28 Feb 2025 14:04:19 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Namhyung Kim <namhyung@kernel.org>
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
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: fix in-tree build
Message-ID: <Z8Iy49ij4eRdxBYR@ghost>
References: <20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com>
 <Z5aiWiqJbkNaVG2Y@google.com>
 <20250127144849.744ec7e0@booty>
 <Z5kiciNxDk-G-Zhr@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5kiciNxDk-G-Zhr@google.com>

On Tue, Jan 28, 2025 at 10:31:14AM -0800, Namhyung Kim wrote:
> On Mon, Jan 27, 2025 at 02:48:49PM +0100, Luca Ceresoli wrote:
> > Hello Namhyung Kim, 
> > 
> > thanks for having a look!
> > 
> > On Sun, 26 Jan 2025 13:00:10 -0800
> > Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > > Hello,
> > > 
> > > On Fri, Jan 24, 2025 at 02:06:08PM +0100, Luca Ceresoli wrote:
> > > > Building perf in-tree is broken after commit 890a1961c812 ("perf tools:
> > > > Create source symlink in perf object dir") which added a 'source' symlink
> > > > in the output dir pointing to the source dir.  
> > > 
> > > I cannot reproduce it - both `make -C tools/perf` and `cd tools/perf; make`
> > > work well for me.  What do you mean by in-tree build exactly?  Can you
> > > please share your command line and the error messages?
> > 
> > I have narrowed down my reproducer script from the initial report to a
> > fairly minimal one, and here it is:
> > 
> > ------------------------8<------------------------
> > #!/bin/sh
> > 
> > set -eu
> > 
> > OUT_DIR=${1:-$(pwd)/tools/perf}
> > DESTDIR=/tmp/aaa
> > 
> > RET=0
> > 
> > echo "Kernel version: $(git describe)"
> > echo "OUT_DIR = ${OUT_DIR}"
> > echo "DESTDIR = ${DESTDIR}"
> > echo
> > 
> > git clean -xdfq
> > rm -fr ${DESTDIR}/
> > 
> > # Only for out of tree builds: clear the build dir
> > if ! echo ${OUT_DIR} | grep -q "tools/perf"; then
> >     rm -fr ${OUT_DIR}
> >     mkdir -p ${OUT_DIR}
> > fi
> > 
> > LINUX_MAKE_FLAGS="\
> >     -C tools/perf \
> >     O=${OUT_DIR} \
> >     DESTDIR=${DESTDIR} \
> > "
> > 
> > make ${LINUX_MAKE_FLAGS}
> > make ${LINUX_MAKE_FLAGS} install
> > 
> > echo
> >     
> > if [ -h ${OUT_DIR}/perf ]; then
> >     echo "*** ERROR: ${OUT_DIR}/perf is a symlink, should be an exectuable file: ***" >&2
> >     ls -l ${OUT_DIR}/perf
> >     RET=255
> > fi
> > 
> > if ! find ${DESTDIR}/ -name perf -not -type d | xargs file | grep 'ELF.*executable'; then
> >     echo "*** ERROR: perf executable not preseint in install dir ${DESTDIR} ***" >&2
> >     RET=255
> > fi
> > 
> > exit $RET
> > ------------------------8<------------------------
> > 
> > Just put it outside of your kernel dir (or it will be removed by the
> > 'git clean' command) and run it in your kernel source dir. E.g. right
> > now I'm doing:
> > 
> > cd <kernel dir>
> > git checkout v6.13
> > ../build-perf
> > 
> > You should see it failing as:
> > 
> > *** ERROR: /.../linux/tools/perf/perf is a symlink, should be an exectuable file: ***
> > lrwxrwxrwx 1 user user 39 Jan 27 14:10 /.../linux/tools/perf/perf -> /.../linux/tools/perf
> > *** ERROR: perf executable not preseint in install dir /tmp/aaa ***
> > 
> > Note that in the broken case the kernel build continues and returns 0,
> > but there is no perf exectuable.
> 
> Thanks for sharing this.  I've reproduced it and found it had a
> symlink to a directory rather than an executable.
> 
> > 
> > PS:
> > 
> > And after having come up with the above script, I also found that the
> > build succeeds with the following change:
> > 
> > ------------------------8<------------------------
> > @@ -24,11 +24,10 @@
> >  LINUX_MAKE_FLAGS="\
> >      -C tools/perf \
> >      O=${OUT_DIR} \
> > -    DESTDIR=${DESTDIR} \
> >  "
> >  
> >  make ${LINUX_MAKE_FLAGS}
> > -make ${LINUX_MAKE_FLAGS} install
> > +make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR} install
> > ------------------------8<------------------------
> > 
> > In other words:
> > 
> >  * This fails:
> >      make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR}
> >      make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR} install
> >  * This succeeds:
> >      make ${LINUX_MAKE_FLAGS}
> >      make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR} install
> > 
> > The only difference is the presence of 'DESTDIR' in the compile command.
> > 
> > My understanding and expectation is that DESTDIR has no effect on the
> > make process except in the 'install' target. This is clearly not
> > happening here.
> > 
> > I have not yet found an obvious reason why 'DESTDIR' is special in the
> > compilation stage, after a quick look.
> 
> Interesting, maybe some install commands were called internally.  I'll
> take a look.
> 
> Thanks,
> Namhyung
> 

I just stumbled across this as well. It is breaking Buildroot. Buildroot
has this in the Makefile that triggers this bug:

	$(TARGET_MAKE_ENV) $(MAKE1) $(PERF_MAKE_FLAGS) \
		-C $(LINUX_DIR)/tools/perf O=$(LINUX_DIR)/tools/perf/ install

Having the output equal the srcdir causes this overwritting. I sent
pretty much the same patch here [1] before double-checking that somebody
hadn't posted this fix already.

- Charlie

[1] https://lore.kernel.org/lkml/Z8Ixn3J2hw8TLdRj@ghost/


