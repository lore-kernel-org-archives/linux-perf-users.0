Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939634;
	b=dXB+sOD3n2zP+83y7OEoIrDKir6n3fN3nh41i8Pjv77haWslQz0XsC3VyKj5ElMt1RiT
	 TDNOKfr2C6wnJ6/QUNbL/LHa0g1KyKZceioDdGq0xpvcSXoQI01XcQxwTq44FuMz2jsP+
	 NxFmNAoXm80yAvVYGuXHO9oX/700nME8d+QI6cSoBhoNR6PIE0cK6YU5a6grja/cvdFrV
	 X2ot26dhh0LpXQeaHsshAba74FSHo6VQ645QPrKNRaP26qazgVjn3/Nce15V3gjioAfEA
	 jiaxZbfnzqV2bLS3NDB5Rhz4Ps4mDg4oq9COS7PpmanUWJIe6y/1jUWv7V4sktlWSaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YTS91iW7fOe1dcxmvoeQpHCg8mKWyR0iL5CHwOYf50Q=;
	b=mNfuKnMVZ5kio3OdkCXiiW8EJOvz9CJvjGPlycK2OYM95Kc9ij9z5G3J3oZjDux0+SAP
	 pRp2lxCVVDIt4rZ2nmiMgJk/7r1/wCHFqAlXQKlvClRTQRz7hGiQs7qEGpiOBFXB8DWWm
	 ak57BIeAjMY5c6MvkBVHBL0I5eFyfPxlleFTct3OB4emIm1Yc1/FcrXBDsw+Tr+gySMah
	 vqgJlM4j/tnjLO5UjA/7zuTCoWFhorlVPQ5ArxebNxlT7agxwlSLEyoQ8/MUR+AMkqOUo
	 X5lWiVPXyOd5VUI4hZgml26zFCA6Is0Hb0FE22HauURhslJOinGwMC435X4OGVK7PhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BbG7j/UM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3C606A328
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbG7j/UM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7F91F008A6;
	Fri,  6 Nov 2026 04:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939634;
	bh=YTS91iW7fOe1dcxmvoeQpHCg8mKWyR0iL5CHwOYf50Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BbG7j/UMZ4/ti39ENx/JPnugesJR0r44Yn+GzWn4fXV2/SBPNW2ndAH0M3SN3krCZ
	 JaMwUmSGKqtLgoVVGDhiph+ZNzuGvQB+hOiB/UdX0iqeyOAUNuM1mscCguvoJvLzNG
	 44P1fh58J6mcYzWpw8fQJV4qwvR7ycFwnBq4gkzlEY2tDlzO9bryp+Zvz399Ckjikm
	 8I88+/1Ou9NYre8f2EavDxJ56Axza4HdXJmp/u4T1GWbogn5onCnWoSjpCxdbPQhRe
	 iYGQTlsJKJc5Lb6TRH0pamR+wydFkAD+edU752Uu6I13H2yrxBpyGW1RuVu9QdwQWq
	 LFfSzqoLJHtmg==
Message-ID: <sashiko-outbox-200733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/14] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to
 the logging options call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-2-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-2-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:33:53 +0000
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
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D2

