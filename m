Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07054DAFE
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178204; cv=none; b=CzVlbv4iTsbrhy4NsBZkqbldiVXd7ZlJIRpGXjhrj3fT731E7r09zHHutjRREq7HmF+zsuips/pdyZqJtVGaC7ZL1vVoepg8BdkRLLylWY/B7BbUWQ5QA99xciN3CGLKDaAXZF8Cywzfb5WHCPMzpUbivt7G3l7OGu5HAHSieQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178204; c=relaxed/simple;
	bh=NPEasyRYDePZUO6MZjS+Q/VJmPKRLx8wiUa+LOEreRk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TkDVChEXga/zAhs8URotodJ+Pqzg3rX7gMp02qkODunK+GCGZ41BKDBGVusnUquawfLVtGnozfVaglRX4n2/Frd5DbuqNOS0cfoJL35H1TkEiraU2mM9PZC5ke9eEnb74f5i5nfc80aAszPZOBXBefVqN6BFclG8+aUZmBS9iEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icGC3eVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icGC3eVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1481F000FF;
	Wed, 23 Sep 2026 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790178203;
	bh=NPEasyRYDePZUO6MZjS+Q/VJmPKRLx8wiUa+LOEreRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=icGC3eVOOyHbZ5Em14r4QxPoyFv5pC0HMMJNmL81Gn1k6esQgJXFIsSLmDauvU9QY
	 yAGBz0xTq8je1wKrjAWwV/ZJQtt0FOiLUxW0+gcrnFEuRuEy4dZr4LsKpOGdivKwT2
	 AeXMpSN4o+B68l2P6Oi3L2YH2ge+5qXMviSK92coGmVDDlPgtK/OooDYAU7741GuEb
	 ErIJ0ORWniE8SLQCWyHchQNnqbMpSjC5LDHR9bIbF9pfTe4ZJFJlMr5rQllTtBR+fu
	 2MdCkNWmykAojobsTR1LmZr20GKc1t+fvePWJ5Qp+JoO6D2mL7+9EnnCG5/ZdecAgr
	 L/NTbj+nmx1WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/14] perf intel-pt: Preserve return addresses for
 asynchronous branches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-2-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-2-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:43:22 +0000
Message-Id: <20260923154322.ED1481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Intel PT uses a zero instruction length for asynchronous branches so
> the thread stack resumes at the source IP. A dlfilter can fetch the
> instruction before call/return processing and replace that zero with
> its opcode length, advancing the saved return address.
>=20
> Set sample.ret_addr to sample.ip for asynchronous branch samples so
> instruction fetching cannot change the return address. This also
> covers asynchronous trace-end samples and VM exits.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D2

