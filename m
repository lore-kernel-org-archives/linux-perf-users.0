Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8B389459
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404629; cv=none; b=kNX+m4DTO9ueqC+1mFnO6Fhv9b0O7f93YZBHUs5OSxHe0fkk75rlFdfDhI3kOIBQApvjtPMCcNVQ2UG8TSouW6bryW2a/G/w4SFzdP7onWw5dPWxB+9KHAxTqtGBMNPTPvVIXwjIgUgPa/qLV9zMHQ4HhcgX3QUyKvZFA+Q28GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404629; c=relaxed/simple;
	bh=VqU/NSA+1v8G9y1BdHufh4xxXMBLHNlj3D3gFUQUqEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AXpzXFwq0Lz13zt/u99Lk+8NP768Lh7CIgcVuegKVTuAegH0PlUerUU6jV8iJOSr8hpohkXmv4bWU6f44g423UdaV9MErscDUaGWt3Mr/WGS6cN61KwV4QGG/ub5Y0SjFzug8inxsTgjRK8+5G9Xj/r/886WzfixrnyPx7tWpOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpAtqObb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpAtqObb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1691F000FF;
	Sat, 26 Sep 2026 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404628;
	bh=DG+K/8g0wnn/TtfyPlfZVYHs1r7zrjmbsqRJJSpS95s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NpAtqObboITtwG2bbTIH84i/cbZ0L/s+sVwGXm8yyp5wlU71Ml3kVMUghgXJWLUo0
	 vvOf7p3YF99NNpNbZppKzTibCtRjVmPCRYGCBIAB3VvnkZ9keKPJVVyt7uDOc1hBtC
	 2NfX5JBlOPNy8xn+7PoJMd2LPGAbyak0dYvFtSoKieN60SNUQwbpsni6eQVvA63yJy
	 JMLgAjkFyIGidlmbmYrCaqDt31laqfD3Dg8FuuOyB7N1UF/0e3yP6/+Nr9AuHHy66i
	 Kt15+npx90RNDkg5Ttnz7z28IiocxBXVJRfaX3FMAbGmzZzRklrAbE/GdjYn+mkRGY
	 3fVgoq2ygUeBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 45/49] perf python: Move and clean up
 parallel-perf.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-46-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-46-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:37:07 +0000
Message-Id: <20260926063707.EA1691F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D45

