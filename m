Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561492;
	b=C9WD2BTurFBqkjdWiX2KhcDPP7QcNmCIyCjJh+sxXz8Jy7dLdOISiB7qHTxOyYxgdAet
	 gMZgPRGrVjCCUxMBnatVwVicHLnOU0AzfZUmtragkJhsecTakXq2EQ0uR5wcWgNt1cTQ2
	 WJ9dxDexHhDcXZ2FFU6qPg1yo/blvdLZw68vwyf2yO0sApHbY31kDkeEbEkfTMEFiQJ1Z
	 PKEAVkT0ZLJQiK9rydMWnz1Qsa2ktIlj8g45TXa1XEDltUNkHUQKmXnqLp+gr7iUIO60G
	 ETCq7dUAKamSA8MxVbEDCc4u93oBdHDiRY3vZ34CFMFIiboX/Wdh4p5R06uw4XLYEDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561492;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j+25lTQ+xKEFE1RLyIAkCszNNATkhT23RM7CTClBKh4=;
	b=HJKTW/uMEW93mdPuHB8n8wEdacdmFkP5q6LTOLmjWmftFFDX90rzuBXLi71iAJk2YnjQ
	 4H1XGE/4lzPSyAVXkLxMKcd0SuxqCFH4RHkzoQUqPhnRxM1kwavDRUk+vE6KmvxYw1d4K
	 SN8udi2vjeNB1LTrs/M8oTtO0xKiDG76rbcXRAv+6Avww38jfhSLyXsKxaExsipsPZzml
	 nr4EPjlP8D1OcZmNLUM1pwKIrm08aavRvh3XS/H3S4TrbrgEJfXkF50ZDeVkWCsSNViXx
	 z7pWCFiXlsPtwU6EZTQ2nvH4johLbYlw7CvIjA/TtxbCfjGndMVfUTpvqK35Grddjqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1aX8tov;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D8606A325
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1aX8tov
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0905B1F00919;
	Sun,  1 Nov 2026 19:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561492;
	bh=j+25lTQ+xKEFE1RLyIAkCszNNATkhT23RM7CTClBKh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1aX8tovi7vaOd/VMmHd4aICk5TC2/8vC6zg922LMXAQW3IAQRP52LN06LXphl6xS
	 g7trL9YnjzlChs5fOceQrD+0TJ6ahcKzRqLqOzbMjmOPl1FiHoV3QY7REioMW12/TF
	 Ve6upPYQih/raORH0AvWsduSqx9T4YGwVa/J+lMz+UK2ruCVRvQouS8qIn8lXi+Yr8
	 gOAltNktUvqzhjK4Vn7ZQql2BP+oE1iIL/uZghlzfP3QxtDpXcdaC89wbl7o9LihTZ
	 PW7OV1nUFL46tElF460Oj03NyEcNrbWkNsiGkrA4L94nFWCXELj01OqkZjXi1NaU9M
	 nnVT00GlqFzHw==
Message-ID: <sashiko-outbox-192611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
 logging options call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261101-alpha-profileme-v3-1-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
 <20261101-alpha-profileme-v3-1-92d511b5a044@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:31:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_enable() passes EV67_PCTR_MODE_AGGREGATE to
> PERFMON_CMD_LOGGING_OPTIONS. That constant is the counting mode bit for
> PCTR_CTL, which belongs in the PERFMON_CMD_DESIRED_EVENTS argument. The
> logging options call takes a flag in bit 0 where 0 means "count all
> processes". It works only because EV67_PCTR_MODE_AGGREGATE happens to be
> 0.
>=20
> Table E-18 of the Alpha Architecture Reference Manual gives bit 0 the
> opposite sense, but the PALcode in the ES40 and ES47 firmware agrees
> with the above: it sets I_CTL[SPCE], which enables counting for all
> processes, unless bit 0 is set. Linux never sets the PME bit in the
> PCB, so if 0 meant "selected processes only", nothing would be counted.
>=20
> Add a name for that argument and pass it instead. No functional change.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-alpha-prof=
ileme-v3-0-92d511b5a044@gmail.com?part=3D1

