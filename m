Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05670339388
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389432; cv=none; b=f4QTYe2zRkJi8X4YD/oSUnxlbJ6ZIjqCluSgGIHOFgF/MZurNWCU6dCeKZgGV6AITC+9VzN9B/VF3Mbf++NFjBLak2wUwoVIj688EDsEHuxaFUDJUDsieYG7t2VQw6XkJO92NqQRjzlLr6EBnFoQ8Pwus8YGaID5iwFmOLndsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389432; c=relaxed/simple;
	bh=aMupW+meOb9f6N063TqI2vtCXR2nWJ3GkqgPJ8NftvU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oD9me/TvSQ6DP5Eay/OmzKDA6oje0psLvtu/ZB04Leu/wafPjEXK0DIjrFDRsdyR8k9A5Pscrgz0gsnbC/RRnAjRob7oJT2TpAgkKlKGliNMU6yovb6OEd6GC0/R4b5hLRA8dltP5EBLtGLF5LYd6hLUAk2DJ/vyDz4z0cQJoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC/rZ9Qm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC/rZ9Qm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656CA1F000C4;
	Mon, 19 Oct 2026 05:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389431;
	bh=+s8aVSWDljISvRCV861MgzJAVJaddV320iLd4ysABeE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DC/rZ9Qm44UZRouB2TOxVPuE0CBzm64/t21BanHm94GHmT9alKBjxS6Zf/vqXBMeC
	 tLMZ0l5HYDg2mz3iPs6wtYauFVV95lI9lRPqgbULGIGLeTTfo0qytTFB2Q9y89A14X
	 0jAwcp7Uiph+zs31Mrzw3aY78TJWdd9FcomMtGpbgDbTzqY+gUIGCF8WT1s3SGV0Py
	 q35Q2svpN7KvYLGrCsGb83lKHLHewhuSTtnHdjxKfzlX8LC+3cP+PUgo+F2YWC331P
	 ogkWYylDnxBVJm+k+GqHzDuu1LvaBSGIkiuds9NE4R/5pJh4vK4UVi0l36q/iRjIuj
	 qNYGCs6cWhgFg==
Message-ID: <sashiko-outbox-176676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] perf test: Fix a memory leak in PE file parsing
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019055207.39325-2-namhyung@kernel.org>
References: <20261019055207.39325-1-namhyung@kernel.org>
 <20261019055207.39325-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 05:57:10 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The get_argv_exec_path() returns a dynamically allocated string so it
> should be freed.  Let's check the return value first so that it
> doesn't crash snprintf().
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-168781@kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019055207.3932=
5-1-namhyung@kernel.org?part=3D1

