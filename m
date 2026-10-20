Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510242;
	b=5tQCKXuVfTaMV/OAnKvcP3AMhm9QXoqKlN5PyMeTqKaTHvzee5IUctE8ybtKokGNM+4A
	 wknH5VcsIWvJOD1XjZ9IDlZknK774vyIdt7LCQHQ22gS94eMyaQrFZZRSsCur1ICJIg1T
	 GndtHmiN8qfd45AooinbW99aM4mEF6kJ45zuX8k1ch/ypmlVaxRCQRq5WKqq4zUX7eYSQ
	 RYm/vSrSwg+MkeMGvjjbWyExh01T3c53N66iOeVajNlqTVXFmYHNXfi6/yrqsxyqkH/XV
	 4nzH4f+YJrqbJQZLkxwdDCtavOZvUwF5z9uh3oKlhMIKqiAhLNe7JDp5BTqW2aqSWnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510242;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9naHukbVHExynFpTZ2VD/ovb9qOUBGbKSr/1klxOPAE=;
	b=DXtgVTEP/sNt/DrO58iP1ujaZauwva/NbkLWIDQxM0Pd6qAFnxCfNQWYmtm3Sc1ZQgay
	 WcnDIiMJcDxbUB3EJuVAVnytP2nHQWF44B/GhMe1BHP7oOIoN2LJZGSvhWwoOMZX5fuvy
	 LsxmXPTeJ54bqZb9m4Yx2DW1HEo7IgtLkxPOCrfK6EbwV7K9y594Ruasuirg9rflHSYa5
	 GYb9DJ7O0qskNu13zx6AyImeL7614ixPvtzc/Af4DuJnLrz2dqT1VypXo9mvjTjdetC0S
	 C9Cm2UZ111ANoudsJe/GyUj3+1wuNVQKj6Mp2kaSrTLg/CiTCxSX1bjYRZoCQVwTugA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05055606A33E
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 15:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892BF1F000C6;
	Tue, 20 Oct 2026 15:30:41 +0000 (UTC)
Message-ID: <sashiko-outbox-179250@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/15] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b67056e2496c2939d1b16c8ff97a545735891b0c.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <b67056e2496c2939d1b16c8ff97a545735891b0c.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:30:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend update_insn_state_arm64() to handle the 'mrs' instruction,
> enabling the tracking of the 'current' task pointer in the kernel.
>=20
> On arm64, the kernel uses the 'sp_el0' system register to store the
> address of the currently executing 'struct task_struct'. This is
> typically accessed via the 'get_current()' inline function, resulting
> in the instruction 'mrs xN, sp_el0'.
>=20
> To resolve the data type of the target register, first verify the
> access is to 'sp_el0' within a kernel DSO. Then, locate the
> 'get_current()' inline function's DWARF Die at the current PC and
> extract its return type (which should be 'struct task_struct*').
>=20
> A real-world example is shown below:
>=20
> [ ... ]
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D15

