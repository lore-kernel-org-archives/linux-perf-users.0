Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F749BD63
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933889; cv=none; b=gBKONPmUxG+Q6zTYpYppLsa1iUaiE8XxP8R51QiNjlZTOD7wDjCC0uo65upyl58GEK4kSYuMzZoi3mmEtBxzr2cSyUjFoZNKdS8WW4xfJcvcSeXGp1UCQ88muDB8NccsI2DmyK/z0AYCQKMIje4eWr0VWaxkkn9m0NAwtdrePYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933889; c=relaxed/simple;
	bh=4Q0GT8t2a3z+ADXVsj23qQRdepqXzY4nsiFSuGwZxWQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SqaMn/KqvJPr3/AHccjyptdtfegE882lpW/4j4zP8rpGMy9c3YF+TxN1Qt2KVXLRmvK3WzDC65bP0m+bvo8teqHsjyYxr/IfNKwhNrP3xAxZkiPqer38wYQoLWNrFfozs/W7KAr/3zRk5zJlT+ZTH0m0J/Ijx8SE6AqI5PY0KG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgxjHv6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgxjHv6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1A91F000FF;
	Tue, 13 Oct 2026 23:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791933887;
	bh=YXMRwH0zuCRcuq5DbIYDWKYOCAdHwVEkn8UQnDYdTSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VgxjHv6tuQsqjYy0By01PqDrVF2MN5ljVkVXqjaQyZEln24HHpyKPtBeU2mbTNO3r
	 Y7dSTBqiAXePr0bjpmCl5IdSOU+iMfvp2vjpFHmZYAB2GxhgsgIMV5YU9Ecv+Rc27p
	 GVAh0rdJ8XkThFJBD1ThExPJlVk+X6WyevA2TIJS3Wcukf2CeRyvUM0S8IQ+k+ENi0
	 BcCH0GoFtM83UuFA+Ev6g7EqaEfCOkXl9w5Qnkodwoi1pX+p93z+ecDtlQn7gABm8V
	 aYhX0QBUaKFp8VGjHlLwXieBT6UVAMbY2YP8D8oHOEmDFay7bfLPrS+e4IHQV4ORii
	 FhmNLSHBmgILw==
Message-ID: <sashiko-outbox-170636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf test make: Add BPF skeleton build tests for
 clang and bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013231430.2163505-3-irogers@google.com>
References: <20261013221643.1815686-1-irogers@google.com>
 <20261013231430.2163505-1-irogers@google.com>
 <20261013231430.2163505-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 23:24:47 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] perf: bpf_skel test skipped due to missing pkg-config for OpenSSL
- [Low] perf/tests: bash negation operator ! masks test framework crashes
--

commit b1fbd7e0bcb15ba961fd484277db525d4021ba13
Author: Ian Rogers <irogers@google.com>

perf test make: Add BPF skeleton build tests for clang and bpf-gcc

Add make_bpf_skel_clang (CLANG=3Dclang BPF_GCC=3D) and make_bpf_skel_bpf_gcc
(BPF_GCC=3Dbpf-gcc CLANG=3D) targets to tools/perf/tests/make when the
corresponding compiler and BPF skeleton dependencies are available on
the host.

> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 7524de5228029..4e66b93cf12c9 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make

[ ... ]

> @@ -142,6 +144,20 @@ have_libllvm :=3D $(shell printf '#include <llvm/Sup=
port/ManagedStatic.h>\n#includ
>  		$(shell $(LLVM_CONFIG) --system-libs 2>/dev/null) >/dev/null 2>&1 && e=
cho y)
>  endif
> =20
> +have_bpf_skel_deps :=3D $(shell printf '#include <libelf.h>\n#include <z=
lib.h>\n#include <linux/bpf.h>\n#include <openssl/opensslv.h>\nint main(){r=
eturn 0;}\n' | \
> +	$(CC) -x c -I$(srctree)/tools/include/uapi - -o /dev/null -lelf -lz -lc=
rypto >/dev/null 2>&1 && echo y)

[Severity: Low]
Does this hardcoded check fail to find OpenSSL on systems that require expl=
icit
paths via pkg-config?

Unlike tools/build/feature/Makefile which correctly utilizes pkg-config, it
looks like missing pkg-config usage here could lead to silent test evasion =
on
environments where OpenSSL is not in the default compiler search path.

> +
> +ifneq ($(have_bpf_skel_deps),)

[ ... ]

> @@ -313,6 +335,13 @@ test_make_clang_nondistro     :=3D $(test_make_clang)
>  test_make_clang_nondistro_O   :=3D $(test_make_clang_O)
>  endif
> =20
> +test_make_no_bpf_skel         :=3D test -x $(PERF_O)/perf && ! $(PERF_O)=
/perf check -q feature bpf_skeletons
> +test_make_no_bpf_skel_O       :=3D test -x $$TMP_O/perf && ! $$TMP_O/per=
f check -q feature bpf_skeletons

[Severity: Low]
By using the shell negation operator !, does this prevent the framework from
distinguishing between a graceful exit 1 (feature correctly absent) and a
catastrophic crash (exit code >128)?

Would using an explicit exit code validation (e.g., ; test $? -eq 1) avoid
masking crashes in the built perf check utility?

> +test_make_bpf_skel_clang      :=3D test -x $(PERF_O)/perf && $(PERF_O)/p=
erf check -q feature bpf_skeletons
> +test_make_bpf_skel_clang_O    :=3D test -x $$TMP_O/perf && $$TMP_O/perf =
check -q feature bpf_skeletons
> +test_make_bpf_skel_bpf_gcc    :=3D test -x $(PERF_O)/perf && $(PERF_O)/p=
erf check -q feature bpf_skeletons
> +test_make_bpf_skel_bpf_gcc_O  :=3D test -x $$TMP_O/perf && $$TMP_O/perf =
check -q feature bpf_skeletons
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013231430.2163=
505-1-irogers@google.com?part=3D2
