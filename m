Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459263C3C0E
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713506; cv=none; b=Yoz9uObPox0FtT4/f5pSMtZvVVeTJ8K1dZYjStf7S6UNZPDXLmsgwwm6cJ3SxeXnVaT9aY133WPRRnUAbD0DUh8hbYfvekAy6vGsYzEaEztmkMe/KTl40z3qRP/U1oXTsVXY8kebFlBr1v/g6kUgPK8z06ZDC4VaXdfnd/p+YVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713506; c=relaxed/simple;
	bh=uDKx+32TGYcndZ4IUQFMcfx1vLJm4gmqJFFr0ZmZjyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fRLMXtisEDqUTlPXbPfHUC+fX2BDvHAlMkKS6Ctm/9JIh5VJuw9oeDPvN+nlFfLgylCLk7nBTD8NBAc16h1erlUgvrJcd/m3cHOvhNby4aalKmcb1Kx2ZisiduoZkWZsXOTtVSh6y3mvlCuJOFJgtDGoMgRlHNNVIedmEPjxEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD3dTZ+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD3dTZ+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99531F000FF;
	Fri, 18 Sep 2026 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713505;
	bh=q0ZvVvoEXFZlShOoTI96IN5SgzM3qOIOXS7L3Y2M5JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZD3dTZ+MrMJ/HyVRbmpw4QVct6FRCAU9ui+T63HIyjxQ+6Bg2PXVlrkiyTOIVIk7W
	 ELLnLj7vCu7v4RIDGrsLoqhjXr2B+a9kLVDZBS5ekeiDp4863ywYnE3Le7xgZNJKIL
	 F+uWc9KQFReE5AHIA2FeZeZVhJHHL+YDraq80xYnycbfoK/dEU8cWnjb+0EGNzvnm5
	 B9j0v4qkrUSzrFlCvYlSYL8FiHSIgQ7Mxxfm60M1ewtOq9wCsNbIo4UkFsSU/pZ2MG
	 Xk85p+OapZsLyxA2tBNnDZSlVlpGG4NwNWvdzA3SwSfkGxRVUsyBne73ksa1ddcZH7
	 rxjRnI60mzpCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/5] perf thread: Free the comm read from procfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918063249.2172589-6-irogers@google.com>
References: <20260918063249.2172589-1-irogers@google.com>
 <20260918063249.2172589-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:38:24 +0000
Message-Id: <20260918063824.C99531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> procfs__read_str() allocates the buffer it hands back and
> thread__set_comm() only stores an interned copy of the string, so the
> caller owns the buffer. thread__set_comm_from_proc() freed it when the
> read came back empty but not once it had been used, leaking it on
> every successful call.
>=20
> Free it on both paths. The empty read still returns -1, err being
> untouched in that case.
>=20
> Found with leak sanitizer while running 'perf trace':
>=20
>   Direct leak of 7 byte(s) in 1 object(s) allocated from:
>       #1 io__getdelim fs/../io.h:179
>       #2 filename__read_str fs/fs.c:365
>       #3 procfs__read_str fs/fs.c:402
>       #4 thread__set_comm_from_proc util/thread.c:297
>       #5 syscall_arg__scnprintf_pid trace/beauty/pid.c:15
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918063249.2172=
589-1-irogers@google.com?part=3D5

