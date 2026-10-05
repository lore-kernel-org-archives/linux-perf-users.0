Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F346D0BD
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222088; cv=none; b=W+xDubfB5tuGTtWjaE2j7BQAyK041XaEUxS+GKmW7WFAvhVndeuHY+Jb7ni1q+paBL1npUv8amePwEg8MGOZJuWdvxxVVdYvnJ7PAF5Sz+bv//gaor9V6xIgc/QU9VYykgAybODGR6x02UKjGEX/Rhy+1eK8HUbUAVlMbsOrHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222088; c=relaxed/simple;
	bh=+60uZpFEHyMENT+2YuMbEeC+akCR+3h17v0k2r2t0rY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZe0ugVnwMVh2OQu5YqUMyl7VjZtAkHZB+fwCuWAFJ7ac19ox+qRjLyAjjH1TaM+ZC86eCCLUkvZhfiADF5JH4G6fFY1SkqoRE/Sw8zW9bcOYG5oUx4GEWW8EQCy/XrjijtcFtC2uTlExnigIU+2sRTmyEqz8HpD5iffM9XzXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZWQqbtl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZWQqbtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1661F00893;
	Mon,  5 Oct 2026 17:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791222087;
	bh=+60uZpFEHyMENT+2YuMbEeC+akCR+3h17v0k2r2t0rY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZWQqbtl8eJw82ZBs58eS/W3rZqLBxrXdUp3yKl7+xgXrCk8B/2j+kZqOcun53kIC
	 OkDR0wOmL46aRsSA6ZhHTlpcAB9QZ6sJRRamlKyaEOis5fzG2oVDArphKkRVnSEG4L
	 +4PNJ3c3r/N0mq+LqbYDuAStfdQ3EMhPuqR6ujlNs4j+z7XhvB/onFv7KIt9VT82vf
	 YJ9EV7SgrXaDe78Tkr4VQMxVP1pc2rwtM9digU4LYLFAijUOy3mkzOKErg4bVVTco2
	 6O7ABcLRQAlwCcYHpYddT5rGwKWMjeed980d5+vcEgUpr9YWBFJon8sncNH44suitu
	 SAecK1VoEH9CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] perf dso: Allow reading DSO data from an
 explicit file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005-perf-symbol-memory-send-v5-2-165dceb2b049@uber.com>
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-2-165dceb2b049@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:41:27 +0000
Message-Id: <20261005174127.9D1661F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> The DSO data cache derives the file to open from the DSO's binary type,
> which can resolve to the runtime image rather than the file a symbol
> table was read from. The lazy symbol loader added later in this series
> reads symbol names at string-table offsets in the file the symbol table
> came from. With split debuginfo, the data cache would apply those
> debuginfo offsets to the runtime image.
>=20
> This patch adds dso__data_set_path() so a DSO can be configured to read
> from one exact file while keeping the data cache's descriptor eviction
> and reopening. The path is used only when the data cache opens the file;
> dso__get_filename() and its debuginfo callers are unchanged. Such DSOs
> may be owned privately rather than being part of a dsos collection, so
> the patch also drops the assertion that every opened data DSO is in one.
>=20
> Add a DSO data test that reads through an explicit path, closes the
> descriptor, and reads an uncached offset to exercise reopening.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-perf-symbo=
l-memory-send-v5-0-165dceb2b049@uber.com?part=3D2

