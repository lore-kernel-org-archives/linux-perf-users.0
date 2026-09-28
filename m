Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D237F31D
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620585; cv=none; b=OtX6IiRgaEAwGacKzaJ26GyNUgWZG11NGbUisq0y4KHrst9oQMf4RuyUndyalVh9XkB5iNr5RTw5XZ9uUQgtXmGIIsDkamxL+twE2bK3KaCvps/3lgCPKjQ7BQ9PVfgAXTLS9RWtRg+sRyh8r9N7qM2pP9JjJl0znTuoTBVueYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620585; c=relaxed/simple;
	bh=62k2HPtbHUYLSqDE/ndkL0yr63LprpUJRUoqjaJSq2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZCB1/W7Ri+ayJT4iD0LMYyeScmVVw+AIRAKc/RKiMnpTaXOnpwDW4qwBGKpaj8vhSqgGfXg1Vt1yq/OBS3Bu7QaqzOa+tzHSKxWovGsR3EWImqNiu254F3AS4Fk/Hm89Cb0zJ8oVFmDni5wr0m0Vlocn3o2zCDAW53Hw1PZt1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktK9rEGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktK9rEGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7450C1F000FF;
	Mon, 28 Sep 2026 18:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620583;
	bh=62k2HPtbHUYLSqDE/ndkL0yr63LprpUJRUoqjaJSq2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktK9rEGvzO+r46mc1La6s4bzJ5+Skpq/VeOki1vBtGjT+5AMxcQ1mpo2ADFbwj4OJ
	 7QM8I5U0Gyrv1GWjDIHnatAUQ7ol9FB03uHsXv4Pj+U6CNserc6fU0OfWaztxE/xXX
	 dQQRG0rN09WQAKUDuHZwjZY3qgdbXamF9+r4PyyujKDGckQxaWAGo8PpCPc6LeNoPf
	 npRVqci8vZNexDotwnXLnDDzCDZ5TvVcme9k6wxSO4FP9A0eywb5em2cC8FFnX1h2U
	 EkWDCFSo4AavJa3Lp4993x6gqx3yqIVNIZHOSOoQmYjbwlDYM2SfDFmuylLE1gACIF
	 e44t2NBJpp+Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/26] perf trace: Stop at internal fields when
 walking syscall arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-9-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:36:23 +0000
Message-Id: <20260928183623.7450C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Since v6.19 syscall tracepoints may end with __data_loc char[] fields
> holding user space strings, these aren't syscall arguments.
> syscall__scnprintf_args() walks them anyway, printing the extra raw
> syscall arguments at those indices under the internal field's name, and
> trace__bpf_sys_enter_beauty_map() considers them when building the BPF
> beauty map. The internal fields come after the arguments, so stop at the
> first one.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D8

