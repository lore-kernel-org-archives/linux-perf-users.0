Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC4149C4A5
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299126; cv=none; b=sGUS8EPaV/LIRnDIe7flneXNWXg252bf/tul67Z+xcD9wKEHYXqaGxaYydoEqK4yjfuJkK8ixjTAx2xV+DIIeAGxhs4PbfArCCFOm+UbEmoJNHweLVQ8kMcpUAGjhof91QUzNPgYSt3EBDmCfGWc3idy1awrbpakQ9pZWLh3BwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299126; c=relaxed/simple;
	bh=PYO+cBhgTaZjE9LNfVZSaF2Nz7WkYYbLUrhV88r66E4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SGu1cIMfebDZt3oqHjJVKdQT39gnxXUcWJaKLtyDkhrGqg0vF+sIJundb4sRTRnM5ZqBJwxKGiV5XiX2a7rY0vhfzo0TTGKyhc++Ug5wsn5ws87cemmixxbVzPcnY2AaX85leL4Io71x8RCAbkBml8hn5YDdN9s/Wd6HScBcLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neWfDeJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neWfDeJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534CD1F0089B;
	Tue,  6 Oct 2026 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299125;
	bh=OYeK0uaqMqnZZbRCv1kWWno6a0hW7nENweLgg3Gkjps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=neWfDeJKlgvPwpDs4KX6V+FvXun9GwaiDabv4ntC6omu+PLsvoaS39upm1zaDNrBY
	 73a8SOpsRmEsJUscuRw8vaFaljYJVIYNhDAj7EnXq9UOZJcLcxecxxar735R1uhYZQ
	 NRzgEd1UW7jwUHRD6v4p182rtt8CA/mqYCT1XS1Qe80wvNf3Ina5HRRsMK3zEF+oAZ
	 dHBVEYTYtnnMCFm6Fp33uvftcsd8Cis0UZm2jxkAC3VGzbj69MRsoc/LVTGrK5R1T8
	 noXHH2Jsp8w+oJahqyGy42byGCoHDEC4TMBF0Z3SCJ8eCzBOSID72zL2OV601zE2Op
	 NPig98clH+EoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006145729.3028247-8-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
 <20261006145729.3028247-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:05:24 +0000
Message-Id: <20261006150525.534CD1F0089B@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006145729.3028=
247-1-acme@kernel.org?part=3D7

