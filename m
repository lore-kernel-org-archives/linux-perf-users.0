Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C489442B1D
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406696; cv=none; b=dHOK6DI1P/iOqHvg5hiY4Dx0q/6+9Vpy/pH9Zhg1azxW+V6yKlYP276L9wfcTBnWT39wHho4GYDihQYluO3G7wpA1QoGqNc3UGkdOI8OBdvsMFuA0K7aNL1HOPP06uV5Fqab7GDzES6AOYVx8rmyqjTjPX10XafKaooTtvBeoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406696; c=relaxed/simple;
	bh=zl+2UgCxVfMUz9gmDGiDLS+04uBpEgQmZMT94mXJzuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDqgdUIk70ShCNCwfleJAMhtQHmQijTj0tFF947qUHPKdGb/PvQGaomrQdj5OV9gbY79WVDpO4CNsS/cRlbzb/WGESnm/MsASlm5I3sxHjYr+5ME35OVTkN5aPn2rNX4nl6XJLzrh549N9P0HzdC3YSUvmsrP7mZrcMKzZkWM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFct8o74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFct8o74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160EB1F000FF;
	Mon, 14 Sep 2026 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789406694;
	bh=zl+2UgCxVfMUz9gmDGiDLS+04uBpEgQmZMT94mXJzuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FFct8o741qm56LnIatA99oVGhBJNAwjBGSfAdEf2CjjMxj2sxUQZZiO8bcYS9jbIb
	 vgHZEMuVXki6bgY8Sp9HPYSeiBarD6GDYNkpUPop/G+byWiZ5kthBWyZztBdFUrE09
	 GIjEzLPTpBK1hFvxWJmB/o8dBHDdUkGbCKtTXlCBVOOKzcSJUt9JZ0VNN5UyVyFzyw
	 DnIeDnSIOtISYZuPSJiNMV9T/Cr6BPKbSxN+N/QSrgQaWRoZW4A5cH5HzSfvOHrlso
	 ZzodrpiiBq99ho8L8Fg5lQ1uyR4JoXLkGZI5gDkiNt0P7icRHGidZ0A6ECMeE4UYsx
	 QQkOj0aZ097iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf dso: Separate libbfd and cmd addr2line
 caches to fix confusion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914170759.1992947-2-irogers@google.com>
References: <20260914170759.1992947-1-irogers@google.com>
 <20260914170759.1992947-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:24:53 +0000
Message-Id: <20260914172454.160EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a dso executes addr2line via libbfd it instantiates an a2l_data
> pointer. If the DSO later executes via the command-line fallback due
> to an inlined bug, the a2l pointer is unconditionally populated with a
> child_process process wrapper. If libbfd is queried again, the offline
> reader attempts to cast struct a2l_data into child_process, coercing
> random arbitrary instruction addresses and causing silent aborts. This
> cleanly splits the caches.
>=20
> Fixes: 257046a36750 ("perf srcline: Fallback between addr2line implementa=
tions")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914170759.1992=
947-1-irogers@google.com?part=3D2

