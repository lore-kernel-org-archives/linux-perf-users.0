Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700744;
	b=UGwPI8cybBUS6rfn4CwOXNBLkfodFBiCDv8Ekh5nZh9BCayn/dh/R0OCts4K8NoisguF
	 2gOMCx5phWFo3aZofWu+DEecf4t2RaHV92hBHLdaFwC5HaO1F1IsNr6QyX3Z9NUJO7HYS
	 SEmnwri85rQhBdBPZMnuky7iIVsGhiXapvCsCZi+UbMod3tnu4IH/NgGTzWbdfidyDcQj
	 tSpMyYl+OYqcirsOazgHZOwQS82961VMmtBMCLyq07iHaprEFvSlS50LdTpggi0UOUKb6
	 aFMmXIOnHg99uTBbNyYiRo0HieDgR1VJgAtPKeajwpQ5et2LKwSPCzIKoHHojQOJosA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700744;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MhGNhZvRtRtngGJmegra0t0WNyIKGy+2J/JPulUVuOA=;
	b=Jb3d3DrKvhn8uFJMH4Pl6NiBXb+YvaefF4rAk3pWDLHiVhZ0zb16RG/httxapzpqe3vd
	 D1jmdv4V9RAm50UUdO7VZMwJido2Yc3bykVZTczh/JjhE+a19hZoUe5TCjQ+0vg0ITBKq
	 Ez+nYyfxUUNZbOW+duJYqDs06lUljpsjYv+qLW1p1U1Y/F++1stU8UlZw22/L0peLI5Gz
	 LWbuU+CUHXsimsnbkmsTyq6K6C0pS17pqru7IkJdRnVlxqgx2ehlvszYVXuduqfJTtNgV
	 FzjO5eK5QJioyglL/I8TezKjcQXxoi9ShzbDjRAJMpiZYOM0FeU/Y36zefT11oMYhZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6sf5WJ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA3606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6sf5WJ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE431F01825;
	Thu, 22 Oct 2026 20:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700743;
	bh=MhGNhZvRtRtngGJmegra0t0WNyIKGy+2J/JPulUVuOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J6sf5WJ64CtXQxsUO3nvHsOsYGJvPDXHbi6XhLqYODcFTvqOyncDFn6Qa7nsJB/+Z
	 1M7D1ksYYb2218+NlbKBiq3DC3Goqlhg674GkfYjWQvD5KcjUYVT0NuIhG/DuS/+e6
	 3l0y+9/oGUkCL0x77mAAgfZMrVlw9WYhoyatlj44sQvz2E5cLRHGeEep9WwjUSiFH1
	 L4Onv0mwKGPFK6W8RD8pOT3NrrHa54Z/Ssp84aaE1M3OIXP2ht8DwqVlKWiGySLSyg
	 eR0In24sv1tQeGq/Am+DpqaZyFpbeniZ5jSmJIjI0oiMcXU7g0dlgLHqA6bHlWIA2k
	 4OaCLRl+P4oQA==
Message-ID: <sashiko-outbox-181998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/19] perf dso: Pass dso_data to close_data_fd() and
 dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-11-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:25:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> close_data_fd() and dso__list_del() only operate on struct dso_data
> fields, while close_first_dso() retrieves a struct dso_data * from
> dso__data_open. Pass struct dso_data * directly to close_data_fd() and
> dso__list_del() so close_first_dso() does not need to recover a
> struct dso * from struct dso_data *.
>=20
> This removes the REFCNT_CHECKING dso pointer from struct dso_data and
> avoids dropping _dso__data_open_lock in dso__list_del() to call
> dso__put(), preventing lock-order inversions and races during EMFILE
> eviction.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D10

