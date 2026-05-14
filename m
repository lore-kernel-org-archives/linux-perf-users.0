Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BA329408;
	Thu, 14 May 2026 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778727759; cv=none; b=t0Hws7gm2JpXXGKS8QvTwiAK3FezCdQC+SXqhIHkR63KPJSOQ3/NzxVF0o81jMH6idGUos4oZZ0KCEtxdZVU6Kazx3WYchU26QVUqfieyg8ncLzrwQuKkKlG0NrFpvojyrJyhJH/ISVdICQ4dUfk4kcxZ02RFnH/ofwpwYCXQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778727759; c=relaxed/simple;
	bh=ZgL/iWZQoWWxs/biX5CpF4YPd+WsObSPsy1MmddC6q0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FVnNs0QH+bcC+m4F3Z7e+iqeRoqjtPAfa+pzA5UGzQtlKFOggiaZ0TfhWljqBlDjNx6XhcJy71sMzLTXJaJF1s8KT15ZJ0S8gxEVG7HEki1On7aUV+VgmPYF+fj+w390F3xie/ZsalR6JqqNEWCUdsqKW2c9uADtjWErm1lAoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTCtQnU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTCtQnU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2E8C19425;
	Thu, 14 May 2026 03:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778727758;
	bh=ZgL/iWZQoWWxs/biX5CpF4YPd+WsObSPsy1MmddC6q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QTCtQnU9rPU0fvWme4gdDv5+E95t31tXihBgXQvcVpwh5uth3v3WdDJpPZiPl6YBu
	 MsMPreIUEdCx36XoCMlXTvf2oCtejgl93p2VQEZyREIHD8n2EVJ2dCCnjFf9DaBcpi
	 Ygwv+I7deAWu7/5q2QbERojuIFfi5MTb7lQcjoMAAlLWveLGoTLLcJ+Njy8s3OZ5dC
	 i5lYN3blo1Jicu+Q/dBDKT7/Fk9bI0L7zbFBCjsSjbvd1xPU3UbjQQNfzaJsX5wrak
	 UzUviKB+coMWnMUEOfJm52h7KAja5FZl0Hfn8ehV77k4axtcmzahuAtNyHJtA3AP3D
	 PwqQfYthUY4Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/18] perf build: Move static libbpf dependency out
 of prepare step
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260512174638.120445-11-irogers@google.com>
References: <20260512174638.120445-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 03:02:38 +0000
Message-Id: <20260514030238.8E2E8C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing $(LIBBPF) dependency in $(LIBPERF_TEST_IN) target causing p=
arallel build race condition.
--

commit e65547c4ccfbe83e535bb280ee457abfc8a0629d
Author: Ian Rogers <irogers@google.com>

perf build: Move static libbpf dependency out of prepare step

This commit removes the static libbpf dependency from the prepare step
and moves it into specific targets like bench, util, and the main perf
binary. This change aims to reduce serialization during the early build
phases to improve parallel build performance.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index ec0e91bedce12..5af767415c113 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf

[ ... ]

> @@ -636,10 +636,6 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
>  	$(LIBSUBCMD) \
>  	$(LIBSYMBOL)
> =20
> -ifdef LIBBPF_STATIC
> -prepare: $(LIBBPF)
> -endif
> -

Looking at tools/perf/tests/sigtrap.c, it is built unconditionally and
includes <bpf/btf.h> when HAVE_BPF_SKEL is defined.

Because $(LIBBPF) is removed from the prepare step, there is no longer a
guarantee that libbpf headers are installed before the tests compile unless
explicitly specified.

Does $(LIBPERF_TEST_IN) also need an explicit dependency on $(LIBBPF)?

Could a parallel build attempt to compile sigtrap.c before the concurrent
$(LIBBPF) target finishes installing its headers into the include directory,
causing an intermittent missing header regression during make -j builds?

>  $(OUTPUT)%.o: %.c prepare FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3D$(build-dir)=
 $@

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512174638.1204=
45-1-irogers@google.com?part=3D10
