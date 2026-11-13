Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600358;
	b=Mws4hdFJ2Z4CvIc34cx8mccpAhJGDLcUOW9PbjkI0T27IzukkXNh1A50cVuUl3cWCi5m
	 EN/z/oiNWDYfoNiFG/aBhRrufggRyCDXXCNTAOqLeUeNH30KxLww3dKjhyOyQhpCLeVxk
	 JDsbDU/yDXXKLO5L1rXZwQq6GMny8cGLlJrNvZmoLh8hqPndZTnJmECWGFp/5iLglsVg4
	 xYmPwEzTO3vjkpcPPjX/XRGHJHV5tK2/l1oKhicRPkgaNkQ2DMaqB2wbdfh0NPUYsC/vY
	 zDgtY8Xd3LSbXBR9Rf+pbsMuNyUfkyhUoAd1O9kh8haYJClM5trazBHK8RQA+/4TDuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600358;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sc3TafMarcT9s7EKs9ejVRkXShU6Js0fvHpxiNxNDEM=;
	b=G2h1nQC/IrfUlrFdN2LIwE8ntXvIeKE/fkp91xVx7lpHK+hlxlZGELxaiKLJ89TtnpBC
	 yp7wz314yix4APTHzCSlPPoqP043wFhRhLPs4AfejwnUO3YDndkNalNN4ss9uvyeq20LO
	 ITknz/hpxeMd+h82mdGRFNvzXElW98VH/g3DJQGgZ556W62tyzphdBUtesnUTSRh7Udyr
	 OhOF8dpsfHXxwF8GYl5WNPLA15AA2gQI1wi76cIXkW4m4bmi+v8Gyq1rAtDwlLx9/QDY8
	 6wdbaHCk4AtUnOLr00ogS3R1vRwUtuLCPr9frZGEmOHDj54k18BmW35WiV2MIFpEEIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CR1U/nTQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060F606A336
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CR1U/nTQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C811F000C6;
	Fri, 13 Nov 2026 20:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600358;
	bh=Sc3TafMarcT9s7EKs9ejVRkXShU6Js0fvHpxiNxNDEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CR1U/nTQWA2Zd4dXLZZicBJv08ETLhG+6/sBBhwtljtd5+kEQEOls/477uZdRJjgi
	 VvVnTEVv5Xj8TlI3eEMS2aGKPzmd0JpK4jgDqeMqILwQJaj+K8UmDIyjjZXCAXpH2x
	 Vw5rNKZusCALiWYwAytp+gWi1DxhGMZKF4nC752XzF38MdhxARMGpKhJ/2DA6q+0WC
	 dKEjMDYPA2kYHQGXCdRUatHhIru41hOVZIfcxGlNNfarWxTyvSXdvotZg5J0Xuzg0x
	 SUOFlvzjFHxewTRU557fvqTCo6W7PbgEk59q/CJCzsF8KWaJZEHaszlBcIG1ftf96G
	 osnuRXTRCsSQw==
Message-ID: <sashiko-outbox-213612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/30] perf pmu-events: Pass e_machine to
 find_core_*_table()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-13-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:05:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> find_core_events_table() and find_core_metrics_table() found tables by
> an architecture name, such as from perf_env__arch(), that has to match
> the pmu-events architecture directory name, for example "riscv" rather
> than the "riscv64" from uname.
>=20
> Instead find tables by the ELF machine of the CPUID's architecture,
> using the e_machine recorded in struct pmu_events_map. The test and
> common tables are found with EM_NONE.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D12

