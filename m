Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCB3ACA7E
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464267; cv=none; b=lqL6lKOTHbFYvDOsc8+qRbD1/pUcUHaxm3cQiab91g6Fs3W2F+E7VI57HRRZU0pTPnizVauw6034Q4Dx/Xrn8egnDaU7YZ6DphJ00oLthEpA09Q7uCwMXH5ClyKBvnWMWTWhO2AchBjRz73KkRwL8tTLwEf0NNycPkt1pVwmeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464267; c=relaxed/simple;
	bh=Ec12pYvXh3KcU6B6Gr2ZqHgvl3VBrWGDMrDmOvLl2jM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yam6cMMWzpTGiIcQPQlkK+LM5yGh7Owl+ARcPLrIlwExavrccfwXhQatGxOueWlSZSG/2yEa+e6VVsIyOZb/eqrH3TBACVfNHi4FRbEoHL/jFMxemStBAt9g3/bFrWQKcfuL96zBR8Mj1NGT42HFJ13rKzQOO+PTDdM1NhBeBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi30+f4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi30+f4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84D71F000FF;
	Tue, 15 Sep 2026 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789464266;
	bh=Ec12pYvXh3KcU6B6Gr2ZqHgvl3VBrWGDMrDmOvLl2jM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mi30+f4SjXrvVERbtX7UOjfO0pLF9G99iJVpaJv1rOK5YRseCg2YHZ26Mg95wpZUj
	 OFkVP9kb8NmXTDZSIsEG/YquxXbam+a4x770SzJYb3VLphTMJqPE3gPH2SPP+4KCHz
	 GesEncy4HObVPUWi5JjVcByj/XE3p9MF8N0fZMsM6o5nG9EiVxH3Dleb4jglq0TQuU
	 cqNvW4Hkqc8adN/A+p8NDrBQ/D5PypKTRfEvtkyLgWcldPP2H6365GWrkx6UjzuyFO
	 2bFJljyREhUZc5AItZXk3mzwAcqVuMg0kYygXnSRvNQYCdF/Ll+9jnrgoVuPLED3ZF
	 WBGHxHaI8QSrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf alsr: Add missing SIMD handling in
 aslr_tool__process_sample()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
References: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 09:24:24 +0000
Message-Id: <20260915092425.D84D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently the SIMD register sampling is supported, but the corresponding
> handling is missed in aslr_tool__process_sample(). This can break parsing
> of the sample record.
>=20
> Add the missing SIMD register handling in aslr_tool__process_sample().
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915091112.3333=
08-1-dapeng1.mi@linux.intel.com?part=3D1

