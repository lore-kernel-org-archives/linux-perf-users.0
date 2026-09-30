Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62546F494
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799775; cv=none; b=pxaoSnls+FyWE81J3REL0o4JX+R7aFKdmU5BsAomXRVpU9ucGJ8YLioogudWLtObgirM8upKSNkb6OWsUhxnaDcL6yOYWG3upWWG3QfOUc2W8sfSQ8lKkaRUoMUVlIcHXM4wZ8jJDqVXSXp+o3iWP0Kpcbljd/bjypWa8GVjzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799775; c=relaxed/simple;
	bh=YeQZoZHg2XgbxQQjkHiqOUmzT4q+qvZaMW1mpmAnAoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NygCF4dJdyc0nrw30N1mcwsNuYoxYfyHgZiuqBUg1jw6snKt8/GaoLrd2dp+kuIAUl4N0hBxZj1n5EQvHpOjDTz6q8TZGiWX423AvxtL6EjYvtJOwji5MP8cYqXb+7Q1ssnmEtCDh5vppvS1TBarwNTMPcDHM1UqevvjtHTKkfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/I38UYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/I38UYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9861F000FF;
	Wed, 30 Sep 2026 20:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799768;
	bh=YeQZoZHg2XgbxQQjkHiqOUmzT4q+qvZaMW1mpmAnAoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H/I38UYBuSn7W1wRrH2ljtgCxOipC2iLDGjVs9HTwuIgBd1F1t7Le0PNVI7muRjwO
	 QdfFL4SBjKGww6GXw2DiHtDSxXFucLGC4qG47UZofSxROLgzFelj2L1j76HFlWb2Ui
	 K+zWCpGIb+IirXJgCu1NKA8Nc+EUuzMSL6ofOR04lsS/NAkPKYLdP/oYx5Ec3ZaF7N
	 vvSkewiLOR7M869IjHl5KctaNUpB1KiNbIW4t1ODik/pLDZ8cCtZmCT3eKfKhCqunt
	 Wren0yv6YyFogdIm29SF3pGcgBOIWb9WcEx39OLOecLXlbKYQROMFzPNjuccbq3BRQ
	 gz+oXX6ZCvCsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2] perf/x86/intel/uncore: Use sysfs_emit() in
 uncore_event_show()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930201617.111270-2-blum@kernel.org>
References: <20260930201617.111270-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 20:22:47 +0000
Message-Id: <20260930202248.1D9861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
> is preferred for formatting sysfs output because it provides safer
> bounds checking.
>=20
> Add a terminating newline as suggested by checkpatch.
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930201617.1112=
70-2-blum@kernel.org?part=3D1

