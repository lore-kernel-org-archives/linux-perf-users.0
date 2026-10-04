Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87DE423A9B
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109777; cv=none; b=f5gNQiz4u4uf5s2dqO1BVxk801x18igD21AYA/dGc07Re5AvH0cyCdruCp6rB7Jp/I7xOdbgp0RN5rIRy321PWwW9alaLcYvt7VtkBhu3K/sL76UANMFqjGonsHv587dPYwgk/7iTYshYo9GrxLg2SKR+xSvwy2xOEl6nbuPs80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109777; c=relaxed/simple;
	bh=EDinh8giU1IagBX+rWabLdgwX/V7QKoT7YIeEjhfhrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nMfrBSloPYwmfuAPRdsqp4jpkIO1O3yXfvxIcb9aSlIqlHMRUXnAeIfepFjcimdmTxgDySGHW9q6vW4KDi+0PIo+qGW1VNv///+/mjdATIhGdsB7lh8x6ZPqqiGX+n7SbeLpaVLpGtY/z4K7MWLwSIiT5A5XyjQ6DlxUbagBXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcBrmpXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcBrmpXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FC41F000FF;
	Sun,  4 Oct 2026 10:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109775;
	bh=8moA3zpOupV51I9QDjhPvBVcRZl1PP5CnNPK1YWzIOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZcBrmpXKqdGQvf7NPC3yID6lL07n+Hb4D7+SiIwubXjMKJbV8Gt3J/QL9dZwD5P8r
	 dvRtXN70gZ7HDd15Lvmfx+F1c5HvNkal7coNBNRQ6xrdhm2RhLzRw+EgE7kAKs2XDi
	 +sISge9k4G8Bbsj9Sl57Xmb5bptrKL2a1Y9x6noSHDbjTlZGYHpz9RVVJRuMaYNXzF
	 pP/yNeABP095QXM0KHQtPkPSa9PRFDyphp3f1EzWxngztAR8zw6tAvxA5i8retErCW
	 i/rlJ5okOD2Bud5TFK8RMWuKGbGbjnVz5oJtw0tbgtz0eye22i/tY5LXlLCIq3cRPa
	 iNqAp0mh0LStA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/9] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004102133.26392-8-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
 <20261004102133.26392-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 10:29:34 +0000
Message-Id: <20261004102934.E6FC41F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004102133.2639=
2-1-acme@kernel.org?part=3D7

