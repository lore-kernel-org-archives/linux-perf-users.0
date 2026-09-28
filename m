Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB038911B
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620660; cv=none; b=o+bF13b9ayUI89hFpJXee6Hkgy6zTOJrA/k5Qx09pJt3gLh22F6lgTSO41vJP2/P1Ty9fIuIaN/1t+0YxLQT9WD8hUx9EAhxFFVd88jQz7z+GlH8CJnppPV/e8hbYuJKfwdIetRrRGjty4Uo6MdXie8SzecZM7V6zemdfsRaI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620660; c=relaxed/simple;
	bh=BLwN2D0CP+e5/gQp0vlYS6zHQPcp1l3zzTX97X1KnGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QgpvOCEhMy/FwdVfMhvPFRWQ0XKjEGR0yRb71IE0Ht53nNsEp0Eu73MeZgtmyUto94iBqm0BOpQcnwNoBueXXQTVVKFkaD2NnRD0nX2XFmBS44iCUqRUfHLSersWF9El3yiCHEWMsluW7eMgfhZJOHq2TvtpuXRedo4mn248K8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SogVy456; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SogVy456"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7071F000FF;
	Mon, 28 Sep 2026 18:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620658;
	bh=BLwN2D0CP+e5/gQp0vlYS6zHQPcp1l3zzTX97X1KnGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SogVy456p6LzwNI/ec6QdCwrIOGBTR563kwcYk5ehhTgRlr/98L/+tsI3bMHpHwix
	 XxuQhRoDn2kZ5PF9ppQQrNotR7/+iZ7SubYbWnVu6kfXUAVfVpB3TufyEl3ukYSr9O
	 ScnMwF31bQ4IeXClpkfA9RySls0VVjplHfXUDtY/44CLZRCdzpJBSGnMGp4Jum5uyg
	 0vi+oHQ39g1XMkhT2eepMSr+VU4iVe6FrDFsqfiuqphNnemv3jyPtKJBd/du1Uzns2
	 evJxAWMEGeGDYIKJa++9OgATBjulS33JS1hpXKFvkgH35b01DEZb7bx2H34eh3w3zb
	 w1HXpvFk5zq3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/26] perf trace: Don't allocate syscall arg formats
 for internal fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-10-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:37:37 +0000
Message-Id: <20260928183738.2C7071F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> syscall__read_info() sizes sc->arg_fmt by the tracepoint's field count,
> which includes the internal fields that follow the arguments, and only
> then subtracts them from sc->nr_args. syscall__alloc_arg_fmts() copies
> sc->fmt->arg[] for every entry, so with more than 6 fields, for example
> renameat2 with its 2 path strings, it reads beyond the end of that
> RAW_SYSCALL_ARGS_NUM sized array. Count the arguments before allocating,
> and pass the array's size to syscall_arg_fmt__init_array() so its walk
> stops before the internal fields, rather than stepping beyond the array.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D9

