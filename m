Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868148;
	b=iXTdc1tJ7ZtnqcagszpjmxpkJ3wVs77lAKQ+oPD8SCTUvdwWvmo9Ev+7Etj83MXHNjFM
	 n2oyPi9Kf5cTa5y+jTce468PXtyrAbTrptVJGHfDzIgX1/knwYUvRg58n8vK0uXLFcAH7
	 4BA7eGsUqmq700T1jwrLlq+pbO8SLTXo3uMngFnsvtkxm9rEkp4g/HXvHOPl1/DVX95s/
	 brx8gH+dgH2BMObuoYF5iWEME1p7EUCYJ7SoF7tLh3EesfQYJ4xhqxnxwVcvvg35o+c+f
	 xQD68N7yotVz347LiPmOE/EeBIZ2qnkaRTUrv+NViJovJ5Qpj2q9Xz9q7uWvgYKWyWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868148;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+/TiAj7VLHncj2qv2ZqEJ7+TV34Qt2l5wv33yoTSdQQ=;
	b=4gTrRwGh6LAfzroJ8gXru1bXstG8mdmePHAnuIM1N+Z/SpTigK3YlyEXkjNtjEPhVzvD
	 8sZZD47OR8zicRjKXik1IRmd1Rk194+NswKeNA5bPT5eJ43Gv4Nwxb9aTf5tUAzH61zmx
	 hCWQc61xBGbOVHruD/ZwdZKSUFfODOk6oefs6suzDxg0JZda0Jz4G2JJdcdE9hQSc8fKY
	 7jgLeG+2Mqrn9Nf75LrXl9Q9GgbpAI6J2uzj/lhr+B62TyuVHVFHthaAS5PiJtRFg4ZKX
	 WVxJxvC7H0n1zxTq9K3a1TLxVt+ABgDqwXf8nOrrgqh00d89hc7ChsM0dkbIe9hEzJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRH8mB5z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A640606A339
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRH8mB5z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2851F00A17;
	Thu,  5 Nov 2026 08:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868148;
	bh=+/TiAj7VLHncj2qv2ZqEJ7+TV34Qt2l5wv33yoTSdQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRH8mB5zNOPMqU/9x8kKS3njRMEqQg4KaI7PWCrVNtYOIukCRCjKYA0yEJUhDdA3c
	 m+qnqvMKc1+oTdf/0ULcUA9+rBB6AvO64VY+FwJSWKHfhzqYD032/UtynEFIen5lcC
	 Avkky39VkYAx5n4L6GkiKjAiaMacdWeswIV6UwWRaQcQdasNLloEejrQXREpjmnXVs
	 umqcBPlFbd4vcF3uTNwI1g1HjEkmY0j/IRaTMXo8UfZmzzWbvtfUPYqjPrIG39WDko
	 eJpvNrGyzfzMoBswfoQ3WVu1iZsdPcJDlBTMQ4tGRKIqyJbS9yf5pzvgpVOaLvTUPG
	 WzrhgWPKCL6vA==
Message-ID: <sashiko-outbox-198736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf: do not call list_for_each_entry_safe() on
 uninitalized list
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <465e342ac620ec4f784424da897aecb4d0aa58cb.1793867553.git.jirislaby@kernel.org>
References: <cover.1793867553.git.jirislaby@kernel.org>
 <465e342ac620ec4f784424da897aecb4d0aa58cb.1793867553.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 08:42:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In test__pmu_config_helpers(), when evlist__new() fails, the code jumped
> to the err_out label, which calls parse_events_terms__exit(&terms). At
> that point parse_events_terms__init(&terms) has not run yet, so the
> terms list head is uninitialized and list_for_each_entry_safe() walks a
> garbage pointer.
>=20
> Fixes this compiler warning:
> In function =E2=80=98parse_events_terms__exit=E2=80=99,
>     inlined from =E2=80=98test__pmu_config_helpers=E2=80=99 at tests/pmu.=
c:296:2:
> util/parse-events.c:2849:2: warning: =E2=80=98terms.terms.next=E2=80=99 m=
ay be used uninitia
> tests/pmu.c: In function =E2=80=98test__pmu_config_helpers=E2=80=99:
> tests/pmu.c:209:28: note: =E2=80=98terms=E2=80=99 declared here
>=20
> Assisted-by: LLM
> Fixes: 8e2ef85c66dc ("perf tests: Test evsel__set_config_if_unset() and c=
onfig change tracking")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8b245572903b8c4ed0d=
c569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org?part=3D2

