Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711F2BEC2E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158923; cv=none; b=NLtqEjF3ERlgiDfZEoEWmw99HVi94b4iamnCuqufEx+N//EsI0xXO+mOR/4qIy1jG5GT/g7hJFBqoDxSM4g2FvLJ5LcoD3GBHnOmOKfCfnTF7mvt4OUWfPEfvf+XD8Plizq5eioE5CQn4Mh22LI5JDYICPRbUNE8hc1Ngdi4G+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158923; c=relaxed/simple;
	bh=inGLhurGQKEgO/SGt3pnpXOl9nYsUtXvqVIsBq1qOXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=diQYDqY11Kb7czIERKPql6eT55g8X6q8f0afGGch6/0R1uxcrGrjLJM172Y4xeuC+CEjOZ3gVtFEsMa+VSkApx0QaTMDBVXjtvcp0YPh1qD+iHAz2E/Yyled3paH9BS+qkivdUkuKhQjvuHSc6KjlVtGo1xhhKVzH2yzC3Z4VNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ethfiKD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ethfiKD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86241C2BCB0;
	Sat, 25 Apr 2026 23:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158923;
	bh=inGLhurGQKEgO/SGt3pnpXOl9nYsUtXvqVIsBq1qOXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ethfiKD40BMcJoLRqCLO8r3YQdqh9Ut8ry+7kZ2jyM1tlGYLnJDjFdWItqjfkmiqC
	 osnxtPFpCv8Vdxdx3iLuntuNDOXjJLW6+IFOxTV5c5mFGiWBZ/rDzr3tydcI3XSsN3
	 MFSNrgCnHt/hOoyGcBLLRPyrlNV5Gem+ZQAJTJb7N/Z80FAk8CM47EfEiGfxGemsHY
	 mY/WHy6EausSUJIVHqJwXfT0EbuMXwvqkrzQhJwqvBCBNgQdPeXu2FcjwzZfWdr9nM
	 IuyYPBdOEwQECYy5kHQZF+3LvT1b24sU8Vf7SXClXnAIJ05I812qRU31J7cqGK5Ycl
	 PqecKKXblC7VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 58/59] perf python: Improve perf script -l
 descriptions
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-59-irogers@google.com>
References: <20260425224951.174663-59-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:15:23 +0000
Message-Id: <20260425231523.86241C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The commit message claims to update the description of 'twatch' =
in `perf script -l` output, but it fails to do so due to a parser flaw.
--

commit 1f01836466e9989f947fc7dd4eae069f6adf4d6f
Author: Ian Rogers <irogers@google.com>

perf python: Improve perf script -l descriptions

This commit updates the docstrings in several perf python scripts. These
strings are parsed and displayed as descriptions when listing available
scripts.

>     $ perf script -l
>     List of available scripts:
>     ...
>       counting                             Example for counting perf even=
ts.
>     ...
>       exported-sql-viewer                  exported-sql-viewer.py: view d=
ata from sql database.
>     ...
>       tracepoint                           Example showing how to enable =
a tracepoint and access its fields.
>       twatch                               Example to show how to enable =
a tracepoint and access its fields.
>     ...

Is the output shown for the twatch script accurate?

Due to a pre-existing parser flaw in read_script_info(), the loop does not
break when encountering single-line docstrings. Because twatch.py contains
other triple-quoted strings later in the file, the parser overwrites the
allocated desc->half_liner without freeing it.

Does this cause a memory leak and result in the parser extracting a later
line ("To test the PERF_RECORD_SWITCH...") as the description instead of
the one shown in this commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D58
