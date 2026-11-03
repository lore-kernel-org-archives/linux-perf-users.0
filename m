Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675049;
	b=hJs7PPmShu6QMRXC4mfUxsxXoEkB1J6NSNU1oE3qVPCcl2RDEeEW65KxIBkwiabXMW2G
	 zsgUMbSXTxA9TfYA46fEgmqB75fRAlPOE1yDvxxS8zthruxA/MVc0w7M4XFSm/h1Mj3ah
	 8hhuiLLy4raucZkMZN9JKIDc0fMxkqJEDd4v0jl5safSmRqlenmuPT4TttLwpsqyqk8vc
	 RakE0mkVJLdgXsM+CA5y/7j55kdGl2dq0KHRZaHGP7NUH9qPJJT8dofs3G0/MB8bFDDVQ
	 PoiaY5cJHNriR/RtZsmGQOROUyLi/PzgYk0Mr90UBA+sS7+tHosKXtfVAgvIo01w5Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sz2r5859H8JpJLBBFC/xR8qe0jmmBmEweycKgYHeVm8=;
	b=gKxBS7NrZGr87yGyuHY5rltJAQOFoASMtM7Fc2XDqLRdjkfnDaHJp/Xmz/zaKFZqoQAs
	 bpVZfi5kDoW6kQrMfLQWY6ODAx4mbojO/8OsHHfCPCUR/OkQvbvic5EeJof+bYkQrCb81
	 Zp/gIBUvrMMMmaP1NuWjiVknE7E3xWwlXo2P83rc9JbngsMNkrTNfvmCKpLQW0uoV+9Rr
	 nWGzaSrnwaVptbVnoRustGhd4jF9OI+3q+urhuoROmMfGSd57WEbG92WRJrGtyy0aeLtg
	 +mj8ypiCOnTwXNk/t3ZhoUJ+U1Aba9Qm8eEDurtaIc3rEAWgvUIuK7T4BHZK/8SnzVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPaACJd6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE0606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPaACJd6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037C81F00919;
	Tue,  3 Nov 2026 03:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675049;
	bh=Sz2r5859H8JpJLBBFC/xR8qe0jmmBmEweycKgYHeVm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nPaACJd6R27/U7MopXOGkt7vmjIxjfJMETm6t3SoLK2A7aPa9gatTFeMcWGPzaGt0
	 TH2L8pQgFIJUTul/DrPhu7nRchGFc3MmEQDXF4f3JeanYF1hZTClvrcxL4Kis4ic2X
	 YYSgLuvWMTbRyyr/g4+VXnT4MpBczeDxUOgzq/ZqBlZCbRK6h5Abyomq/ey2w0t+id
	 KHvWnNO7fcFk3e/VQsDN73NOuy+Yy4RyffrBf3c3m7mPujK0tAFXNFRUvB353enaIq
	 6Wl25MUJlpIb3opPpKFDvO7PIo6yU8XYgLNogfYAUoXUnSsk0A07Q7TYI3+O9Sg02f
	 TdwObl9Ixln0w==
Message-ID: <sashiko-outbox-194489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
 logging options call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-alpha-profileme-v4-1-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
 <20261102-alpha-profileme-v4-1-61e00f5e1da8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:04:08 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-alpha-prof=
ileme-v4-0-61e00f5e1da8@gmail.com?part=3D1

