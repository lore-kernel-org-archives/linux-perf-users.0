Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600112;
	b=OiHN1iWCyQxoiDMoQwTKkI45u6kPP/xrx6q3GPWIXQKDX9fzBEKCmg5UV1u5I5PV9POP
	 V+XjpXCUkTDGCtdPSuGc1sO5yKsPcRfAug58q/Exyoy9sSGHLt2U878/2zSytSthNztlY
	 ppT9vAwdy0dAsHVxhh4LrFM8SxOxWNxxGmEUgZ3ItDjp4V1ua1IMORJ8HVnoua4O5NZY0
	 YT+U2yx2rki7iJ2lc5JGGnHFwXuy7L+epMd7LOPvd1utMX6hPg5UtJygy96abWRQ76Hwv
	 igr0nqKhrInK+2n8A9YdplZP1YLT5UJnoTcZmlWc5q+47U3BOuL+nX981+qQPh8cPaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d4yfFgr8bJ3SPh9CNB7w2K9KXyxfZoFzFPzsQGlgF3s=;
	b=1ovR9Q7cLc29purNzYQjWfugwKtxGT3pZgmM9ckvzT+nBHltA+frnUIvOIRjzIejDsAl
	 gUraVpVxgnsp1bbgzkfNwN/bJ5Dowrt1QuwhMcSWq2fD8m+afy/cnzPhERb01MDEN/twR
	 Y4cyF0WZChib0Ku9BQzLzBEIty56asLpTY7uVw6b96U3yr98vxU27hQGYeWDfvJ8PA/rI
	 +QJ7yyVup2wyiIaL2bsXznZZZ1w2HmE7Hc+uSxf67orZ/DNN2HYj3N6/J71fYVk1BMZ8d
	 pRVClZajRbKWnOZLRpOWeMOBdmD1Ckz03+hyJnQ/eiq/E+uhepBk3dccnRa8Csr5lZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jhzs5pPD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39A606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jhzs5pPD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3911F000C5;
	Fri, 13 Nov 2026 20:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600111;
	bh=d4yfFgr8bJ3SPh9CNB7w2K9KXyxfZoFzFPzsQGlgF3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jhzs5pPDKurompZ9yPXmeloBos4haUF6U3lEBmC38jRT1adZ0nmCfn0xxZYynBbZV
	 Yn5zJdT2K3LKDXul2jc9/jPPZ86q7sVxmyt4Vlk1MQFLexUEIzUK1EpKajJ29TRL93
	 ql1kRodAkyXkbWqyKUD7I3S4MsdbcoAXxRJ1vhTwMpOzl1affozSfLktjXTMIxNz5v
	 WFCSbe2hikOxumKFjV9L6ct/ISBMF/7dg39IaKNpOE+3zzAGRepMpFOUFdPOlIKE+j
	 +BOEULHlGFd+l6eTZK+Qj6cOiGtv+p9jHJuSASrGff2co/Y5rn/R5tTkYc4lPPi310
	 F4bBijWTQdwiQ==
Message-ID: <sashiko-outbox-213600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/30] perf header: Pass e_machine to
 strcmp_cpuid_str()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-14-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:01:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The format of a CPUID depends on its architecture, but
> strcmp_cpuid_str() is only given the two CPUID strings and its
> architecture specific implementations assume the CPUIDs are for the
> architecture perf was built for.
>=20
> Pass the ELF machine of the CPUIDs' architecture to strcmp_cpuid_str()
> so that CPUIDs can be compared according to their architecture rather
> than the host's. The pmu-events tables pass their e_machine, comparisons
> with the host's CPUID pass EM_HOST and the arm64 CPUID matching test
> passes EM_AARCH64. The architecture specific implementations don't yet
> use the argument.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D13

