Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601581;
	b=PIbeqTdWiZkHvN8oaxIyXn4EMzC+g2PrcXIOlY+bkew3/0h3yLwWReKXvzoVDOsMZyGg
	 mSbjIr/h2huf4VUPrpbjIXQT2j6kAOsQhH/x8SchqG6NBHuOA+b7SCBkPiF0XTXv2AwVE
	 xHHUyZd4VlCOfPAG+6rxpvNneNRr9OF/GQO1frmWETf9IA12/egD/SYCogXjIp/NFz6ic
	 p2qFEpQ4YQxrSfwYBuYHkWde5bYYIp/Nu3x/gtJmu1dCbhq2Wrgb5B21NWb2PlbGKfVMY
	 Ca9v2pRgvg7b6vVJanhsnfY6ZcSj433fmpLNclsaNmGqJjayFAWq8UeeVbkWRR1okwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cYwKFNqzlAGS1Tis2Iyth77sSdlQu2JduBWKYAaRo9E=;
	b=15TbXord/aRfzPFgXcXB5UTHAffV43y0hhS4H1jf0ZwuW2++sHR/BYumTgedNtkJ7hRs
	 n4ycN1s9kqBbDIsuhggLwM/u2e6uobEedo/+GlRx/y7pbZqTwdrj42Oo8fMvQw+UdvsCn
	 AmqfGPtTTFkto3P2QUVUSHwHdKbwRNjxlVNwQ54WQPphtOPGz82rI6BkI7BP+naEyVfCo
	 Yp/rJgi9DDcyJ4iZmpSN//0nEaA1rRMIGcfN2bXPaAVMJm6NYpPsletQYxKYm0OrlJbLH
	 zdFmS5ZqhiAM+Cgrm8qQA0Z7Or6ICHKtYf3VaipLSEoaxJw0a54bbSmzlKm4q6i8ylw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goMZE0xD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD5606A332
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goMZE0xD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027731F000C4;
	Fri, 13 Nov 2026 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601581;
	bh=cYwKFNqzlAGS1Tis2Iyth77sSdlQu2JduBWKYAaRo9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=goMZE0xDJq2TQV4LF1vS1ealehDQsxtSFSZDxfmTIJpRvyWnk1w0oE0X8qDG1AT01
	 om7MistUue6KcDRZ0ax2g/O9KEEtwSW9QrxxDyUa003tVr5prx9iqOg/2C7HDqxAFL
	 kD/1xnImlnNV/jk6+CkKEigkZva5EMyXAeuwZFsFsWRcUwGA7bUeWSaRxwvFtXv6QM
	 FWX+iMOQnQlPJMHL3mWFwfnXzVYL/EYz2a8RtE4L7UG9K2B+cgcKCnDhRLBIcaMOsm
	 Du74udkA4G5sReBakuZdsHxqKxyjQkQFJWq66pythFcbpH5aDVeX6Rugg2GuSPdxUc
	 3xlcckwrUZbVg==
Message-ID: <sashiko-outbox-213636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/11] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-2-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:26:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Build perf with clang source based coverage, run the complete perf test
> suite, merge the raw profiles and report line and function coverage for
> perf, optionally against a baseline.  This is pahole's
> coverage/coverage.sh + coverage-diff.sh merged into one script, wired as
> 'make -C tools/perf coverage' and listed in 'make help'.
>=20
> Without -f the report lists the files with the most uncovered lines,
> which is where new tests should try to get more coverage; -t narrows
> the tests, -f focuses on specific files, --html writes a browsable
> report and --table/-T, also available as 'make -C tools/perf
> coverage-table', prints the last run as an ASCII table with the
> per-file line and function coverage, like pahole's coverage_table.py.
>=20
> [ ... ]
>=20
> The run above was unprivileged, so tests that need root are skipped or
> fail; the report still points at the gaps.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D1

