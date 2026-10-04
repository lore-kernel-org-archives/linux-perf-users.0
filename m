Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D43BED66
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135446; cv=none; b=MpTl5OBlPX0hsxBgcb9Va9geBcUWXwJCpYXik/dv22krAHxlOl0MREs5i2k4OqtEA2MlkVlxa12Yzw38iui9k2Qob+6i0uVPyM398ckvcNUdhyCWzN60PkXZLZS0fG0iVJgUfDTcc8qqrAtSf0mEyypEnBig6tdttQfCHuYQKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135446; c=relaxed/simple;
	bh=7IELopo5tYTci7zNj/iTMSXoil5QeX5hR5NZYZnehMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SSA8M+z8tmMS0wDVhA28r2b371Hr38EKXtDbMGGvCilJAi9E/KVGlh0FtO8Q3aOitm+eWcXh2Rh/9dnjczKJ29t6u58yT/OgbryemaDm150wRAbfwIsCXU+fnfeC1Qv5leXFnBHGZ78FRIPe+92xiueI/BJHbA87UVwiD2C7w2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKoQB70l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKoQB70l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E841F000FF;
	Sun,  4 Oct 2026 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135444;
	bh=mbOfLtrGZfrRJq1OHodIMpt6rd7ckNHbbYaoccXLgCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oKoQB70l8gTSuHJ8l9cM+6NV8fAYY+UlsoEZfkvAxr/m2KbvbmODl+bqgJGuuIrwX
	 meEC6PvGzSFd4po9K60f3FUu7LQ3Gg4rQzPA9WFfQUOYyJt/jByRUuS/XY15qg043V
	 TyuJMsAufZAL/8XCrZZx7TGULc2FV+xFZRJ2Rhf3GHdaOmeF8BDq0kg3YNbMQlMRZp
	 QMaZ8vBwl7nlK6Bp6eqhwEwacSKh+05+w4OTyxh2sDj8HIBQ+PPQPi5LZEvXwpdo79
	 5SJeknXhklgc/v0j9aW2+XoXQJlCLAUkAqti/qZDX82mBvF9KRiIkGnFveboeZ0kl1
	 kkZ5wiO5tA0Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 7/9] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173000.2863935-8-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
 <20261004173000.2863935-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:37:24 +0000
Message-Id: <20261004173724.C8E841F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173000.2863=
935-1-acme@kernel.org?part=3D7

