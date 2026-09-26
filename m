Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591BB3939A2
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449820; cv=none; b=KJP9icwu1CNEH/sB5W+1TJJmszjujcVuZD14+jfqEFVu3GyHg6vq+XH7Z8RDWjznkg9QmMWKE/H83Zrx1UL9tHbXF9feAse6Mk6WYVyM0gL/iBbNqEwcXrDOU0zPwJntuAMfDZ8UoIxAAMgCqkfPeUmuRa6YUa8SwOfwMV2w/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449820; c=relaxed/simple;
	bh=GPL+SyquVoqfNacn4iSpgM3iSZDkNTG5F0lD7GK4MCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jDhuPedAtDV+6FBtyuDMADFBZFG9/tz4ZNaj4O1SS308YMnksgvLmMbgSFBSfjSHsvojWgY0iNfqBjxwS8buV0NecIImaikd5JGB6ZTwgm+mTiapDxLtO457Z4oE3HSorXx8RhOJjkgDzJESKFkuBGnCu83x3TzSEnWfxyjptEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFpN602d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFpN602d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51631F000FF;
	Sat, 26 Sep 2026 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790449819;
	bh=GPL+SyquVoqfNacn4iSpgM3iSZDkNTG5F0lD7GK4MCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QFpN602dfQxJMzXvFiQ87sHNdfRnePytYkR0DxkQIsAgI0ssHt/DpsEcdLY8VPLJ+
	 6FmiF5wNTvuy+zzd1J1zfTswhqxPpDe8JhEPHR0XXx35+BDHHHWv9n1+sCvkucAhRk
	 FBaidrCeW0SXaugTswkzTeNBEa/9BSphGhZOK2DE6KoIcr6Lo6msNUYJKBV1I6wbHo
	 xx6bWpbhJhcQxX06qxS84EG4Ezon52NIhjg1/wVzw8GA3DUZWfv3snY6JTx72ZOBWu
	 yMPZ/FU0NWr0SNSBlQTJUs7ECatjCEqm6qqEMpi5CA+UmHAct9Ckjqjw2q7AaIWn7y
	 LH/jPmophIUZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] perf bench futex: Reject invalid -q, -f and -b
 values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926190407.1106421-5-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-5-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 19:10:18 +0000
Message-Id: <20260926191018.D51631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Some values make a futex benchmark hang or are silently ignored.
>=20
> 'futex requeue -q 0' never finishes, because no thread is requeued.
> 'futex hash -f 0' never finishes either, because with no futexes the
> workers never notice that the run is over. A negative -b is treated as
> if it had not been given, and the kernel simply auto-sizes the hash.
>=20
> Print an error for these values, except for -b -1, which still means
> automatic sizing.
>=20
> Fixes: 0fb298cf95c0 ("perf bench: Add futex-requeue microbenchmark")
> Fixes: a043971141f1 ("perf bench: Add futex-hash microbenchmark")
> Fixes: 60035a3981a7 ("tools/perf: Allow to select the number of hash buck=
ets")
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926190407.1106=
421-1-michalpl2003@gmail.com?part=3D4

