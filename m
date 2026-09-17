Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA4340283
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622206; cv=none; b=uOknyrXKbhRuaAhMxVNoayZ0vlupM0NGxxJTX3FzoqkU/H7cUpldUDwh02VcPFVBYEmi/LK9z8eeDiUz2Zr4odxHjF6tcpbpxwSWAnUyB/Y/d9SUV/HHGBeWGYBLvT+5ONB5Evt2XFdBWNGWxQIck+E0E5si5rixokgdjViTf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622206; c=relaxed/simple;
	bh=u5XAIp9GbzSg72s3jcirPWkkyLgUBivf9e3pZbYFokk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gd8ERpBcOOsngdCZ+hEZNLp7ow6yNBivpfIdvQN10i4uvaEqEuYNkky9wW/tLzTBKV1bKUzxRa2Ydpzy59qyqMxUDrOuPB2cduUVQMToBwL+Ku1MARXNrPTTvpXzfZPPlHnfkiWDk/MWB1ytQqIM47JCPtyacywPHAa5Bmppyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ9VLVbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ9VLVbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5341F000FF;
	Thu, 17 Sep 2026 05:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622205;
	bh=u5XAIp9GbzSg72s3jcirPWkkyLgUBivf9e3pZbYFokk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZ9VLVbWTVhZtCAKNasLGoA55LmUOotGBKheldhDVgtWRvw6avpLksoiQvKd8IZiB
	 vGibqoWjrHqq9JRFQw4aqSk101k1PoEw7/DL3zJlCuTOr2KGWu7HA8chu3TpHdFyyW
	 VBVNKK+bRHKPr0a9tlY5/jPdNkLFJmmOvPIzDpvmaddiPv2p3zdQfP25mvq/riWai2
	 HY7qTKYEP7MWT38XF+k5Yrs019kN3UpU4Pps54EFaxw9oKo0nr1QFOHTsdQ76jWcmg
	 rZPZjtb+vzz9hCf7H2kW3EFvSD2pioQxVsdXViiVFfJdEvEY5Iv2seco5xkrtu8z/L
	 avyiMYoFnZrMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] perf tools: Expose opt-in --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050708.704702-4-irogers@google.com>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:16:44 +0000
Message-Id: <20260917051645.4F5341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add --hybrid-merge to perf report and perf top. It merges the events a
> wildcard expanded to across the core PMUs, and their histograms, so
> that a symbol which ran on more than one kind of core is reported once
> with the total rather than once per PMU.
>=20
> evlist__merge_hybrid() links the events and evlist__merge_hists_hybrid()
> links the histograms. There is nothing to merge on a machine with a
> single core PMU, or when the events didn't come from a wildcard, so
> warn in that case rather than quietly producing an unmerged report.
>=20
> Merging collapses the per-PMU entries into one set, which doesn't
> combine with the per-level breakdown of --hierarchy, so asking for both
> is an error.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050708.7047=
02-1-irogers@google.com?part=3D3

