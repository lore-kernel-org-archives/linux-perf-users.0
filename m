Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873356;
	b=SQN8lvTm+gkpH0ZZ5I3qhGV3rLL7tI83L053naBNb7/AiIsYI3E5adVkrJNSR2pbFTKx
	 xGUaBk6DBTJv2E7pzPgF9qugwmceE9ugA7Cv3AyAk3nkiH6RrC2La3+jVQo9sAU/rBKLo
	 65CTc0FR6zR/dzWb1+ZDNcWCEPKcCF2vwt84QQyRU78U6Y5IvP9UqqKxuPfR80hyEVvVW
	 XA5WKLQqSkMlnIf6BIIEM4EKHoj1zqC9A2EKFYoJO4U4fJbcgmZL/LEKvd63PM9Q8vkQr
	 iMZ0AwRZAhBQdXOnNefG6jMRIzq9ETUC2TTh7YWNWUrw26t5zZkrl8egPgrP5N/9Q0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873356;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+9ANZd7pWM4DgGcRZX8SNgWfpoFSUah/5sDy8HeQFms=;
	b=JST9X5V2XYjduH/5N6qWnTtFVr1VYj+07uUCGED/pavF9SB0IAdwHZUTXaiFzJb8WpEp
	 X/7vc87PWi5qPSD3IFIESqgVKyTIMh8VrUcJvBcqEJQJrsVm8w/xocs3TWMLT2LRQlsdD
	 0vJ4PaKCM2maKzy5b4OjYnd6+IvcCTjTJZIwOytTkVK5jgaUkhKwdBpFEBBySzYC5wAL8
	 rZYRhCGVuVTkgBhVmGoV7gVddbS6jQJf642NVfl3HGpu7r3hcbh201jfcLATkNseufVkw
	 zoUDVDXOpz1CysNn9Lo0TfaHoh5IkfNbpR6/cZrfo4XmagpTQqhtss62GYdfLGnUidw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYS+2FCh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12781606A334
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYS+2FCh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D60D1F000C5;
	Mon, 16 Nov 2026 23:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873355;
	bh=+9ANZd7pWM4DgGcRZX8SNgWfpoFSUah/5sDy8HeQFms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iYS+2FChgiXIG6Ie3Vk6gOmVL0l8KNIp6dDPuCfSXjMz2hY5m35QQZNB1XX2+0LW5
	 Q3GOVfMzr0iQho0mnQvuvHO4vnk/Jnxu6/UjoIMbDwBB4d/qUESQeDU1VM4MQLG6jA
	 llL491FaQKVWtYqTzhe6Dy3j2N1JcfU9f2wF7oHTjindMP/9E+SacEVwzfYquOwjr1
	 +Y93cmTKIjNiCeFHbVmxEx6fDxatHmVipj08swuWEHvTlh7/Kh4cGbSNXE7uxmrHHZ
	 Cj87UM7/RuOorRjzIv8F3vzXF+ps35y9fgx6z5ML0Eyo5oMdkWtGWXjCddM26tOn6P
	 Jy7Gwbnw5ODIg==
Message-ID: <sashiko-outbox-217942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/12] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-2-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:55:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Build perf with clang source based coverage, run the complete perf test
> suite, merge the raw profiles and report line and function coverage for
> the whole tree, optionally against a baseline.  This is pahole's
> coverage/coverage.sh + coverage-diff.sh merged into one script, wired as
> 'make -C tools/perf coverage' and listed in 'make help'.
>=20
> Without -f the report lists the files with the most uncovered lines,
> which is where new tests should try to get more coverage; -t narrows
> the tests, -f focuses on specific files, --html writes a browsable
> report and --table/-T, also available as 'make -C tools/perf
> coverage-table', prints the last run as an ASCII table with the
> per-file line and function coverage, like pahole's coverage_table.py.
>=20
> [ ... ]
>=20
> 169 tests passed, 27 skipped, one failure (20.2: Tracepoint event), in
> code this series does not change.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D1

