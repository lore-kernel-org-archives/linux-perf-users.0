Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D237F8A0;
	Fri, 15 May 2026 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869860; cv=none; b=T1PNYng813fL5IQRT9o+tPZJ0H2hob4YHZOVsNeCq2jFJ6EKcO5rv/2EewkcPVsG49le07nuA23cT0/maShaOiUyQLICNsYymwV/GNKTSt5cJnpjE4G/Apvk+vu2Nl3xcYc5joW/aTGsRKOT5gjWnt5+u030ceK4Wq4t2W0nEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869860; c=relaxed/simple;
	bh=dZ8s1K5yssVtnsKpvElF78wb4Ddp58cS96GOsL+ggcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AUW4pl7nKRqFC+HpHBEhyYQxs9uD/EcoZtY6CYymtG6lVoYZGe+tMPGryvbCCmnL4mAHg3ENqIodtdcSj7d7vfqklcanqosrMi6OkzVlGMrg68VW4HGWmJDERW/b2289oBtKWhV3UWydry5QBxCpR5xAeRVbXHVKFEsMu2nWjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIn4TGRB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIn4TGRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D76C2BCB0;
	Fri, 15 May 2026 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869860;
	bh=dZ8s1K5yssVtnsKpvElF78wb4Ddp58cS96GOsL+ggcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YIn4TGRBHiPYRZgOo9ljEeXlqapd2/U8uDgAsGQWCtmspeh+Lav4XnnW/mNwg6q9P
	 DntEO1w730Hb6yM5ZGbLTpu7dtbgU6zRTXvThGHYxEVafFEgyIRRSeHx+U+Gf5JZin
	 MVWWFgvLYkf6rsHVRQiRDObEaEyXZSavM1GfHdmYmEZj8+ptCESw48m+ijeHieJ01A
	 fQVF1OBOacQPSvrLdQzIcuf+QaNEkc787cCM2gAf+vT37FYb6cXlUWc9lCUS/m3jkI
	 gCG2KZADf9S+1zND1i/lyo7fqKa5gLIBfgRgM0A53Rhq3zznPqwEEB6KGMqNNE77MU
	 t7sSB33LsIPfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/14] perf build: Move libsymbol dependency out of
 prepare step
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260515173852.1378571-9-irogers@google.com>
References: <20260515173852.1378571-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:30:58 +0000
Message-Id: <20260515183059.53D76C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removing `$(LIBSYMBOL)` from the `prepare` step breaks standalone M=
akefile targets such as `make check` and direct object compilation (e.g., `=
make util/symbol.o`).
--

commit 75b0ba18e6b9ffc69fa79d6bb98e33c664d4de91
Author: Ian Rogers <irogers@google.com>

perf build: Move libsymbol dependency out of prepare step

This commit removes the libsymbol dependency from the global prepare step
and moves it directly into the bench and util library dependencies. This
is intended to reduce build serialization.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 876065a02de6f..96a68723109fc 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
[ ... ]
> @@ -637,8 +637,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
>  	bpf-skel-prepare \
>  	$(LIBAPI) \
>  	$(LIBPERF) \
> -	$(LIBSUBCMD) \
> -	$(LIBSYMBOL)
> +	$(LIBSUBCMD)

Does removing $(LIBSYMBOL) from the prepare step break standalone Makefile
targets such as make check or direct object compilation like
make util/symbol.o?

The prepare target serves as an umbrella dependency to ensure all necessary
headers are generated and installed before compilation begins. For targets
that rely solely on prepare, such as the pattern rule
$(OUTPUT)%.o: %.c prepare FORCE, removing this dependency might cause the
build to execute without the libsymbol headers being available.

Running make check or make util/symbol.o in a clean tree could cause sparse
or gcc to fail with a missing header error when processing files that
include symbol/kallsyms.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515173852.1378=
571-1-irogers@google.com?part=3D8
