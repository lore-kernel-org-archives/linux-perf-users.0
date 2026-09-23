Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655E51614C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188895; cv=none; b=kFswAl85j4pQgC+0WjJRNg9aEw15q5sTODWhqRS43Z3PaSHn/VUgz7EWpmYA8kj+8I/CKK0NJKQ6/hnRXh8eJJr1IC0PIZnvwD2M0npA5WVTukpmgUo2PH5hoYS557VL/10qGOOylTl1tH2tHg2nokQ3BT8fddDi5KmEMH7nwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188895; c=relaxed/simple;
	bh=fb/VeYaoWrnxIM3HyUzvvnOGHW5BrnC/knC4koypIRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OO46kZLRsePSu02kKXsmlYd9FaNUXC5skMR3rDpndxabszJA1PQX1Q93/Ah7kDIIe1I117+SCyx5tC/o1v9BanulGPT935NazEwjVw6bVfx1vjAyW3mLGAVfMlvO5kQCHHyhtjPbV3N1VPYOnC1xGFOO1G0gsn/lynP7z75DP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd+YTeqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd+YTeqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF0C1F000FF;
	Wed, 23 Sep 2026 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188893;
	bh=PnTodkGJP0+wOcwJ5pmsvtrCqKRH+MnHiiHCMWnFr3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qd+YTeqjwjWm8gtiuedID78ZN6HoQYrigGEhQFk8JHBEKvoUaK5OhppANpBqgXHUJ
	 X1yYVeqbUr8prtSXaKw/9aV5UDr5Ttn5+mPJha2iK2y7uN2UaBRWuiRQ7vXhp3/HqJ
	 6rXXXCWlwdamRFufXWyG6zDBq9IGEZ5aWYt3BX95mLC5RTPnMsrhor34z64Z7X+gEq
	 ADrQms2jEge7CEql/nvrHJIaVLzIGR7UFxZMnsC6Zu/9xCJSXw8IeXLKnGMWcpc7x1
	 HpQuuHfyEjqKDjuGLexdJ2NdM/i8VdGhvXPEK3xiKxdIrgHqnERZNnwQ47QpGbSzGW
	 e+L8ZxAGQdIUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 45/49] perf python: Move and clean up
 parallel-perf.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-46-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-46-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:41:33 +0000
Message-Id: <20260923184133.ACF0C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Move parallel-perf.py from tools/perf/scripts/python/ to
> tools/perf/python/ as it is a standalone Python utility that invokes
> 'perf script' in parallel across time slices and CPUs. Update
> tools/perf/tests/shell/script.sh accordingly.
>=20
> Also fix bugs and clean up the script to pass mypy and pylint without
> suppression comments:
> - Fix Work.command() to return the shlex.quote()-escaped command string
>   (previously sh_cmd was computed with shlex.quote() and discarded in
>   favor of unquoted self.cmd).
> - Close self.popen.stdout in the parent process after spawning the
>   consumer subprocess in Work.start() when --pipe-to is used, ensuring
>   the producer receives SIGPIPE if the consumer exits early and avoiding
>   leaking the pipe file descriptor.
> - Convert method and function names to snake_case, specify utf-8 file
>   encodings, and add type annotations and docstrings.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D45

