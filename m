Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0042A82;
	Sun, 24 May 2026 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779590968; cv=none; b=uCOOCQu211pQ43uz0Fk50Lwz8F/S7zlYP9E7kOIXu+WgAZlca06DAx9wVR1FDmOS9FVX5lZ7Y3HLBNd+rsbdmPQPYb/XqA7qOa2pasuutQjvfiM9IH+SomUfjUvqMZXAQVRpHz3vRyIAhx0nFvSlqkJ23Rhhwv7yt5DAsMIQCe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779590968; c=relaxed/simple;
	bh=GNskyHfWBJbiE5IRw/kRktWOpjwJ0bgamS8YS0drrFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAKsIAaTG3g1eOvuSVV5dzb5g61Lwg8DeOAV0bTYYrvT0w04pqM9ijMVC5E68dV+65eIv9ln1aLG1k/JEorJs0J8xacjSTv1B4UeXzaHwAVxD0yNRB5nMRYYiVRrXkd0aa0QW5UbSB1EnoDAS+y5mbiUXEG9xKEfqkVxt5bUpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLTiPszv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLTiPszv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA81F000E9;
	Sun, 24 May 2026 02:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779590966;
	bh=2eEoxePRk8iO1qs+fr6U++xrwfwz+FI/li6vau8/Zv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SLTiPszvMhF8aNaq0+KVl3OMn/W0mRBwzPz5NMrL0kS9TKhbzQI3sC7Rsr5S0s7mm
	 5Mxuu7x+ojOJQDVnS2kf/7V3/y6C8nMHSuilPWwVVDkHY9R+Tn2zyV6YvKFd8OzVUl
	 04iH1WIyWXrHX9mtl4JwpdG9JqFWuRWUvvBS4izvE3T7YqGx6e+7jldOUkTowsUvKI
	 3WAqegiUnLhbo52E+VAQVyghradE2zJmloih7E9gKR3tmirCx53z/MsRdHng8Zp5Fi
	 m9tMBs4u9/WyTi5Y5RxuH9SCGFrIzRT+a9q5ywi81lX0vXWXSIjegTUEiN3v1ZMJQH
	 CeDW8LMk+MJtQ==
Date: Sat, 23 May 2026 23:49:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16
 hardening
Message-ID: <ahJnMnOr4i9urrRk@x1>
References: <20260520125637.105681-1-japo@linux.ibm.com>
 <20260520130905.9C85D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520130905.9C85D1F000E9@smtp.kernel.org>

On Wed, May 20, 2026 at 01:09:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch explicitly allows text relocations in the Python extension shared object (`perf.so`) by adding `-Wl,-z,notext`, masking the root cause of missing `-fPIC` flags and breaking W^X (Write XOR Execute) security protections.
> --
> 
> commit f3832fb0ad0d1f9c2e69039b2a5110f77d220d5e
> Author: Jan Polensky <japo@linux.ibm.com>
> 
> perf build: Fix Python extension build with GCC 16 hardening
> 
> This commit addresses a build failure in the Python extension caused by GCC 16
> stricter security policies regarding dynamic relocations in read-only segments.
> It adds the -Wl,-z,notext flag to the linker to explicitly allow text
> relocations in the Python extension shared object.
> 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 76b35ac19acbf..eea170d6576db 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> >  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> >  
> >  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
> > -	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
> > +	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared -Wl,-z,notext" \
> 
> [Severity: Medium]
> Does adding -Wl,-z,notext mask the root cause of the GCC 16 linker error?
> 
> The error regarding dynamic relocations in a read-only segment usually
> indicates that non-position-independent code from the static libraries
> is being linked into the shared library.
> 
> Using -Wl,-z,notext suppresses this error by allowing text relocations, which
> forces the dynamic linker to map the executable text segment as writable at
> load time. This breaks W^X security protections and weakens the security of
> any Python process loading the extension.
> 
> Should the required object files be compiled with -fPIC instead to properly
> resolve the linker error without compromising security?

So I asked Claude about this and he suggests doing like other parts of
perf and using -fPIC, can you try to do that?

---------------------------------------

● Sashiko is right. -Wl,-z,notext is a band-aid that weakens security —
  it makes the text segment writable at load time, defeating W^X.

  The root cause is that PERFLIBS_PY (the static libraries linked into
  the Python .so) are compiled without -fPIC. When you link non-PIC .a
  archives into a shared library, the linker needs text relocations. GCC
  16 correctly rejects this by default.

  The proper fix is to build the static libraries that go into the
  Python extension with -fPIC. The perf build system already has
  precedent for this — look for how libperf and libsubcmd handle PIC
  builds. The Python extension's dependencies need a parallel -fPIC
  build, or the existing objects need to be compiled with -fPIC when the
  Python binding is enabled.

  The -Wl,-z,notext approach would also cause issues on distros that
  enforce RELRO + BIND_NOW hardening, and some package builders would
  reject the resulting .so outright.

- Arnaldo
