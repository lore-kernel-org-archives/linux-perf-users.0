Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD43B52FA
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717283; cv=none; b=X4BUOI+LRODrMu7Z7UQSCi5tIpdJ5O+IDONa6NV6ZW1Ud2PPzLzyrknjHIP1IY6OZduvQRS1G5qY5HPaIlWM8trGQEUFUKfmuffEdxLSbjzmKNe5rUpsU90d6L8bRDk7UrkctYrMz1zi5G9WbLQE15wwVimCgu7Q9zmqezD0PFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717283; c=relaxed/simple;
	bh=+LlRP9rxVG9aqJqmy7YUG3YWzTMKecb/dzNcE7CDQ9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C+Eb/AMkBgIPfo5PToUtNoFT9avgMW9TfTWgWVEsSpvKO1BsgeLN97DGryGulqscjvqX51k0Lk9f1/FbzqnikxoF76KvXe8G9O1aDcbhg0AJmkRBBMLn6fSN8dY/SekeXH3ogOYTcZT61R+zKtG6QmkLTwlj19rVP4Xz3P3K3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIuhYIu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIuhYIu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97341F000FF;
	Tue, 29 Sep 2026 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790717282;
	bh=3rQyBEIqsF5USAhP/NuyJMnqbfnxemQ+rEid7eAYo0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bIuhYIu7vfwvUsp4C8DmwSgzHuBvff8DpKo45eAl4dFmNe8XkNKOXjlknKCi5xbBa
	 38PF9g40c7nSZMQotw3oljWJHilQO7HlxdWvPH0/2MMDX/9ZaVyots2IQXYL86kGRu
	 4Js9iYrMgndzigRavk4byfX0pKD11FHP9xScpn6sC5yYz6GoKt7XnM7eHtmuoKbfO2
	 +JAmWZgVP40PU0uscHCZ229H1u4/QxG03MVp7Bg0lQJ46TZNgyRAqS1AK/NzEiDTLA
	 KHXhfjiPVqFxwFH59zwZZHEz15cBY0rTH2KTUuTIGIwrjnC2xwVR9Krv/kqN5+G6/e
	 3cDgJ5GEh+owA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf report: Add --no-progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929212246.2532021-4-acme@kernel.org>
References: <20260929212246.2532021-1-acme@kernel.org>
 <20260929212246.2532021-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 21:28:01 +0000
Message-Id: <20260929212801.D97341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Add the counterpart of --progress: the TUI and GTK browsers present
> progress of their own and there is no way to turn it off, while the
> option just added allows asking for it when there is none.  Install the
> no-op ui_progress ops, the ones already used until a backend sets
> theirs, after setup_browser() installed them.  The phases are still
> counted, nothing is shown for them, and --no-progress takes precedence
> over --progress.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929212246.2532=
021-1-acme@kernel.org?part=3D3

