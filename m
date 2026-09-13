Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232438236F
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270455; cv=none; b=K42mRkUoF1PveS00AlJ7YEZAhxGnrSZCY2ATVr2E00pF94EEQP/f3W0ONOgZLU5XeK+z8D7D1o+kYY+0B7yZYzzA+THKUz+XGAEbKhH4MPgorL85g0T4ALLK4zvdlbhw60zSrmobxUVA4GHqFs0dtUg68UK3vqdBpdmT+zvgGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270455; c=relaxed/simple;
	bh=hCzDxsJgH1kGbGCRNC+Y9fEzEqHofFIWIN6Ue1EW25U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CeOEBVUwC7Bc9pObiV3knk4Nr555dM94Vbczv1yW56wwuZCYpm43SpKEHr2VNJkmZkSH+1acb7mJwrXUu8k5kI5S1lbBMY8WmPkgk6N6Z45KRDbAdbO5dcPkrwDLJMhdDehwUQK/zhRRmlghqeyQhy6R1bDH7Y8HjFx09acJjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7r8eu5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7r8eu5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115481F000FF;
	Sun, 13 Sep 2026 03:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270454;
	bh=hCzDxsJgH1kGbGCRNC+Y9fEzEqHofFIWIN6Ue1EW25U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7r8eu5KijDzkJZMBsHD2YVu7StBkoovG9Qc3haOc3oofYpu6IxjHDNftTNVH5SQ2
	 Ktx9fA/Ol+ZuqnqJp5dN5jM9isEHUnao24XBLrVIK+5MZxPP8qJOjgsL3bitO13zeV
	 p3+lIKydATTnX3x6Q47JIy+prYXsvwqKsvVNp97lmSCOAFPWdsXqSvAoy07cxavtCj
	 YSL+hTa/mh0P0ho/9WHyRDXxELb5ddL2Tpy2Dq13ss9D66T1keIGGhEoRlx2PbauOC
	 rOlrGNRM82IvL7LCafTe5wYlTzaMQp9KcK/Rx1xXnXGs47ged3oxsr8q0t04a66TU3
	 UjBu2W+h4AVvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913032632.116277-5-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
 <20260913032632.116277-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:34:13 +0000
Message-Id: <20260913033414.115481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data-type browser has a samples view, selected with -n (or with
> annotate.show_nr_samples), in which browser__write_overhead() prints a
> local nr_samples variable that is initialized to zero and never
> updated, so every member is listed as having no samples while the
> period and percent columns for the same entry are filled in.
>=20
> Print the histogram entry's own count instead.
>=20
> This predates the load/store counter split, so fix it ahead of that
> patch: the split then only has to adapt a line that is already correct,
> and this fix can be picked on its own.
>=20
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_da=
ta_tui()")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913032632.1162=
77-1-acme@kernel.org?part=3D4

