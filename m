Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98072389453
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562568; cv=none; b=Nq0eIlWt3Y3d/Ctzjgssek1hub3nqq+pcAOAmh3k9p3dTAV7Eg3NmiVRVD7xvCDR8AD4cAqcYt4sECcIvqlYjHE5SnPOpvpBBguMhIv3t9QpdpGHD0r0pK4cru5x+gKAY3zyITOqM9xHgCBtwBT3lQaLkjir0nvyTjwT1c3h12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562568; c=relaxed/simple;
	bh=QkFWgDbskrGtOYriOCvT7y7lYhohCltnCtHN/4gurf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZ5+fCFZi6G1ghz1dirTrMHWgn5e4nX7p+C5B+SwYsl87BJlecLq5us0jqBZ3DHkZ64fz5tbFlSQ+yqou4Y62Vs44EQv5bB029WKyWMbOd6LzoXFJKq6cm9M4ZUPTEgqLMO13uA2N2E9vtL4Q10GUQU0bmAc+cPUN2llkLQmn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHiOCUT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHiOCUT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4E21F000E9;
	Mon, 24 Aug 2026 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787562567;
	bh=+7xR3OdT9NHp5cXwmeAH45nQiyOIfNScdG4KEJM2u+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHiOCUT5hXLcjzQALVEzu39FzJxQR2yptd9sGo4arKdtn+ScYaotbfQw7EPo+E8L3
	 ejjvw3VGRIvgaSAa49zNnbXMPmK9DK4zGMuVGMKlHbhAG+fBUtZgTOyvDbtIoOmkju
	 8XRvIdiBNGsIl8/K7Xh4GO8rq/nJgabbPLK7M764P6rm174aFUHWa+XLRqws8cCx8t
	 Oue5Y0V5XUxSjR+GfpSESRr7q2xjqou50quRDrR3NdrLDtkLjX7m3jf8O4NN6S7quD
	 ODA9QwpiMjoSe8yQ0o2Kb6gcKka82FhtlM7nuJMSOdHf0uodSUJxFFB337IarWhC1h
	 CvcVug9n1NNcQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 20/23] perf/x86/intel: Support arch-PEBS
 based SIMD/eGPRs sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-21-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-21-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:09:26 +0000
Message-Id: <20260824090927.4D4E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Support arch-PEBS based SIMD/eGPRs/SSP registers sampling.
>=20
> Arch-PEBS supports sampling all of these registers. SIMD and eGPR
> registers are placed into the XSAVE-Enabled Registers (XER) group with
> the layout described below.
>=20
> Field Name 	Registers Used 			Size
>=20
> XSTATE_BV	XINUSE for groups		8 B
> Reserved 	Reserved 			8 B
> SSER 		XMM0-XMM15 			16 regs * 16 B =3D 256 B
> YMMHIR 		Upper 128 bits of YMM0-YMM15 	16 regs * 16 B =3D 256 B
> EGPR 		R16-R31 			16 regs *  8 B =3D 128 B
> OPMASKR 	K0-K7 				 8 regs *  8 B =3D 64 B
> ZMMHIR 		Upper 256 bits of ZMM0-ZMM15 	16 regs * 32 B =3D 512 B
> [ ... ]
>=20
> Arch-PEBS based SIMD/eGPRs sampling will be enabled in a subsequent
> patch that sets PERF_PMU_CAP_SIMD_REGS.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D20

