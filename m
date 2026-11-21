Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245331;
	b=KXFgddt3ujpfOEmltv+6yvxHls8q9wrp1exSp1/G0DRRLr8J5A157s1hP9p9UE/nzbv5
	 oNdQqWlmam7LGfNBCvkGj6CA9xRbTxTP+AWA3KtYdSwudD6C+k7YxT0g7tW56IkdBgNu4
	 PL04XfKt5KRDnKvc+vmyXPXNJM2OP/53+qiMJobTL+Z/8WrprVP+TiZpaaK2Q06zBeSvB
	 fpI1mob6kxDNJeOOVIamYKpQ3uHK86qVzzDzLnybcrlVIxcIMPkq0RceGONQFjrDQPHM9
	 9Bsemr78y/z7aIcMcQn7wijGTd41CjmUr/CxZ9M3Elytg+aDCMn4FwHD7RBo51Fjklw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G0uyMFDGyckwOBGYTT6lwAnjij2kuJxQgjkA5mrH0Cg=;
	b=bhInhPmuDf07+So6GfdUlyygocTJFRCKqlvHuhdkVwpef8lm/3dWPgy8FbT5zm8GQF3s
	 i/v083x1CxJk9vGW92BgcWullqN5dkqYDTmqqxZKr8pLZuqvo6+Za9FjzcmT+KLGovoQP
	 bHQtdRwStLGtbJ1WTeS6BVRp2Cbr5kK1hlh5vDv7jHJPSNW9+HxSSUsAgSlXGW9ZckeV4
	 dlVrtTj7+13BAyQ/JOcbDXiMlk86PG/kA9V928WUaATIYo1hc+l6t8X9g+bbUu4eRffGb
	 S2la7o20boqEW6RnTN6N8/1soZzyxZ4tWgE21nJnulPP7/n/ub1kVckykWd+sWyl+gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l+U//SuE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197C606A325
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+U//SuE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1D11F000D0;
	Sat, 21 Nov 2026 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795245331;
	bh=G0uyMFDGyckwOBGYTT6lwAnjij2kuJxQgjkA5mrH0Cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+U//SuEZo42Q+YtOiUzhgJEstdJURHScGxi5vTpJRTqDCND+zIp9Ri6N+E1CBSBp
	 cn0i8shvmT24B7saTadIy+ssV1juVDecdkef6cgmOdU78oXh6FHzQ5HEDcdXSfwZaF
	 +0k8QRublOhxDG2hi9nxhL0TsTO0atrQD+vgzPIJVaLQbOFvKU2BLnSnOgSZa4aJUy
	 bYvJGSPDorMT5h9snkC61k6w0vnvHyZ8Iut6GmuUl81agT6wl14TItOEIWZadXXI9r
	 W6SN2OEjYIl6V6s/iLzmGhMB4VbW6Ar/nFvdtBFxepnL7DrLGREnIaGC+HlFVBDxom
	 zOc539E8nRKGA==
Message-ID: <sashiko-outbox-226752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 00/23] tools/perf: Adopt kernel
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
References: <20261121065813.4143649-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 07:15:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 23-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121065813.4143=
649-1-irogers@google.com
