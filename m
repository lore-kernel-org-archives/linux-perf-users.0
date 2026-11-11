Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425194;
	b=h0tm3pMiJqZHHEOwhhV4nQv2p5h/9VDJtG7mFVGm6tB8zjyph3m5ixP4GzRfPW0g2VBJ
	 s9QVDLqFwoU0Qu/QDanqS0c1JdiEKghKXU3VOwofk02uvqdEmU2WxlUC4JHAb0baiPSV3
	 sN1LDtWvzbsSArO0OlIyWAZLSskXuyzmwGyx+QGXhlvw3cvzoli7QB++o62sSN5F9OJfv
	 CKSOYwQCAfMjxvmXPDVmqqURRbPkIMs3AHDyq07TvuZXyKi6wZaAWZzdtjHkehJG4qgFM
	 Ew3YWyLLlfy1n8mdh3t6h1MQt/hjt5vtD421PrdTJ/udtIvnWBLFqGiZTPi2zPft/qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lHwtvGy1oeNGf3V1LRpSV9GCWtpFiqJzaz1iO3/vdYg=;
	b=rVYvxVUsguiGB0VKNkbYuTnXVs1dcdF7Rd0/sCMgH0nJJLSsrVSfrJx6h9xVk2QVCS0Y
	 MHocqpLyDQoq2eL/TmoYQ18qrg7B3XGNRzKahMHntsokh/XclTuRAqHWlVUv4r0dFCZO2
	 UGXD/B2ZoM4ziQ20KetkhmQGhcF31i6S1Ya4gxBFmF6J7e837p91bkydL0J2s1agFJKTR
	 P4BXRfErTGW/RHjwaNdL/L6GvjnDg0OaDeSatHeT0rOI87geC2zbRLCgXYiEaxA8F6x6H
	 NflQiD11XU3+a0X+4ybIYqrCHI4sufNAvN25PgSTu2CzGtFxzDrqcTV6gQHysPM03Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hQV/KLd8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C4606B834
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQV/KLd8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72141F00A05;
	Wed, 11 Nov 2026 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425194;
	bh=lHwtvGy1oeNGf3V1LRpSV9GCWtpFiqJzaz1iO3/vdYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQV/KLd8Lv+LpS6dV3JskdHW12hA69xye1wIziBm8V7ObXMTvUAwQC/ERRtZlgu8u
	 Wo+3QkUL4tRKA0tnPokdF57HLMBsVjIM/pS3QsjqDYGTdBCGVuRPgwLv/99YWzYBMp
	 /6Uie8ALSb+1TQgWeIsxrnoRi02YUsER8C+nbGw69YMBlmkTHCZsockJAKlXyHLFt1
	 PvOqLWdId8O7FvJZOFg66ktMf2J8sD93cRn6RGM4xL8ukrBWYcPbWYq9SVgqZqS/p5
	 XZFumo8hbNayToOIW91X1lqz9dvweip+G2woPQSeMdWx3Vb9Ptb5pg4T+fC8YSdAeD
	 yLeTQzVzPofCg==
Message-ID: <sashiko-outbox-209558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/20] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-6-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:26:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D5

