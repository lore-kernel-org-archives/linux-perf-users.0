Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D8336896;
	Thu, 14 May 2026 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792148; cv=none; b=GSFMG/ic4ZRaQKplY6G4PxuJlajVNFQXEUsNEdzBhStnVhBD6WYEE+140sjuBqa5QYtC2n9J1xqO1/VD1ve0WLPk/LHS3dfUk2kSv89H25oDUUhaS0djTWflihdS1dnD8jZlfAae/OlZQYHwS2N+VGSsdcmwJANOj86PLlFz27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792148; c=relaxed/simple;
	bh=/u+kBtjhkrPUDNnwcrIAtnRTaDR5Y8j8LxOoIT+0f/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iJwuN5Mw3P1Mb9b51G1z+/TLqwansXCqhU7QIPuoNK+y8krqcC/WjusL44rIFPcpw2usnzU6/ljdZIkxoM55J3xLYAotu9XaJw9eq25u80oBXtlCDk0PIu1ZhWLWwRKCs964Th6MS7TC/GwiRxphXfJtLQlUJ9h582k4qfJdFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm0MNkdD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm0MNkdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C29CC2BCB3;
	Thu, 14 May 2026 20:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792147;
	bh=/u+kBtjhkrPUDNnwcrIAtnRTaDR5Y8j8LxOoIT+0f/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gm0MNkdDy/bV6JqiQ8vg2HC6KCywYKBfjE2efIFwEiccv6Z2OH98hG3wIDWOIUQHw
	 2H8IBIpMrVsHF1S/lYUSg3yiK+jRmOFw1qm0zQ8fvom6BM08Ju8EguYZ9nYD3GK5UB
	 fSuechthkp9qC28NXMiZ6cMu22HXh3ZCJIyVJvedv8oz659piaHWuf2b1wtno+ya9J
	 VvK18goYvzvq4uG7BF97kEU11xhQcFeamhbWyqJCs0ASUdIVY/PWqbXv0FLNKd8nRL
	 KMRzBp3fSrSEuXuUglfZPQ+23uVbGOk7uTNxLSo9pFP3lMshzBNMVKYOY1bg27dije
	 QNE+5D47B0LAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/17] tools build: Integrate libdebuginfod into
 test-all fast path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260514163409.927816-3-irogers@google.com>
References: <20260514163409.927816-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 20:55:46 +0000
Message-Id: <20260514205547.7C29CC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The use of `$$(shell ...)` with unescaped variables like `$(CC)`=
 inside a block evaluated by `$(eval)` causes a double-expansion bug that c=
orrupts compiler flags containing `$`.
--

commit 8e0d941d5a7133e71fe2afde9b8f70d691de8879
Author: Ian Rogers <irogers@google.com>
   =20
tools build: Integrate libdebuginfod into test-all fast path

This commit integrates libdebuginfod into the test-all fast path. It also
updates feature_check_code to short-circuit the feature check and avoid
a sub-make fork if a feature was already pre-detected.

> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 2f192d3bf61b9..064c75dd9914b 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -8,7 +8,9 @@ endif
> =20
>  feature_check =3D $(eval $(feature_check_code))
>  define feature_check_code
> -  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$(=
CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))"=
 CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"$=
(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURE=
S)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
> +  ifeq ($(feature-$(1)),)
> +    feature-$(1) :=3D $$(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D=
"$(CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1=
))" CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=
=3D"$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FE=
ATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)

Does leaving variables like $(CC), $(EXTRA_CFLAGS), and $(LDFLAGS) unescaped
inside the $$(shell ...) block cause a double-expansion issue?

When eval parses the assignment, these variables are expanded in the first
pass, embedding their literal values into the string.

During the second pass, when the shell function is evaluated, Make scans the
embedded string again. If any compiler or linker flags contain a literal $
(such as -Wl,-rpath=3D$$ORIGIN), they will be incorrectly expanded during t=
his
second pass (for example, replacing $O with the value of the output directo=
ry
variable O), corrupting the flags.

> +  endif
>  endef

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514163409.9278=
16-1-irogers@google.com?part=3D2
