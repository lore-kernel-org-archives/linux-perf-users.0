Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E6338E100
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510581; cv=none; b=FSZXzhq/Ed5L8af4h6/MEaYC8w+qaLy+77QocSvKiDaIuIVVuV4fQHDJsx8Jfmr50vZ8K8fzN2RuzA4ZA3HMCd5v7w3OtDj42aT91KY2Cdnf1YzfxtqLAw6yntuRD3DBcWGMHjHVi47vhyWuAE981qVyTNbZsDw7mofYQArJJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510581; c=relaxed/simple;
	bh=W8zG9g2FggA12fQ6c9tPksasNAkc9t5YwQ6qdXHEmwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KFmx6iNxVtAdnZdye+zCLH55Pgbr6NG4ejjqjlNEotBHNUOZ0ETtAOArXKKzmiRv+7VpfwCkJLyP6Xytt5GTkukIOL+8RqzRi8PNzwHi0i04muznuP5aNkwf5DbLIadL/5v4n2E6jYwCQ5CPLj+sNfvDK6F9M27/RU46cb1VpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6nD9lVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6nD9lVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169F11F00893;
	Tue, 15 Sep 2026 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789510579;
	bh=W8zG9g2FggA12fQ6c9tPksasNAkc9t5YwQ6qdXHEmwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U6nD9lVfoCw6LSorpCEMRiDt6lJxWo78q/txmtak0kVRqMTTB6XcOEih+OfcGczRD
	 P+2CesqRpk+y1WsHhmlQX+YURa6lxBaFsEAHVNl7Pqlf4DEja6XMyR9q5FKEfPXRhG
	 TfYkE5CUoyhV2xxi3xY8sNMKZbTBykxhw07xzYA5XZqECIuMcPiw4ZYl2K05wwazi6
	 /3UpttwxDo0CoqayI5nt4O2MIj3gHWIHOTNsa5whaN1KMz00oSynUu/6vXRAynkmJy
	 /q43KsZgSu94VF1JcHx0k1mFqX+Kf3Ohp2d+ZzBjeHPR7pY6Sk+QNMwKyE2eKTYxv9
	 XdcgTlFIKOdpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf bench messaging: Fix the formatting issue when
 printing.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915221122.2174928-1-irogers@google.com>
References: <20250922091736.2798-1-liujing@cmss.chinamobile.com>
 <20260915221122.2174928-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 22:16:18 +0000
Message-Id: <20260915221619.169F11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: liujing <liujing@cmss.chinamobile.com>
>=20
> The unsigned int type should use the %u format specifier when
> printing with printf or related functions.
>=20
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915221122.2174=
928-1-irogers@google.com?part=3D1

