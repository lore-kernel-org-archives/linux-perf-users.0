Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5474357D0F
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759048; cv=none; b=P199oz3mE+0F9o3IjxmrTDFDCf1t6GGq+UOZQ75YJR0C6aqTxPMvtAdrIE6yF7eLxOkR70BinbRVlSvTgdh2X+bepDLD9qngfP/Zs9pTF8Sc/mZEHelhvFnSlUPkDTmbLIiUutuRDDycG/vIQvGvUjaL1HuoFEYLiamm9e3RWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759048; c=relaxed/simple;
	bh=ZLxwj5EcnWDBMZhvR/6qGHz3DZO9EOdphDJqsBCxHR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bqdsC9+aMMmidvoWNpQOP1ReSApAV/lTQSV7i6EqKBcnUqO74lo5nyXPEqiXfMDdQHy4SQxmgM2fO+c4O0gTXyHDH+j/KLTYqgGi0EmzAfaNII8FOc9fKC8CbcTugHuEwOt13YgOSWUJp+I1Mpjfp6Z0hYF/LOIYlmVyzby+JnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebd8pa1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebd8pa1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344661F000FF;
	Wed, 30 Sep 2026 09:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759047;
	bh=ZLxwj5EcnWDBMZhvR/6qGHz3DZO9EOdphDJqsBCxHR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ebd8pa1hemTXY2NyGFVBtTa8DNqtkrZwd4zXZ3cnaAGnn4+fqPH7u5L6kuudZFJ00
	 +ZFFthrh6H/TV9j6yIvQntas18JssxYTp97uTFsYfEEsx6toxMKpE2nYFkq5MTaY6K
	 v8Y/eIFlH6arcqH1JpCn4vDtMN/EBYRw5Q6bd9aW4coouTIaJRjFBl3Sw0wbwHuHoc
	 m5WBj3T+es2v8ml00Y9nkCZH3oRqtUHVYsHXSeNfjfdFcNp1nczdmsrQUYFDP/jYXo
	 LqSWdVz20ieXyZiVP/Hk5wK/WX6nSicXF46un31JBf+Wp9Bn77PCf9r1hkzx71ahm6
	 dAZV2m2f29gmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf test: Suppress optparse deprecation warning
 with older pylint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930-perf_fix_pylint_errors-v1-3-f72151d8b255@arm.com>
References: <20260930-perf_fix_pylint_errors-v1-0-f72151d8b255@arm.com>
 <20260930-perf_fix_pylint_errors-v1-3-f72151d8b255@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 09:04:06 +0000
Message-Id: <20260930090407.344661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Python 3.13 reversed optparse's deprecation, and pylint 3.3.5 removed it
> from the deprecated-module list. Perf supports older pylint versions,
> so suppress the warning on this import and document the reason. Keep
> other deprecated-module diagnostics enabled.
>=20
> Link: https://docs.python.org/3.13/whatsnew/3.13.html#optparse
> Link: https://pylint.readthedocs.io/en/latest/whatsnew/3/3.3/index.html#w=
hat-s-new-in-pylint-3-3-5
> Fixes: 8a54784e708b ("perf build: Add pylint build tests")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-perf_fix_p=
ylint_errors-v1-0-f72151d8b255@arm.com?part=3D3

