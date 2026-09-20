Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0FF320A34
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789883154; cv=none; b=JPbm14AlAAcd6DYzfefc4gUzNkVxKYuz0MfThhfIwCSLtXOfgxlgUdFWOBCFUWQrptQoXsd20r3kliwkz/03WF2vWAi68vtFagpeSVUASXU3VdQEQOk+VFnw4fOWe8npyZSnlbsXUEvJrPDWMwbKflP9Gns5xuO8S74dv7Bt4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789883154; c=relaxed/simple;
	bh=x3WE+BwdPhZP2wN7qorDaBThZP5kST0N1csV0LCJT+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lPFEYdyVWFVOsFm4NQT3Wk8FuCTT1nrrzFUT9z5Cd9lgKukcNxMPzs/VyG3PtIB+mLVpl0Hrq7IMsH0raT6CaYErK9cTW3KauKhCoepg+YTc4+zD7RNHi3sFzZpmi5l69N6iONOHDyE9MSp//nHgJJxFQwie3jkUZZzHU0keioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxw5OyZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxw5OyZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110531F000FF;
	Sun, 20 Sep 2026 05:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789883153;
	bh=jV5kR0CKR0bcmJoNQ4+cax7TMs5BPE86PIlY0hMxXzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxw5OyZz+ZQT2P54qh/YP0RlF2ZRKI64uZ4W1OCub05ZHfA+WBKV6tR5tV4S8pYb1
	 VhmvwYxxRU4qpAvmQYQLchHo6GrYOpjUvMp7XHUKX0CYJmRvQ2Dr4mQJf/WJ3meRAp
	 qKgd0oSUuBdzHqvZopRaatWW94rbB3zWl8abGDlbbKks3nwqook0bXQednvezDMsPp
	 1MvSUM6BraFQ6/grJXUh1YbVQjsjeIXtnwyZ8KR8FuTQuA5qj/lIUTO1awIEKLT/BG
	 OyyGX6S0mNxkJwFvXKKvbpX9GfNB/pk3WiuE/IZ5mfXFyByg96SDShij+qYX0/jeDr
	 QPQuDGQUOzoAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 48/49] perf script: Support standalone scripts and
 remove embedded scripting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5f68cc9d70610c56ffd66bdee04202a51e99aff3.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <5f68cc9d70610c56ffd66bdee04202a51e99aff3.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:45:52 +0000
Message-Id: <20260920054553.110531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Refactor 'perf script' to launch standalone scripts directly via fork()
> and execvp() and remove the legacy embedded Perl and Python scripting
> engines:
> - Remove the embedded Perl scripting engine
>   (util/scripting-engines/trace-event-perl.c), Perl scripts, bin
>   wrappers, and Trace-Util library
>   (scripts/perl/Perf-Trace-Util/), and script_perl.sh test.
> - Remove libperl feature checks from Makefile.config, Makefile.perf,
>   builtin-check.c, and Documentation/perf-check.txt.
> - Remove -g / --gen-script option and scripting_ops dispatch table from
>   builtin-script.c and trace-event-scripting.c.
> - Hide the legacy -s / --script option and update script discovery in
>   find_script() and list_available_scripts() to prioritize the system
>   'python' directory over bare filenames in the current directory.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D48

