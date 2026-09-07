Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B853F1046;
	Mon,  7 Sep 2026 03:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753511; cv=none; b=axZSxpZpovjPeLKKSoceHgqXoICvaeW395GT06aqYw8GqRvMtbC5XHTlv2vRoZ9TqMLL5s8vA0PCxWvWQorhSH6HkQDYGi8QWXs1zgVjRNjQ5kMbbsFHhluImB+OgugiJtL+Z1LMbGbNvXO3PTVKRLP+XUWiYcnT4lNi01joWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753511; c=relaxed/simple;
	bh=iySOZ+8A4IfM0egDwFe55Y8FzWRSFcSqnFbzMfRyN1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ecCqbE08TGRQFb3mQtmsVSApzvfEKMHvcwCkDyvvo/ysqNhlwVA3hSfMYuHHo4J46CsGajpjtN/XIIZvE3m3JZigUR5T8TXiTbb2TUxIPZ8pZcPHRfCtlUPlTlhWiy96RafSHzTsMpWUXrqeOcuoznIzi5w8O1Kf7N/EoW461Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsBqrAHK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsBqrAHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79E51F00A3A;
	Mon,  7 Sep 2026 03:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753509;
	bh=iySOZ+8A4IfM0egDwFe55Y8FzWRSFcSqnFbzMfRyN1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OsBqrAHKcsyLc3pqKm8UkKz0FeRBjC3RLfiBq99HzaEes4hhwhqMy7LKvQo3wFryM
	 XlYwXAuOyF2flY11agV2YDfCLrvV6Fq9YLsSI8DAoP6jp+IJc+Q9f7PVn5KvDRS2fL
	 MYk5FpVjGGhRhDSi2ju0BXCVrfCwBCUbi9UTCOtDO7bN5dt1SuXm7ewto0T+Dhi48o
	 GvllZOBUwB5zkV0tIZWI1OVavcgLhkPa6QqdcQesUYf2Ck9+4LQM9RYZ1OKewhO1b+
	 A1szvK4/T9Jgu2zW7iXE5otnWuhQEiRCel0IdAK+lulzVTPOdfimJk36G+v4Lc35dR
	 SxlNQxVrch9pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 08/12] selftests: tracing: Add syntax testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178875286830.93794.14966404625232529162.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875286830.93794.14966404625232529162.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 03:58:28 +0000
Message-Id: <20260907035828.C79E51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
> of the watch probe events.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D8

