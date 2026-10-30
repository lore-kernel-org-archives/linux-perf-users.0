Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373896;
	b=xI3x23FYIRZbRYMucNc/lFGW6lF7MjA21hzfkxVMZ/nrI0HE+4EdaxZa6e5V5a/8UJLn
	 wxwfwLtidgFvH2iIEJBlPTgUfgyYhlArdtdpVWGAvRFpEypWrxIw6O2NYQ++zFJGJUt78
	 LipJQHK8GQV7DMORu7Lr5a56lMcnIgFtQRThEpyt3e269108lYtaafnGRk8gVQpGjub64
	 9skARLev5MZOR+xk6AKA5wR3qBPuBoeRzGB99sM7NgV0vmMd4xFd1MMewZ7wdGaBoOgu+
	 ipad6/0oNjQDzPETik+IgQ7S0+yOF/CcSgoMrsZz2iQ2p282XAFXs8cAA8HrY1kHfow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mrroWNn8F+zR8VFNwwAy0uWTVNXtUEJ+MXPcimsejzQ=;
	b=0ylT4dzbm6iZRd3cCwd3HXYVB6eExRynne8gC6QfeJ5hdsUmDhnb/r+mtLWvJKasqbjU
	 VKr3BhA8YV58dBxcrjA+8c6akSCnc0ho605bl+Lzlze8dQy627+ovSnEkpiRR2/uckA9c
	 aaZ7+rtmyHTFZ8B3X/sRzomtOmuxB69I7X0xHLYJDID3kqLTXfk3WtG6FLaJPCZHHJ1mg
	 Qmnoh/bjofDmnMewvAzN+9ZZqpmZGWbrwLJpIt+vgrdpIuGjYtlXVsZsm52b49yvKjKUS
	 ZqNvk+EpLeLsjpP7OXtniPzwNLe7bG0JO6sNaPbBno4SkL7GZKaqmTd0YZNGUEu9yUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4zgnlKf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EBD606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4zgnlKf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE421F00A1A;
	Fri, 30 Oct 2026 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373895;
	bh=mrroWNn8F+zR8VFNwwAy0uWTVNXtUEJ+MXPcimsejzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q4zgnlKfTjj4OhKcm8Qme+RoCMfxeWPM440svUWcz7WC2XcShgrY6/EA7FH/JE+Sa
	 vfT3ZkN4Ql9grqsDDC8S7tlXqP3eNyh35yjtBSO2bGl+XcRJ/m1jocRmgPxKIY6uEI
	 tgV6aQa6V+3MN/NybVnVVJLLDwBa5/1Zto+xW3GlTwrS3DvI3LPRh+8QqwIygrH3Rg
	 tqIr/ZUbOQFrCq0DJPnoaEE5QrN3HnKhXU788sh3PEECUEej1E/M6LruFBI4pY27aq
	 AJZyT7naBQDkA4f5hYRndEheBc67McGAUdh/O0JNiutXtfbqHQ4g6F8O5oRhD40Ez0
	 8x2cyxLGb0n4w==
Message-ID: <sashiko-outbox-191169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/14] perf tests: Check CoreSight emulated
 instruction entry and exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-14-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-14-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:24:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Use traploop's EL0 read of ID_AA64ISAR0_EL1 to check an emulated
> instruction. The kernel emulates MRS and advances the return PC by four
> bytes.
>=20
> Select MRS entries by instruction encoding and reuse the common FIFO
> recorder and pair checker. An instruction page fault at MRS also matches
> the opcode filter and returns to the same PC. Retry recordings when the
> pair check fails or finds no complete pair, and fail after three
> unsuccessful attempts. Recording and decoding errors fail immediately.
>=20
> For example, an expected int/iret pair is:
>=20
>   int            5cc808 =3D> ffff800080010c00 insn: 00 06 38 d5
>   ...
>   iret ffff800080012284 =3D>           5cc80c insn: e0 03 9f d6
>=20
> The entry instruction is MRS X0, ID_AA64ISAR0_EL1. After emulating the
> read at 0x5cc808, the kernel returns via ERET to the next instruction at
> 0x5cc80c.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D14

