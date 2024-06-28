Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB413E3FD
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570439; cv=none; b=tPJ5Cm8+br0mdtq0z+/jtJ3sTvIaT0SxcdGtw2meCvdeo5NogVbojNNehWyG2n6Tm06FJ7U+tPnsqwx9ZRJrD7z/FdYbowCmkMKhD2pMbI1UzL0a6OMSRxSnCxgrWDUQF030Hx0hOsLdMtXO8w6T0oL3sGSu5AJdxiamwkuiTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570439; c=relaxed/simple;
	bh=6oDGBVEaBl3dCfJu+IlZWGgDMbnDY46o2aNX4/z7u70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGINUkCzT5Hfyl/iLFK/WOdf/bCKCFrK5WCP0xiEKuYdhf/E36uwuoBJdZO18CmlRW1oJ0ZTnmy0UV8Ls87+rv4wwxXec9fWog/9PCt0KBtcTPz8wufUSYyjo5wsydkZKTj56JkE25pL5MDfsr8eq9Fn3iais+9wQTInc6Y2Xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 28 Jun 2024 12:27:11 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: acme@kernel.org, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf build: Use pkg-config for feature check for
 libtrace{event,fs}
Message-ID: <Zn6P_zAaN7frkjPd@gentoo.org>
References: <20240606153625.2255470-1-amadio@gentoo.org>
 <20240606153625.2255470-2-amadio@gentoo.org>
 <072d3965-7140-4f0b-bf9a-9d7edabbfde9@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <072d3965-7140-4f0b-bf9a-9d7edabbfde9@leemhuis.info>

On Fri, Jun 28, 2024 at 09:13:43AM +0200, Thorsten Leemhuis wrote:
> On 06.06.24 17:33, amadio@gentoo.org wrote:
> > From: Guilherme Amadio <amadio@gentoo.org>
> > 
> > Needed to add required include directories for the feature detection
> > to succeed. The header tracefs.h is installed either into the include
> > directory /usr/include/tracefs/tracefs.h when using the Makefile, or
> > into /usr/include/libtracefs/tracefs.h when using meson to build
> > libtracefs. The header tracefs.h uses #include <event-parse.h> from
> > libtraceevent, so pkg-config needs to pick the correct include directory
> > for libtracefs and add the one for libtraceevent to succeed.
> > 
> > Note that in baa2ca59ec1e31ccbe3f24ff0368152b36f68720 the variable
> > LIBTRACEEVENT_DIR was introduced, and now the method to compile against
> > non-standard locations requires PKG_CONFIG_PATH to be set instead, which
> > works for both libtraceevent and libtracefs.
> > 
> > Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> > Cc: Ian Rogers <irogers@google.com>
> 
> Since this patch landed in Linux next as 0f0e1f44569061 ("perf build:
> Use pkg-config for feature check for libtrace{event,fs}") my vanilla 
> -next build using the RPM spec file from Fedora fails. I'm not sure if
> it causes my problems, but it looks likely.

Thank you for reporting. I think we need to use similar checks in the
tools/verification/rv/Makefile.config, as it seems the problem comes
from there:

+ pushd tools/verification/rv/
kernel.spec:3000: build rv
... (compile command lines removed)

Auto-detecting system features:
...                           libtraceevent: [ on  ]
...                              libtracefs: [ OFF ]

libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
Makefile.config:46: *** Please, check the errors above..  Stop.
error: Bad exit status from /var/tmp/rpm-tmp.yNun6A (%build)

I will submit a patch to fix it.

Best regards,
-Guilherme

> 
> A log of a failed build can be found here:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/07670271-next-next-all/builder-live.log.gz
> 
> The gist:
> """
> 
> Auto-detecting system features:
> ...                           libtraceevent: [ on  ]
> ...                              libtracefs: [ OFF ]
> 
> libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
> Makefile.config:46: *** Please, check the errors above..  Stop.
> error: Bad exit status from /var/tmp/rpm-tmp.yNun6A (%build)
> """
> 
> But libtracefs-devel is installed and pkgconfig works (output from
> another machine):
> 
> $ pkgconf --cflags libtracefs
> -I/usr/include/tracefs -I/usr/include/traceevent
> 
> From a *quick* looks it seems those flags are not picked up when
> building tools/verification/rv/feature/test-libtracefs.bin 
> 
> """
> + pkg-config --cflags libtraceevent
> gcc  -MD -Wall -Werror -o /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.bin test-libtracefs.c -ggdb   > /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.make.output 2>&1 -I/usr/include/traceevent  -ltracefs
> + gcc -MD -Wall -Werror -o /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.bin test-libtracefs.c -ggdb -I/usr/include/traceevent -ltracefs
> make: *** [Makefile:216: /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.bin] Error 1
> make: Leaving directory '/home/thl/usr/tmp/linux-next/tools/build/feature'
> """
> 
> And
> 
> """
> $ cat /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.make.output 
> test-libtracefs.c:2:10: fatal error: tracefs.h: No such file or directory
>     2 | #include <tracefs.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> """
> 
> Then I ran out of time looking where it might missing and decided to write
> this mail instead.
> 
> Ciao, Thorsten
> 
> 
> > ---
> >  tools/build/feature/test-libtracefs.c |  2 +-
> >  tools/perf/Makefile.config            | 27 +++++++++++++--------------
> >  2 files changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/build/feature/test-libtracefs.c b/tools/build/feature/test-libtracefs.c
> > index 8eff16c0c10b..29a757a7d848 100644
> > --- a/tools/build/feature/test-libtracefs.c
> > +++ b/tools/build/feature/test-libtracefs.c
> > @@ -1,5 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include <tracefs/tracefs.h>
> > +#include <tracefs.h>
> >
> > [...]
