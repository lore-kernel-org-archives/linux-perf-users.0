Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603194;
	b=2MnvuNULo3Psvr5a8ev1gWrvhILvaU7a7vPTTKys4waggCBfFoA8MNOUFo2Y1kzRNbsb
	 PYcJrMCyxo4YRYK8jM31eJb75Vul3ru8zjPvO4nHjelR4FTSjjpc1UqNvtBHN4IZ1uCIP
	 wWc/u45YaESO1ZKU26miFdjG2J7VubjQ2TMAJpZ6e4giY89T63Q/GLgAf0vycG5frk3+a
	 nfM550jaoNTP9BFrpZ5leyIEClBEc3tyWum7QsaEw4TBBv9A5RpJv/1HkYTIu1G+whIN1
	 mllMqVs5W8vjmZF31JPTdK1ckioE2VN8qvYOmJ9+xA6yFBfV+sUGHlrej1124KCEJEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kt9LvtvBAQnWxGqr49iErXHonQ5ZWfceq4whLfj13FA=;
	b=esrKNIEPo235YOfFUHaA20baRPfiZDcifY3KTTHNnpCMo99s0w8blVap/NkDpC8lNLyp
	 lrgTNN4YYfqCysU44hQvzIZgqmHLV22TUx4UHY49i/dYhUyk4F4zGwPJOZXOxViqZyxLM
	 ievT/hIcUEAWBVazkhcIKx9nFXNg8GI3dU6iQK9dAMdlje54F06GFPp7YqTfWb7eqOSTY
	 yUuVIEu4ultKYETwcgom9hVJ77COIO2u3A1y14622yZKskUFb7hF9tMRKDufqkOkd/GG3
	 7OO7HlK4axXy2iBbhsSdeyMP72DpexhYKg30Tyw93IKPjBWN8YOcSOChk8n/CWNjZkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4hTfQvL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD386606A31D
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4hTfQvL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9D81F000C1;
	Wed, 21 Oct 2026 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603193;
	bh=kt9LvtvBAQnWxGqr49iErXHonQ5ZWfceq4whLfj13FA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K4hTfQvLvTY5CHxNEG2UczwFvvbIqJhsdpNi1lT5ieXRt52ofvAINrQcaPiJlHlKE
	 OY8L4EEWCNAB7TjuwTUWRDvZKeGz46zf2bquBPW6Q28OyRuyXHrWObOlRD6odRbDEj
	 chv+iFMYbSVSoPy7+EXx0rEn3VJu69eydY6aTC2EXGqxtFGrKfAm+WRbq7EBhvTBQu
	 rYHjVdO9cHVoU07Ja3nMeKwk2CneEplxQXlQS9b3mQD5ZKmjaagp35VMOuDL38CJM6
	 nQhv3/xZZlSb9wONce0HGBah2N8bcuzsdlmYhiZcZ4eIGqAjkbWqZNwewIAwF0O/F9
	 JPLOnyU5hNo3w==
Message-ID: <sashiko-outbox-180511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/17] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-5-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:19:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
> builds in tools/perf/Makefile.config, replace the custom lock safety
> macros in tools/perf with the kernel's compiler-context-analysis.h
> annotations (context_lock_struct, __guarded_by, __acquires,
> __acquires_shared, __releases, __releases_shared, __cond_acquires,
> __must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
> __no_context_analysis, and __context_unsafe), and remove the redundant
> macro definitions from tools/perf/util/mutex.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D4

