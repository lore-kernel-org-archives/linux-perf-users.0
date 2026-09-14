Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FF41A919;
	Mon, 14 Sep 2026 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378857; cv=none; b=toA3W67i2wN1M060CAUhOZvE4Xeiw16hS6l8niOOlx3LVzOTEnskllfg/kK6Afi0z8RV8PTfWYz4trdRzUlG9+Dc7gdnzcGNJgIHC6y6F5U5y1bDRXqiodSwryYsV7jn94Z7c4BDPADgynVOTx4+7hw/b3Qlml4YfKZWMrnh3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378857; c=relaxed/simple;
	bh=qMmFBaf2m5aYuaj9hBj/h+oviKtKkKHpwUm9Scn6cYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPQsq1Oq4+exoe0XZSkHtZF139aWs7PxQYkTv0lqAsNwmH78mZWQefULhsFk55HT0TV2O0uhpmyzAx9HLrpEriNio3DoveWRBecHwkmwyjf94iQ4GaZaeJRNCFlu2iZaAzJcuLh54IEPoj/rjxopIPihDJ8LeQfTuLODRcEGlkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTZiS1ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTZiS1ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837D71F00898;
	Mon, 14 Sep 2026 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378851;
	bh=qMmFBaf2m5aYuaj9hBj/h+oviKtKkKHpwUm9Scn6cYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DTZiS1veIG9tXc9+IwE9J0WEYI020XnG15ngZBYdah1rHvTJ0BSpILLfJlIWVSPD9
	 eFCc4g7Mc8hP+2cmd2RyStlg4XrOdHpm1r2TYQYrvXVIy/g4lCXhIipWXfJZFqT+tZ
	 HEuWkOhmE0ggj9gFW4gI3QOhbMpSLcHPoX0k2G5I8fANVVrC8zXtCXMMLPcExVwwYP
	 H6gJ6p4XWwproWxAXXgKOyW9kz6vnaXMnKrx5kbz9nb1rfoSMJPudd5hknWZgKlcCf
	 MwYEke4gjEKdmWq4MfZEG94V7Z1kxuRLeYKkWQcmD0zxE5s11ogR4PgU248BsRGpbc
	 78/fOrM5wY6gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/7] riscv: stacktrace: Add frame record metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260914092648.51254-2-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20260914092648.51254-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:40:51 +0000
Message-Id: <20260914094051.837D71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> Reliable frame-pointer unwinding needs an explicit way to identify
> exception boundaries and the final entry frame. The existing unwinder
> infers those boundaries from return addresses, which is too loose for a
> future reliable unwinder.
>=20
> Add a small metadata frame record to pt_regs and initialize it on
> exception entry, kernel stack overflow, kernel thread fork, user fork,
> and early idle task setup. The record uses a zero {fp, ra} sentinel plus
> a type field so a later unwinder can distinguish a final user-to-kernel
> boundary from a nested kernel pt_regs boundary.
>=20
> This follows the arm64 metadata frame-record model, adapted to the
> RISC-V {fp, ra} frame record convention.
> [ ... ]
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092648.5125=
4-1-xueshuai@linux.alibaba.com?part=3D1

