Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1D1BF33
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225926; cv=none; b=Hqq6eARvtq0QLZRkIAkcOIt26arf34234iepeS48h0dAPcgdBi2WnwVvswi1XIJC3kzABJo2igR+YUJqiqkh0atL+ZMEhda/44Bx8aEbXkjHL//i+W1fSXaUYkHZN0fSvLHfTjMXe2IDeC4H4Y/VoUFEsHKRlekoffU1JMEUN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225926; c=relaxed/simple;
	bh=wA+BUzE+N6oz/SF38sizm3U0zUj2Uu/oU2vLgOBsS7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P5nKpcbY188evHUFT38Ux7VjRscDl+ZrW1Ztq6uj/eUXWbcQ2oV7u191Ku2OG9iKqB9Z/S3zakWwHFahpveGOv5Javleh442v+uZoUuhQwRnAmDI+euSBNwRvRn2e5xxJDoyER3tXcLy69anaSRamlbNufEWdDEzaluZSq5SHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktCIwZ9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktCIwZ9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5361F000E9;
	Fri, 12 Jun 2026 00:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781225924;
	bh=MaY7fo01zSYnrSxoeWjGYsxDULopP0IU0JefvPg7YzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktCIwZ9+6HeAoOMGfFP0+2o5V9Wn0Rz/JRa4eiHlq8VXcJL7OyZFOVZnRkjyPHkXA
	 Qi04TUy0Mxv1ssp0klJEGyCEEuqWA/zXHZXuP0na0L/WrRec7rxLJ/+N7fiDMHTEnN
	 XXDXoDaA99BtaUZ2p3CCTbUomS3mVkJcuqZpRn2ZsIRF39ydCQ1aJTF00V7gAM6ad1
	 F1n3wsQqEpf0zhnb8DjM3kelZx42QyNkNm9Q8aH+Z9CW5g22cJCsmx7j2ki4PjzLGl
	 CPkC/sykqTenWnXd7HXuS0bDHLkz7C14DzA+9pB7RRE4QatxOf0zc4u9E9QQ7wIWN2
	 HvHDzjY7E2PmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] perf c2c: Free format list entries when releasing
 c2c hist entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612003444.50723-14-acme@kernel.org>
References: <20260612003444.50723-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 00:58:44 +0000
Message-Id: <20260612005844.BC5361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of inner `hist_entry` objects in `entries_in_array` wh=
en releasing outer cacheline entries in `c2c_he_free()`.
- [Medium] Memory leak of dynamically allocated format list entries on the =
error path in `he__get_c2c_hists()`.
--

commit 0bf603f26db9e5b4fcbe6b43bcf6b0d0f45e4807
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Free format list entries when releasing c2c hist entries

This commit fixes a memory leak in c2c_he_free() by calling
perf_hpp__reset_output_field() before freeing the hists container. This
properly unregisters and frees all format entries that were allocated by
hpp_list__parse().

Closes: https://sashiko.dev/finding/41

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index e205f58b2f3d3..07c7e8fb315e6 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -185,6 +185,7 @@ static void c2c_he_free(void *he)
>  	c2c_he =3D container_of(he, struct c2c_hist_entry, he);
>  	if (c2c_he->hists) {
>  		hists__delete_entries(&c2c_he->hists->hists);

[Severity: High]
This is a pre-existing issue, but does this adequately clear out the inner
entries?

During the tracking phase, node-level events are inserted into the inner
hists of each cacheline c2c_hist_entry, populating
hists->entries_in_array[0]. When perf c2c resorts the main cachelines, it
may merge entries and delete the redundant ones by invoking c2c_he_free().

At this stage, the inner hists of the redundant entries have not yet been
output-resorted, so their entries tree is empty. Because
hists__delete_entries() only cleans the empty entries tree, could the
subsequent zfree(&c2c_he->hists) leak all inner hist_entry objects in
entries_in_array[0] or entries_collapsed?

> +		perf_hpp__reset_output_field(&c2c_he->hists->list);
>  		zfree(&c2c_he->hists);
>  	}

[Severity: Medium]
This is a pre-existing issue, but is there a similar leak of the format
list entries on the error path in he__get_c2c_hists()?

tools/perf/builtin-c2c.c:he__get_c2c_hists() {
    ...
	ret =3D c2c_hists__init(hists, sort, nr_header_lines, env);
	if (ret) {
		c2c_he->hists =3D NULL;
		free(hists);
		return NULL;
	}
    ...
}

If c2c_hists__init() fails partway through after appending some format
entries to hists->list, they don't seem to be cleared before freeing the
hists container. Should perf_hpp__reset_output_field() be called here as
well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612003444.5072=
3-1-acme@kernel.org?part=3D13
