Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7DD3F1040
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542269; cv=none; b=pP6imtiA4miPTo6nTF5Iip3jpZNB6e2kuCu+KN//LNUHeD8N0ve09LSbtytCq4K5OHWPNPCL91oF1njq8VLKwBHhicHfm50A6PZ6JcmZLk9ihD+92afGGGRDOFJBCsQxQ6jtDD1kyTU7MxpnaGIzS7Xaz4q3y7unVQGp8JH/Knw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542269; c=relaxed/simple;
	bh=RY7iqQrKTcuhKb0mFYIU0rEpsRQRJQXXgIgLxRB+b7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mEWnSfa869zh9M7Wj3iQefny0jNp6nlPhuX9nd4RhHp46UiZjUAi4skrpySbUZiYHKeMsCGXkYeZomHxeg64RiC64LaoSc+DRSAp+YfeS34AhapIrdQ63TDHkESJ5o7MbDmVbwsIZoqBDJ9XGZnIHcJTs8gahfJFMufzC4VgfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHLmZ859; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHLmZ859"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BEC1F000FF;
	Wed, 16 Sep 2026 07:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542267;
	bh=RY7iqQrKTcuhKb0mFYIU0rEpsRQRJQXXgIgLxRB+b7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cHLmZ859y41VX4UWvOVSIQqeb/s3D8kjASkgP3VocglkMtB53Ojunh4otd/T4QPXl
	 j2MD+hgUyVtbqvPXyMh8dQFuP0+IiLUe84fnbgV+R9QSHHC4pwUlA5kvPOvLR3ng03
	 mhTWS1aWcQVok2CSpAry4w/svyyyY7XmQgqmo0k4QSERzDPk9N1U+s5hux77uVYGdj
	 CyGO9dUfsE4P4Sd7NJm6Bc+XxMqtb0afBz77ukfqfFnR90489hATHk3NjpXldQuxSN
	 xRkSTTJZ80VGxLI/IycSt+M/T3Z6nu9xbeywUNnDtWjSRSCs4KiPFyHBvdQ7C3JK/6
	 cH0iDZdRJkW8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] perf tools: Expose opt-in --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065248.3153556-4-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916065248.3153556-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:04:26 +0000
Message-Id: <20260916070427.22BEC1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065248.3153=
556-1-irogers@google.com?part=3D3

