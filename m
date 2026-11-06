Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949175;
	b=VinTGN/bvtPqcbhXJsYb+BvRwhTbQdNLnxbcP0D13tZg7KhU9fxzFkvGn0vRpXzZ0IFt
	 ZgHHtuQ+XM9FyuO7vvPVZBjCSwJX1dbDDXPo3FejjnEPcm0RzrQ/hHI6TB6uQK2U4CnOD
	 AHv2Ge9mUedIdP7dGrpC60JamFYk0p5rDuO4iRGQOHBeGSGqZ/S2qFmdBYWEp9BHxDYY9
	 Lshf+vhHa/MP50a3UL8zPBQRbDiDcHt/3uWc3Wm6/et5c5giBcYLOmQsdcCwnw5IbsBYF
	 G9dwBLYvVGBlXqIQqlT0G3raaIMgMNJiceA8xdwAc5fq/PYlbGEaM6Ghj8vUjxQQRPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949175;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fZkV8oE6XMAzF+RPJ0TqYMhB39ZjG4IvVAqQdml1pxY=;
	b=BPo9drzu5lxZofaXOQgYdFLxnr+PkxVYbR5WT8fDBV4JaiBhDoV0iND2w3IHKHAsTdTM
	 6qCCWrKK5aeRpHppC3SpRIhUly3BZ/0Cx5AL4qt6hSOfRu0i3rgDo7GrCDJzoQCytR9j8
	 QMT7klSS7CSkwsyPANqrdqheZxXlWrCJtTIyEgqop5rWL0/Q56yaBs0hVMwvEwZAbCjC+
	 nTQN+EhZyKMgVLOno1EnokHziYVw/HSK5vGwyKhtlOwHHO9dy6ztzKUFiatVA2R+uh6Xi
	 CmRHCy6lkNVU3pdTYf1YzyH2DICmxSrgdudaFg4xfCrlI0WkjJJ4qnZ2TdBQA6dwxLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktiC25En;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D34606D832
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktiC25En
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A041F008A5;
	Fri,  6 Nov 2026 07:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949175;
	bh=fZkV8oE6XMAzF+RPJ0TqYMhB39ZjG4IvVAqQdml1pxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktiC25Enewl1Ee+bAuWyE9eoGUt+Jmd9T6Y5P5wbtT+ayJNGT5yyA5iDLGrNygc9o
	 rj6xlNBAidC4KPY5F1dMQEcFtA5YWk6ODo8Kp1O4o0nMUbET93uguAH9uPtGc+cEdO
	 mgtK5MvbRMkRkXyXzH4tMDr7VSeNl9VfE387a8BEfBvxBDAutkscoQyVkHhCvzKXCX
	 INIWwGhwChE5enbR1dd32NjEEsR3mcPVgzpFou4o9uk/1b/ylrg80n0RjpUuu5Mg/e
	 fbRUleNop/AuUiUcHwtT5vnKhWhRD/dGpu7lyqTZ398fQSJn7nq1MmODET2QFBCiOa
	 0lC9H8SqCD1Zw==
Message-ID: <sashiko-outbox-200973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 16/20] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-17-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:12:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D16

