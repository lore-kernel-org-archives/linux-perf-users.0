Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783079;
	b=OfxmsezYlJKRjNjgcKhE4yniAhro/menC9BEm7GJOpU7uZy78YW9rYDH+fr239fKt0Un
	 ytdDqvfVx3Jg7CnwLfj/nHt3yWa4+Y9L/AVVtdjP8SDqAirBnuuSY8SSdJ0B64DCl7Ims
	 +qG2EY/fKae2ldAfJEk9XzV0/QgxVjCY0utaioQAIUTrh67btPrYibnci0GShw7/apH0z
	 6Ngxyi+sKExEWv9CT9cPo1WSJZPYK3v3D9mj79je+D7uOCjfusJrZFuLBHqc9vbgqHpcg
	 w5W3cWGtPq6Lir+iM6rfPhEjzXXhCZ0CA4JguGs5xmWm4E58LtKrUiX6LDdhjeKhryw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783079;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j3X9aSeO80s/u5SRVhm50JDVcM8DKGqmHyQ/h5OJxwc=;
	b=p0TD0t/6KX/jVYUvwTL4OhJK8a4CNf/oW+6SfjWhRsFGfkl3IYp830uZa6hM7xQdjLOZ
	 /19GzwOnSo+S9zKZmQogX8vPAuO9o5DquLEDjKMv2qp9gdLKETUlTQCkYnIiiJWR11QU4
	 SF/8xSrlRuN/n8Q4f5wbMjtJ8taQ1MqxzN/fexrdDH2vMS4HQG98XK5Cj3y7/Jq2QNOE+
	 ywC/Dytjp5OPazRtr/KDhfCgiImfcGNKIFwtxBhpZmQBcSOH50XJXcbL6tZMyQKi/SpYt
	 3PLlM4rwJ3X+qLNZ7EuDwUi+ORq8AJtBoezi1H1/a0gOXfLDPn0+znnH5GX/Ko/jjlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LyxsgSWi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9671606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LyxsgSWi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626E81F01828;
	Fri, 23 Oct 2026 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783078;
	bh=j3X9aSeO80s/u5SRVhm50JDVcM8DKGqmHyQ/h5OJxwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LyxsgSWiE6Mg85x+a3HbfbS2NRu3Py0oVAXK/7XczLyLov4PjlYGJrxeEsQ7B8pTF
	 7TRjlMujDM6kIRq3u3z8clq73Dj1lOm3yMzbDJtGSknO0twYOm2ev+j046FFDOjKtp
	 CEW7r5r1k5Tihj3pl0yihsU+0DjPv6IVJ+ewf5cygwt+AI/ReDYhE7HD1zEslgyfxT
	 LBQVi6woItWQKeQ16WR7ihhntYYfoLSTuzWMUdvQfLu/bH+BggOVa5XWj1BWbmmPt4
	 q4b79NoPQgx4b5kV4jrRcu0X2TxKjXquwk93LbTS9ndAqPqEQLYl5bRnStlRxwPWh/
	 Xo8/GFFiFyeVA==
Message-ID: <sashiko-outbox-183103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/11] perf bpf-filter: Fix bpf_link leak by using
 PERF_EVENT_IOC_SET_BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-2-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:17:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In perf_bpf_filter__prepare(), the unpinned filter path attaches
> skel->progs.perf_sample_filter to each FD(evsel, x, y) using
> bpf_program__attach_perf_event_opts() and ignores the returned
> struct bpf_link *, leaking the allocated struct bpf_link_perf and its
> BPF_PERF_EVENT link fd.
>=20
> Furthermore, bpf_program__attach_perf_event_opts() is designed for
> callers that transfer ownership of the perf_event fd to the returned
> bpf_link: when bpf_link__destroy() is called, bpf_link_perf_detach()
> unconditionally disables and closes perf_link->perf_event_fd. Because
> evsel->core.fd owns FD(evsel, x, y) and closes them in evlist__close(),
> destroying the returned bpf_link would double-close the perf_event file
> descriptors.
>=20
> Fix this by attaching the program directly with
> [ ... ]
>=20
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/20261020053226.55936-1-n=
amhyung@kernel.org/
> Fixes: 56ec9457a4a2 ("perf bpf filter: Implement event sample filtering")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D1

