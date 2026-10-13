Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507D3D9DC3
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931317; cv=none; b=JlNb+JM+gKuao9NbNehUPI2rMG0770wsYJZFXTk4YI76n/+6QftIiGLwu87AGHDw2qCFOzXEHs0TneAp/Y1gSQ1fu7KE2qnSEFygrlqTYpDo0Zz+MVJdWxIX3iJis2B9aaJAdn9X6AbFcs9TJJ0iioYiI/+0fk0yj3hZu3N2Mgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931317; c=relaxed/simple;
	bh=scHv0qgCu4QqDZBrNPISAtBYsUmlt3X8Onrfuo9GBL0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oahrvgui8D7iRDOOb++8IuO4kIY2M6VvpGGJ7GG5s1o0EvgE5VHJrLkCo0qnvA5aXUvFsEa41TMVFZ2PBDxreJKxtPe/pWvJlNtFO13jbbUOU5Fl1W9n2msPMNwhVU5HH+cZSuXoiAWklHfdZycjB4MH6xCSJADI9WqZ5LVdPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPeqhcQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPeqhcQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5470C1F000FF;
	Tue, 13 Oct 2026 22:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931307;
	bh=Cro7/niJ1lM5EvxAvVwguLhepX6YHxIoDOmU4fUfbd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hPeqhcQppWo4xqACvgWGoJMMFjLaUyOVDTe7/ndrU7G8ioTHstSFaLP8mu5eUAOwD
	 KMYlmtKPC7uxWB7wMBZaX84+SDdMU105j/wKJjviZMFm7aMRufLcxpthrrgfSBwqd0
	 XABQ7bsYzrauX3Tf3pIRgMGZ6VJb4P5HCkNXDdAzqKbuloin2TgLBp2b5TczAFbUTF
	 XFTAs8USkEuSxEQPp5Rk4bfPYgcAg1eb+jz0CWJzdRwXXG0dko2NXk6KnRs9d7hJDJ
	 MyxVzOk2bVv1b8+HPL2+Dja5UKbpzTzBDfE3Xar65y2Fyo1ZucacnAS76ra02QjwT0
	 IT/2sAb+/YLgw==
Message-ID: <sashiko-outbox-170590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-10-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:41:46 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: Missing POSIX libc header inclusions for musl compatibility
--

commit 8960a6e4824321506be07bc73e262a9ac1420f9c
Author: Ian Rogers <irogers@google.com>

perf config, intel-tpebs, env: Add __guarded_by and __must_hold annotations

This commit adds __guarded_by() and __must_hold() annotations to static
parser and config state, TPEBS state, and perf_env trees. It also fixes an
unlocked read in tpebs_stop() and transfers tpebs_cmd.out ownership to
prevent a double-close.

> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 7c0b8b15bd10e..85dcf4f646976 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c

[ ... ]

> @@ -236,15 +222,17 @@ static void *__sample_reader(void *arg __maybe_unus=
ed)
>  	tool.attr =3D perf_event__process_attr;
> =20
>  	session =3D perf_session__new(&data, &tool);
> -	if (IS_ERR(session))
> +	if (IS_ERR(session)) {
> +		close(data.file.fd);

[Severity: Medium]
Does this file need standard POSIX header inclusions like <unistd.h> for mu=
sl
libc compatibility?

This file makes heavy use of POSIX functions such as close(), pipe(), read(=
),
write(), malloc(), and strlen(), but omits the standard headers. The patch
adds new usages of close() and modifies file descriptor ownership without
including the necessary headers to prevent musl build failures.

>  		return NULL;
> +	}
>  	perf_session__process_events(session);
>  	perf_session__delete(session);
> =20
>  	return NULL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D9
