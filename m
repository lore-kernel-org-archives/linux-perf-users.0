Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588966;
	b=PddmwNvhXoOnSVmZI+zzsMLXQIC3/4uq1+pBJW6J86XKSNuK/QQnxqX3EvfpmGuqk9aF
	 dyREqYkZEsiuBsmkocVSYuh1v4Bx/Um2RTSLvQDtPJcPkXOQ5MxsaJM/8FmvRuJm/S1zQ
	 g3rp7llsicHgdpNPN4TVmvaIh2qqigKrGBaUbh9mKoNf90IAKIwn6pwBSK2rA6F1SrvhS
	 4muRVPjaNqhV1BxkkyjKfBOjE401pNoW3N5xfHL0Ke5rUdQdqMigNvApQ9H8KXd5G9dtO
	 jUWUc6szJ4Mn/LBVrMwayev6P0Pu/Z1Unde5pVdxe48jKPMPvdDaUOTeANo+5eSNofQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588966;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f/+ENfvSlv7wIpRU841qoVrTzckfT1JNcnqqTiHP7Z4=;
	b=5tyoDo7E6XAkSLUIQXAPyywWpmcUlOqP6Ji9Zp3/dFgjxGSSU+UJu33ltRcd7aWyHQXU
	 Nfnctm7KaaGBQX86FBqgVv4L6RW4Mq2LcqMvL0AmB0+wcVXH9KzW0teHb9Swzk/zw1WFJ
	 YjyrAtAzRBka/C3OXb5AGKfBM6ynyNDBELQ2WYEXLSqr0rIi0qM8BLAvwmWAQ4pbKV+8v
	 dgYIa36CnyJdqZZAZbJ8tpDjGy26b02IzNETM0aOL6Nuas9aM0BExIAAMaFo591FXb9fA
	 MbY8blB3PmP5YWB5aCOzlWmL5azPdq4Dxgg8U61hE39dgbDmHzooArtT65fL0iAlDfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxgYb2KL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F67606A336
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxgYb2KL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CAE1F000C4;
	Fri, 13 Nov 2026 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588965;
	bh=f/+ENfvSlv7wIpRU841qoVrTzckfT1JNcnqqTiHP7Z4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cxgYb2KLYczlelX0nmj5SeLmkutm7nxEoQRIIQnxs1SMRGTvG44YfkTWhnmScs7OP
	 IzK6mJcY9JHukf39W65sCDigOvw1igeKvupIuCdcwpVzLAfbAheP43t3wpm84dcxoS
	 7Ze6ZHyKo0zGsirfqmr7xdliioqiDjZ+WBY3NSuUZtQ4Fv8zh/quvUXjTD/dZWv4+z
	 9a67E4Kwm3+fuLTP4hvacyIy9Bqaa2nnqhqcHf6us4FVinlYCPUrl+75KrXF6s+wu7
	 kcJ0Rz00IK4RjzPHZnEHl2A5uan4RgPENZEiqe9IjHbJ4j2IbaAv7T5/808vU1bCNg
	 /yg8ndpsuIyTw==
Message-ID: <sashiko-outbox-213251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/21] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-3-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:56:05 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D2

