Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B98368958
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182642; cv=none; b=S0n+I2kNl8vbb7tNaJSACHDzKYV06oRbW7DYeuYlPQ2ARN0UyTyOwvSEsYQ/cYwtDEb7eQ4X6AUkrID9g9LdcweNz1HXHlIJ/tQ7/9Bo4RXjsRLxXyzny+wyLik+vayFsW2gvyqrbb61jhdAxss4Ou171OKddkmIYlRdN1d+nVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182642; c=relaxed/simple;
	bh=78HqEVtEBoq4AkcMEa0qJLvXN3kciMWK+J2je9g3Rq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XWoxW9pY8SpzEdgI92VX66d5MOsvFNWw7gG9qB4a3wbxoLFrsUTWirJJtN72AARlZEgUO7NYaqsj0eOuGw5uhOrCs5iJv8X3i+1/gJO43zqoiWMrIoeFEtW3siqe9SwXpcrwNLvaH92/QVK5yYCTFmkGuRkeG1j/peSDOG3P3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1tUWmh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1tUWmh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7129E1F00893;
	Mon,  5 Oct 2026 06:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182640;
	bh=3vOsMQQCbro34lqNezSVbM4cCqvk1lphfPUwE54csNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O1tUWmh0pJcCjaeK/0v8/FfoRk3KXq56ZnQt2sNdgdC/sPzYraU/Xg7+uI2JgT0rZ
	 NAyWP4x1bs+t6ldMVNieqSf92ZyN9bBprhYDWTWp34fKvX/INsHs9ekiI39BV3D+D2
	 g3dRkfaJsPlVr0JcTNev0TfNX9PjTwis5BmzMkii+Md0chnv3INYZ4PuE5l7x/Smqi
	 tGW3GazkWwNLAM7hQ2+amPq7PIaoj1swZj+b0O6GJS9py1Mr1wIQpNasVrZuLcraiN
	 HETLW4PE7K5/2IUxAZm/1gaEQB7Z9yOD2OT+Hl+LJG3h9GK0+wdrj+31yt2KNoSo5f
	 HTQh6kTGV8omg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/7] perf symbol: Set dso symtab type for libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005063411.114244-6-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
 <20261005063411.114244-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 06:43:59 +0000
Message-Id: <20261005064400.7129E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It missed to set the dso symtab type when the symbols are loaded by
> libbfd.  When it happens both syms_ss and runtime_ss may not be set
> and won't call dso__load_sym().
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005063411.1142=
44-1-namhyung@kernel.org?part=3D5

