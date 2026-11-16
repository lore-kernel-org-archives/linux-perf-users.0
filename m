Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813194;
	b=Yw/EKyyiBZ4R4qxWF0HfM0DFhBeyBqNdn/zZOXHUnvaKvW3ANK/GMwncVEXBVTL09C5X
	 jjbFFH+XLGH0iEmfIHU8qPaegRlk6CzpgP7QMRdgAfxDQYlLg8Cv1YUVWuOe3Ex4u25xr
	 Wx8MCY3krzw1lFNR7Kx9S02hJjZ0tW3oItZgPDKoN9UT4Zrk8mlI+SD4zdVw7B2r+XGGx
	 qwH2aJKEe8tdCEBeslaNZO3kNE8gRloGbhiyE9kgoqwx6ajCzvnz4khtZSx7yBczOkAaO
	 VC+sm8p6lchWAajuiAkD6oXys5IJo9iAXH96tX6uPVqjwMYgOuJ3k/axHCV4zOD3qFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jzUWv4NaLo3cvVBh8i9b/MfGLSHXXfT8K1iVAn5Tj0w=;
	b=MQm95w8f1zNvoaPt/wZ7+qPG77qCv8LdorYpBk1cYXCyuFHY48uyhIn8Kdbz1TwZAsqF
	 5ZskB+nHAApkSU+/UATn8EyIW/JfOdn3Sff/cmpJcL5seH7C/fAWLbbKK9SU92QSdmbZx
	 luXmmXnvnyzd38jbeEZ5p1nycn0COWHXQvaSulnugo48oFwl9/PelQ9+vetBfORlVnxN+
	 QPJbAHUdlg7t3CXy0EVZ03P+ukw5NXUXwZHq/9XWZnuYCNfa/5HP44zc8tLUKact/c4So
	 OEF7/w3Pdp83rwcEPG9bdhNaH5FSK0PUNAD6Jw/QsGvjrKtxKKNYbZi2VSZL4vfD/Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUdQmanQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7FB606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUdQmanQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1581F000C4;
	Mon, 16 Nov 2026 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794813194;
	bh=jzUWv4NaLo3cvVBh8i9b/MfGLSHXXfT8K1iVAn5Tj0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KUdQmanQTYa3Lt7vUHQr6NVmqGUspjd98Lo7jvAOmFJkx3YaT6kVdYDZCDGtT0HJn
	 8f8YHdf/kmE5PMz0oAn0ARj/zVLpJ7Fpmxh+Hvb0wd+SvjqzFBFFEYMqt5AgXwCIq9
	 uRwkknOu2GbcbWExn+rncrXGqMvMbRsOQCrYfhq8/iZ3GGtAXQ1wvTGjrbjQQXPGoM
	 WLiSqwzjp/UqjwLwa3Z5A9SNAzqmqH01Zbl5S3w1xkl3AYX93ionKRhQfWn5Mvc6kj
	 71SAlmHy/wTF/kXCLLrx2RtR4YwAplUDO1hWq/z0rAfc47jXqKhV1b7kD+EVhe7xe1
	 42Zb1lk7khArA==
Message-ID: <sashiko-outbox-216394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] perf tests pmu-events: Test metricgroup
 descriptions and concurrent lookups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-10-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:13:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add metricgroups.json to arch/test/test_soc/cpu/ with prefix-overlapping
> keys ("group1" and "group1A"), regenerate empty-pmu-events.c, and add a
> "metricgroups" subtest to "PMU JSON event tests".
>=20
> The new subtest verifies exact and prefix-overlapping metricgroup binary
> searches via describe_metricgroup(), validates metricgroup descriptions
> across all core and system metrics, and launches 8 concurrent worker
> threads scanning core/sys events and metrics to stress-test lock-free
> block decompression and shared dictionary initialization.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D9

