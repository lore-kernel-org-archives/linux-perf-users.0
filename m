Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A74B7A35
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664184; cv=none; b=BqqbE6I3P+E08hH9UZ2p1nFN1feGFxSzRyIrvN8IpCbwXM6zaq8aKjZHvgsoG+WV22ofnsSZQSEHjdLe/S/AU86aMZIyduk5u6S5qh9KtqAVFalvBkOGO/srkWhG302gzFR7EcURGJpo0LRQ7eTn8qM7GAIy6JnCP891F99++Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664184; c=relaxed/simple;
	bh=CHzuKZvf14a8L36O/fcFb1bzWUFShPHpQI8OmMkkIHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MHhLjuDfy4E6w8QqYIHbparsZMz+lxs8gtWQaOS4Mt7SQeaJ0g92jhMGeSGJhLNc3/TV0WQQKU3SHaQStLVDW2beg6VKY4A2HJYdA0oVehzCP5UO7nz3+vnPhj+/SijccHXyPYcx5ez2DXWGN2Y04ShyMvpLXETUGqVqwccFN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcrGyuFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcrGyuFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA181F00893;
	Thu, 17 Sep 2026 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664182;
	bh=CmrdnLa4uWjngOOAqA4Le6JGNKsL2mypChkeTbxybjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KcrGyuFuhdhxW03CQ1OI+3fBeFLcGDO2gZRGxpT6CIGx6Bx76Cvuj7XhkxRkzAHLz
	 ey0BRvTqu0Xe5EfMEXZnUzHc4FJXHg6aU2OtNCEZDg15XJ5HtB7W6gpp/6tPFSL0ez
	 JeUw5j8dfdCICIzTDtxut/D7JTV9mPJG3ikXA7XhTwJVnQFuw0KQxofw4O2Z8/7eAx
	 0XfZuivNibYQqMR0QwaroL2vj5err2tpeqVuPUljWqk21d4VKyK5i8bJ8wNTSKcL0R
	 Pa7Xot7AfsiSu3BXHex0IiW4JGsbf7LYz4w8ovaJQMfjbiLsg0gC05aTfgQAY+wd57
	 d2dIpIdeGJsYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/14] perf test uprobe_from_different_cu: Scope
 probe name to PID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5a3d268b240f34ac4ac230a630c641471a333bbf.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <5a3d268b240f34ac4ac230a630c641471a333bbf.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:56:22 +0000
Message-Id: <20260917165622.7EA181F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The test builds a binary in a per-run temporary directory and probes
> its foo function. The directory name is unique, but perf probe derives
> the event name from the probed function and the group name from the
> binary's basename, so every run registers the same probe_testfile:foo
> event.
>=20
> Running the test concurrently with itself, as 'perf test -r3' does,
> therefore fails in all but one of the runs with:
>=20
>   Error: event "foo" already exists.
>    Hint: Remove existing event by 'perf probe -d'
>=20
> and a losing run's cleanup goes on to delete the winning run's probe
> out from under it.
>=20
> Name the event after the pid, foo_$$, so that parallel runs no longer
> collide. This lets the test stay in the parallel pass rather than
> having to be marked (exclusive).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D14

