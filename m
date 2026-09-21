Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ECE4EE87C;
	Mon, 21 Sep 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013804; cv=none; b=PxGoOHtG+4cuOal2iF7YMoBufhae9qfZfvu5hD/L73/eHpqmb1iC4/kOcNv8uwxHsXj0x+6fEAVZ2je7guzy84gs/cGvNS2Jdx515hShUA12lUUQd41Bb77uUCxEUhPBKLfimKCXHsU77iQ/lOFrkDIbFXzRwWPrnd4Do54GN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013804; c=relaxed/simple;
	bh=G17TTFwhQ3mDCucHSe6QFk7y5hNKg0+Dhg8uF7iCTU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TRnpcn1S/al5pULCuzgQEVNI/rFMzqKTGgP18f1NP8U6h70UG8w6Wb+VJ9o2tlfEvcK4Bq0oDP3V91cBlAULoBZ5yrvJQzVo2HO+HYzxzG7mRgdJPUKll816/wtuQ6yxSOGySDCCJ3LnL/cC/SLtCgmRz3z0ojflIxi+5FP2eXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWVcGuUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWVcGuUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45931F000FF;
	Mon, 21 Sep 2026 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790013803;
	bh=G17TTFwhQ3mDCucHSe6QFk7y5hNKg0+Dhg8uF7iCTU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KWVcGuUSRBoT9EK9ysQEe+/emDp1nMxEE1ytifXCFhRxerEvwoLKn7lBml85FDZ0R
	 Mi7XJKDttB2AEKDupujMgM5SaQjNv1myKsLCqleyahqXwhb5pG/DJ/nfDSjmO0T1D6
	 pr8AjwyHEtvKCPCHv7jNgj+reEgie8eEtCpOFszjGxfc7YmTEKv1JTF3t6iWYYc//s
	 Jh2oG9u9czRISHbiI1DDcflCs4UjCJPAly8gh7hxO62UDEaSXr/8zq03RtvSw9Lyqy
	 9EgzDkN7taKqLngixTJc6DVXhLh+uJn+t6dYbQPJhPTgqNpJVhDwfO33EaJUO/SbV/
	 3sBp2Eqsg8ngQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf tools: Put Python egg info in output
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921175719.846883-1-irogers@google.com>
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
 <20260921175719.846883-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:03:22 +0000
Message-Id: <20260921180322.B45931F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Ben Hutchings <benh@debian.org>
>=20
> Installing the Python extension currently creates an egg-info
> directory in the source tree, preventing a fully out-of-tree build.
>=20
> Add the necessary runes to the setup.py comamnd line to relocate the
> egg-info directory in an out-of-tree build.
>=20
> Signed-off-by: Ben Hutchings <benh@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921175719.8468=
83-1-irogers@google.com?part=3D1

