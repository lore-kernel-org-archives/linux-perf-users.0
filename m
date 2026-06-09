Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E03D0BFB
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989148; cv=none; b=ddK3LL5evuZOfDk47cQNBiue2DU/EOW/Hd1eChd+1mzPu7636+pNhs5ozw0+b8OrBZFcxoKhjyhRiRRnq4J3o5eOHBZ/bd9AR1n9h5evBaRYcWpMpdOJKG/9OvcGK04xKpSo11qhkN5wHSv4YybLkCjxClLvoZ207f0moomFLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989148; c=relaxed/simple;
	bh=ZcxgQiCja3Ysdk7Fptlq+1z/ltK7XYJarPIfRRM8JxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rZFUG9K2b5ZdMI6w2aLR6v/EmatGlteS+7j6ceKEz38dAluANfJvQ0nhD5Rs9nFDrIEeyVWxfg36E4AAzQ+Y/TyC+ietht70E8Wfofv83GIon0pSIZ5BtN7k1xEte5ZFtPGXz/T3FOgcIo1Z91VWOPTqnjprEe9yeEStVJzQGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0v4bQC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0v4bQC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77D71F00893;
	Tue,  9 Jun 2026 07:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989146;
	bh=mp+N3KSvCqhwAKxSd9WDp1bc0ZPYk5xNWLl+yOrjHt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a0v4bQC4WZJk9xXD95BVNwLV0+n29fdzZ2m3wzfPpo+AsCZiDFjJzhQODdBuDLxhj
	 yhlrHIco6BNmE/HvB8zxm/+QDavedufbnMXrA5jopLbxNvQY0zPD6OqEbA/mT6A6qT
	 LGvgvlQvKAhkmTSMgrybuWzGsVQWazjXQnTC2nGCeXk0o/jNPsbHuclU+jz8GQXV6u
	 FAOeabLrZ9EVgA2VI506KQrbBqMLY08Wggm0Dt4Bo4ruKWSwyWw314Qiic5qrbW0AP
	 5e5DpnIKbrELluUrQ/jsbpszM5w/AvufZle5BQgOw7nC3+tABLlFuPvI9HiYmn2Iey
	 2j3JSu3Vc3TMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] perf build: Add libnvme feature detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609070348.541964-2-irogers@google.com>
References: <20260609070348.541964-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 07:12:26 +0000
Message-Id: <20260609071226.B77D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The feature check for `libnvme` fails to utilize `pkg-config` du=
ring the test compilation, contradicting the commit message and breaking de=
tection when the library is in a non-standard path.
- [Medium] `libnvme` is omitted from `test-all.c`, which causes false posit=
ives in fast-path detection and triggers continuous feature-dump flip-flops=
 and rebuilds.
--

commit 1f4a72ba50b99659f0972d94ef171f8be76bc329
Author: Ian Rogers <irogers@google.com>

perf build: Add libnvme feature detection

Introduce a feature check for libnvme so that we can conditionally
compile the NVMe PMU driver. This checks for the availability of the
libnvme headers and library using pkg-config.

> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index ed1374af31c16..bf85032415397 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -73,6 +73,7 @@ FEATURE_TESTS_BASIC :=3D                  \
>          libbfd                          \
>  	libbfd-threadsafe		\
>          libelf                          \
> +        libnvme                         \

[Severity: Medium]
Without including test-libnvme.c in test-all.c, the fast-path build will
succeed even if libnvme is absent.

This can cause the initial discovery to falsely report libnvme as present,
which then flip-flops when individual checks are run later in
tools/perf/Makefile.config. This mismatch invalidates the build cache and
triggers full feature evaluations and rebuilds on every make invocation.

Since libnvme was added to FEATURE_TESTS_BASIC, does it also need to be
included in tools/build/feature/test-all.c?

>          libelf-getphdrnum               \
>          libelf-gelf_getnote             \
>          libelf-getshdrstrndx            \

[ ... ]

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 62909a9c799d3..fd00e0be60690 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -147,6 +147,9 @@ $(OUTPUT)test-libcap.bin:
>  $(OUTPUT)test-libelf.bin:
>  	$(BUILD) -lelf
> =20
> +$(OUTPUT)test-libnvme.bin:
> +	$(BUILD) -lnvme
> +

[Severity: Medium]
The commit message states the availability of libnvme headers and library a=
re
checked using pkg-config. However, because libnvme is omitted from the
FEATURE_PKG_CONFIG list in tools/build/Makefile.feature, the variables
FEATURE_CHECK_CFLAGS-libnvme and FEATURE_CHECK_LDFLAGS-libnvme are never
initialized.

This rule manually invokes $(BUILD) -lnvme, falling back to standard compil=
er
paths instead of leveraging pkg-config variables.

If libnvme is installed in a non-standard location discoverable only via
pkg-config, could the feature test fail and incorrectly disable NVMe PMU
support?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609070348.5419=
64-1-irogers@google.com?part=3D1
