Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247F38F95E
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404504; cv=none; b=lZzHSy3CqK3bPXwLgBEeLaMU5DXGa2KJ9MWkSrXFxzUfFE3qBXpjI8/hqQ10zr4d301g550jW/qR1fVLt6zrvey4KKbPWOqoT19T1aZgQxHm/O7Q08aS9BHJIyjT3Cql2zb6QB4zxctNmPnFRTx0ZS7H+oVEo+3ZyFNZplPIU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404504; c=relaxed/simple;
	bh=qf8xssqqsv5Ujg//3j8Lfb2WfKBdZxsIFHiyzYRwKvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i6mKXD/KVwAfJVwd3x4bA5MF2wh86ME71sW44s93xT6MjU6yXoDhd63/8i8kTvRAG1RWBR0mkw8Z7ErGmOmf6/o9+iGk0VjXP1gQLaod0h5h3wF8hFYYAkpJ9zFlCm9HSxa0SCHqzvOqACT4NZDSZob8N6srnlEwguIlwuaRSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR38QcDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR38QcDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A551F000FF;
	Sat, 26 Sep 2026 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404502;
	bh=x7JJ1YY2ItyHzi1Qjtis91ytRZ/kspB2p17qH9TRcPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fR38QcDr9Im6fCwGsqTR/IRx2YXsG7CHtEZQBZ9FX69agEDprc/q2oY4JOGGXAumD
	 K2s1fbT5psJ/EeHpB7d1T+qgIm6R5CIPP2LHDKj/QwkYFOoHAzCXFJr0OJfeEdsMtv
	 wMS2k0eqxiyzs0TMjeeFF7dgzH/zTyTm6bW5/lz7X4wdePyZ7IUTJ3RRgfb5oynRVq
	 tRduFJIKgrKQxKG9G3A2/+xNSDhMlc12/zwtP9EnfrIIw6kQsBR2pCL8FdPByhl402
	 Csj+/BTz+GKMW0jZX2yHHX9yk/yq1v5TTKhIiifYA0GwLQcUBHenHScN6/PQB7q6PH
	 Pqb5iMM1HBrbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 39/49] perf python: Port powerpc-hcalls to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-40-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-40-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:35:02 +0000
Message-Id: <20260926063502.69A551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port powerpc-hcalls.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into an HCallAnalyzer class with full type
>   annotations to encapsulate per-CPU hypervisor call entry/exit state.
> - Use perf.session for event processing to track hypervisor call entry
>   and exit timestamps and aggregate min/max/average duration statistics
>   against HCALL_TABLE.
> - Add argparse CLI support (-i/--input) and remove Python 2
>   compatibility code.
>=20
> Add a shell test (test_powerpc_hcalls_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D39

