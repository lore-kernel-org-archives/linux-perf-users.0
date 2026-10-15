Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C053D0BC;
	Thu, 15 Oct 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092397; cv=none; b=r0O6dipMxjZ1vS8ENcXJwqzcpKgKewDKvhAeoJlvz2ZgINe1yqkbIxnuFSLBJdygbAACmrntNRJeIEYZarwKwbZE8XnpGhFPWMvoaW3maY6My5WRI8QfSkvRvQJPqTf0ztqf8GYqsn9GAND13yi00egYYPqBjNmue1XCV6fFZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092397; c=relaxed/simple;
	bh=8HYIL/IUK42wSidmex5/uML5d5tY8SMbkm5WL+eMHUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6FXevJoNQtmny/VtzRDrpEzVOCvHKSkkQurIY+YfAV11yVzhRGTcfA2V8LaPGCOme/2jH6Vc1uTp574XqKviGzhJEoIyKKVVYKxCtY4yasOu/zr65lSe6aD98WYO33oSuv7gazYRqRqN5ZQpmkDgVvCeWQGFdalb5BDcb85k9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frUfgCqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frUfgCqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ACD1F000C4;
	Thu, 15 Oct 2026 19:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092395;
	bh=SOc68ACcIqGT3CwiXHdBNKfARKvPAMW6ciWSIUg+luY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=frUfgCqFfjAk9pQBN+YJLvbjKmzq+XwUPuhYsVL1oQ7zsudvM9JUNwYsTRF8SBOlR
	 IDj6kgoNeHOk7zoR8IDgwrh8IV9D9lrlpnS0hdb9BxRQupsRztLrozATDMaHbfX9OX
	 OpOQlTRH3dZ7Zrxfrkk+GxEYEZXkeWIE/6J+5S9nrEPcxPbxZku4cGcNj2A4Fp/M5u
	 KpPDgLv7HZcZ6reEbinI7u/ql+uT1s0zzOISob3ubFC3HDcL7EGJmRwDMc3Vb3kwX7
	 t/6deHJLEGJbzDe4fy41E0sH6+s+1Q9Bzkh0v7NGhqQboQnTIMRDZG3Up+QdWRltC9
	 SIoZFWGljolEg==
Date: Thu, 15 Oct 2026 15:26:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] tools: build perf in tools_build
Message-ID: <atEo6aIQbgww4G0y@laps>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-4-sashal@kernel.org>
 <CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com>
 <20261013170854.647305-1-sashal@kernel.org>
 <as6SxXELnoIJenIX@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <as6SxXELnoIJenIX@x2>

On Tue, Oct 13, 2026 at 05:21:25PM -0300, Arnaldo Carvalho de Melo wrote:
>Why is that difficult to run:
>
>make -C tools/perf install-build-deps
>
>To do a recommended perf build deps install?
>
>That would be useful as it is what we expect users to do.

That's what users do, but it wants to install packages.

We need a path for unprivileged builds on bots and CI machines that can't
install packages, and many of those builds are cross builds, where perf needs
the target's libelf and libtraceevent rather than the host's.

>If that is too difficult, for some reason, there is a minimal build in
>tools/perf/tests/make, that is tested since forever:
>
># all the NO_* variable combined
>make_minimal        := NO_PYTHON_MODULE=1
>make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
>make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
>make_minimal        += NO_LIBBPF=1
>make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
>make_minimal        += NO_CAPSTONE=1

I tried make_minimal on perf-tools-next. It still requires libtraceevent, so an
arm64 cross build without the arm64 libtraceevent installed stops at that
check. With NO_LIBTRACEEVENT=1 added, it then fails building the Rust test
workload. Natively it still enables aio, libLLVM, libslang, libtraceevent,
lzma, zlib and Rust when they are installed, so the result depends on the
machine.
  
I'd like to go with Ian's suggestion then: a MINIMAL=1 knob in perf that turns
off every optional feature, which tests/make can use for make_minimal as well.

-- 
Thanks,
Sasha
