Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CC3BB9EB
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009712; cv=none; b=gsg3PrjT1YwDa6nB49HoVAypRM1XlqYgfvMZ1yo9Dfwcb/tUyg5wQb8Qu2CZtURIhxSQBzDxmfHa0tk0DgqVTvGQLmM+Gr3x4pnKiak5JdqLdZ0PMuFiUPhmdRzbhUYRk2spzDrCkr1DiRFijQoegG750oOPbQqeDijCvs3MY1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009712; c=relaxed/simple;
	bh=5211T3fHt1ane39NdeP3YyMgR4i2BDv8JI3WZHsQxew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jZ3Cqduj9HAJe+yHh5PPgD39gGFnhV4je39jmwwc303hj6PKmd7y19OeHV/0VNrUkingKpCJQgB5wWxRQM4GjDZCBI+ewj5kk1LECuXxJydbUgeGLFldbAUWbYeJTdw2lppP4YQRPIVUt+4qVCfCCyDH9KZoSecZenxUJ7Noo7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5p/W/em; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5p/W/em"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDD71F000FF;
	Mon, 21 Sep 2026 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009710;
	bh=3TPqaWRqDMIo9SYwnDELt8nJXPGMG6rfpCQErJcPf7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5p/W/emmoeuQkIEXYvMtAPpXBw9MC8Az9yd80f1tntxe3pBIleZm5DvWC9IWw0Y0
	 akGKOe8pKctMAcJxSauux+gf+8kDcF5JlcHdLN36evwTd8E59+Uqx/8tLLuU9CL7vD
	 I9w4whTTEPW6jBot7Nkkeb3pH3AKdjJ4AGw52vwlFmN1No6Rl8Cr04vMY7DM6xQVxD
	 iDf/n/JU08nXtYiuSlRc4YvqdeZXPOtSsDcPsK2aZimyRHXjdhMu/Yta5XCC0hWl0p
	 iuG1veFpjUhF6EDTTGO9saN+GTP4z3gRqWCgPPJTkR92RAyYyv+4y9dmBB8XE3c33z
	 kfZx3ss2OFLLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921164813.6727-6-acme@kernel.org>
References: <20260921164813.6727-1-acme@kernel.org>
 <20260921164813.6727-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:55:09 +0000
Message-Id: <20260921165510.4FDD71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The samples view (-n, annotate.show_nr_samples) prints a local
> nr_samples variable that is initialized to zero and never updated, so
> every member is listed as having no samples while the period and percent
> columns for the same entry are filled in.  Print the histogram entry's
> own count instead.
>=20
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_da=
ta_tui()")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164813.6727=
-1-acme@kernel.org?part=3D5

