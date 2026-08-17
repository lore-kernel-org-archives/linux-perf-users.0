Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C103E022C
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960501; cv=none; b=mhqXZqC+DNFr8QmbYxnmvVhZaWksh3veHtjfty1iFNcuX1hO7Yz1a3vAYARr+W4ADjwKQh46rk4uQU2wAl20XruqMUpt0I6RFwdol0Rm9yHE9f7pMVxv/ySVx1Wj3D1mZcSpGF4vWXoXWtn0uSHMBY09EOQlLn6RZFCKy0Nh8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960501; c=relaxed/simple;
	bh=fCXmiRbm7E99XcmhvOoAgs21MGOCQel484DZVo2rz34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kQ5iliO7/ojXpZb2uw6Fa/Km1CsRQCegfF8YjgarCaP5yOL1INHN/ye5rp7jQwQ0GIlsOeCF6Dm2qd68JzdQgcX4vWYnSnI6M7tyVmCMvc9+vpbRol3kSzmvdnayTUC3COp4OpSB+y2leSr0eXv4ukszKxlzKlAwIkNnc4sSF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHuSfqed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHuSfqed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EAF1F00A3A;
	Mon, 17 Aug 2026 09:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960500;
	bh=fCXmiRbm7E99XcmhvOoAgs21MGOCQel484DZVo2rz34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHuSfqedvbWsTmCZaLFS3lGpByOwyjeToq9zCqwqbKgx9kl6z0PYeLz1vi3thadfL
	 V9cQk9Jhl0sBs7pUaib7pjjRf4w5mr04Ni+uDYzcK1S7Ge0fHnUbEsNUAzJ6vetBLJ
	 cYA4q2udNakP8r4rpa2JW+IXKwv/7mEiZJ3KhRbiLNHg1F0cGSOXZT15qXlVf5/FEm
	 Ke1dEU4HMYJRdYD65RjUKXJv3wvwqcTEf5vSW9+y3PrypojihlJh4TEV+D4ni8HpQB
	 c/fUnahbKkYhnbrQrwENgrtvn8tcHjA0fja7FAgIHT13WtiypOL8UtGKpCgbgFyj8q
	 CekLLAOc4D+BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/9] perf c2c: build and finalize the function view
 hierarchy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817094623.3288456-8-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-8-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:54:59 +0000
Message-Id: <20260817095459.E4EAF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add the builder that walks the top-level cacheline entries and, for each
> read-side function, correlates the functions that write the same lines
> (level 2) and the specific cachelines they contend over (level 3) within
> each retained detail histogram. Aggregate the write traffic per contending
> function, resort by store count, and prune writers/functions with no
> contention. The finalize pass then computes the Cycles % denominator from
> the surviving level-1 entries after pruning, so the column shows each
> function's share of the functions retained in the table rather than of the
> whole recording -- the semantics documented for Cycles % in perf-c2c.txt.
>=20
> Expose c2c_function__build() and c2c_function__reset() for the TUI front
> end added by the next patch. The builder requires iaddr in the cacheline
> coalescing fields and returns the completed hists through an output
> argument. Validate the inputs before replacing an existing model.
>=20
> Function-view entries do not carry callchains. Suppress callchain handling
> while building and tearing down the model so the common API does not depe=
nd
> on the caller's current callchain setting.
>=20
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817094623.3288=
456-1-jiebin.sun@intel.com?part=3D7

