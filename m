Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878212;
	b=4OPKiuwLthdkcXnCmEHAUcyX9aCNiG1BzucfA+Gn9vEH+qhuTBdZfYnCpuHvK8qqSvOV
	 rRmyt6jp4BsTdP0t8NQm1Apk5POljrxMXA5SFez3V5IBq1XvZ/tgUw3f1KGyTjg7iEex5
	 oAijf2oZNTIfg/sQskKCjiFf+Z6RDmCWBk4lLE4dpXUtX9OP3bzoc8Y5bjPXSXvviEOnU
	 JZcR2gmf6lOTutOu2jKeoXme2P1R30K33/k/HqIW5aeBZix04TjDRyBeC0GaH3ADxiEhe
	 3wi4N0MRUKf0D3LiMGoOeaoSxgt0EKIAsnFap6/qrhZtya77f/uL/yyW+5PwqhKfD9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uw+RPD8Ck0WQde9SdCEHr/+VAilSgWqGTlrpPGZXnHk=;
	b=XPNLr1guC6InzRcPMF1VqSItYzv1ITRbw1hlAgtOr7nIBZkcu46ITk7uQIlKfu1YM8Mu
	 xQOFMYJuqYLIC9sbrSxZ2bx3zrIJ+GKkP4MNSX7gcr7szTnWyZA63sManHT2SGmhC1axb
	 8ouxtJFq8ENdc98XPc0zyN5rdf6B7FSyeDMFWtPKwDW0d7aB0y+K6RAaRtDJVKDmCQAB5
	 XIFPV1KDJ4OFifYyzUO5Y5Q3qLAYHrRlPMktOlyfrptx5Eiy7wGGU0QiI1J+jGGDlsWt0
	 CYz8faioFMVdfn3LSnkM2RWU8D9yBf0a7Eff/LRqIliQF9jjpFUT6ulBeA8EvZ2KdTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KOMykpPD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F045606A31D
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KOMykpPD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15ED1F01825;
	Sat, 24 Oct 2026 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878211;
	bh=uw+RPD8Ck0WQde9SdCEHr/+VAilSgWqGTlrpPGZXnHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KOMykpPD5+UR6rT8df8pJWxFDYnRaWytt9WsK9tX/rhUB7RSYtUmAbntt9vXkoSu3
	 8oSVDGW6aH2zDIVWnJanXHKqAycaibRFmQyQQfkZJSiO9F5orzDL0n94m2UT6TEnyC
	 OtnuDQvnapRf2jFpum9NLvzDi1Iu69z4IXClxEvYw1yVx98ovOVuG91JbTALh5b3Cx
	 5T5a0KgLuDNfk/pbUK73FJo9KI6v1lo/O4znTdTWz5D4dKTtfblDKAKZlWUifOtQCL
	 sDU3Wdz+mNxPAimk24JcmPPYfjOYuyPPLo+SmLkqTzFUbxQIXwDK94zsijA/DzfAje
	 RzDj4dAAz0wMg==
Message-ID: <sashiko-outbox-183897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 09/10] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-10-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-10-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:43:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Linux kernel's function graph tracer displays the execution duration
> of completed functions by default via the funcgraph-duration trace
> option. Whilst informative, in scenarios where the user is solely
> interested in the call graph topology, call flow sequence, or inlined
> hierarchy, the duration column can add visual clutter and widen each
> trace line.
>=20
> Introduce support for omitting function duration by exposing the
> noduration sub-option under --graph-opts. Consistent with the existing
> nosleep-time and noirqs sub-options, it accepts an optional value, so
> noduration=3D0 explicitly retains the duration column; when specified
> more than once, the last occurrence takes effect. When enabled, perf
> ftrace configures the kernel's tracing instance option
> funcgraph-duration to 0, and restores it to 1 upon resetting tracing
> options.
>=20
> Because the profile subcommand fundamentally requires function execution
> duration to compute timing statistics and call counts, combining
> noduration with perf ftrace profile is rejected with an explicit error.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D9

