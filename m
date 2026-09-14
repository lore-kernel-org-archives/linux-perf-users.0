Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730DC3D75C7;
	Mon, 14 Sep 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395296; cv=none; b=dExQstlvRw4CJlOwAHsT9I58DvXZ5js3yFqDZ7xAw9Olw6magOrWzPfmYjc+nuojz2N4gqdxwX80YY7wnWUzSpaBnKAjJD4S0HAzTocp8W5losp5kccvgnMO8JD3gaXLbwM1L3T1bfOcGvQ2tkWhZmeKTs0ugHH1LCy8ckRVNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395296; c=relaxed/simple;
	bh=My6H0/DAK+zl4fRIR24tK+jVkRjRcvNtZjHsDmr54ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMHVqypUPIP6LE7qCqfHc8zhIUFgTJQm0wsOe7Rmtb0bFwxUpIdyVi7RMlKO5UXAu48IDA5c1u17Eum+HOJ6Ig6HxpHOOB4cBVXr/cFjTDsweS+3Mk8Li26jHnoY4/IjBDWvLdmyv33wn7Q3RhNu7dtaln/NVppW/iEk08zP7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huzjlDP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huzjlDP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEAF1F000FF;
	Mon, 14 Sep 2026 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395293;
	bh=My6H0/DAK+zl4fRIR24tK+jVkRjRcvNtZjHsDmr54ac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=huzjlDP4dX6usWWYCLmIMMyD7uO8NOHJq2UEBBT7I66VYgsQAlwHIKviaJLn/nRx5
	 RS7YB9fEqOf6zuxH/DaNDK4CIBHrDk2w8tFaw8Mp7pxT0LVrLP5Tc4kJ1fpAqNBJLy
	 2//hk80kYKT5rhsI/4PZFA5dNbPWP60OWMi4y4mPKli9vTWSknQzDdXyKPVl0pFmER
	 /TuQOuQScf93T97UQi0AdlqRld9wRWuDgsqvA5e1nh3/JRMpluKJr9QutJK/+yyXLJ
	 2V2XH51TDL53m3HywOup/FrdY190He4lj8SktzHvniKvWkBBjc6jo1+3euztazjgMY
	 ST+p8Rtv3/xuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 06/13] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178939024764.94750.11181367508605155346.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939024764.94750.11181367508605155346.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:14:53 +0000
Message-Id: <20260914141453.9BEAF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add hardware-breakpoint-based dynamic trace event support (wprobe).
> Wprobe creates a dynamic event on data read/write accesses using
> hardware breakpoints and logs the access context and fetchargs.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D6

