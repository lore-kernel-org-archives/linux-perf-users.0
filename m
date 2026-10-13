Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D755C32C
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930983; cv=none; b=td8lDkwgJPj/76uwRA3ktaDg9IQ7o+AVA+6DBQUL5cmO/Pb8qtj7U4HK4kwrtkiAHO92vdxt1Olz4OqZ2iTxNPmhotvE82m7kdwmg1w3/fcEHXUSDSzEzNCrGFbqDyThNN6F/Rt3mc5073GsGFfX6CsGa7RAi3Da0Q0GL6bJZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930983; c=relaxed/simple;
	bh=ylCFM8tyu2b25zYnVxQGtFmfPNjKwdTnRsXiQ/4ajps=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pSz6lE5NESdbxxybar+k92ALrAsNNrDAcLtac5hJYsa8moiHRqL6CmIjsS6cZKD1VX8cCYwFTlzWGw1XzYhCOl1jmd/9ufTtIof6cmmm/hgg6CjePSH+usiMK7nNoSB7MHoohPc1Uy7xIC2ZfHZQlb4vNrblvLzCdiiED1GZ7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQiuE6RC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQiuE6RC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B1C1F00893;
	Tue, 13 Oct 2026 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791930978;
	bh=ylCFM8tyu2b25zYnVxQGtFmfPNjKwdTnRsXiQ/4ajps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GQiuE6RCLnq8720OBe5oajRqDuRQVKnVFq9RQEuhG+NtoUsiTYbQCnGftw/fBQR/l
	 +reFPZdEQgLwGfHbvKYXobRhuQ3JdjORw0SOjZlNeNLxP5feq9AOSGVwBjY3fJ57CF
	 ld10ygvHZkIEI9dcW+g0dd2IpLwBSwT+euCeir1G1v6nBMNPfARWN9aSj0iWDa1Lm3
	 1VTn9rW8ZsreFOgKWVKYW7Bh5SNpB+K9z50adjaAL+kbGx+7JaYwDm6zTFo1zubEG/
	 KvVqJ7iYANwvaCB9aVMmxbbYN0eC1PRAjdoN+pKKvkEcf/paluMuegpy7fMLWNu1hA
	 d450VJ05SpwrQ==
Message-ID: <sashiko-outbox-170583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-7-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:36:17 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D6

