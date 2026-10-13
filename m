Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B428850E;
	Tue, 13 Oct 2026 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911338; cv=none; b=dGi0XANc4Ec+GrMrF9zl6L7yOB17d5OuuBPCTt4nnl6AOEnMd5tDXej8/OG0fIjQVu656Ruw5qVwqZeSK8fti0jFV9R+LK7OVlSCnguBJjXZ70Y9RhcMflDEIrqZBx3/JiHeuZ0nIHrCD3wiJHQNlsJgqFvE4jiFtvPDBI6Q6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911338; c=relaxed/simple;
	bh=uaY9LdUlrOVEVoZvqU+C9jMuThSOjyJeRSnjm9MDqLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM1RKNOwqyi9MyZVQVvPYPZ+xK6JXZJ7p7BUsEFK6IcmDeBkoNcwViuJldRO1p16Y1tJJLMVTgxAsV9CYRDCYW7DYL8BJKJcoiDauGX9iXQoqTLpfEYkViN5R6PB/7N77HGLJrnUZ/BQbCctDp6yd0HfJPAHF0E2FYu7UfgZ1xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgYU6yL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgYU6yL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884541F000FF;
	Tue, 13 Oct 2026 17:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911336;
	bh=EAAQkl/PQrM64YDACwAftRUqMELY+9ZC0tas3R5d+jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AgYU6yL8xC7LrmxDj+yjIAYWeulA7NM0jkJK/lSQES9E20v9bodHS3CmPT5i7gDmR
	 DMW2o5Tb4TovwsGEr1ZooGgHNVQvck1vvB7axYs0FjuzVVEmhTX4IdOGyWORFV44wC
	 Zax4oAiH73TnUmfoDcjM1CCuJUkQ17LncsTCqVdNU+siUPvY2B28/vW7SBdr9Zw2vn
	 Zh4HNtihcmPc/wr4PqkTiHX3ftLz7Q3MiIUMQEV9wlLeTLP54Ycodni8rnT0+xHQxv
	 pkQD3JwkXNaA+1gqz3YJg04YM+bGFPEUqYQHo1HotKk/QKQu62wb3a0+DUdHP3LaZQ
	 f0MfP1y+MN3ag==
From: Sasha Levin <sashal@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] tools: build perf in tools_build
Date: Tue, 13 Oct 2026 13:08:53 -0400
Message-ID: <20261013170854.647305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com>
References: <20261011233647.2454648-1-sashal@kernel.org> <20261011233647.2454648-4-sashal@kernel.org> <CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 12, 2026 at 03:07:10PM -0700, Ian Rogers wrote:
> On Sun, Oct 11, 2026 at 4:36 PM Sasha Levin <sashal@kernel.org> wrote:
> > +# Every optional feature off, so the result does not depend on which
> > +# libraries are installed
> > +perf-flags-$(CONFIG_TOOLS_BUILD_PERF_MINIMAL) += \
> > +       NO_LIBELF=1 NO_LIBTRACEEVENT=1 NO_JEVENTS=1 NO_LIBPYTHON=1 NO_LIBDW=1 \
> > +       NO_LIBBPF=1 BUILD_BPF_SKEL=0 NO_SLANG=1 NO_GTK2=1 NO_AIO=1 \
> > +       NO_BACKTRACE=1 NO_DEMANGLE=1 NO_LZMA=1 NO_LIBZSTD=1 NO_ZLIB=1 \
> > +       NO_LIBNUMA=1 NO_LIBUNWIND=1 NO_LIBLLVM=1 NO_CAPSTONE=1 NO_LIBPFM4=1 \
> > +       NO_SDT=1 NO_JVMTI=1 NO_LIBDEBUGINFOD=1 NO_BABELTRACE2=1 NO_RUST=1 \
> > +       NO_SHELLCHECK=1 NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1
>
> It seems unfortunate to maintain this list here, we also have a
> minimal target as a build test here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/make?h=perf-tools-next#n123
> I wonder we should just add support for a MINIMAL=1 variable in
> tools/perf/Makefile.config and have that set these other variables.

Yup :(

What allmodconfig really wants from perf is what allmodconfig already does for
the kernel: build everything the environment supports and skip the rest. A
kernel option that needs something the toolchain lacks just ends up off rather
than breaking the build.

perf has no mode like that I think? A default build fails when libelf,
libtraceevent or python is missing, so an arm64 cross build, or a native build
without libtraceevent-dev, breaks. Turning everything off was the only way I
found around that.

Would it make sense to add such a mode to perf instead of MINIMAL=1?  A missing
library would disable its feature with a warning rather than fail the build,
and the mode could skip shellcheck, mypy and pylint too. allmodconfig would
then build as much of perf as the host allows.

-- 
Thanks,
Sasha
