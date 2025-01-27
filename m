Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585E1FECA0;
	Mon, 27 Jan 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985743; cv=none; b=pGz9TQbZQ/ezgzzvPVw6tfnR8bb3CtRTOuaMWLiTdgd3gL9YPaFg7yRJn4xYuMrmEMta70FsM0nDXIRPxQUZmn2BrVh9wo/ca48yRNGB4bcbaj2jDkqAYwXzCcYp16tVgCEcidRZF0JdxpuPq3IgG7Ae31sOEdFhCHxxMabUSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985743; c=relaxed/simple;
	bh=X1fYghLYqNZH+LTIso57Z/ViGpJWT/XpAIDReNjGdI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDi9+pqs3lVSPD2alvNj8GqgDpJB5TfhktlNzi+F67tjl8i3Fp8LP/TG6OE8MMoOiucdDqBbjrR0231+auWCjdY95hzFspwJLLmmH6En2/ZKM2noUKrtGqYBvpBKSMUO/Q0xEa7tI1Yi5YqoF8Lqv5j9MOHosXNChaAZfZ4hsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oJvj9Tb3; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oJvj9Tb3"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 266E7E000F;
	Mon, 27 Jan 2025 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737985732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAUpfLOaApPb8YbcqujnrkqADoPvQNE2tKxRThozcyc=;
	b=oJvj9Tb3k94uiQ99TDhlqWv9wDe2K+UZG/x8yaXyFC3rdvMwqHXFzh/b81vt9RXWkvHC8E
	VFfojZQpSeLIKr0DSbx3CltjvqwByu/xsUxaCFKMNZ4V+yX4/WJzlsaAZZ5ZhhneV5tnc/
	mAfBvIrqx0UZ1DXeWJdnp4m56t7dSTD8RBuBaJAczzsqc1hWU9GxZ+o+UuLF2Dji9pEncH
	ofKi/EYKF18cJM3Hzbe2LbU6Uo89Y6ACv1ojAvPoe4VIgfcAL5ywEyJkp3x93rcyRGPPdf
	Z80JK2m6zqnSNHsvbs5eLg4d/++TMhLXWzT+U/aS1p1DQ/cThI1GBRocCa2K0g==
Date: Mon, 27 Jan 2025 14:48:49 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi
 Kleen <ak@linux.intel.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Alexis =?UTF-8?Q?Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: fix in-tree build
Message-ID: <20250127144849.744ec7e0@booty>
In-Reply-To: <Z5aiWiqJbkNaVG2Y@google.com>
References: <20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com>
	<Z5aiWiqJbkNaVG2Y@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Namhyung Kim, 

thanks for having a look!

On Sun, 26 Jan 2025 13:00:10 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> Hello,
> 
> On Fri, Jan 24, 2025 at 02:06:08PM +0100, Luca Ceresoli wrote:
> > Building perf in-tree is broken after commit 890a1961c812 ("perf tools:
> > Create source symlink in perf object dir") which added a 'source' symlink
> > in the output dir pointing to the source dir.  
> 
> I cannot reproduce it - both `make -C tools/perf` and `cd tools/perf; make`
> work well for me.  What do you mean by in-tree build exactly?  Can you
> please share your command line and the error messages?

I have narrowed down my reproducer script from the initial report to a
fairly minimal one, and here it is:

------------------------8<------------------------
#!/bin/sh

set -eu

OUT_DIR=${1:-$(pwd)/tools/perf}
DESTDIR=/tmp/aaa

RET=0

echo "Kernel version: $(git describe)"
echo "OUT_DIR = ${OUT_DIR}"
echo "DESTDIR = ${DESTDIR}"
echo

git clean -xdfq
rm -fr ${DESTDIR}/

# Only for out of tree builds: clear the build dir
if ! echo ${OUT_DIR} | grep -q "tools/perf"; then
    rm -fr ${OUT_DIR}
    mkdir -p ${OUT_DIR}
fi

LINUX_MAKE_FLAGS="\
    -C tools/perf \
    O=${OUT_DIR} \
    DESTDIR=${DESTDIR} \
"

make ${LINUX_MAKE_FLAGS}
make ${LINUX_MAKE_FLAGS} install

echo
    
if [ -h ${OUT_DIR}/perf ]; then
    echo "*** ERROR: ${OUT_DIR}/perf is a symlink, should be an exectuable file: ***" >&2
    ls -l ${OUT_DIR}/perf
    RET=255
fi

if ! find ${DESTDIR}/ -name perf -not -type d | xargs file | grep 'ELF.*executable'; then
    echo "*** ERROR: perf executable not preseint in install dir ${DESTDIR} ***" >&2
    RET=255
fi

exit $RET
------------------------8<------------------------

Just put it outside of your kernel dir (or it will be removed by the
'git clean' command) and run it in your kernel source dir. E.g. right
now I'm doing:

cd <kernel dir>
git checkout v6.13
../build-perf

You should see it failing as:

*** ERROR: /.../linux/tools/perf/perf is a symlink, should be an exectuable file: ***
lrwxrwxrwx 1 user user 39 Jan 27 14:10 /.../linux/tools/perf/perf -> /.../linux/tools/perf
*** ERROR: perf executable not preseint in install dir /tmp/aaa ***

Note that in the broken case the kernel build continues and returns 0,
but there is no perf exectuable.

PS:

And after having come up with the above script, I also found that the
build succeeds with the following change:

------------------------8<------------------------
@@ -24,11 +24,10 @@
 LINUX_MAKE_FLAGS="\
     -C tools/perf \
     O=${OUT_DIR} \
-    DESTDIR=${DESTDIR} \
 "
 
 make ${LINUX_MAKE_FLAGS}
-make ${LINUX_MAKE_FLAGS} install
+make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR} install
------------------------8<------------------------

In other words:

 * This fails:
     make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR}
     make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR} install
 * This succeeds:
     make ${LINUX_MAKE_FLAGS}
     make ${LINUX_MAKE_FLAGS} DESTDIR=${DESTDIR} install

The only difference is the presence of 'DESTDIR' in the compile command.

My understanding and expectation is that DESTDIR has no effect on the
make process except in the 'install' target. This is clearly not
happening here.

I have not yet found an obvious reason why 'DESTDIR' is special in the
compilation stage, after a quick look.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
