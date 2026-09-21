Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99335E931
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969362; cv=none; b=gdmu/IxPJfUIF86ctpKvY5cD13Evj+v5K7en9dUDh39wi0+uSh0vWYXttnxqKYecD5AhQMaJ0iTgxcFBu50um7Wa1Zr59jpHNinV01cPO8RTEwn2c/mIp8uRLNaK/+6eACZ9/bx2aRLLY43DNfPWQpXhEooOhPiQAhNrLR9Z2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969362; c=relaxed/simple;
	bh=rGgQVqnVkWDltP5bMcS5NurxP7U7AkHZ6pYUXO75abc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bnOOOQgQTKuOj21doSdrsJjye6MbQzsgASbawK4+7mYI7RdXzFfKoa4EL1NfEZB9mtwE90v526CC673l0QgSmOsr8ky++T5CuJ3sj3Ix2k5RistdRZ1yW4xH80qxsuDOwmK7ehZBNb8dOZSBDPNjKqRcsKBaiGw8vWw2yEKuzu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOzIavum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOzIavum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270431F00898;
	Mon, 21 Sep 2026 05:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969361;
	bh=rGgQVqnVkWDltP5bMcS5NurxP7U7AkHZ6pYUXO75abc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOzIavum+Xj0v/ZSOhbo6ddoqBQIOfr8KFFUpfGaRqqkpVcEsSy83pXdR9jq1u/uw
	 VCkW05OtirPP6DXRlh9SzwRKLGCR+yazI94VDH+OA3/uLq+bXJx/SHWl/bGHmbyEHq
	 j1euDWkqUAUQIt2Zh8dxLAY2lRQn7JnUndIANsMX04l/DCa2NsAzjim/dp+lfMJG9O
	 lTz++4aOzrqc3B4ni7teSqndBQfWW84/fErZT1Y/nQQuhzHbmWE4bD9N8K6dyh8WAM
	 EtBWRyIaiYM85Ebr/hVgf0rgOBoWVcLPBauKwjEQz85/PRAj/Vdua3NsYgLhqYDlyx
	 /8OSHyagtwznw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 41/49] perf test: Migrate Intel PT virtual LBR test
 to Python API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <1caa73a4802b459f83ef8d4b93893c32d392192e.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <1caa73a4802b459f83ef8d4b93893c32d392192e.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:42:40 +0000
Message-Id: <20260921054241.270431F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Migrate the Intel PT virtual LBR test from generating an inline legacy
> perf script callback to using a standalone Python script
> (perf_brstack_max.py) with the brstack iterator API in the perf Python
> module.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D41

