Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138783;
	b=zZ+zSHYdV1rRTiVFdBPAODdQp7AWz+8wAspbvoc/Y/tcVSac6YW235Y1Ian48XCrXXhi
	 z/GkpeZ4CmXlqc039zgfH/qr51MgAsNtgwkn1KpjJd6FryQA0DQQqdmOa2nH0JydASVLj
	 8129nolFnqGyyaxRw7NeRKSxK+SZB2QK2IvqnC4mjfMjVoBAiYBFESDdVz2HRLWT7yM8a
	 hfhwQqFEv2TLQVzdbHu2La8MFEXciA+14XWXyM0F8wZ+08ZH6nsz6dF6QXHEiDJ94sg8L
	 Bi4PnAeLqBms59PrJ+efacqqC/wrcQojH5dosB2bMH+oFFw+rKsaI0r2x1YMhy5N2kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138783;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kr5ySmJxt5smMLoFpAMJ2lqK/VouMtnAaYleuC8/GQc=;
	b=C5hX2nQu5WfLoK2KKvFrKo22bHvAjr80Dv+boc7uSydz/CdzQAJvtjOkUKqZWHjWmy6k
	 fU3BC9JvjyGWNrp6OAXqqnArOxyyeetPY38f+imnI4zv0HPXGRMTXY7i+L4pRvu6iFwJu
	 X7tq8lhmy6HOHHDPNPlh/vzLwB/Xa1Hc6NhWvydHrpRKNQTij5zs5v8EdkxmRWw379viK
	 wJuQdT+UWvKzsPgW2uWRU7SN6t999hZpEIqCyKvUTetnmXdkggKAgdUhbQEDHdEklzzJT
	 EAz9esfkgtQV495y+RNK1hSaUNv8axijdFb6wOE44VAZ4r4CYhxcttGzpyBZ7AxlBZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYPzmV3K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360B606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYPzmV3K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B369B1F000C4;
	Fri, 20 Nov 2026 01:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138782;
	bh=kr5ySmJxt5smMLoFpAMJ2lqK/VouMtnAaYleuC8/GQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYPzmV3KEQq0EXenTzUnOzY3u0b6PRi/rs3qZHpfApO5RiQqcMkk2KlyF9Q1q4JnY
	 X+WbiCtKsiypsAf0/bPXVu38latBr8jQg7aV2UlQ9x829WDcxbKMbqxBJK0QdhLhgt
	 RtD7ceQQlo6FU0uR0sIET9o0bNgo2+gw0QNvuR42lP9WY+mXCls5zUZg+avE80ORkB
	 luNr4LEMw9+fy8F0uxZlRaYgvoJus8JYhVz/cD1hPTJFqRMaBsCwwy9N3kZrq/Ga9i
	 wuR14hoDLyTvbeedeuMFbbxm58a/uKotb8BF6N9j8kiFGLZAXR9hjvv6q95BClU47k
	 BWfac0kUjR/bA==
Message-ID: <sashiko-outbox-224332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/13] perf test: Skip the LBR inline unwinding check
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-14-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:39:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The LBR check takes caps/branches as sufficient to record cycles with
> --call-graph lbr, but the file only says the PMU has an LBR: AMD LBRv2
> rejects the call stack mode with EOPNOTSUPP and AMD BRS, which samples
> only its own retired branches event, rejects cycles with EINVAL, so the
> test fails on AMD instead of skipping.
>=20
> Skip when the same event records without the branch stack, so a PMU
> without the LBR call stack skips while a perf record that fails for
> another reason still shows its error and fails the test.
>=20
> Fixes: 446c595dc0dd1759 ("perf test addr2line_inlines: Ensure inline info=
rmation shows on LBR leaves")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D13

