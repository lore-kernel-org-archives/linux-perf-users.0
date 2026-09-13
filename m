Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62640B0E2
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339073; cv=none; b=dMYPl6R4P4oOvLk2dMExoHScrM2xhFpg9AZdQ9t/Y7lvy1wsjnOe4BzurmfAdXpo+GdlN6TnOXwP9jWPtYlJt2eaw+d99Owm+ZX+rA/RAH636OLAJLcaV8cIt8ogT42NbgHl1gdId92hfQzOEQoKW77EMTsS8tOPZSz4I+68SNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339073; c=relaxed/simple;
	bh=7GnZZK7D1jayjH+QiPZWOSg+iBKXQ21CEmdAG2yYom4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HxchWQgex1EEkc4aQWVH8YJ4DwSfvzEOuKsjdPMvpKaxf1XVTEM8Cx95RHl8omFnD03eN9SPjCNbV5yjPtrYjU9MrcYZEzwYHRXY4siRD4xV5lmJifuPukdHWnR9jB92j3AtXaQPWzACrxYlFeWGs98h00Rjk43+dXATOnkzkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B322fyFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B322fyFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794A91F000FF;
	Sun, 13 Sep 2026 22:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339071;
	bh=RyeUbtgje+faOis+SirGL5pVckuP1eORQ++cl+J6EVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B322fyFM8xkk0gaAre64PFkk8zPL2ZJR1w/THgwIB+QXQUdJr40CjwlYlXm9Ss/u3
	 ZAk1qoOe9Xbd9CvJnXTsR3NqHpgbTT/jAetwW6MZzEBe+mgkAsBh0aNA61KyAP/NW6
	 r7M9cp0idARHQDvYaKAVOKlJrDmWiptD2qqID7h37d5oGPqQ3DuoTDDyGeqoPUmsu1
	 ts0fmbE13555zaLlMm5pAyjTKbdV5pyyYy4VV8FALK29tSMIKjRbiXwcTFy0dOqg4Z
	 w0TwjYfNRRCRvh1xxGuOvY6j8abKGYb4v+zuRU41C/iW4PXFcntasXl87VPi8KsF1n
	 ewn+go3TkjnZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] perf annotate-data: Resolve type DIEs in the debug
 file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913222821.3353-8-acme@kernel.org>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:37:51 +0000
Message-Id: <20260913223751.794A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A 'perf report -s type' on a 783 MB AMD IBS data type profiling session
> hangs, burning all of a CPU and producing no output:
>=20
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf report --progress -s type=
 -i perf.data.ibs > /dev/null
>   Processing events... [100.0%] 746M / 746M
>   Merging related events... [ 58.0%] 293828 / 506686
>   Merging related events... [ 59.0%] 298894 / 506686
>   Merging related events... [ 60.0%] 303960 / 506686
>   Merging related events... [ 61.0%] 309026 / 506686
>   [ ... nothing else, ever ... ]
>=20
> It is a spin and not a slow path: with perf-stuck the CPU time used
> grows by a whole interval on every sample, while the [stack] mapping,
> [ ... ]
>=20
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913222821.3353=
-1-acme@kernel.org?part=3D7

