Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BF599A52
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584092; cv=none; b=abQbuhDH6m9OXSlDlJnnLeCEqDb85ReJrOwqgsJ+g+uRaVqTRDois9p4iY3YtdL8GyPe47ULbav/t2g7+gbqzB7CfcGSgrtPScmKGTNKGCrwR/vsNlDKTyDAw7RVnUB6cboPLxlSeZ4humIvL40knANUwjnXXb5Uy5TwNBR/bSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584092; c=relaxed/simple;
	bh=TMhwAdUhw9DM4+S0qcjZ2mTznUpK62LL1Tlw13d3SyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N8FXjL0lwdOs62mSiYQK9NtWtM8fQeQtmEp0zCaW2L7R3qfuGhpGIX0BYmYzryHmU80WCOCFCp/ToAHnuQqL/r6Hg2En1o+L4SSia0yfL2mTWhc7n4PCmjQEvi4sS2ZFunXs1UY1KNChblA0vLjwdgCEtWhTqj+ovZjgLIoVqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+9l4Er3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+9l4Er3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043801F00893;
	Wed, 16 Sep 2026 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584069;
	bh=TMhwAdUhw9DM4+S0qcjZ2mTznUpK62LL1Tlw13d3SyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I+9l4Er34rYKMhtwGZo0aoRgQ4RxfwI/S1TX7Hvo6K52e7YsO+SwHgGyMrh6/8KU0
	 gR0ZRpwZEM6ljq2vICsAKjt8c/szL09N6SYGFG1ZFOHKAlmWo69LUOvUr7xqaal+qA
	 Q8UwkiTKrjo5BWOeh24G1YrmgoCLGmHfIvey0q5gkQiQkbVSDwY9Z5TvBbSRk0A/fK
	 FbVgIYC4fugAC8V4P0dp3nWg78XKtJshUsS0wA+vqbfii61QvnDkM5wntH7tNLpYsh
	 DS0Ln+h+mp5YxN4yh4u3ZzUh3H6Rhv+I+0t3Xb6a7h02io1jbzdECOm3jhxUdRWS2y
	 Hwyd32i6wm+6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-8-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:41:08 +0000
Message-Id: <20260916184109.043801F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D7

