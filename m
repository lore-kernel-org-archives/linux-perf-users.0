Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1B31D39A
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882827; cv=none; b=j7qcAjzVFoKJi6rhJPpqfex+diIKTkJhIIn2O5ipPkvpT8+4GF+WI/H6PQUbQ2aUgP89ZykiSfrrVBv1COeJ+a9VpXgscTWk32KK4TmJzUbgWbrE6WYL2b0zXyIw14EP+5InJuaIr74LYPeo3b8Z1UkakNZVQPODARETbf0JVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882827; c=relaxed/simple;
	bh=4sN+iD7odkoG0gNiwp7XNKQ+nqV1BDVm79tACuUi/Ec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ak6JJJMmSp8TBO6ZFilYNvTeXBtqJkx9sk6F2p730GOQn+6LjFaxdnTiqdegumVfbPU33a+qnMpc164G420axszbGbBXXVDwlbtvNqiOIFZqt65hUHUMCVV9AZcSx4wSrjG1/244JJaZjWFYmCCQlcuQda2Ae495N+j2MSyPbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8z317Vv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8z317Vv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A21F000FF;
	Sun, 20 Sep 2026 05:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882826;
	bh=CVM2ddP2g1Dkp2wp0ODyL709AqGZ4T+MXGZ5scVMO+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8z317VvSMP0QGGHO0EiD63zJNyHQaf9qVDHrcnUyhNl4io9MN3SjkE/cFxbBdMy+
	 kXh54eaLWk6B584/Q0F5xaiGPgGv/02/TPn1LHcaqHlrTX8apxtLajAwAfgK2rpmSY
	 V16OExGZ/NSb1KYrYE/4mhCX0oNlsmE5jeg9Myo8b7bLgw/weQTmsjxUa6A/HQd3Bk
	 BOINQ/tIxACvsDRXqYLiMb5oeHGZ4AZA5yTrdutRfYakQPKlWiaGET6q7FFGizVyVg
	 fU1aQUv3DQre9BsSDwqW/2J6A77ervpE0xP576uJgoGHvBYFPqJjRDLNKib99j7GLx
	 qwYIp7HFbra8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 45/49] perf python: Move and clean up
 parallel-perf.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d2dddc2f6fa855a397a78baf5289fef2e9fe19b6.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <d2dddc2f6fa855a397a78baf5289fef2e9fe19b6.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:40:25 +0000
Message-Id: <20260920054025.EE4A21F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D45

