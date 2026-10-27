Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121175;
	b=5F+D7kcR1G3qZZBQlBLwdauJVZQd9cyUyjQMo7d5Va/eHUuRXNsR6o4gdhwPhtBEXB3r
	 tpxLQYP/rSVX3OeewX8aVhZq4ZJ1YxcQ2MxJ/rNHWSio7XZGNFmej4yQUQTF362HtmjPA
	 L33toDDA0Ejj89H90aXFnbB59pnOyLy7j/GYpK0lAOHfmALyRwTunCrLTaaNbCJ/lb0I4
	 WhBhrblW3zDZFAI/ICDxB6NYdFcK0KGlUgSPm4h/HKhfKnWUnGI5IuuzLAgn0sD7kKXyG
	 ec8yWwA7S0VvBjd5YDOwpwtxKy0Ut+KBEAOZLZdHBzMrcS3iOIjLgmWgSgjpzuW0vaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121175;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tHwr8PwLjd0XDF4TaX+r26R/GG/jTdnYPsJQNjaG4hY=;
	b=Sdi+/qjhy2slnFejCZ15pTig9I8m8faYhxCN8vh531DQFvy0/AUy0VifRrvLLDhmCJc3
	 whGdUtPjuGLCNCV8TYGdmEp1lTTC00sUruS+KqcximkpOofKStaO7NvgPGtQkaNK0UTDf
	 Zl8zrbRPnpXtUL+kc5QqPzW3l7Jft5F1L4rhMznkGnxXIb/eGV566VHDttBjDoKDpIiks
	 uy6boeNxJgSiQ0F9V7W7qyskGrPML4E5tiR3vYMzHAD+XNDFIOru67PscZqv+3ifCDqmC
	 gsDkeH3AnUl9uxwkQx8Ad+ezsBCy+76zL5hXJKaTHJkMZ0oMl1rqlz36yQFcfx+RCWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OD7cSi/d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD2606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OD7cSi/d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823871F01825;
	Tue, 27 Oct 2026 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793121174;
	bh=tHwr8PwLjd0XDF4TaX+r26R/GG/jTdnYPsJQNjaG4hY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OD7cSi/dEDFHKPhihOYyri3MWcIGU5sidkPuxMCnzKF2rmoEKXvDEzYJZN5Wq7Npd
	 zrWUEnLt/toDXrVP8mMfuPvPhiQl/JgoWgLi+HkkmtewuCdY29ycHpItcUtUOoISZf
	 fYSQAPE+RLHJBe8UKsISaNjXm37vE7OKIIA252UmLjcllrTtqxRdbi2CNLwaNEtwbX
	 WUt9NaHwm6iZliVNjwEpykSEVFTzk0ubyEcXMjVc4Ei7BLfHHsGyR/BM1wU/iE2nlz
	 orc4zVxkvu1dDvRePl1BoES2WJziju4TVfo2Os+fdp4SpDdG1vfABKWovTdZwQLL4u
	 7utbjmdsnNfjw==
Message-ID: <sashiko-outbox-186976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] perf off-cpu: Write the sample ID for
 PERF_SAMPLE_ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261027170415.2815859-2-irogers@google.com>
References: <20261027170415.2815859-1-irogers@google.com>
 <20261027170415.2815859-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:12:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> OFFCPU_SAMPLE_TYPES allows PERF_SAMPLE_ID, and the sample ID is
> computed, but off_cpu_write() only wrote it for PERF_SAMPLE_IDENTIFIER.
> When PERF_SAMPLE_ID was set the synthesized samples were one u64 short,
> so the remaining fields were misparsed. Write the ID after the time as
> the sample format requires.
>=20
> Fixes: edc41a1099c2 ("perf record: Enable off-cpu analysis with BPF")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027170415.2815=
859-1-irogers@google.com?part=3D2

