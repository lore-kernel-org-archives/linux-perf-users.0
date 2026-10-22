Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701116;
	b=WAH1L03qjcSMahladnXvMRCkmnuMFV2if5zXeIVxh9z2geYoabkiRAII2Ybfa7AcRPQ2
	 IkGXT6Rp5wYXmVoHJ9vH03kHKhiYB/kuHLwtlk3e58igDT953BOGACvG5nC+ng0mnzX1v
	 Q9TRzEdVeqfoV9GWCdqmzz6vgACbie2jOxHxjBRosDg4M91vgFLQ7wzWlgp1HQkv6W8b2
	 DfFO/Ad0XR0HIuD/aNe/296+MXlDsxGS+nWCBlfZr1MIEgbm5JFzXMVPY4clgY0Qs9qJI
	 rT8bW+G7MuJ71B6E1mlYYfKIpZI5J61qA5wk0T/FTBRG8qf3YeT1voe0DJV8J0lVMsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701116;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nas2OrleCLCPcOkZRSdasqnotY1fDxK6IukIbED9xLo=;
	b=pbpTnM+HQD8f9WJbb3BeHKjJQWRLr54NYf63JyB01LNpFU6iYpDoOgXItbZK5vakGZry
	 WR13BiMjgzZfa7zk9hRb6yrEMZrhNT6CHZRvNHu8IZMX+/YyvhC5b3c1SVNvlMGGw1PvL
	 hP4eAXKQzBPk7bf1rL0oG9xw0rDCbqRXCbc5mA5TT8YxW50uMWNbeu6PSat+DD6f3s3RJ
	 HoFLP3V8mXypUJpTOXJgSyUXX2EiIIUSGTjVYn/Al61Y4Mnwnf+4U1hPoMpnrSRG2dQDz
	 X7TIRmzpVRqQCQ3Huyh9bAXhklSYNkEKG96bYoUvpU26UnYRnk1KIgLl0Z9FiglTr8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyIOZWHq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339ED606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyIOZWHq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8DE1F01825;
	Thu, 22 Oct 2026 20:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701116;
	bh=nas2OrleCLCPcOkZRSdasqnotY1fDxK6IukIbED9xLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lyIOZWHqeAcMZ49CTxGyqdKLtJOQTk7ab5/TO2LwGY9BSEM8u8wOyy53Qwzs25TLh
	 OKE0YHUIXmrAWjhbU75UtHQR0TU6ly7Km5JJ+EpYIy977w9yv9dCHPG/VQlFaM7UH2
	 cR2oHNukLDe82oXtjIt/ORcwNdbocZ010fCG2vhcHhEGjEM08ECLfYexXChj8M1klg
	 I7/EvHf3AvmopASmf8O2kOaczghPlzeZENXzIHUUwqZa+NO2p1BZyKpSA94n7bZq91
	 SO3QPfmkX81uYBCBgBjJgGbk3qcRKX0AaVP3noniqhnAgLPXSMzGFP/E2METVq7pAj
	 bWYkgAT6FheMw==
Message-ID: <sashiko-outbox-182008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/19] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-7-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:31:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf comm: struct comm_strs __guarded_by(&lock) breaks build on =
Clang < 22
--

commit 5b99280fd6ec287f3ff5bbe3100d016159c309e9
Author: Ian Rogers <irogers@google.com>

perf comm: Add __guarded_by annotations to struct comm_strs

This commit annotates the strs, num_strs, and capacity fields of struct
comm_strs with __guarded_by(&lock) and __pt_guarded_by(&lock) for Clang
thread-safety analysis.

> diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> index 6343a3c9debed..9fc4e91a36e9f 100644
> --- a/tools/perf/util/comm.c
> +++ b/tools/perf/util/comm.c
> @@ -16,9 +16,9 @@ DECLARE_RC_STRUCT(comm_str) {
> =20
>  static struct comm_strs {
>  	struct rw_semaphore lock;
> -	struct comm_str **strs;
> -	int num_strs;
> -	int capacity;
> +	struct comm_str **strs __pt_guarded_by(&lock) __guarded_by(&lock);
> +	int num_strs __guarded_by(&lock);
> +	int capacity __guarded_by(&lock);
>  } _comm_strs;
> =20
>  static void comm_strs__remove_if_last(struct comm_str *cs);

[Severity: Medium]
Does referencing the struct member lock inside __guarded_by(&lock) and
__pt_guarded_by(&lock) on struct comm_strs fields in tools/perf/util/comm.c
break the build on Clang versions older than Clang 22?

In C mode (-std=3Dgnu11), referencing a sibling struct member inside an
attribute on a struct field requires -fexperimental-late-parse-attributes,
which was introduced in Clang 22. Without that flag, Clang looks up lock in
file scope and fails compilation with an undeclared identifier error.

In tools/perf/Makefile.config, -DWARN_CONTEXT_ANALYSIS is enabled for all
Clang builds even when -fexperimental-late-parse-attributes is not supported
by the compiler:

  CFLAGS +=3D -DWARN_CONTEXT_ANALYSIS -Wthread-safety
  ifeq ($(shell $(CC) -Werror -Wthread-safety-pointer -Wthread-safety-beta =
-c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
    CFLAGS +=3D -Wthread-safety-pointer -Wthread-safety-beta
  endif
  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c -x c =
/dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
    CFLAGS +=3D -fexperimental-late-parse-attributes
  endif

When WARN_CONTEXT_ANALYSIS is defined,
tools/include/linux/compiler-context-analysis.h expands __guarded_by and
__pt_guarded_by to the underlying attributes:

  # define __guarded_by(...)		__attribute__((guarded_by(__VA_ARGS__)))
  ...
  # define __pt_guarded_by(...)		__attribute__((pt_guarded_by(__VA_ARGS__)))

Should -DWARN_CONTEXT_ANALYSIS in tools/perf/Makefile.config only be enabled
when the compiler supports -fexperimental-late-parse-attributes, or should
struct member annotations be guarded accordingly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D6
