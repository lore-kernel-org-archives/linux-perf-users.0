Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C219E839;
	Fri, 14 Aug 2026 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786667979; cv=none; b=Qr8Nk5gVbsaNT7+z4c40uB5I2wvlOjsqAtwPbaUs/ABj1XTlLR4tpamcjseRJaK1mf0vlIUUToSPH5F6J2vb5lhMIYvocFPLaoeewfLPLiTmCmoX8rhLOyaxP9XlRMpSL9DBly4bK2rnwULnn33naMWLLloTbTc1TRcmMELRmHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786667979; c=relaxed/simple;
	bh=E1CeHb/K8TdqTA+QSdD70uA5NpDglfZYBTNORKcpvx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+JEscqSmMXB6s269zEzDlJOwSN/P5/gIexaYJitOl8LmSN39v3W4B2ukKQZkz42+6IN4uibqJZhAwB6KZi39NfRJY9z/5GtwGYzvtLp+DVTtHC1KPe2r9TCuz1fbjqGRIQNvJkhhWfxzc/wOS0/mSgwuQzmxRFYIsLSoxp90QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB7iZJNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB7iZJNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135831F000E9;
	Fri, 14 Aug 2026 00:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786667978;
	bh=E1CeHb/K8TdqTA+QSdD70uA5NpDglfZYBTNORKcpvx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gB7iZJNXc1D9j+5GDGLhpEj6O4TEa11+dBMDBGaKyTLk1QnlH+fabFQs2IUDUbNVi
	 7c2kbIu05e1NgagQ5rw9wsbUWYWNwqgp+AYbQ+ahgRwqPFfhD5jq2rgXaywosw4w4n
	 w7ZPqMpuMnw/ySB9NNAJpE5SwnQN2LX8A7FaTj8HsV+OmVIYKXkNuhpi/xHXnOcnMX
	 tilPrqhn5G1iIzwscDTfFRpsvn+QERh7PskNlozeQJkR1i/rJhmwM3sv6RLqRHSd06
	 Qzu/esgm1w1IZ4AP77pR8ofZhu/qo3i7RjnI/mLbKKsEhOh0mDWZdaQcl4SASDyXU3
	 fuypMUibADK4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] tracefs: make root directory world-traversable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anubhav Shelat" <ashelat@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260423151746.16258-4-ashelat@redhat.com>
References: <20260423151746.16258-4-ashelat@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:39:37 +0000
Message-Id: <20260814003938.135831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Change the default tracefs mount mode from 0700 to 0755. This allows
> unprivileged users to access the eventfs directories underneath which
> already use 0755.
>=20
> This does not expose any tracing data since access to the files
> themselves is controlled by individual permissions.
>=20
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423151746.1625=
8-1-ashelat@redhat.com?part=3D3

