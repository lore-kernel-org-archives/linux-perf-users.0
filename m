Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1044A40D
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133172; cv=none; b=lDdm6nKm6cqV3f1HCzMytHCGgnRnDlRLRPuD9Ch1fJNKcvc48JgdaHoElpmXdSdG0JonJHIrgK5+4I3GmLLRqr96ErF55Ir6iTRPGqGu7j0cjGq+tl9czSahU+9bLAWTTz/50EDA270Dg6oTaLQGU3rPAns11iiL6Nh/r/UGFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133172; c=relaxed/simple;
	bh=Nyxq8qV/RLe60PoPteQ8OXI+VVupBSokQ46peq8M7ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CoeQ57ThK7YQZ41neP4aSYFW1V3N/ysXOHQTvGTXhrEcOKwu+G3WGJIbCqn9ssjhZASG+y07cXYAMELX8sHB4qvard2sKnGJ5XyropG/M45sZlw8cl0bvtz8PULhQ5STpvju2hbkOUP1KYXJZ2jjJiwUt3msqlK8PBfo99mQ/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6rWdJbA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6rWdJbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0031F00A3D;
	Wed, 19 Aug 2026 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787133164;
	bh=jFkJTyTM+xfxUUtKB7ZisfhWHAnYXSt3/HRRI7zgQnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P6rWdJbAxIxNxrQTZ5VM0WMbtI67Dv8hNPv4Cu2FlvPU927plBs0zfQtEv35JY1p0
	 bNJUM+2ogHh2+956P1TGxMJqQeh3h6laeTZFCaV/Bg6Tz+y17STge2kFuty6FF2KUp
	 eQE/RCAFxb4hJuYp+FnctmgTn67DR3NRdQUt19geXnAz6EUUmLD+DFG1PEq6zYy/RO
	 Y4cnEM+ccAFnUdghGolzRdqt/kFRB+B97CiA8yXFuezTt1sCEQNROB5TBcYgPeQi2E
	 9JEefgIn+Jh1R55N+NlDkEUikeRhstc1kNQqu7SEIRWpTu9puiHspjAuNSNVHBCl3t
	 ULKdsBeKXqQ/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf symbols: Don't apply the symfs layout to
 synthesised paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhan Xusheng" <zhanxusheng1024@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260819094621.844115-1-zhanxusheng@xiaomi.com>
References: <20260819094621.844115-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:52:44 +0000
Message-Id: <20260819095244.7B0031F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
>=20
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
>=20
> The flat symfs layout was implemented inside __symbol__join_symfs() alone,
> which went from
>=20
>         return path__join(bf, size, symbol_conf.symfs, path);
>=20
> to taking perf_basename(path) first.  No caller was changed, so all of th=
em
> got it.  Most pass dso__long_name(), which is what the option is about, b=
ut
> some pass a path perf built itself:
>=20
>   dso.c        "/usr/lib/debug"             -> "debug"
>   dso.c        "/usr/lib/debug/.build-id/"  -> ""
> [ ... ]
> it is converted for uniformity.  Every remaining __symbol__join_symfs()
> caller passes a path from the profiled system.
>=20
> Fixes: f182573e06ab ("perf tools: Add layout support for --symfs option")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819094621.8441=
15-1-zhanxusheng@xiaomi.com?part=3D1

