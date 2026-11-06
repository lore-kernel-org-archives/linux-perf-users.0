Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949573;
	b=GllnX0QzlroWXwQvtyK9Fw8O/QY2yr2qRyJ7Xft0prqceKfzBmOJ7zw4AxfJjn1oAPeC
	 Ba2xvQU8L1wXiLMSSX86kL7+8e+zFAhu+9FNlI0iJosgzLLOdC2tP9fM1alBBODF/sDLd
	 qhT9zM0ThZa6Cz+Q3OoPms/lypHF27FBzbR1WfstuXhhC9IMVZR+F11a0Hqvdu7ZxsrSC
	 jwCdRq0yKSdxwQH5Mr41MGme1SBPW5wYYjdpE02XlCsotqp1n+uJYKCD+j/0dgc/zo+le
	 Y/EHH54b6Y7iG/bnL470oVb9NcUjuTkfodaqh5RsiJCIQCF5OH9Op9xSK1yIzSF92GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JciiS1ZB4K5/EJsFU5BbUIYG43oPxWpEQLN7jhdqfZw=;
	b=c8q0/xEAaYJhXPaOhGNomOx8zFRLOzHJ2e0RA94uUa4N7mJlndl+RPkPpYeFZWx/LcXm
	 PrjvI3JW6w5m2kDxmNY7ixGMSDt80dI+MV3bDULzfkaa/ITxEeKF8vZaPl5w7Z56yevSl
	 Cy5EeEQ9CBbgslp4op5zPJkKeJlxxY1ek9S2da/PaVE8CX/1WwUp2AAw6qAZM9BtFLSC/
	 5FhNJECyIOymXpHHZTfP+hgJZtFZTY4AJvHrwiJVyT4uhfSnKgY3pY0TgnvNhKlCvhjUf
	 BROYEQBgTRadqKv4Jc4YKPMVmLAuY0HvGl61C42wzfHV/OZ8s9jJ6SHfWprI4dWdA8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5rTAYUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1A606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5rTAYUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8161F0089F;
	Fri,  6 Nov 2026 07:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949572;
	bh=JciiS1ZB4K5/EJsFU5BbUIYG43oPxWpEQLN7jhdqfZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5rTAYUAu8VuBYWKtOI3lbNkyUpywX8itAaoxNo8aesAekeC38P/g/39m7rb0t8CX
	 oS3f9qWpOaIwjlp9MQPTPIjBwzWlorEOko2xadbbdtEWKgU+x14e79KPlIk77jgQEg
	 dh/6O/G8jrHVV28mGMG9xOhAQsdqk+HXRM0unuxPbLvBTQRcRv1UPIXmmi8HJlUD0Y
	 WOsTqh5uVovVczWGZTT5fcs3nEwdzkIraoD282T3lu29XmwCi585DzuLIUn2f5pNU/
	 C4SaAdAGgIySNltfbSmQQ+jNK/xZBiG2LM6+3v3k67aYO5MYcF5E67wA6gJK5N9T4A
	 eDVNSy9cPS6EQ==
Message-ID: <sashiko-outbox-200986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/20] perf dsos: Ensure DSOs in auxtrace, machine,
 and symbol are in dsos
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-10-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:19:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Place the DSOs created in addr_filter__resolve_syms(),
> machine__process_ksymbol_register(), and maps__split_kallsyms() into a
> dsos collection so that all DSOs that may have data fds opened or be
> referenced by maps belong to a dsos collection.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D9

