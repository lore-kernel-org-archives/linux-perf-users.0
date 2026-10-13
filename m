Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0A5208DE
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898480; cv=none; b=ktx5NKZNAvr+WQAbwtu4gPU3O34sIXL30OAIwi0HC7rMOUZE/fl3xGocOsCX8nCqV04376IudEKjWKSkS6+41v719u4y86kBKdcWXnhEIGf+yryeO2yilEEkkhh6scKQ+JMY7cv+uCu6xFNeEzuF/UBLwA9UqOwG50I2UgCXybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898480; c=relaxed/simple;
	bh=GBr57trTW4G3RlS3Fu/jCG8kUhbrEMvX+A4VSs10pm0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lrJ+rY3IneN7WoKYAc/XK+0mgFSrToGmwIC5uU0ZQSu02aRQxruQWIduyYGWhswAHTmoCis4HX2XNn5G1rk5YLnB+8zwztFDtixxdOWk1/e7xrmNnG46rroFPunm4Tujv7hEyDaPOauwrx0xRlqHkle/upuy/hORJ8mPIS+nupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c90aftvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c90aftvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617521F000FF;
	Tue, 13 Oct 2026 13:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898479;
	bh=GBr57trTW4G3RlS3Fu/jCG8kUhbrEMvX+A4VSs10pm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c90aftvyqFj+96bGnsVnDIu9TqToR809ZbGFganspGvdC4far3IC5Hw8EHFEwCA6S
	 aUvhDQX/fMX3AR659AlwXZYWOo1v5rayI2PZ3b/yFPsTGudwluWculFPOnMo8FSReU
	 gAWVQoMnCtz2P7hNyo/Brfw136CbBCg7YjsZptjX7xzp6LiEjkOG4TXgpgUHi5y3SA
	 NyE0FmiV19r2GKWmWV9SbFjdZr4MGHT2jUIe1pmJSD22+op0GTp7SzjKuv1flJH1WR
	 nTDjhXxUpCPZ6YN1+nSquWYw8NYEaXOyoz3ejT/AhrvHCGsHkDVCYBqTF0dIMlQW4a
	 kMhW4uFSAmSxQ==
Message-ID: <sashiko-outbox-169825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/15] perf annotate-data: Extract
 invalidate_reg_state() as a common helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <54195831b0f1beb8b2f086d29419913eed8d83fe.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <54195831b0f1beb8b2f086d29419913eed8d83fe.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:34:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The invalidate_reg_state() function is currently static and only used
> within the x86 data type profiling implementation. To prepare for adding
> arm64 instruction tracking support, extract it as a common helper that
> can be shared across architectures.
>=20
> No functional change intended.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D1

