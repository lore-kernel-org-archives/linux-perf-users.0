Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759804;
	b=Pu+3AXqtLv1BlhZCtvJ/m+LfWE5XpDSFmjfj/Oz1QFIkHway2XZUGYo6V78U0yjyfSiE
	 oUdbdY7ZI0611ybXnGDJ2jEiliF4J3hXd4r514SGWUPw806w0cQ9VU+/WVlQ68VflMaWl
	 zS8ej5YX7Z8Xv7qc2eIH0QkTYVHKgDu68jjNzGKQJ1UpRz/THCP1TNbf1aS62Njy/lQA7
	 UPM2lESMRSI5xLxHc5QpvLbhn3rKy2+CMvtG7RAeWt2RKkLwa66DqEEJsZ2+tp5ZyqK9p
	 RBolNjzLkrqxM8QxK6M+8Ev86O1PADnvz1XN+d7pon4QNIDF2FcENSfSEDabRiHD0LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wFcBywznSS9oIzRQY9++T+B4BWoPidYXY1wbs202Doc=;
	b=VZ2EfCrNgWyeQJpWhvso5Cjt9XpeJvi1hUSg2HA+sWfU/8Kt7Eh960imfogICgtp6Dkx
	 MxLSKeiVEJpRoYD9n+i91BlHUeUgzAFKv5qs8bEv6kxnLUTajw1viqHH2gR35RlhYT8ur
	 NzvQU2p4AjGGNDuWk/c8J3pm9JlR/xoGpuyKCOANOVVgcDaPZITj1uCXHDz+qqXk2Yv5t
	 KTpc7+kOQqUgAuVeBxu5HoI0RdB9nslzOQtO/dn8u/nKsqfFAkjYKQDno4yCrbUSQKUky
	 l6dCrX15katPuMw787NkDk1hCovDPdLq+LCeA8LqaE4A/w5vJ7d+NeQcPJyYNYgWbPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNooalTx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C67606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNooalTx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBED81F000C1;
	Wed,  4 Nov 2026 02:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759804;
	bh=wFcBywznSS9oIzRQY9++T+B4BWoPidYXY1wbs202Doc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dNooalTxitdWKA8a5bLCV1ZYSmTmhXE3v6K74JipewzqwFbWlaAyp+1QtvhkSl1sW
	 UeRuo+EiVYtU7I2kQcNMz0rGP537YcrclWJOJR9jWsFWVNbRB6xTI5vb+Y4NBoenWB
	 027Nz0vfj6dGHF5mk7Bh26s0fEXQstaRPOnnYSjFLVsU7Lt6tGWIQj/PQZpTHEou9f
	 IXQC+zL4XGmrd0OD3t2bO5y/3XbVtw/BdehSdsm/+g5uyLy2uShmM6qGssFnjMl9aX
	 AAh8RTy+zWFhNE5hHuTn34ojJeOX+iMqMpLQD2LAZqDQ1JJ/+/t8Npi70bpMDyD6Pp
	 PCwoaTtlqI+ig==
Message-ID: <sashiko-outbox-196502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 15/41] perf metricgroup: Move matching of metrics to
 recorded events from perf script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-16-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:36:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf script finds metrics whose events are all present in the
> perf.data file's evlist so that they can be displayed alongside
> samples. Move this code into metricgroup.c as
> metricgroup__add_matching_metrics() so that it can be shared with
> other commands, such as perf stat report. No functional change.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D15

