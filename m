Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33B487AE;
	Thu, 22 Aug 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348411; cv=none; b=HJi5zemtzggABwELkqDCzpDZaD/Khw7b6nZq1XaLCVCRO+ZJXzNU5JnbVJvtmr7ey1HBbr3xy0vAn17HdBhtSuRCJfgfPo4rOLnIUAngl5kniF6MoEjx7ftDaZLkdnBABq0y5io+LBHyWUIGJk/RMa6c4ZRTFq38+7tkgwevoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348411; c=relaxed/simple;
	bh=bOvfXFEBJ7hru/SrBmVn2vRabF2j+tb8OvK48mGn5qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4KMgucm4VNy/vePwCVZR9TDyPI943jf8hoeDoTToiqORuzGcrYBdHFcgQGdFl7l4WDJ0ivN/etVNd9E/RSSAgQI/ZSUWJutbXoUJNJw5T3Kf/wQfQg8X+tht1PA2eSjGu4mbnY18LyCU6WkioD2wdSV8axqxdzBDGMeRuQIorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqczij/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqczij/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1898BC32782;
	Thu, 22 Aug 2024 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724348410;
	bh=bOvfXFEBJ7hru/SrBmVn2vRabF2j+tb8OvK48mGn5qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gqczij/OrYIZ/u9U8W1H3wa6kMNVmANz2nlw/TKj5o/u9+b94ArUq7w0UShqBAtNb
	 hd/tEE6qLMwkogpM5zMMQegWBkLHqp1JasWwPver0olKGajV0Gq20RDxx/S8Gf7KZJ
	 9vNGwcJjIERJ4a5dqv60oF+kR/Uxt7FcB/Dpga+B6Y0MxYAzz0JKrkmE4ioLNj8o8G
	 5390EZNhWKBG+Ea/xhVvxSVtZri5zh8YaxYbzkkO0lsrUkXCQCykoH4pY0cCWSWsyq
	 QgzHkH3OmLhG2+SHLagYKytAVuBQznfI0o8+vjmuQfjXgz08UBpPNdv8LgwOlNptvb
	 2QdijYKxXwdEg==
Date: Thu, 22 Aug 2024 14:40:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
Message-ID: <Zsd39zG9BuGpZ8aA@x1>
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1>
 <ZsdUxxBrpbuYxtXN@x1>
 <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1>
 <ZsdzLmIFWRqsXeXD@x1>
 <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>

On Thu, Aug 22, 2024 at 07:31:55PM +0200, Sedat Dilek wrote:
> On Thu, Aug 22, 2024 at 7:19 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Aug 22, 2024 at 02:12:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Aug 22, 2024 at 07:02:52PM +0200, Sedat Dilek wrote:
> > > > On Thu, Aug 22, 2024 at 5:10 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > +++ b/tools/perf/util/setup.py
> > > > > @@ -17,7 +17,7 @@ src_feature_tests  = getenv('srctree') + '/tools/build/feature'
> > >
> > > > >  def clang_has_option(option):
> > > > >      cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> > > > > -    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
> > > > > +    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
> > > > >  if cc_is_clang:
> > > > >      from sysconfig import get_config_vars
> > > > > @@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
> > > > >  cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> > > > >  if cc_is_clang:
> > > > >      cflags += ["-Wno-unused-command-line-argument" ]
> > > > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > > > +        cflags += ["-Wno-cast-function-type-mismatch" ]
> > > > >  else:
> > > > >      cflags += ['-Wno-cast-function-type' ]
> > >
> > > > I tried with your diff with SLIM LLVM toolchains 18 and 19.
> > >
> > > > Both work - see attached build-logs.
> > >
> > > > Yes, are right that LLVM/Clang v19 was first introducing:
> > >
> > > > -Wcast-function-type-mismatch / -Wno-cast-function-type-mismatch
> > >
> > > > [4] says for LLVM 18.1.8:
> > >
> > > > -Wcast-function-type
> > > > -Wcast-function-type-strict
> > >
> > > > Feel free to add my Reported-by/Tested-by credentials if you sent a full patch.
> > >
> > > Thanks for the report and test of the fix, I'll add both tags,
> >
> > So below is the part that deals with disabling the warning if present,
> > the other patch supporting checking warning options I merged as a prep
> > patch.
> >
> > Thanks!
> >
> > - Arnaldo
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
> Thanks for the patch, Arnanldo.
> 
> @Nathan Chancellor
> What was the b4 magic to retrieve a patch included in a ML thread?
> 
> I tried:
> 
> link="https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com/"
> 
> b4 am $link
> Grabbing thread from
> lore.kernel.org/all/CA%2BicZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com/t.mbox.gz
> Analyzing 9 messages in the thread
> No patches found.

I use:

⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com
Grabbing thread from lore.kernel.org/all/CA%2BicZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5%2BzQNQGUxK7%2B2aw@mail.gmail.com/t.mbox.gz
Analyzing 10 messages in the thread
No patches found.
⬢[acme@toolbox perf-tools-next]$

Using the Message-ID for your message, which normally is enough, but I
think I didn't separate the patch from the rest of the message with ---.

Lemme try...

---

From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 22 Aug 2024 14:13:49 -0300
Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-mismatch if
 present on clang

The -Wcast-function-type-mismatch option was introduced in clang 19 and
its enabled by default, since we use -Werror, and python bindings do
casts that are valid but trips this warning, disable it if present.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 26c0f2614fe92eb6..649550e9b7aa8c8f 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
 cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
 if cc_is_clang:
     cflags += ["-Wno-unused-command-line-argument" ]
+    if clang_has_option("-Wno-cast-function-type-mismatch"):
+        cflags += ["-Wno-cast-function-type-mismatch" ]
 else:
     cflags += ['-Wno-cast-function-type' ]
 
-- 
2.46.0

