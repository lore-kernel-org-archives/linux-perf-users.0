Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9E3CDBDB;
	Wed, 13 May 2026 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716761; cv=none; b=PERmxa/KBhSsp1sdlPPfbtwM1Ax1DmBE94SV9pSOsv6lnETZZLjj/8NrxJBhvNou9jm+YyrsENP4DVCIgxwT22Qi23M1AL2pOU6OnaYDNKGY84XOXiubtsqRmQNsCIWNFmhAUwpAf9mxwtNwZhWSBwi8Hins+AusE+dfw00F3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716761; c=relaxed/simple;
	bh=0a61uIj0+52/GsP6pSo5A533nIsacLarLU5SrmpMIRQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKiGueg0rPlL0MyctFbN9btQUgstenKc8jXK+LIpMBzpoxbzghDf7gJZNFBSdc1PLx7jdioBknqTTLP3FDEGoXjRjp2XQPJgv600Fg5Qrl1C4DjEtQ6nDTkJgTuXC2XykQo5NSgxdH2o/BgsTBopZL6biFFu+eGGiD1ZMnQXCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o357qpsM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o357qpsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA7EC19425;
	Wed, 13 May 2026 23:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778716761;
	bh=0a61uIj0+52/GsP6pSo5A533nIsacLarLU5SrmpMIRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=o357qpsM3g4i72ilseuhibISHN3e1N/ZIEXVw7i1kl7ji6qHVgdphzTtbBXfm2tbS
	 ExZZwL4qPq/J8nXPF4+z2fQlbDa83lAdnqPZjKJ+uOM+cxKTg0+eJDLp/84dumki7E
	 fGfPeUMloIRVlqaoIPlmQcSGNXIzM2uLMFi+hiVmAQYf25knU714wy2jn/0/xUCxMi
	 3HNFGfTEomvAPWnHnz/1QzosgCu2OJqwYAenbmLm2V6sRWvB4ldxW2G89mfAOCA/Tr
	 Lt/6C+JRjvFAG0NSaHEI/h1nKoGAmY59v3Q3cr4DJIjV0RZauH8Ae8BICLdnmRZC+v
	 LRFpwKiLzDhBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/18] tools build: Integrate libdebuginfod into
 test-all fast path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512174638.120445-3-irogers@google.com>
References: <20260512174638.120445-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:59:20 +0000
Message-Id: <20260513235921.2CA7EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `ifeq` short-circuit in `feature_check_code` fails to preven=
t unconditional sub-make evaluations due to eager expansion in `$(eval)`.
--

commit e9f96ae598e8b4643d43a93ea3da9bfe004d8b24
Author: Ian Rogers <irogers@google.com>

tools build: Integrate libdebuginfod into test-all fast path

This commit bundles libdebuginfod into the test-all fast path to reclaim
sequential startup latency. It also attempts to short-circuit the
feature_check evaluations to skip sub-make forks when a feature is already
pre-detected.

> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 2f192d3bf61b9..d8febe5d58005 100644
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
> +    feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"=
$(CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1)=
)" CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D=
"$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATU=
RES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
> +  endif
>  endef

Does this $(shell ...) invocation get evaluated unconditionally before the
ifeq is parsed?

Since feature_check_code is passed to the $(eval ...) function:

feature_check =3D $(eval $(feature_check_code))

GNU Make expands the arguments to eval completely before parsing them as
Makefile syntax.=20

Because the $(shell ...) call is not escaped (for example, as $$(shell ...)=
),
it appears it will be executed during the initial expansion phase, bypassing
the ifeq condition entirely.

Could this result in the sub-make fork still running unconditionally,
defeating the intended optimization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512174638.1204=
45-1-irogers@google.com?part=3D2
