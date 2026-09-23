Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273AB406270
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188800; cv=none; b=lYsGOEl5/t4jW4QyfmZ42jdVt0LG9nGUdusYUYUo8JjN048G1Co9BPTIfJIlo2f3AudT1Fp9e/ANgDBo/u6GYC3HHFTHmFW7vuwEEs0Qt5cxe6dJb7T1N/A4/Q6UryCJv/SCiq9C3JdP19ZQfPHaiKTQYBacCuvcJZLI33ViExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188800; c=relaxed/simple;
	bh=YW9NAJN/1yMiMoeDoKCWmXq/gIeDt7uxuyr+Lsp0SZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IoWrJZQFYdrBGl1AWnpgApEDOtCSLnNXzI6gO5r5zTDLaKDk9GzHBkPvQENeyD/TDb+7W1ULZRRh98zM+748z7Q0TvErEauNRLKgKgLLwVR6sZuqM8o2tk43BeBJNgGS+S0lpGHijgSh1oMvRh28PAZfzJhmUErBsYz2EEzhsAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiN6wpHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiN6wpHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9221F00898;
	Wed, 23 Sep 2026 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188792;
	bh=6rRvPGa2Vo+vaeB1f/9Wdq8Yb1xcpc4++hX69k6QZKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jiN6wpHescXAh0Ld9eQUPw491AatRLiNFCTCPQ6KGZjkOdIuXuoHgzdRncN8U7EIM
	 eOHTKgWpoAJ7EQLlECIlPmqZHcNdG9Td8XBrFqyJW/8mzGomlGhPSqCrT1skUJz014
	 21C8xtUE5ouJkW7iElzeAzcEKVVBlu1mYzHtFzImgoLFSmbwRgmmnJhg1K1y3PgTLb
	 eGvB2cEM7GA7CcfowkQJsePpbIgP5WImaMYSKx9OHvWw9mB0n+VT/hb9TbDgdXwBfY
	 DWouOqQCIzQEpnr3xtCFjcyO8UTqJHjQb1JtPdSOpb74bKOTvArHVNRKQrwEvwsGut
	 HglH46MV6OVLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 39/49] perf python: Port powerpc-hcalls to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-40-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-40-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:39:52 +0000
Message-Id: <20260923183952.BA9221F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D39

