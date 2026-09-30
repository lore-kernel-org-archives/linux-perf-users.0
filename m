Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615C4CDDF8
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805485; cv=none; b=d0r0qi8SkZZz7403piKRBazP069k/zGgtHBgZRjkCo4AdmF8k9k/lHr94hdvDqr2UQDQci4tPpW0TCwZ2A3BBBZ3YvlImJzHlgdD7XfXQLz2TAs8xk3K18k1jj29VK7V8cLomWW+u3UX0WScd85MD6CmP/ZdW0+5nfGxRkl6U08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805485; c=relaxed/simple;
	bh=2Ntyrb6+DD3kuW3/pW9U/zed6xk+u4NTq8jpKbGsYco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E8UHyY9bGpMLFV0g/HIocf9AuIZ4cEVCOT70rcUDv+4/SMBI9hTdfckBuBJ92Ol9T8Izf6ISlNU1uzyB8KbT8pVtLqlz95rdwLW9cyKWg1V9s5PcS/rpLo1AEPf8QcAyTEDU+mIq7OGp0/8rgxVZ/SgiHqK/9FGPEtkxwzOB3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKUg3Io9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKUg3Io9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E21F000FF;
	Wed, 30 Sep 2026 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805484;
	bh=3vJs7HPge0g12EiTWB5t70iNF1Gxq8ACCNReV14eVA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EKUg3Io9PkTSGdcxFqywZQESlX9H3Tt+wFsXfl7ic6LQnLv1npfBuzC92ywAVUIxK
	 wabtP+5auZjrniA9roUj2XfQ1u7l11Egt7OFUbyIfQjB5wEzrwpoBxYHEuSvkw0ihz
	 Iq/8/FOhXFrul2/UTjtWkcErJtAWpMcpAC71NbLFRAvjhN8v1T96gaYyDFFkZrmqv7
	 DuwGbRPSesZkOpD7d2pdVoo+P4AcxlboDN86ErVYT+PwoqJ2ktgdbeBuzA5cBswHRF
	 fTi7wDR4BwafV9tgppBhw9ZC8lVImcrhRsVJGsHaz/p8eI7OMD5dQbHl3+brMUQEtZ
	 mraGwie420Sgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930213716.2633750-4-acme@kernel.org>
References: <20260930213716.2633750-1-acme@kernel.org>
 <20260930213716.2633750-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:58:03 +0000
Message-Id: <20260930215803.F38E21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Now that --progress is being added for the stdio case, wire up its
> counterpart for the browsers: the TUI and GTK ones present progress of
> their own and there is no way to turn it off.  Install the no-op
> ui_progress ops, the ones already used until a backend sets theirs,
> after setup_browser() installed the ones of the browser in use.  The
> phases are still counted, nothing is shown for them, and no second
> option is needed for it: parse-options provides --no-progress as the
> negation of --progress, report.progress_set saying that it was asked
> for, report.progress being false both when nothing was asked for and
> when --no-progress was.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930213716.2633=
750-1-acme@kernel.org?part=3D3

