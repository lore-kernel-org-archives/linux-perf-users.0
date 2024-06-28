Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB94C3BE
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579412; cv=none; b=f/AFMnQvm0VUo/a6r7vo6Ujge9lnCISZCIH3Ubc3nrWvvMZykCKFOrwg76NcalIPrGuSdsDyMnQEz4UkN+dywUHYD56FRcDg3wjqI4RE0NC4+8D2OK3SAhcoBArtAo/6aCf1Y9TXwXB1QmSUHVJjrRZSDGswLJRc41I2Klkkpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579412; c=relaxed/simple;
	bh=iNRCyXfjAwJ3SE+lCS6kxWfvowYQBDStWGZbYVyUgSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQTONWXDDG+IxZoMQM+GMHdbuBSI/TM7p5ajFWQ5d3qWc0/vRBBOrBYFtBYl68Te/RKsFCxVTq4cY+0IyLjBolzaCpJRxWbohkbCODQxnybDEcwHiNx5wDkXQpSjJhSCXlI0SR3680EilRZRb2OORB/ZBLYV4TlicjgCmu/Dj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t98W+m7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t98W+m7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3307C116B1;
	Fri, 28 Jun 2024 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719579412;
	bh=iNRCyXfjAwJ3SE+lCS6kxWfvowYQBDStWGZbYVyUgSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t98W+m7DMLOG+az3LyosNlrtwxi1PC5gG4e6ufAFLPz7QJzCeAYGKVF0t1eFCEUEK
	 x9JrbTotXjI11IP1ANspL29yCh/1I3SoeadjDdi31JmNyvbY9/qxzQj1CzduW0t8YW
	 EyZF2JZ3/kHcc4zSBjWlqwYJXBCktfMboj7Bwrb2SVRo4yTgJFIJ6ujy7D64IjBBg+
	 JvGngVLkKIi7VEYUuXR2y8rwdNhXj4lz9/FDg19RhNqSur4z0Jzl1q++5SDcXj8ERF
	 C6xla69JEZ/Sf2wyUTuQWD1phLfsKtFtKlCaTjTZmJTnbwWOKWOliIiuWdfT5+LkWE
	 BpFJaAA8TKzJw==
Date: Fri, 28 Jun 2024 09:56:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf build: Use pkg-config for feature check for
 libtrace{event,fs}
Message-ID: <Zn6zEBgRu1KLVQ1m@x1>
References: <20240606153625.2255470-1-amadio@gentoo.org>
 <20240606153625.2255470-2-amadio@gentoo.org>
 <072d3965-7140-4f0b-bf9a-9d7edabbfde9@leemhuis.info>
 <Zn6P_zAaN7frkjPd@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn6P_zAaN7frkjPd@gentoo.org>

On Fri, Jun 28, 2024 at 12:27:11PM +0200, Guilherme Amadio wrote:
> On Fri, Jun 28, 2024 at 09:13:43AM +0200, Thorsten Leemhuis wrote:
> > On 06.06.24 17:33, amadio@gentoo.org wrote:
> > > From: Guilherme Amadio <amadio@gentoo.org>
> > > 
> > > Needed to add required include directories for the feature detection
> > > to succeed. The header tracefs.h is installed either into the include
> > > directory /usr/include/tracefs/tracefs.h when using the Makefile, or
> > > into /usr/include/libtracefs/tracefs.h when using meson to build
> > > libtracefs. The header tracefs.h uses #include <event-parse.h> from
> > > libtraceevent, so pkg-config needs to pick the correct include directory
> > > for libtracefs and add the one for libtraceevent to succeed.
> > > 
> > > Note that in baa2ca59ec1e31ccbe3f24ff0368152b36f68720 the variable
> > > LIBTRACEEVENT_DIR was introduced, and now the method to compile against
> > > non-standard locations requires PKG_CONFIG_PATH to be set instead, which
> > > works for both libtraceevent and libtracefs.
> > > 
> > > Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> > > Cc: Ian Rogers <irogers@google.com>
> > 
> > Since this patch landed in Linux next as 0f0e1f44569061 ("perf build:
> > Use pkg-config for feature check for libtrace{event,fs}") my vanilla 
> > -next build using the RPM spec file from Fedora fails. I'm not sure if
> > it causes my problems, but it looks likely.
> 
> Thank you for reporting. I think we need to use similar checks in the
> tools/verification/rv/Makefile.config, as it seems the problem comes
> from there:
> 
> + pushd tools/verification/rv/
> kernel.spec:3000: build rv
> ... (compile command lines removed)
> 
> Auto-detecting system features:
> ...                           libtraceevent: [ on  ]
> ...                              libtracefs: [ OFF ]
> 
> libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
> Makefile.config:46: *** Please, check the errors above..  Stop.
> error: Bad exit status from /var/tmp/rpm-tmp.yNun6A (%build)
> 
> I will submit a patch to fix it.

I noticed something related, but in my case the build proceeded, giving
these warings:

Package libtracefs was not found in the pkg-config search path.
Perhaps you should add the directory containing `libtracefs.pc'
to the PKG_CONFIG_PATH environment variable
Package 'libtracefs', required by 'virtual:world', not found
Package libtracefs was not found in the pkg-config search path.
Perhaps you should add the directory containing `libtracefs.pc'
to the PKG_CONFIG_PATH environment variable
Package 'libtracefs', required by 'virtual:world', not found

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                             libcapstone: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

⬢[acme@toolbox perf-tools-next]$ rpm -qa | grep tracefs
⬢[acme@toolbox perf-tools-next]$ rpm -qa | grep traceevent
libtraceevent-1.7.2-3.fc39.x86_64
libtraceevent-devel-1.7.2-3.fc39.x86_64
⬢[acme@toolbox perf-tools-next]$

- Arnaldo

 
> Best regards,
> -Guilherme
> 
> > 
> > A log of a failed build can be found here:
> > https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/07670271-next-next-all/builder-live.log.gz
> > 
> > The gist:
> > """
> > 
> > Auto-detecting system features:
> > ...                           libtraceevent: [ on  ]
> > ...                              libtracefs: [ OFF ]
> > 
> > libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
> > Makefile.config:46: *** Please, check the errors above..  Stop.
> > error: Bad exit status from /var/tmp/rpm-tmp.yNun6A (%build)
> > """
> > 
> > But libtracefs-devel is installed and pkgconfig works (output from
> > another machine):
> > 
> > $ pkgconf --cflags libtracefs
> > -I/usr/include/tracefs -I/usr/include/traceevent
> > 
> > From a *quick* looks it seems those flags are not picked up when
> > building tools/verification/rv/feature/test-libtracefs.bin 
> > 
> > """
> > + pkg-config --cflags libtraceevent
> > gcc  -MD -Wall -Werror -o /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.bin test-libtracefs.c -ggdb   > /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.make.output 2>&1 -I/usr/include/traceevent  -ltracefs
> > + gcc -MD -Wall -Werror -o /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.bin test-libtracefs.c -ggdb -I/usr/include/traceevent -ltracefs
> > make: *** [Makefile:216: /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.bin] Error 1
> > make: Leaving directory '/home/thl/usr/tmp/linux-next/tools/build/feature'
> > """
> > 
> > And
> > 
> > """
> > $ cat /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.make.output 
> > test-libtracefs.c:2:10: fatal error: tracefs.h: No such file or directory
> >     2 | #include <tracefs.h>
> >       |          ^~~~~~~~~~~
> > compilation terminated.
> > """
> > 
> > Then I ran out of time looking where it might missing and decided to write
> > this mail instead.
> > 
> > Ciao, Thorsten
> > 
> > 
> > > ---
> > >  tools/build/feature/test-libtracefs.c |  2 +-
> > >  tools/perf/Makefile.config            | 27 +++++++++++++--------------
> > >  2 files changed, 14 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/tools/build/feature/test-libtracefs.c b/tools/build/feature/test-libtracefs.c
> > > index 8eff16c0c10b..29a757a7d848 100644
> > > --- a/tools/build/feature/test-libtracefs.c
> > > +++ b/tools/build/feature/test-libtracefs.c
> > > @@ -1,5 +1,5 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > > -#include <tracefs/tracefs.h>
> > > +#include <tracefs.h>
> > >
> > > [...]
