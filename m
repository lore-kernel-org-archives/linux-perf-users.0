Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB3385D99;
	Wed, 13 May 2026 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706671; cv=none; b=jIkg7SM97NGkDzU0Ji3phtkJgu6AZdk6yzhnrbZ/L24AfbmrpqWCXbDhmksg1CasrNtG/FfIZblz1gikD9BpZ9Guuc1QfxRVE/W6RgJItexMjqT8rufrrH7bfcvwYBp078Ze4NThkYW8XEDQ1eQAVWi3h2Q2mwlBJQNaV4MckNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706671; c=relaxed/simple;
	bh=OWs2fmtdLI3RwhyRvJKm2yLrXrPHrWGXTxLbBkdmbts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RXlzG14zOuCQjyTZPz8RsjhdklpoA94Tiai+Qw0ab/Ucr2V8BD0Fln2SVQFlOg7IrYuMxBLabBIQoRFJp5JR8szgrogWk4NNRdtC6enmAN3naTJOPe53gkBUyTrJOH965oqcU8TX2Q4te60DT++HYnDBu1pCqNFD+6qL7TrLpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvCvyPOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvCvyPOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76438C19425;
	Wed, 13 May 2026 21:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778706670;
	bh=OWs2fmtdLI3RwhyRvJKm2yLrXrPHrWGXTxLbBkdmbts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LvCvyPOvghg/6vKvJVtHeWEIprHpOZvdoAT0bOVTBus7J9Pv45rfqx1B/oVf1Ym8y
	 DAOqouFnSdVSjOzQ49rwEfSdq1Zpy+lgpyIMQLIVwOwRGKUH6+scxvQq1CGI9jyplX
	 sT8MBY4mwIOqa1hns3h7hQoVCuUdBl8ajubyVQUS5bvkFCa4RKze8CUkz3QRLCEkow
	 aGPvmGYm18ftr0JHWNRfPPVM9v2yiQsEIzO2HTHoZU6yfDUL2I5sxNe9WEnBCSsxfr
	 SfZc4Puj3/6RKtNC2hWutO4NZ+6uTBkyQowN6oYVkntl8N3GTM6pW5aMf3PFxGD60s
	 0S+hmtLI4NhYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/14] perf build: Move libsymbol dependency out of
 prepare step
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512053539.3410189-10-irogers@google.com>
References: <20260512053539.3410189-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:11:09 +0000
Message-Id: <20260513211110.76438C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removing `$(LIBSYMBOL)` from the `prepare` umbrella target breaks t=
he `make check` and partial object compilation rules (e.g., `make util/mach=
ine.o`) on a clean repository.
--

commit 807af289bc2dc2091029fa64ee06af014dcf927c
Author: Ian Rogers <irogers@google.com>

perf build: Move libsymbol dependency out of prepare step

The prepare step is a large serialization point before parallel sub-makes b=
uild
the perf tool. This commit moves the libsymbol dependency out of the prepare
step and into the dependencies for the bench and util libraries to avoid
serialization in the prepare step.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index df68d29ecab73..d2e673d5e5bea 100644
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
> =20
>  $(OUTPUT)%.o: %.c prepare FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3D$(build-dir)=
 $@

Will removing $(LIBSYMBOL) from the prepare target break make check or part=
ial
object compilation (e.g., make util/machine.o) on a clean repository?

Files such as tools/perf/util/machine.c directly include <symbol/kallsyms.h=
>,
which is dynamically copied into the include directory by the install_heade=
rs
target triggered when $(LIBSYMBOL) is evaluated.

Because both make check and partial single-target builds explicitly depend =
on
prepare as their synchronization point, and $(LIBSYMBOL) is no longer part =
of
prepare, does this cause sparse or gcc to fail to resolve <symbol/kallsyms.=
h>
during those builds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512053539.3410=
189-1-irogers@google.com?part=3D9
