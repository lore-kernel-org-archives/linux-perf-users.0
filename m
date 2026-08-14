Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012482C9D
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669160; cv=none; b=kZxi3EtEZkUztg4chh3Ajk/XTLGMAnFohJbR2otRqSJU9rl0/0vVxMKA3Y+QLD2x22Eih9ekhzBi9pAIAZZCOCD42YKyGIv7Q5tSpzb5UEL+qq3DXim55e/5TUwJ5fbeW2eBljJBe7j21PNLH/dTqCy2IoYfVGPB9d7NN+dfN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669160; c=relaxed/simple;
	bh=lyXAfRPPwr7kO9YQcZNC3VDbt036+AvhCGbSjDggtTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RJ/a84taJgw5d1iSzq2wL/cyrRL0cJQiDem+PzifgWeTuyapFO34CVtSv4trk/waYeJeGYe1/x99v9bvH4X8Cf4sBeHRRUVJD2iJKsEUMEJmSOY532p8qAuAD9ioxXWci86H5me+dS892bLC9Gl3sMs+CGVPpfibb1X7DbyM41g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIvhwFE9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIvhwFE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F811F000E9;
	Fri, 14 Aug 2026 00:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786669158;
	bh=lyXAfRPPwr7kO9YQcZNC3VDbt036+AvhCGbSjDggtTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XIvhwFE9Xy608NPiMCS6lXsXgUWvimPRhqpjSJREGHdEc6CXGNoQc6ARS+zRqugcl
	 1HWCwF6OhmPTRzIwJSsQgle9ydMPvq2etKICWCc4CwnXrOAdj9f4Xss6LHLmHkdXTz
	 oRIKheNcVPTqoBttKsQgN60JTT5oCdvOydYu43QAFuIZUf1KQ9blxmpcy/AEajVlX6
	 OiHaZUs5APXSOrKLVSfQERZ7Rk/G91nVoMkAQ91G5yqr4xKzUFm6y/oj+C5jF6lH8p
	 ZtxIvFaIps4bc+hZcUtmLdA/7o0jKPUO/1KvY6Gs+OXVIqlQ6FTH7zIU+3wlDjRBJ5
	 OlnLCvvCdxnvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 15/33] perf kwork: Don't pass evsel with sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-16-irogers@google.com>
References: <20260413041143.1736055-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:59:12 +0000
Message-Id: <20260814005918.35F811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The sample contains the evsel and so it is unnecessary to pass the
> evsel as well. Remove the evsel from struct kwork_class.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D15

