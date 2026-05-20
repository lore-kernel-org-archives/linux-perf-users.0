Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637E3DA5B5
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282553; cv=none; b=W8I5NUwqutvY34HVx2J92uGPh+RChaTCd4EsQglO0ZGAeywHVFpkSTEowTMDjH4W5CNogS/85Q/uX2cxhOsoBmiKR4m2+DZYbIVCcmKA4CpKr/x+DS8n7OtfJBNabBRDD+03JXhD9bVrnQDReaoh2ZDQWC5iEoQvxldNk5mK3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282553; c=relaxed/simple;
	bh=NXrJ3yjOoYJhn/g+eIRqNzH8GDIqs1Jium4AC9qbfdU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RMT6ErDbjF2Jkw/a+24xLbyH/v7w/7dQxehXafGOxYYi/12DsKPhMcbiebhgprIbLfeXXzGnayEPUxfDeHb4i39z6x4dH1XzyrFUteo/dl8zAylDvs02ILzon+Lv7Ovgha5/o4NGkwRVQg9bX9BTklGJa5m1457y/Rb7wD03S8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edZoUsGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edZoUsGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C85D1F000E9;
	Wed, 20 May 2026 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779282545;
	bh=ajmq1kl7JsL9b7oT+yG1CkzlsHTyNkFnmY3QDrpGoBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=edZoUsGfVjAIHTyZTpsThjlYdT/yyTRmWZ2yUyYnanElKaYPOx6tlsCO1nsVJi8DK
	 SI5AG5Y+RnlM4cWRiKBggkDYE5hIG8mjlaSd4yZAAabHaaDvWP/gkJYfTTAsNbhXTe
	 PAsT+PZd45FEpYK8XmwmW0fWszJu64+qkmyGOpu9stYpkdeOeUiMeX7Q4VDt6nM3Mk
	 x0sFUNwlM8kseXJdawPqZAs2k5ftf16tc3EA8RQwcLdsxXJpeM0hmAGu2tpmdcvHK/
	 LojQhbNKc7YTjqbmnsSiMvQ6Y0r9S9izuM8ew2BuVu3oPT6nfVfvJcu/4bsvecIanc
	 PvFPd+k9T9LDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16
 hardening
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jan Polensky" <japo@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520125637.105681-1-japo@linux.ibm.com>
References: <20260520125637.105681-1-japo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 13:09:05 +0000
Message-Id: <20260520130905.9C85D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch explicitly allows text relocations in the Python exten=
sion shared object (`perf.so`) by adding `-Wl,-z,notext`, masking the root =
cause of missing `-fPIC` flags and breaking W^X (Write XOR Execute) securit=
y protections.
--

commit f3832fb0ad0d1f9c2e69039b2a5110f77d220d5e
Author: Jan Polensky <japo@linux.ibm.com>

perf build: Fix Python extension build with GCC 16 hardening

This commit addresses a build failure in the Python extension caused by GCC=
 16
stricter security policies regarding dynamic relocations in read-only segme=
nts.
It adds the -Wl,-z,notext flag to the linker to explicitly allow text
relocations in the Python extension shared object.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 76b35ac19acbf..eea170d6576db 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -749,7 +749,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_=
BINDINGS) $(OTHER_PROGRAMS)
>  $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> =20
>  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup=
.py $(PERFLIBS_PY)
> -	$(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared" \
> +	$(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared -Wl,-z,notext" \

[Severity: Medium]
Does adding -Wl,-z,notext mask the root cause of the GCC 16 linker error?

The error regarding dynamic relocations in a read-only segment usually
indicates that non-position-independent code from the static libraries
is being linked into the shared library.

Using -Wl,-z,notext suppresses this error by allowing text relocations, whi=
ch
forces the dynamic linker to map the executable text segment as writable at
load time. This breaks W^X security protections and weakens the security of
any Python process loading the extension.

Should the required object files be compiled with -fPIC instead to properly
resolve the linker error without compromising security?

>          CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS) $(LIBS_PY)' \
>  	  $(PYTHON_WORD) util/setup.py \
>  	  --quiet build_ext; \

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520125637.1056=
81-1-japo@linux.ibm.com?part=3D1
