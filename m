Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF73F9270
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094664; cv=none; b=CsKXN5w7PN60rtUuEH7Qqga7AiP35OSAUEtCTjDqhx+Y6xWgwpNRjDR8290ueSrfvHBkOqfp2VLNhiGLUkjjvbLRp3wECifRxDG2U2rqhGs3kWZaW9RaNps4zOUMoWKn8IkYo4a2+xeS5MokOtRo0J2GGL6W/HkyfQ6YC2eHPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094664; c=relaxed/simple;
	bh=CjAIDVwrNR+WAwDaPyEJMdzoBRIMzc6831I+QsdJ5k4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BslP7NJfIwO5pYNGOxwrcZe9yd167+XYncBrzWNl7/uiQoMXUn+lTyPVTutv7yBfUkcrIxvM3yi8JH+LUoPXH0UgBhd6t9V2p3xMF3Y/tDubnTNMBETlDQBa7wpzgUaah1VzK6kDnNoCO2MG7l0G7V+QRdHlao2Z7tt+p/bz6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6zrtVFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6zrtVFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA2E1F00893;
	Sun,  4 Oct 2026 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791094660;
	bh=6Pv1glftc0xfI305V+IV5lcbBkq8/NnLV5NIr1Cb7yE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6zrtVFpyMK9njvwhn8mczbn8ix8U1rPrmJJQ/8YuGJyj/68MvkF+KJWefHUdzDzT
	 iy+uXQerOiuejZgXiwfZTWJJbD4e6bY35NFlStBpcdaYY4zI3E9ABMnnsMwkTwPkSm
	 EC7LgOsd6cayozx6DGMaMNASPtrwiBJQFnE0uIGVl1a9aLn7hAGYnCoZwKrLkCklQH
	 sZmbmUIvuFLw6WtyfyICDfyrohPo78rh58vJOby4j7f5z7U9W6Vc9ULz9pEslD6en+
	 DPW0MUJzoMr4opzTgEC7Gi7ZjVy7BGEgOdgDt13q1z+5xKfXEZQCGDkCk4WQXVbqn0
	 erE4EiSX+8Fng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 8/9] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004060457.3353-9-acme@kernel.org>
References: <20261004060457.3353-1-acme@kernel.org>
 <20261004060457.3353-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 06:17:40 +0000
Message-Id: <20261004061740.ABA2E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf-stuck.sh: progress log \r carriage returns corrupt terminal=
 output
--

commit bef40c1a9b75b6852c5b823d7f7eb048553178f4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add perf-stuck, to tell where a running perf is stuck

A perf that takes forever is hard to tell apart from one stuck in a
loop, and there is no way to see where without attaching gdb.
perf-stuck.sh samples a running process' /proc entries and its progress
line at a fixed interval, and with -g runs gdb when no progress is made
across two samples.

> diff --git a/tools/perf/scripts/perf-stuck.sh b/tools/perf/scripts/perf-s=
tuck.sh
> new file mode 100755
> index 0000000000000..f9b545c107905
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.sh
[ ... ]
> +	progress=3D
> +	[ -n "$progress_log" ] && [ -s "$progress_log" ] && progress=3D$(tail -=
1 -- "$progress_log")

[Severity: Medium]
Since perf progress updates typically use carriage returns (\r) instead of
newlines to update in-place, will tail -1 read the entire sequence of
updates into memory?

Does this also fail to strip out the embedded \r characters from the
progress string?

[ ... ]
> +	printf '%s state=3D%s cpu=3D+%d (%d.%02ds) rss=3D%dkB stack=3D%s %s %s\=
n' \
> +	       "$(date +%T)" "$state" "$cpu_delta" \
> +	       $(( cpu_delta / hz )) $(( (cpu_delta % hz) * 100 / hz )) \
> +	       "$rss" "$stack_txt" "$stuck_txt" "${progress:-(no progress log)}"

[Severity: Medium]
Does printing the unsanitized progress string here cause the terminal cursor
to reset?

Because the embedded \r characters remain in the string, printing them will
overwrite and garble the previously printed diagnostic metrics (such as tim=
e,
CPU, state, RSS, and stack) on the terminal.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004060457.3353=
-1-acme@kernel.org?part=3D8
