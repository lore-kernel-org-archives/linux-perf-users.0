Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527022;
	b=OdgqckwCkdthCijPhX79dkxQ5cdBG0VHfsTIrVj2Iz2eKoxGMzXH5ZMqT5dQYPPvin19
	 x0c2LYYAeACvv0c5BZjtB2mCEYJ+uC25mAj7VTFMcmyzoTmRkXLPisOoGyQYaJiUP7uxg
	 JuQZ7Ynt66WGfzKrZ+AYYJoOAKK2ah/o5qijw20A11pMvBN2tvJ73oMrkjrzAs42yrxMf
	 4dXQ6q1sr/FxR6MpeEYbHiHQskFfu+XBUb7Jgf48Y3Gpsd2Cx/Z9PTaOjkKFkEiEHEc7E
	 SuQF3zCD4gwlCipLSB2UcecZJFB8lIH7XbhLVFCLkXPAuQMs4Jw2z9oEJG27MRRHBgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B1Iv61ugdPIpjNYfShBnzqK0NU9ntyilMwxRVfpfp4w=;
	b=MWQhtvtCUIqbV7kNrPL/S8mihc9i8y4CacKdkE5Mf8bOH0plj6+l4wrgExxc1yHyqOC4
	 /iN/J9LaRGiIiS68oq94FYrjsANqFtDHKe1J5c433x7qGRIvyoPK90hwxLdi4hF4rVwPT
	 B/arJc9SRStKetOZUZTBpKn8Ex8tETlVzSCx6KvY77QR8GFAT5zNDYUjvSjfZ8n7t3h39
	 bbk/bicHflG1k13PFR+5LDvS+82RMANMVzudnXPLjopX9cnLXWLFxhTBXYBdwQ7FprqOK
	 VIlx5yM3ziGMD3zEQr5yoFZbMxWfEGPckCtQzhESpvBQFO/t1iF1NrgzAjwwC/KEUJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVcWajCl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA5606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVcWajCl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816521F000C4;
	Thu, 12 Nov 2026 23:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527021;
	bh=B1Iv61ugdPIpjNYfShBnzqK0NU9ntyilMwxRVfpfp4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVcWajCl3mD1L0aWx/q6STGGVc1enJQHSzOt18PmFq4YQ2MAMI5pvJvUvy3BJxUeJ
	 PRSX5ve0Jtp9XBnAnPh39I3YQaoMIRNR0tEbHSfjckV9yBTuel0iVvg+u8rPZngzao
	 KfeCndG91EwI7SdJYhW6mI+NLXL2Ns9nyp6neEoE0X+7tpnswTcodQyzgdwd2Z0Ubx
	 0frL7da5MIdDwTYezU5B9h2oaVJZeYg/mH/LPeup5xpTNf18N9z8yuiS77uW50n/Vu
	 Go5WkpLSkI4Qfo0VHhYdV23VG3MTAx6/ABa+/CGBKfFS1ri3vyxaU6HN2B8NM0E4B9
	 BldIv/OI49ddQ==
Message-ID: <sashiko-outbox-211961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf test: Test perf timechart --live
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112233738.699031-3-irogers@google.com>
References: <20261023054952.2503540-1-irogers@google.com>
 <20261112233738.699031-1-irogers@google.com>
 <20261112233738.699031-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:43:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Extend test_ttimechart_python.sh to cover --live option validation,
> LiveRecorder's perf record subprocess, control pipe and -o output file
> when system-wide recording is permitted, a synthetic live UI test
> exercising the rolling window, pruning, pause/resume gaps, round-flush
> framing and zoom/cursor following, and a live workload recording test
> when scheduler events can be recorded system wide.
>=20
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112233738.6990=
31-1-irogers@google.com?part=3D2

