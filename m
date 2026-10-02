Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A347DD6E
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937002; cv=none; b=as/taSib2NRwWz5dAnCJlJUzX1sEnFkMtvdXjTTLG7yKZTNY227KeJWdwnfF1qw2Ah2ZLJEQAedvRzMh8TKo5cy6AdjObexor9bCmM3VyP/9FMjdZsAeTB+RUryRSSWv31u2cjpHQg2lvtts4XDEpS9A16P2iTpDV1z2c2MFetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937002; c=relaxed/simple;
	bh=sRbpjdRaqRCYHbw49CUcQazI/wWt6O4g2fLtaOUw2ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fJtCVc3xmyt5UGXbkVS5Eg3rGQWcf6rJcQzPcs6Elx6+gfiahso9xT7wwQURr3w5fh5pOmz59QH8EjZrQAlqRwS+sirgkHERrQnYisHNQnxhJmvHaktlvVmrpqBlbCIkpoHIgLxL5f+i74jymQAnywvR3r0IRF6AwJ+7XRtjwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH1v20xE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH1v20xE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55431F000FF;
	Fri,  2 Oct 2026 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937000;
	bh=PtgFv+l9q/quDVU/DZ2krZsk/ceMsD5gpRN6TkyVcu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RH1v20xEPDr4JMfma+5EEpC91/fKMpTUvII6wDgANTgv6ZaQD3ppuT45TfjA6aRFU
	 Bg6WS+17w7pksXn++8bGyRfR1zcBBUJZOHZ48bie2W3U0MAeWlAsX6PsJ5CnmNxSNH
	 SAeclp1Iny3s9fGqolCwmj/hysxpJnfI6fssfdJQD/OoaAcM5F/Onxw9JI0t71lvTF
	 w/reR2sC8B3Aeay9I6XTJc6W8xGrgsdY7B9VrEbqtNbFuM+OZ9qn1TfEoNDZcuoj0A
	 aYwGRMSogmaSgzu5HvHIpsveGNgYT/YivuEN48ONT4k7KdTmvDwrTYX8RD8G8s4xHK
	 yNtZlukd9gA9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/9] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002102110.27587-8-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
 <20261002102110.27587-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:30:00 +0000
Message-Id: <20261002103000.A55431F000FF@smtp.kernel.org>
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
> after setup_browser() installed the ones of the browser in use.
>=20
> The phases are still counted, nothing is shown for them, and no second
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102110.2758=
7-1-acme@kernel.org?part=3D7

