Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314E47141E
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937008; cv=none; b=tgkg2JtsAVSxOb4d+DJE3xBVKBPokB4+gQ/nCqiCDLpJVh/4MzexnsLDv+hkKIjZtKAQgOz+Qjaw+/upB2Y4rNrluhiD9xdbVI+fPwa6dccNcOdaEsq9ZzEXx7kBGpImEWKIR+pf7F9/bviKOrrnRCCpeWCunxeh2G3kS2SNtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937008; c=relaxed/simple;
	bh=pSSXrn6e3y1aABVKv/ocLLnuRHU45mr68ZoB32y+rd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LbT7jBT6z0HLJHsS1JshVsCbM4t4xqsaIJ8c8ApltTfe+9/Mw/u4bdbP0T+h2U9CRrQWzyfPOp/uM9u0ZMhqRMdPmcCAhaDIcOqHT5XszrDxIZFlqxHPpAv49m+BbOetxtZy2vzSw1zOntQVy/RW9oyOIzSLgcYddCe1gQobMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt3FYk7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt3FYk7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED011F000FF;
	Fri,  2 Oct 2026 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937006;
	bh=3nUC2pnwo5Wi/EHX0vknZibBpMDLz6dsjnsiSaYhnhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vt3FYk7ZpzOHYDck91Q0aT5TAN5BWAs/uJbCp642MNNQnPN0ir5ayEmw/QLh1v25r
	 UFHKBwqozR1vxJUmmpp8J27STDMnKSD1zsTqvSZP/hjcInVkC+OD/Jic2CveOvijO4
	 VYWFVbI0mCTwZ4Xq6B9eFNIX7KizSs4kaPhlhUH6fjOJ9Ry5C/YTub5FwwjUTQwTRO
	 WMZnC/dt/f5VlPSpK1hsrvqjrddy/48Igcnkixg6Pqb0AqF7Cslz8iNPmanJx8RsYV
	 RYMNjswfQCP/xiM3McO6bi/d/narLHK6LXthG/8ak6K+BUlgLFFvYEvzCyjZddekaO
	 7+F71q24I0YqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/9] perf config: Make perf_etc_perfconfig() never
 return NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002102110.27587-3-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
 <20261002102110.27587-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:30:05 +0000
Message-Id: <20261002103006.4ED011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> perf_etc_perfconfig() returns what system_path() gives, and that
> allocates, so on failure every caller dereferenced NULL, the
> pre-existing ones in perf_config_set__init() and in the daemon
> included.  For the usual absolute ETC_PERFCONFIG system_path() just
> returns a strdup of it, so use ETC_PERFCONFIG itself when that fails.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102110.2758=
7-1-acme@kernel.org?part=3D2

