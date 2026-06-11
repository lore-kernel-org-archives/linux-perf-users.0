Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CA357CED
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219349; cv=none; b=g7EGx9VhfsK8UHj/z2Ytt5R5kk3t+jlaq9WPJ9K0UMu9G6oWkCBBGQrSGIm0i52BS6tNjUlgPSPvXN31jRoW7mwds9lmYJzYMWhAIixiCWvHfDbOF+u6uP1Cm0w7w/57tF8o78pbn8AYJeUCcJwwVddX74k+b5BHST7fQ8HdHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219349; c=relaxed/simple;
	bh=sTJDbnXJX6oPRtIHp411hlEILLzywWwLTXTnmwG2Idw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UsOOTIIEgZZL7ZBbdE+nMvkgiNRVseHIpXJA5NuOgVNUnJCdbbpPkCD1EvNKD0/SXB4V7PSMpHfiqj/UGCjHByjyZdEnZRA9dugX/GmnkjDI25mvaiEtv+gc7eWjYJ3T1hCOOz+ik+FR6tBQk587ipPS85mIAykMajPL23Ce5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWKMIhDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWKMIhDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92CE1F000E9;
	Thu, 11 Jun 2026 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781219348;
	bh=0Tg/La9EYOcSrr4PMfK2AlCAJpHhR/nkO6M+iV3NOis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UWKMIhDYON+6RC/jFsKhEyt6ugMmqB1J/SF7lwp31XVXE4UTGsHH7Q5Pdn8rcw6kr
	 3Y9/nG18b2tDZRUznqSc6Ba6LSMzxlLD2yXCA+FjBvKc7pmIfTSg0Y2iDW3rCgs0j7
	 mWpzQfmDL6EViAKm2fHH+pV7ns4PvQzZ7n4gIe2ptb+wE2nGWguNX3VlR6cClXZLS6
	 ZR0asiazsP35yDPR05EOzRjBsAxw56b3TNxRI5fn/djYpVB3lVDRqaDP5KZhnGMg9o
	 ih0tukN70H9Hgck37xZCRGTA640H3DYEn0vqbAaL40EEwqvHZ9UzwbGNEhbiJaqieK
	 aVnRURtyHEPOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 18/19] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611224455.201994-19-irogers@google.com>
References: <20260611224455.201994-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 23:09:07 +0000
Message-Id: <20260611230907.D92CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added perf.pyi type stub contains multiple factual dis=
crepancies from the exported C extension API, which will cause static analy=
sis to either reject correct code or accept code that crashes at runtime.
- [Low] The `python-clean` target does not remove the copied `perf.pyi` fil=
e from the `$(OUTPUT)python/` directory.
--

commit 6ae06d00cb3a3e49696af83fdabeb86d78ae882e
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file
   =20
Add Python type stubs for the perf module to improve IDE support and
static analysis.  Includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -522,7 +522,10 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util=
/python.c util/setup.py $(PE
>          CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS) $(LIBS_PY)' \
>  	  $(PYTHON_WORD) util/setup.py \
>  	  $(python_setup_quiet) build_ext; \
> -	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
> +	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
> +	if [ "$(abspath python/perf.pyi)" !=3D "$(abspath $(OUTPUT)python/perf.=
pyi)" ]; then \
> +		cp python/perf.pyi $(OUTPUT)python/; \
> +	fi

[Severity: Low]
Since we are copying perf.pyi to the output directory here, should the
python-clean target also be updated to remove it?

The current python-clean target only removes the .so files and build dir:

python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $=
(OUTPUT)python/perf*.so

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi
[ ... ]
> +def syscall_name(sc_id: int, *, elf_machine: Optional[int] =3D None) -> =
str:

[Severity: Medium]
Does the C API for syscall_name expect the first argument to be named id
rather than sc_id? If the C definition uses id, won't this stub cause
keyword argument usage to raise a TypeError at runtime?

> +    """Convert a syscall number to its name.
[ ... ]
> +class lost_event(_sample_members):
> +    """Represents a lost events record."""
> +    type: int
> +    id: int
> +    lost: int
> +
> +class comm_event(_sample_members):
[ ... ]
> +class read_event(_sample_members):
> +    """Represents a READ record."""
> +    type: int

[Severity: Medium]
Are the type properties actually exposed in the C PyMemberDef arrays for
read_event and lost_event? If they are missing from the C array, could
declaring them here lead developers to write code that throws an
AttributeError at runtime?

> +    pid: int
> +    tid: int
[ ... ]
> +class callchain:
> +    """Iterator over callchain frames."""
> +    def __iter__(self) -> Iterator[callchain_node]: ...
> +    def __next__(self) -> callchain_node: ...
> +
> +class stat_event:

[Severity: Medium]
Should stat_event inherit from _sample_members? Failing to inherit from it
might hide properties in static analysis that are actually available on the
object at runtime.

> +    """Represents a stat event from perf."""
> +    type: int
> +    id: int

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611224455.2019=
94-1-irogers@google.com?part=3D18
