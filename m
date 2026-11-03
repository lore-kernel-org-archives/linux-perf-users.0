Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738616;
	b=cU7/bU+yGI1GqOVCsKbQVNd6iX3rcC4V1Yimdo/OtBWDeiadH2SEF/bOxjcM9NXNjSoz
	 WMSDLyjUOx9yXaou8apvooHH1s1YKPZxZxQatPmMmcVXYxBAenfn6IvECdsPpZP5mhHh7
	 wtQs/oYKMQlwIYVK7WRnu/pIB+dxKy++tH+AGpH1xlCWv5ui05g5ZokNTxQLt0OLFk5vL
	 IX9M0IZk1RPCSrRyNNuZTcbJNR/83DOa5+OKZyiSOWYxT3xwOCFOHggoTgN+Kstq8+5rF
	 cbrRNnegQvAUkmf3a6HMudSxc2zPgl8CGbbL9IpOQNF1zIAWgrXvR6s4UrBfg+/9fcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738616;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CnHlXlCv8wuJHpDUdFRRqdXHdQWhukBgznb9q3OtANs=;
	b=o+xVPbFOWx55c3DIJ9GCaBwPqSGDONviXp3yp8EbUoR+e+NpK7d363NxvgbZAMrL/Z38
	 /fGUm/oCtFlvF9OE7lXOkXDpBVj6OjaX6RUbJPtnoNdooiSExPAUnPHEKi7nmL8YIrfpU
	 Bjoo59juUxz3YrDOQulS/b6c+36jLv/PAE32ffX1bBqSbaSx/YIwKUnuQRPrzXTZsfKPL
	 IMQVNhSJ19kxxToINex1ujNWs6La6iYc57PStPjoUX/m5RwPOJ9T4szmI5O6b8G53d93M
	 REc0zmGrUx8tKX+DWI8VFgnWp99HlNGfBlOEyG2sCV9DSVsca7Z9ZESnYMTcQ52/xgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIA8IO+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15730606A329
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIA8IO+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AED61F00A15;
	Tue,  3 Nov 2026 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738615;
	bh=CnHlXlCv8wuJHpDUdFRRqdXHdQWhukBgznb9q3OtANs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HIA8IO+Pi4GtupYnP3safCP5lqexsMyeff89im9CPoexCfSNeIgMekHRsFRj/7k8T
	 TcP8Ul3P+twCozS8PMc/DLi2b/DvKVoqLAZdFcJP9j0SsTx7to1pJvpVkAFlQJCRWV
	 r6Izx7u1MvYocK9vYQztPdXqjKKAdsKkd3qFAv9aO623sFYEZlU+WfCYibuyVkYbhJ
	 4tAVMvZ7iZ6ETC9WSVNcYkpHe/D3fdWeZHYyEwN1bmvNVWCZ9bJeZJmQhPSi+TFjzC
	 XjCnlcTWyBAE24rShSemlwO2NMkh+xju00qag4rb7+zeSwHdOPw5Knxkwzmzn/n//Y
	 /99/VEG1uX+1Q==
Message-ID: <sashiko-outbox-196006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/11] alpha/perf: clear PERF_HES_UPTODATE when an
 event starts counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-3-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-3-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:43:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
> then programs and enables the counter, but nothing clears the flag until
> the first alpha_pmu_start(). In that window alpha_pmu_stop() with
> PERF_EF_UPDATE skips the count update, because the flag claims the count
> is current. Since the next reload rewrites the counter, everything
> counted since the event was added is lost.
>=20
> perf_adjust_freq_unthr_events() does this on the first tick
> after an event in frequency mode is scheduled in, which is the default
> for perf record, and it then sees no count to adjust the period with.
>=20
> Clear the flag where the event starts counting. alpha_pmu_add() cannot
> do it, since the event is not programmed until the PMU is enabled, and
> stopping it before then must not read the counter.
>=20
> Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D3

