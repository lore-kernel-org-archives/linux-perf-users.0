Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D64071DD
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703685; cv=none; b=SFOPubvfJsQ3usEJdyqbdsDWQnk+yJMxQ0HyJt/3NClpxg/zgYjcY0CPlngUiH+66ODig2zFcz8hiOyuWMjMpSjtI3IpY4qUsQUTwLlRn5VbXrlDmHwpCm6mIDP2ReKPxLXCECMpVwK6Ipw+EFAQ3TlBEA0oEbLYsc8W96v17jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703685; c=relaxed/simple;
	bh=95UHLDopXIggIzscZjUzS7o4/SrFeO3gU00FCeqL0tE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SxCN2nlnjQi73608lrRrwHnLLBADbUW2AQy1VeI61AxpYx9hTfskepbuwxG7oIfxjjddupH6s0KcABYvoNlLg93oeX2swvbq7eOcIF+aau1+siPLYMavxuZGrgo8GLNExB/EhpwS/usfIQE1ql/4zPzj2mFXAEkWeOnvz5IhqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGxfb1jW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGxfb1jW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852FC1F00893;
	Fri,  5 Jun 2026 23:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703683;
	bh=ajHxvhpjN7nIn7qRipGo8ZE73KXMwo42aAAWVv9vl9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KGxfb1jW34qgKA706zkTw6GntXB3L6pARuXclPz+BGtnqLMHh2hffklfgmDzO0fqs
	 lBCJS27ydbt/3yleSourWLLBJMXqHvivaECHK1m7L3uCYfJ5Slipl9+qmXky6FBvh2
	 z23cGPinD0ZPFfTmdjwJcPF1QLzmOFgYz3ArmlIL1nV4DEDTxp1hhOGGJGIQljbipT
	 4I301CdmZCN2x+R4K2n3mefucXdScvKLUvNTD4tw+Lvpe4HK2kRkmggs6C6dZcOB2y
	 PYfFmnM5SO+T5mEwMMaFY7mEtahQYNXrZDk6ErzBxZq9wY4aGQNalavAA9hn4bV2Tv
	 jnKNQMMGYzHHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf c2c: Bounds-check CPU and node IDs before
 bitmap and array access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605233837.1773732-4-acme@kernel.org>
References: <20260605233837.1773732-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:54:43 +0000
Message-Id: <20260605235443.852FC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling pointer in the `he__get_c2c_hists()` error path leads to =
a Use-After-Free and double-free during cleanup.
--

commit 4a6b2b9d1bf179db3b813952c508e27db4f604e7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Bounds-check CPU and node IDs before bitmap and array access

This commit adds bounds checks for CPU and node IDs in c2c_he__set_cpu(),
c2c_he__set_node(), and process_sample_event(). It aims to prevent
out-of-bounds heap writes and array access when processing perf.data files
with unusually large CPU or node values.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 3dd45a550fdb7..f060dfbe11c28 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -391,7 +399,12 @@ static int process_sample_event(const struct perf_to=
ol *tool __maybe_unused,
>  		 * Doing node stats only for single callchain data.
>  		 */
>  		int cpu =3D sample->cpu =3D=3D (unsigned int) -1 ? 0 : sample->cpu;
> -		int node =3D c2c.cpu2node[cpu];
> +		int node;
> +
> +		/* cpu2node[] has c2c.cpus_cnt entries; large u32 wraps signed negativ=
e */
> +		if (cpu < 0 || cpu >=3D c2c.cpus_cnt)
> +			cpu =3D 0;
> +		node =3D c2c.cpu2node[cpu];
> =20
>  		c2c_hists =3D he__get_c2c_hists(he, c2c.cl_sort, 2, machine->env);

[Severity: High]
This is a pre-existing issue, but can the error path in he__get_c2c_hists()
lead to a use-after-free and double-free during cleanup?

If c2c_hists__init() fails, the memory is freed but c2c_he->hists is not
cleared:

tools/perf/builtin-c2c.c:he__get_c2c_hists() {
	...
	hists =3D c2c_he->hists =3D zalloc(sizeof(*hists));
	if (!hists)
		return NULL;

	ret =3D c2c_hists__init(hists, sort, nr_header_lines, env);
	if (ret) {
		free(hists);
		return NULL;
	}
	...
}

Since the hist_entry is already added to the tree earlier in
process_sample_event(), returning -ENOMEM from here triggers teardown via
c2c_he_free(). Does this cause c2c_he_free() to dereference the dangling
c2c_he->hists pointer?

tools/perf/builtin-c2c.c:c2c_he_free() {
	...
	if (c2c_he->hists) {
		hists__delete_entries(&c2c_he->hists->hists);
		zfree(&c2c_he->hists);
	}
	...
}

>  		if (!c2c_hists) {
> @@ -410,7 +423,9 @@ static int process_sample_event(const struct perf_too=
l *tool __maybe_unused,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605233837.1773=
732-1-acme@kernel.org?part=3D3
