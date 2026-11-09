Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254474;
	b=Lux7FmvKDcD9eFVAuLlxkWo+AoTRY6S/diBdoEqehb0CKXk8s4xA7+B8cWr03bD7SBwF
	 v0xrxvPIMViD6+YlkJKo/VEIQQjq4V70BxGtSkvWKVRNX1Gr0ET++YznAja4VU0Ih0GDY
	 QEw405zYLtAw05VyxL9Rxpt/m4zGsPB27BUR8ij6A7bRBN33hv1/iuAsoW4wPAc5u5Jka
	 DTT1pbfm0E8kccDNtvJDZMcMgN+og5lUsOI/q836xbFF4zRCUBzqMQdo+74gyDgePSl3S
	 faJ6rH14TwAGcvU1q9Ay/TkQz2P2W8LEFam/04+bG8gjCdfXmF20Ax2B1VyVKOS0dPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254474;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GnqRLI/XbMMXA3xPOMZiJIKwDZttpz7py+GbFHyNY9g=;
	b=SlODzLw3FlhMqbtxpdNj93ej4GTOCDOx9evNdK0DISBjnbm+8hZu9t3iO905sigsBOAs
	 XJLQw8CuGb1TP7EXeyWbJCIYdChfzyztZyjFKNud+QYFihrslVhXryaSdl+iw/cXMWVLA
	 QtUDyNShh3m37Ru5yCnnk5a6VuJhzDxjGSTppO1gznV+3EI52QfIcYF3gYfmzwrrGeyxq
	 vtcOz9tSoUHhXjExQb1mL6Z5asUHUCjWX+odERHWrg4E8IB6cPbLpU73+EZpiBCgkV5yD
	 McE3A3XiY0b0cm8jdHBcq/lpdts4Nt+qT2vrInsqU+wXX6kt5vDUWB94zTDLMaboZKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrMijeEY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9B606A33D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrMijeEY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B249F1F008A3;
	Mon,  9 Nov 2026 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254472;
	bh=GnqRLI/XbMMXA3xPOMZiJIKwDZttpz7py+GbFHyNY9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZrMijeEYw0RfNCYdDhHbqLiVf7eK6d6uuJEMHEkUkHEwqPGH7UeXyyK7Lw7vE2BDt
	 L0m8qY7M2vfn4/o2NTrYl3EPbrY8pCtz8mKMFZ94VHTlFV5typxLIS8pXmf4shJOKL
	 bIE2iLIiOgCXY8/+WTIyuPezytbHDOmrLE00NNku0bJ+aBItldD/lzcx6yX5otEng9
	 Q2+Z3spQK15MjQUe6QFLdCZgwcBjo9MZPu7k4FU+DxxkfLF3E+zIXeBzS/s8QrwA6d
	 VR9O8e74iNXlxMbhEs+qwLOY0W4lLY4HNw42gdm+Trc3XPDPPT6Bt8Oad4B84RzjNF
	 q0/0MAH43a71A==
Message-ID: <sashiko-outbox-205523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/20] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-3-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:01:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D2

