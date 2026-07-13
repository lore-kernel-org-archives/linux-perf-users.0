Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8935AC03
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976349; cv=none; b=bYbRFm2G0gEX4JslFGMiEeyRfc/X4H7dhTexoACNvVeYSTgL9qhG+8edeApxzUChyoWNWtAqOzAvxfOdcK78lxbNS0fPEmobL69uKacIvo9BXWrfQixPxZiWsCbY6vJFurQ/yMTdfmDN2vMiU7paKS+GPgWY7aJvK0ZPpJxGt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976349; c=relaxed/simple;
	bh=Bj6vgfAA0wLecrcDhgzSr6+tZ49JweI+iZ3yrooG/y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIKWoEenv4Ui0Vup9RvH4tH7wN12VGNc3xklLE8Jaw/oF5cYADPXwd7ulmG22rw9lXlKKm+QemN/6XrIkvyZ4UICUlzy0AGwn0cuskJiXRAAUFYPcgatLRF7v/27z/AGhKnX57W7UOm0eNpm7sn4hk9HJV0nbdYVne+Bv2MMfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REYcAJKk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REYcAJKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D4F1F000E9;
	Mon, 13 Jul 2026 20:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783976347;
	bh=0Rd+z27x9EFQDOiT67atB0A0F6/z8eYsByVNn3sPKzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=REYcAJKkO/BUCkhOkXdS4yf8r0NvJ+peojepSXeB0KfY1uNmpEoWiOvdixXn8fs3Z
	 YeJllfBbuu0xtYdkhFods7ck6CaDqVtJoMa1vQweY/6bJ/NeRjyY3FiDePeHB6pFJq
	 nV+jF9fwI1eajpSraT3GQ3+5AMcHD38MKr4gyDR2cbmyeTBrTzG0xoCMyvq/XurJr6
	 6Cwg7HCoEl9v03KqknLPHK7ceJGV1U/l96Xasqnwch9Ut3mTRUYhQLj/eg9XEFzQKa
	 zXKQbC4u9cnXZJ/5i0TC+PQep+I5gFtHWosSs/ZkhNj3x+dqGoQhjWhgdjRq3psk8O
	 M7L0+JjJCiZew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] perf sched: Add missing perf_session__delete()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260713204707.2181098-2-namhyung@kernel.org>
References: <20260713204707.2181098-1-namhyung@kernel.org>
 <20260713204707.2181098-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 20:59:07 +0000
Message-Id: <20260713205907.77D4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a double close of the file descriptor `fd` =
because `perf_session__delete(session)` inherently closes it before the exp=
licit `close(fd)`.
--

--- Patch [1]: [PATCH v1 1/3] perf sched: Add missing perf_session__delete(=
) ---
commit 2da9bd6a7ce8e17e442d8be81b1b57837aaee6e1
Author: Namhyung Kim <namhyung@kernel.org>

perf sched: Add missing perf_session__delete()

This patch addresses an ASAN-reported memory leak in the perf sched stats
record command by explicitly deleting the session before returning.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 6e0d8f4d270e2..68147a0be5c71 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4027,6 +4027,7 @@ static int perf_sched__schedstat_record(struct perf=
_sched *sched,
>  	else
>  		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
> =20
> +	perf_session__delete(session);
>  	evlist__put(evlist);
>  	close(fd);

[Severity: Medium]
Does adding perf_session__delete() result in closing the file descriptor tw=
ice?

Since perf_session__delete() internally closes the file descriptor associat=
ed
with the session data, the subsequent explicit close(fd) will attempt to
close it again. This could return EBADF or erroneously close an unrelated
file descriptor if another thread opens a file in the meantime.

>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713204707.2181=
098-1-namhyung@kernel.org?part=3D1
