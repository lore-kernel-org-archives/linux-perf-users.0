Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A9D4A0EE8
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560413; cv=none; b=JbYhIIFFjjMED7zqvG2vLHfUb9P7u/VFwwEfcxUWSBa4P7FerAMm6Q8JIYC4eILImrpuBw6yE7UlPywg/H/LTTtRO3vyR+llGU66yzExoy1iRU2bvPFFVa91g8ArEjMsuR/0v7aU81Iiddo5zX/YWvhBvw41o/lxkwSgeJlqKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560413; c=relaxed/simple;
	bh=PLUizAahm26SYUPuUUrJU3jhe2MbMJAs5y7MCSJ4EX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C7x7CfglwE3dYVTHSWCv/C7ZasN4KfKSUtvaZT7/IYaxXnqPIrps6e6Ux/JBmdJe/bAX8NitIY5hHXdCmdsBe8Vyu2fHpxTpRGRsxofUtGlyT3yKh5Bb3wlH4MQYJhyRJAUUNxfwZdPkpzMBr+Ihn8suD0V0iPejXKaN7DnxCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW+wrZyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW+wrZyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C3C1F00898;
	Wed, 16 Sep 2026 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560400;
	bh=yQzI2pOkVaa31kbqZIac7MtD9uP72RSvg1XJd+rdZpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NW+wrZyMgvHWMYk6f+SAlMyMWSWb0pdVgRen5jX7o/2YvEunNU/TLYDSq35Ml78ju
	 kpyVPDKRbn3ZImlo7nz/ajncy9PPT0MVk1lw62CjnNi6PSway8IPa3UxWII8kvo0hs
	 4WsStVJWL2Xf5uW7i/nRgwN/lELtufwlgoujkjdocAfH6tOwEcEmUzvhPLgn7nUUWa
	 xpMs0vYJCAQlQ+bAFAbITjJGq781i9kuvYondQ2Q5hahzd4mPLWFtpSibBn2LRr1Mo
	 p4kFsnYZJNTHGPdyLBQyAgAegXfdpZaMAyyu4qWoXV8P+zCrVirMpOxELGrCP211Wu
	 9M2qxhmmF9HYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] perf mem record: Request PERF_SAMPLE_CPU by
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-12-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:06:40 +0000
Message-Id: <20260916120640.73C3C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data-type profiling per-sample stream keys cross-CPU contention on
> sample->cpu: without PERF_SAMPLE_CPU the cpu field is the (u32)-1 "no
> CPU info" sentinel, documented as such in perf_session__deliver_event(),
> and same-instance reads and writes from different cores are
> indistinguishable from same-CPU traffic, so pahole's false-sharing
> detector cannot tell them apart.
>=20
> builtin-record.c already defines --sample-cpu and 'perf mem record'
> forwards unknown options to the record parser, so passing it explicitly
> works today; make it the default, next to the -d (addr) and -W (weight)
> the command already requests, documenting it in perf-mem(1).
>=20
> The rec_argv array is sized as nine arguments per memory PMU plus the
> user arguments, not counting the arguments __cmd_record() adds itself,
> up to eight with all the optional flags.  On PMUs with separate load and
> store events the four event arguments plus the fixed ones already filled
> the array to its last slot, so this new argument would write past it;
> reserve space for the fixed arguments explicitly.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D11

