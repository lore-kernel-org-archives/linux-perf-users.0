Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702465;
	b=YxjzzpU5HVcqwrM80WNo4Ui/twMjh9q4uzmAbNWjtgrVImMKhSXKhh9vITGXOJ5iKJlC
	 8QVk9K0IC77oCq00piXc7u2HFvvCa768W7VQMb8N1iy2qQw9kqLLrEhndqG5q7qQMy4zI
	 BTKA5gZwPpgv9Gk7yeUd2+L+fA6R8gftgtvwRp+VscuJ7qDcXunL4mmkReRijNLroH5nJ
	 kfO2zV0mkyvqx2Qn9pboYy1wAx4kEsgXSC82JOIMBA5vGlZYeeOa0l9+6LZWmoA5rKFR1
	 zFQcKjkB9aFJslvsgxt0sFwjhaC3MqAne8U6OqeD1pbQ/8op2XeDmCKz/tej/BKp1JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702465;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zwXuztkuOLKJK7hNswKjkTGPOo5z5EMRsvowtW1Ffus=;
	b=V8FuS13FBEEx9T89vkO5p9B66ayPQwHZCX6qfELO/oNwa2SApAs94XIQnK3a9enYQ8MJ
	 Eb6nRinwXxs+LowTxv7O+KPHsKRSn25TFK+3f7isYGCYk5gYhzplutO/ByRnZujxtuV8A
	 tpN3awkhBYlQ1cFyFWtL5QFJyUu6/MxzZLdTZn+c5RFHIaAZwFXc/LZS+EqLR2qqryggM
	 b+fxNBTfbCU6arZZZbKagXrZn2ibdsFg5+0RJ6HaphBABNiwM90dvdWQ5dwDNXzj9KWbm
	 kmNJI/Kyo47Cm522gvZvRtEDABQL2WX3f4GMWXnPy2SD2WrD6/rGDy6QeFPbNUowv6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NMOzEMl/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94A606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMOzEMl/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C201F01825;
	Thu, 22 Oct 2026 20:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702464;
	bh=zwXuztkuOLKJK7hNswKjkTGPOo5z5EMRsvowtW1Ffus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMOzEMl/8ssPhs/tmHoCZC3nTvYnL663cZxieHYelicZBZllU54EXrRZ8ySM8IsGL
	 iaES8s9Mv6EI9nlRQdMSbRsLaGVWnC53hRua3Kr10mYlANbIB6rNHl0oFauJ9F0rH7
	 ZH9Xpyt2jXD98pAi2Ijeub6mkji4pDt01GMxWECBjjIclB4orLqd2vf6/gyuAXkFiv
	 7zhTvTZ4sGEGvL2LYBF09LDa14Mc7PM2wcHCkELitZhID1ho8k6OdTrJWXwlsACU3n
	 MUb+Qx+p91ZcDbHt1VjUr09csxZX3tpfIE7eEmeAVveceEqOoTJg2H1EiRnC3OpM7N
	 ahsxc9LlHvWRQ==
Message-ID: <sashiko-outbox-182028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Support building BPF skeletons with
 bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022204627.1813821-2-irogers@google.com>
References: <20261013231430.2163505-1-irogers@google.com>
 <20261022204627.1813821-1-irogers@google.com>
 <20261022204627.1813821-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:54:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Support building perf BPF skeletons with bpf-gcc (>=3D 14.0.0) in addition
> to clang (>=3D 12.0.1), similar to tools/testing/selftests/bpf/Makefile.
>=20
> When building perf with GCC (CC_NO_CLANG=3D1), prefer bpf-gcc and fall
> back to clang if bpf-gcc is unavailable or too old. When building with
> Clang/LLVM (CC_NO_CLANG=3D0), prefer clang and fall back to bpf-gcc.
> Explicit command-line overrides via BPF_GCC=3D... or CLANG=3D... are
> respected, and setting BPF_GCC=3D or CLANG=3D to empty disables that
> compiler.
>=20
> In bpf_skel.mak, pass the bpf-gcc flags (-mcpu=3Dv3, -fno-ident,
> -DBPF_NO_PRESERVE_ACCESS_INDEX, -Wno-attributes,
> -D__TARGET_ARCH_$(SRCARCH), and target endianness) and query system
> include paths from $(CC).
>=20
> Also update version-ge3 and version-lt3 in tools/scripts/utilities.mak
> to split the two version arguments separately in awk so empty or
> fewer-than-3-component version strings do not shift fields across
> arguments.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022204627.1813=
821-1-irogers@google.com?part=3D1

