Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606873;
	b=GgTcmNsHv0mwFp1HCOocTxX1E2AeE3R2jQjP58FpYLZkRhEn0lDtz7A6WXMHaHG/2B2t
	 4KN8kWHkAV2MDEuWrSaWa3/wS+N0HQqBU9vBxqJcYgbYgRRrz9gkM0cAALa3BpZpd4gFv
	 m5NlsPJVDcK8CpzvM3jfju0BZ656L/CdfP7MZwfcqfsKBDCZN/Iyc1vNcYp72FclUmF+e
	 H4qG71buoCy+KVHJdsF19kOVjskLTStQ3N8jbRmzWKnaz6uCLu23IhiM2x1IbZ7CTppaD
	 n+42ryTIqW4C6kcpoy1/3xBRjKfadDp4TKUP5FLlk71AbIi3sbDs+Edg1/vygVOmrJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XDfCsW0IgzDMxxpeANO5pos/2R8jHoCtRWmTHQC3kIQ=;
	b=dqIiTQ+CYb2B1nOLGX4D9UrTr21sT3CV2VxrolMvS+4z+V+q5aicTh/P/2s7TK6+vziZ
	 rYVVyvkGJSS7fTMlnWJqOxC7c7BhFHMxan5bzZ20nrYx7bzWo2LdGlLQ9iXvqPEDX4GAo
	 B3jgK7c54InUdjUPig4BH0TGeywATgFaN4xn8o7Z3MOKyaTRmz14eeNLptfLmuiEOmBBz
	 KZn7Dore0JiXFaoGLCxLNVUCsUgcrgZkiNn0QM8TK2Afg02TGa1CNQMFCgWTAPOt4Lj8Z
	 bYJpA/z9pinM1BpvS+DROvNwMomVuKI4kqkD3pNcPhBGfVkwRnVfQRBk3ChoFxooq1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiAihTFf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3A606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiAihTFf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7821F000C4;
	Fri, 13 Nov 2026 21:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606873;
	bh=XDfCsW0IgzDMxxpeANO5pos/2R8jHoCtRWmTHQC3kIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fiAihTFfC84l8/FKwyg+hqeyZGP5TPmRqwEQ2kKEntfoN2KNbz8r3jIV+Iam1DHa9
	 t9uOb8aTHUeIIOYrtujcI0F4telSh77wNkj9IICY8qgMuplH5YvNmkCWm5J36c2ZL+
	 1j8Kb6OUiuHscslLvwXENXL5s8JP7NJSQHkNCGEvTkxwOlblVkOJvjYraOdO/6pnHh
	 Lff1Z7lOO4NnJhf0Rt73gLvzZcmyqmz0m4YwYynmPYSpsg6dlyotQAuCk5sFAP9xYH
	 pXXjQ/CfJ894CaW95/ORtJFMmNU56Pdh+KcR0TXj8GpJS7RJCR96wGi2DgfK1b5J38
	 O7Jfa+lNeV71Q==
Message-ID: <sashiko-outbox-213744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/26] perf build: Don't check difference of perf and
 libbpf hashmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-5-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:54:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> We want to explore diverging the perf hashmap from libbpf's to fix a
> few subtle bugs around strict aliasing (casting void ** to long *) and
> use of ERR_PTR which is non-standard in the perf codebase and a source
> of bugs such as:
> commit d05073adda0f ("perf trace: Avoid an ERR_PTR in syscall_stats")
> commit 96f202eab813 ("perf trace: Fix IS_ERR() vs NULL check bug")
> commit 9f3c16a430e8 ("perf expr: Fix return value of ids__new()")
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D4

