Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453916;
	b=dw9g3WY+vlR1IhsEsXSITCMhlMrf0klPyYOT3iSUIsroYeW4BSjrJ0/PJWo1Hq6msNci
	 N6IDNig7pXGaFKcR6P6JyM4DDhb4FTNas2rmhMCkrSlznBrBDngzhMBwWcgyGy5igHOMn
	 rerZ6mV4dKol0KORdv9h1ZSSQc8gocjwQcGoGihkaBGUCmfk94OPYJ7CFy2r+oaZtl42K
	 IPxrRynOUg0o6eqt5tlygM1qmbmXjsK6f5IBXzdWZg6Y3OVZCuCR0f610lfhtnAR4T85G
	 hBsBCrpTVZunQfSvWoHdM4XBaBPNOrEiDWfh+4uSQmESB3oyxf3tHrQKzAiUdBbld4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RXeTn8x2b+rBfnyuV1F7rXQQUwpHzowNA8x5LaoSaRA=;
	b=uBd5P7XyK1r03kP8FOd6q+wtBfOl6JYZRI43ULC7arxleZDd4rzryE6+6vt87+rIj6bD
	 Rr7K81Gi5vl8g/wIRU8BA0PyzX/xfd5ET7FMGX3079ts0Pbdno9BcAqV7xTLugXOGhyw3
	 umcEDbq+nNassWYqArn/568Ab+lAR7lLgBI5j7w8ipLFGnya8vaCeQxIys17e4rKKvwCT
	 XL/TE5WOWPII8Q+QbrtKNZqlmG+9New3mpgx4j+IS3hlOMiO8wYiYwGaMn+HDNehVJJ31
	 h8uMOR7iwAfkdAvg8ovYz9JWN/Qop0ak+hSN3UoUYggze6NkzdeNV6H0h6apKsdqsOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7o4EjPw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1B606A323
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7o4EjPw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFC81F00A08;
	Thu, 12 Nov 2026 03:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453916;
	bh=RXeTn8x2b+rBfnyuV1F7rXQQUwpHzowNA8x5LaoSaRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7o4EjPwuttrYjlxG9n8Yrt9DtOytHCOQQp5IINgT2zB9fGdlFkDYK1/5b320sklo
	 Hsqb86ahKB9d8EBtREIZByQZk2O/YTejGmwh6S/6oO1RRfmPelGOR+t7zG28T9jGme
	 skt8t9XM4l7sTDGzpps9pT7c8CCFlg4VShC7WpU471wS9zuDNwooLrx/1qyQ1+pvw/
	 S9wu1YxyRBYeT+CTBHzeNlsm98yAIed4BUQ4jEsk4WcUNWKjJamYQPwO/wfOjWrHmU
	 hhMQktIFX+2zIyQDh/kUpQVsdtbVWpuWazxtEVefxEFzqBpEcMHrBm5lT8goaBv1EG
	 w9o+4tSp9szpw==
Message-ID: <sashiko-outbox-210269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: guard free(new_filter) to avoid double-free
 on OOM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112031810.1899-1-gubin@cmss.chinamobile.com>
References: <20261112031810.1899-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:25:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] perf trace: unhandled -ENOMEM in trace__expand_filter() [1]
--

commit e8aa93f0bab0450d21dc93c231c980b9474cb264
Author: Gu Bin <gubin@cmss.chinamobile.com>

perf trace: guard free(new_filter) to avoid double-free on OOM

This commit guards free(new_filter) on the asprintf() failure path in
trace__expand_filter() so that evsel->filter is not freed when new_filter
still aliases it.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 4094141461f91..f4a67491f5be1 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4679,7 +4679,8 @@ static int trace__expand_filter(struct trace *trace=
, struct evsel *evsel)
> =20
>  					if (asprintf(&n, "%.*s%s%s", expansion_offset, new_filter, expansio=
n, right_end) < 0) {
>  						pr_debug(" out of memory!\n");
> -						free(new_filter);
> +						if (new_filter !=3D evsel->filter)
> +							free(new_filter);
>  						return -1;
>  					}
>  					if (new_filter !=3D evsel->filter)

[Severity: Medium]
This problem wasn't introduced by this patch, but at the end of
trace__expand_filter(), should the return value of evsel__set_filter() be
checked [1]?

tools/perf/builtin-trace.c:trace__expand_filter() {
	...
	if (new_filter !=3D evsel->filter) {
		pr_debug("New filter for %s: %s\n", evsel->name, new_filter);
		evsel__set_filter(evsel, new_filter);
		free(new_filter);
	}

	return 0;
}

If strdup() inside evsel__set_filter() fails with -ENOMEM, the failure is
silently ignored and trace__expand_filter() returns 0, leaving the
unexpanded filter in place.

[1] https://sashiko.dev/#/bug/linux-cbf4bb01-a981-47dc-b440-68e5c9c3e81c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112031810.1899=
-1-gubin@cmss.chinamobile.com?part=3D1
