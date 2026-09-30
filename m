Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305C4E1C73
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774045; cv=none; b=ktjZbZcNAVS1nlQ1mN7cE46AJZvcETTWNu8oFxO5cHVR9zEmoUjy8n6pAHMiKwGaEFa0wpcouFAqADC2cPds4dNX5CqhlJDMqwz2157Xu5jtPPQcTnydfGDrL+HB3vYoYVI9wsv/heG48xLrvji2QZkvurhYeKcMYR/fuRfHIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774045; c=relaxed/simple;
	bh=KiSllQLHC2jaQNoJq82dTrOukFXJLUqnvCnG/gt76Vc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=isHSl9O/QSqyOBaphMwonWy0Avv2gKGpk8Fe5fIekRZj7iYr+++i4iMnbskeP9ncnlhUeO5rwSEPy41M0K6rKBGwiQYszCbmtdZ7yjuaZPFRZgUhOQOn6PyTI+mFwlbUAvYsHcjLrocVFFjpr7uj7SLTaPx38E9yPAWkCjwdHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzCvTZii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzCvTZii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235D71F00893;
	Wed, 30 Sep 2026 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774027;
	bh=1OiFZIJoHn9wCGyKV6Ip/+6ZJ9ZjRVXrv7hHDrD8/LU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YzCvTZiiEPAc4SBNFAVk3yn1qkkVguEXEqDMWj8NrDSka7dKnfLK1b4AoorkodrKv
	 n+yaLnteUMcP/91B12+HzhJspgWXaOdK9iIaJ6cqbgSg+Ots7gJHnXm+fQAt6tqLJE
	 us/yQtMOY+ywu4vhKckzsOabFOPA9HuGo5PSad7QevwW2aqCIJD7xNgA2ggynf89yM
	 6F8ExUVKvCGOi7gR7cCddtHEY1eo16O2Ypxi+pZ8i6o7uLp8CioMBrQ9Sm7b1QcGy/
	 S1WgBIjOgv88Mi6lV8zk8fS8HVTSvzMuwWxyo/JtgTdsS+EgR3Es8uQ+Iw4wASDvfy
	 akxQiWUeMN8Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf python: Avoid shadowing exception name in
 PostgreSQL exporter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-4-945cd526576b@arm.com>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
 <20260930-perf_fix_pylint_errors-v2-4-945cd526576b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:13:46 +0000
Message-Id: <20260930131347.235D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> During the perf build, pylint reports:
>=20
>   ************* Module export-to-postgresql
>   python/export-to-postgresql.py:319:8: W0621: Redefining name 'e' from o=
uter scope (line 100) (redefined-outer-name)
>=20
> Rename 'e' to 'db_error' to clear the warning.
>=20
> Fixes: b1f968c9656a ("perf python: Port export-to-postgresql to perf modu=
le")
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-perf_fix_p=
ylint_errors-v2-0-945cd526576b@arm.com?part=3D4

