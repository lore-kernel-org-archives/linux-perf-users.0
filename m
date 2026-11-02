Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654312;
	b=I20DWN1WbtdmVzZ/gDrkcc87SWXy5YgNMPWbuly0iuMMZly1CnwUffk166GN1TyAx/n3
	 gnRICYGfpteppQ9tKTfvZ85/TrLq1+aeqqC2r1rkUUK+C8j+ln+ZgGFcb2Mpa5pCUbZ+L
	 LczXd/0sUfSNBicqB1D42YRicVegbzY7IR96rr+dCoX722YZdH/AP4c1g1V4YEub5DZIY
	 F+yZPAnO81RzFPRVUDZUxhNr3Y7qxbWqlXYLgFiLgsLs8vYMP95JJCJeMymnqMusle140
	 6NjcdgCUxyErYiIzkPkc7TS/kPPPbiJw0npz/Kgpo9lkCJtxdl/IUZz98GQpb1oylbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654312;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nNA7+aq8FTLWDmN2RO20dTYuNEoXh0YziQThanrGUAQ=;
	b=WIf/Hr8EPH1zP7ZCx3t/HYNb1XBj17nWzPckEOD0AORtVML9K3+KHp+AlT+iIJiQFaEQ
	 N8edhl35Xzu22Oxd/Pip1gmlmrtYKNVasrqYtmdPz9uc+q2BEyKbzAzUrqDcDMSMdXvwe
	 O5L3EPwT27m5IdgNN05uN5Qto6BtqoWXjTBObbePJ8gIEY7oIBw4LH5MG96yxic4TchtB
	 5zFdlMjv6wVbu1TrNpzXm3gNR5oHfYw9R7abZZLOWkXv+V8ericC+4zwEopho1D45Pgtd
	 O4jVuHkzMIR+Gtyvp9oGyOWgW7u1/p9ymdzaC6McMZBi5BIxcxz7rEBpoLx2Sherz7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuunQuwY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADA606A32C
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuunQuwY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A151F00A17;
	Mon,  2 Nov 2026 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654311;
	bh=nNA7+aq8FTLWDmN2RO20dTYuNEoXh0YziQThanrGUAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kuunQuwYKEhM/1l7Wu0otUjkBk5CjmyQhDIi/Zmtms0hfxOaZT7oIgblIGX9ArfVU
	 P8M2P6+enU5mhTe9q408mGUaZB19WbnwLLrqf9hIIMLl8UqOn6+RJwiITPBJYnBoy3
	 xa+9KPradC9wYyJTeLneMtsPAkEU3eGRBW+PWPR/RiAXp66gZw/YlTKKXYKAjx2kbY
	 tdraoUdjDqy4Nu2tbavbhzTtcu5ghMjHUuw6I0kWXH0sDZq0K/TtpgrzbAzgaXnsI8
	 fTrq9y3DZ5530CjSGLz1vHV6s5ri8Me6Loopgaht6Q0AU/czJ5WuS0yN18jwa/iKiE
	 XyESOL2N/PpiQ==
Message-ID: <sashiko-outbox-194188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf jevents: add amd specific device table
 entry metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jacob Lefkowitz" <jlefkowi@akamai.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-perf-tools-next-v2-2-4d237f886710@akamai.com>
References: <20261102-perf-tools-next-v2-0-4d237f886710@akamai.com>
 <20261102-perf-tools-next-v2-2-4d237f886710@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:18:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Jacob Lefkowitz <jlefkowi@akamai.com>
>=20
> Adds AMD specific device table entry metrics to perf jevents.
> These metrics are only allowed on Zen 2+ processors and are
> implemented using the 'amd_iommu' PMU events.
>=20
> The list of metrics added are:
> - lpm_iommu_dte_miss_rate
> - lpm_iommu_dte_lookups
>=20
> The metrics were tested with the standard 'sleep' workload:
>=20
> perf stat -M iommudte --per-socket --metric-only -j -a -- sleep 10
> {"socket" : "S0", "counters" : 8,
> "lookups/s  lpm_iommu_dte_lookups" : "4117.3",
> "%  lpm_iommu_dte_miss_rate" : "0.0"}
> {"socket" : "S1", "counters" : 0,
> "lookups/s  lpm_iommu_dte_lookups" : "none",
> "%  lpm_iommu_dte_miss_rate" : "none"}
>=20
> Signed-off-by: Jacob Lefkowitz <jlefkowi@akamai.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-perf-tools=
-next-v2-0-4d237f886710@akamai.com?part=3D2

