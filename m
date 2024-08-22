Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526173514;
	Thu, 22 Aug 2024 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350652; cv=none; b=m4G2F+Qu6bJRbk6N4xa1u6ZgdaHvbgKCFSsvNr6S57ErLn/Oqn9HqyrssmmbsXzTj7OSA+GMMQHM6TOsacAoa/cHSgdlT/CZRUqZvjh7pkmEQQCdKfjvWbts8S2W0iZg9r28N6opdOTQyrHz65q/lkAyXP/l0u9bhPoTvIc91ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350652; c=relaxed/simple;
	bh=8fqcQ/EzxCrNO5U+dC7TaLv7MV6A/7Vm1r+bS8rldcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smnX9+7G7M7mGToHfOS3tSr6fUxyP7UAn9d5JWjkJF1hQL60AwunocsjJh6+U6pF2GF5PWb/tBYZDvzRZ5PwmWzqExZo4MbFFU0O8JP+tILaRtj+tuiijQRKlQcMCl5jYsp3895kbHqPaKyvctnt/4soXkVqSE3s+1mlKqOKAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxfBadyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxfBadyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D42C32782;
	Thu, 22 Aug 2024 18:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724350652;
	bh=8fqcQ/EzxCrNO5U+dC7TaLv7MV6A/7Vm1r+bS8rldcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxfBadyKfhK2Mk3K2bVvv+1Pypfo6XuOZ/5S/6V12pLzfuPU5Tfr/v5ZgJQ259W3b
	 lKvTOh71PKDTljtWYF5t6LNP2cz4rAMaDPf2t4QH/5YVieN7o89oebQ2YqTRe3S8RY
	 /pD9I2S4RumM0LRHqxfS/MZRN7VKIitNg69sKfSzfBgnAeqX/ql9Dx0c7Gpqeghvpp
	 r/ByntiSFffJqVJ+4lGi30YcFyCUklmGN7MrLPFc+CWu8Kx9m7QEos0vwyiYDGAcqQ
	 oEAIcbAhNoTjXl/tNG5gkBO7EC7DiAYOdSsj4mhYouOnmGPWxUA/xkb1My9BzRnrAS
	 z/5ldXrN/5Ptw==
Date: Thu, 22 Aug 2024 15:17:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
Message-ID: <ZseAuZelNHgcchGj@x1>
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1>
 <ZsdUxxBrpbuYxtXN@x1>
 <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1>
 <ZsdzLmIFWRqsXeXD@x1>
 <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
 <Zsd39zG9BuGpZ8aA@x1>
 <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>

On Thu, Aug 22, 2024 at 07:59:13PM +0200, Sedat Dilek wrote:
> On Thu, Aug 22, 2024 at 7:40 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Aug 22, 2024 at 07:31:55PM +0200, Sedat Dilek wrote:
> > > On Thu, Aug 22, 2024 at 7:19 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 22, 2024 at 02:12:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Thu, Aug 22, 2024 at 07:02:52PM +0200, Sedat Dilek wrote:
> > > > > > On Thu, Aug 22, 2024 at 5:10 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > > > +++ b/tools/perf/util/setup.py
> > > > > > > @@ -17,7 +17,7 @@ src_feature_tests  = getenv('srctree') + '/tools/build/feature'
> > > > >
> > > > > > >  def clang_has_option(option):
> > > > > > >      cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> > > > > > > -    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
> > > > > > > +    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
> > > > > > >  if cc_is_clang:
> > > > > > >      from sysconfig import get_config_vars
> > > > > > > @@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
> > > > > > >  cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> > > > > > >  if cc_is_clang:
> > > > > > >      cflags += ["-Wno-unused-command-line-argument" ]
> > > > > > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > > > > > +        cflags += ["-Wno-cast-function-type-mismatch" ]
> > > > > > >  else:
> > > > > > >      cflags += ['-Wno-cast-function-type' ]
> > > > >
> > > > > > I tried with your diff with SLIM LLVM toolchains 18 and 19.
> > > > >
> > > > > > Both work - see attached build-logs.
> > > > >
> > > > > > Yes, are right that LLVM/Clang v19 was first introducing:
> > > > >
> > > > > > -Wcast-function-type-mismatch / -Wno-cast-function-type-mismatch
> > > > >
> > > > > > [4] says for LLVM 18.1.8:
> > > > >
> > > > > > -Wcast-function-type
> > > > > > -Wcast-function-type-strict
> > > > >
> > > > > > Feel free to add my Reported-by/Tested-by credentials if you sent a full patch.
> > > > >
> > > > > Thanks for the report and test of the fix, I'll add both tags,
> > > >
> > > > So below is the part that deals with disabling the warning if present,
> > > > the other patch supporting checking warning options I merged as a prep
> > > > patch.
> > > >
> > > > Thanks!
> > > >
> > > > - Arnaldo
> > > >
> > > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2001
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-mismatch if
> > > >  present on clang
> > > >
> > > > The -Wcast-function-type-mismatch option was introduced in clang 19 and
> > > > its enabled by default, since we use -Werror, and python bindings do
> > > > casts that are valid but trips this warning, disable it if present.
> > > >
> > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Cc: Ian Rogers <irogers@google.com>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > ---
> > > >  tools/perf/util/setup.py | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > > > index 26c0f2614fe92eb6..649550e9b7aa8c8f 100644
> > > > --- a/tools/perf/util/setup.py
> > > > +++ b/tools/perf/util/setup.py
> > > > @@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
> > > >  cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> > > >  if cc_is_clang:
> > > >      cflags += ["-Wno-unused-command-line-argument" ]
> > > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > > +        cflags += ["-Wno-cast-function-type-mismatch" ]
> > > >  else:
> > > >      cflags += ['-Wno-cast-function-type' ]
> > > >
> > > > --
> > > > 2.46.0
> > > >
> > >
> > > Thanks for the patch, Arnanldo.
> > >
> > > @Nathan Chancellor
> > > What was the b4 magic to retrieve a patch included in a ML thread?
> > >
> > > I tried:
> > >
> > > link="https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com/"
> > >
> > > b4 am $link
> > > Grabbing thread from
> > > lore.kernel.org/all/CA%2BicZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com/t.mbox.gz
> > > Analyzing 9 messages in the thread
> > > No patches found.
> >
> > I use:
> >
> > ⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com
> > Grabbing thread from lore.kernel.org/all/CA%2BicZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5%2BzQNQGUxK7%2B2aw@mail.gmail.com/t.mbox.gz
> > Analyzing 10 messages in the thread
> > No patches found.
> > ⬢[acme@toolbox perf-tools-next]$
> >
> > Using the Message-ID for your message, which normally is enough, but I
> > think I didn't separate the patch from the rest of the message with ---.
> >
> > Lemme try...
> >
> > ---
> >
> > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-mismatch if
> >  present on clang
> >
> > The -Wcast-function-type-mismatch option was introduced in clang 19 and
> > its enabled by default, since we use -Werror, and python bindings do
> > casts that are valid but trips this warning, disable it if present.
> >
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/setup.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > index 26c0f2614fe92eb6..649550e9b7aa8c8f 100644
> > --- a/tools/perf/util/setup.py
> > +++ b/tools/perf/util/setup.py
> > @@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
> >  cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> >  if cc_is_clang:
> >      cflags += ["-Wno-unused-command-line-argument" ]
> > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > +        cflags += ["-Wno-cast-function-type-mismatch" ]
> >  else:
> >      cflags += ['-Wno-cast-function-type' ]
> >
> > --
> > 2.46.0
> >
> 
> Hmm, OK.
> 
> My first posting:
> https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com/
> 
> $ b4 am -ctsl --cc-trailers
> CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com
> Grabbing thread from
> lore.kernel.org/all/CA%2BicZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5%2BzQNQGUxK7%2B2aw@mail.gmail.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 11 messages in the thread
> No patches found.
> 
> Did you drop that part by accident or intentionally from the patch?

I mentioned that:

> > > > the other patch supporting checking warning options I merged as a prep
> > > > patch.

Please take a look at tmp.perf-tools-next at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

⬢[acme@toolbox perf-tools-next]$ git log perf-tools-next/tmp.perf-tools-next -2 --oneline
155212c965b5b23a (perf-tools-next/tmp.perf-tools-next, perf-tools-next.korg/tmp.perf-tools-next, acme.korg/tmp.perf-tools-next) perf python: Disable -Wno-cast-function-type-mismatch if present on clang
b81162302001f411 perf python: Allow checking for the existence of warning options in clang
⬢[acme@toolbox perf-tools-next]$

One patch introduces a mechanism, the other uses it.

- Arnaldo
