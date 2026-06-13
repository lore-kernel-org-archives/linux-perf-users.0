Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581838E106
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336144; cv=none; b=fjeezlKZKgyuPHZlDuqKuPhOXiqRkNX41kT1pSE5LwIv/8jM7QhcxT+rNY6GshPQAZXe6GlJcZdiRSrQz7I8eoJKfuLv0uCrbKYK3zxv4hyiwZGNdsG+l1Z1I6UETGCWjF7++6OIKni+pC3HI8HHe1lPNUc3jiy675r8wSF7g2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336144; c=relaxed/simple;
	bh=bZxIuw4zJzYRxPxgvW1EEokb/MOinL31d7Rh2pFe8sI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SxnkCvakmrP80yvP7bJT50JSe8FMY8XkICRy8N4FtOduOuf7e+8QXXhDD5PHgAAC7QyW8CB2U5mM2A01whT5WY7M+rrdqUzfprZBa+JUyg+kpS7Omob1x/XPmfmaxA2UdWUA+u4ufrm31g2VJgeedh6pWUfAj1HEr32/emEK1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAKG8fR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAKG8fR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290A81F000E9;
	Sat, 13 Jun 2026 07:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781336143;
	bh=ki9VlhkrYFpcqMSJuBXpLt1a6P7hkYDLdTRgDEcneg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dAKG8fR50jt30u4Bso8FRD8LHK+uw9mGic6BhYPVYGV1xLeIpDa/n7XhRB1sumCV/
	 xfCFI8Am6S8WyFn/pcX8mO5ze22Wb3mY/sTJTZQD9Wuro5RW7TzMPYPApoLC6GTf2Y
	 704NEWK73ARvDaVzTLdpvC2o9YE4yBK9DzLxhNdYLx0D/Anid7kVpt4Szn+H4M9vvD
	 1nJbObZfYdMI6ayet9UBFAeDP5YzSS3st9ICWuA3WgZYa3GyqRslYBg7eJbbk1wH2F
	 zw2c9T8jeVeaYCc/ZOMgtC1OGZy+jtD8EM2vH0meYAwkMAFoQWSy5GrcH6NckKwaSD
	 srDxPmmlkcNlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 19/20] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613071100.1508192-20-irogers@google.com>
References: <20260613071100.1508192-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:35:42 +0000
Message-Id: <20260613073543.290A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `make clean` unconditionally deletes the newly added tracked sourc=
e file `python/perf.pyi` when building in the source tree.
- [Medium] The perf.pyi type stub declares `COUNT_HW_REF_CPU_CYCLES` and se=
veral classes (`thread`, `callchain`, `callchain_node`), but these are not =
exported by the underlying C extension.
--

commit a04ee3f565ecf9bcf0b6522b7e85d0f455ed4c7b
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file
   =20
Add Python type stubs for the perf module to improve IDE support and
static analysis.  Includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 476b8dcaef58c..f4568c80d5b23 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -399,7 +399,7 @@ PYTHON_EXTBUILD_LIB :=3D $(PYTHON_EXTBUILD)lib/
>  PYTHON_EXTBUILD_TMP :=3D $(PYTHON_EXTBUILD)tmp/
>  export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> =20
> -python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so
> +python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so $(OUTPUT)python/perf.pyi

[Severity: High]
Does this delete the newly added tracked source file python/perf.pyi when
building in the source tree?

When a user builds and cleans within the source tree without specifying O=3D
or OUTPUT=3D, the $(OUTPUT) variable is empty. Consequently,
$(OUTPUT)python/perf.pyi evaluates exactly to python/perf.pyi relative
to the tools/perf/ directory, which causes make clean to blindly delete the
tracked source code.

[ ... ]

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..976ff965263b2
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi
> @@ -0,0 +1,672 @@

[ ... ]

> +class thread:
> +    """Represents a thread in the system."""
> +    def comm(self) -> str:

[ ... ]

> +class callchain_node:
> +    """Represents a frame in the callchain."""

[ ... ]

> +class callchain:
> +    """Sequence of callchain frames."""

[ ... ]

> +COUNT_HW_REF_CPU_CYCLES: int
> +"""Total cycles; not affected by CPU frequency scaling."""

[Severity: Medium]
Are these classes and constant exported by the underlying C extension?

The new perf.pyi file documents the constant COUNT_HW_REF_CPU_CYCLES and
classes thread, callchain, and callchain_node as being available at the
module level.

However, COUNT_HW_REF_CPU_CYCLES is missing from the PERF_CONST() definitio=
ns
in tools/perf/util/python.c. Similarly, the classes pyrf_thread__type,
pyrf_callchain__type, and pyrf_callchain_node__type do not appear to be
exported to the module namespace via PyModule_AddObject() in the PyInit_perf
function.

Will developers relying on the type stub encounter an AttributeError when
attempting to use these module-level attributes for runtime type checking
or direct references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613071100.1508=
192-1-irogers@google.com?part=3D19
