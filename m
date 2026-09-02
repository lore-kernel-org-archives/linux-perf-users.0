Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B78D377EB2
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333323; cv=none; b=U4MAeZDpl+CZCbHO5/FRouVEBErz2w1CPTDE1YYrt4EVeP819BvnUGuUsmF7GpwQxhzd5pk4ATYe4MxxpC69P2mxi6Z0V2fLp9+hPNW/t9gcUJ+i72Eom2EhuTOodF9IDsgVQRIAUciIuRwX6ODSkTcwSw7uZG/tIaPPmPqvL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333323; c=relaxed/simple;
	bh=DQ83WHaxFPmoJ22tvuJooBywoAfhZxf4kTBvkNfi6fs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mi5K+4d7L/yzgun4/z36r/gMaSZgIg6j8XT7miEDkBJnmT2v997wHW2WcxkU6MvaI08iJjLnbmwzSslv2qO1FEFFN1rYo6XhMdIB4mj5hFpX8MnigjMoKXTXf6NqLVyjCw96VV3g17H5b9lJp2xMZgftOx9ac6b2yUpSHHvLmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrtzLsu5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrtzLsu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757041F00A3A;
	Wed,  2 Sep 2026 07:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788333321;
	bh=5XdX8hOt49rp5UJt/IxUcDfKt7LK2/2jsO3LaH8hlY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FrtzLsu56o+a2nAMfkEWpOR0skhLZqU6cYuoYo3jJ3d230HBlM6jPswcq0MayzWNg
	 YujHGHtMp7xez9X6TPYrqyZrg2WaHuymHerwm39P1rCjSX7YjyqMJFrABhLh8TehBS
	 5Qbu+CWm3+UDxwf1n1DlBy+/NXgAViT/dKInY1Q1+oJEBbvQDffpCelxVPIyh3mNiH
	 N43nu15lCxptLnh15lhMlCz1Zl8M0HxVLyE5LxoyqnBdEfWlFNG0kCg7vvey3DsQ5i
	 LS4EL+eZHaVURl8J/zs2CIlXSFf95Gxj1swQpvC/o6cms2Tk5c/ld9mtfYmwyyWb0M
	 LddQJ6gw3ling==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf bench numa: add NULL check after calloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "longlong yan" <yanlonglong@kylinos.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902070913.1424-1-yanlonglong@kylinos.cn>
References: <20260902070913.1424-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:15:21 +0000
Message-Id: <20260902071521.757041F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Two calloc() calls in the numa benchmark lack NULL return checks,
> leading to potential NULL pointer dereferences on allocation failure:
>=20
> 1. worker_process(): the allocated `pthreads` array is used in the
>    following for-loop via pthreads[t] without checking for NULL.
>=20
> 2. __bench_numa(): the allocated `pids` array is used in the following
>    for-loop via pids[i] without checking for NULL.
>=20
> Add BUG_ON() checks after each calloc(), consistent with the existing
> NULL check style used elsewhere in the same file (e.g., node_present
> and nodes allocations).
>=20
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902070913.1424=
-1-yanlonglong@kylinos.cn?part=3D1

