Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E791CE6F9;
	Thu, 22 Aug 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347187; cv=none; b=BEjwPcrdzpoWUJSr0pQv7cljWhlo+93hlg69Q8r8xZ1ZSiXGcwDtwdvIjTYAWCOkFE3AtmmVQSgX5+RnYREXNWn9GGveSHMO97oJgG2LDq6J88ngjNzXm0cZYI5KBatuF01HOuv3KUlFOtsuJWCzfH/4P/1iVgNK5axVN4TXVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347187; c=relaxed/simple;
	bh=9CnxiX6Ho2Pl1OxChA1sUzl0axBtxQI5GiO2kcqZ+vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU1ZReHv6hVmZ7mKXXwpVFehWFzGLsjuVmtYbAAnmrlnGn+ZT5fRBD+k8wP5+eir/aE6f3eY6qmiNcQ0OV2Je8LmJ3Yd+dgO2Zu9AmqOXBQJdLIOXz6u8wyrxFhPtglhs45TRH1qI6pJNovanveLYXvB7jSpfAaR/VuPuQ3rMsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZON+pcm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZON+pcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2E2C4AF0C;
	Thu, 22 Aug 2024 17:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724347185;
	bh=9CnxiX6Ho2Pl1OxChA1sUzl0axBtxQI5GiO2kcqZ+vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZON+pcmuzvVcNv8CUt6z+H0K4yYW/ODFZ+3BdhUrVAcOCnua8TmZnNARtRUT5U32
	 NR6mfB3OZ7GyYrKjDxszouDk8iAbhdRtPG2alacAR5pmpSXNOhwAdWDFDyiz+vx68v
	 s5neCmR89ZXi6AjYSyrculVZkwnydA7FD1jeI4vulikZ53Mm94wQepLk5Hb8kjxprM
	 PdRn39V23c1mcgC5Om2Ear/N06KFi7zZIdLRjINB3LiwT4He2UJKYyi4Ur3wTt0VyB
	 fvMpju7yeF8X0teSX/FH3/n12HuTS693FBn/Z25WoQKim05Lxi5ivkf0TNyZCPRW+8
	 p39EdtYEc7ZYQ==
Date: Thu, 22 Aug 2024 14:19:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
Message-ID: <ZsdzLmIFWRqsXeXD@x1>
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1>
 <ZsdUxxBrpbuYxtXN@x1>
 <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsdxinrZP1kHINWT@x1>

On Thu, Aug 22, 2024 at 02:12:46PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 22, 2024 at 07:02:52PM +0200, Sedat Dilek wrote:
> > On Thu, Aug 22, 2024 at 5:10 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > +++ b/tools/perf/util/setup.py
> > > @@ -17,7 +17,7 @@ src_feature_tests  = getenv('srctree') + '/tools/build/feature'
> 
> > >  def clang_has_option(option):
> > >      cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> > > -    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
> > > +    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
> > >  if cc_is_clang:
> > >      from sysconfig import get_config_vars
> > > @@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
> > >  cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> > >  if cc_is_clang:
> > >      cflags += ["-Wno-unused-command-line-argument" ]
> > > +    if clang_has_option("-Wno-cast-function-type-mismatch"):
> > > +        cflags += ["-Wno-cast-function-type-mismatch" ]
> > >  else:
> > >      cflags += ['-Wno-cast-function-type' ]
>  
> > I tried with your diff with SLIM LLVM toolchains 18 and 19.
>  
> > Both work - see attached build-logs.
>  
> > Yes, are right that LLVM/Clang v19 was first introducing:
>  
> > -Wcast-function-type-mismatch / -Wno-cast-function-type-mismatch
>  
> > [4] says for LLVM 18.1.8:
>  
> > -Wcast-function-type
> > -Wcast-function-type-strict
>  
> > Feel free to add my Reported-by/Tested-by credentials if you sent a full patch.
> 
> Thanks for the report and test of the fix, I'll add both tags,

So below is the part that deals with disabling the warning if present,
the other patch supporting checking warning options I merged as a prep
patch.

Thanks!

- Arnaldo

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

