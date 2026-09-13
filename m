Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB82F7EFC
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270273; cv=none; b=iB2X9tDPeLxy0Mh3BG6w4L7lArng4wP/93jL+D/oh42JASBizxxOLMFdT6d39yPbVTmNWnDmXOwG7aP1dYT0j7UPBdxikUThuSDof27TQiU8S80i3JFjUGXo1W7/QQU44Zx3tVT4viBs+kT3I4iZGhMP1cowxZEd1tGaOHh4n6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270273; c=relaxed/simple;
	bh=yucFwyd/ZEn/TqkLVIUv2J+rbkTJCbc/s9AP8IyTpvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=afuQGx7qgVMFhWzoHApCzaYDa+M7Pi66Tez2CIbe2Pi9QoqAvtSv3sHnVN0yx7J9eyqF+ORIcLlmsiVNsFcGqkzNj/R4UdLNOBAEoIEDwR31E6UnrqdIov3hMYSihrIN0HfB0EwWqfb7hthaLpOrGTb7VvmZ2+JY/zqWgr1hlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzOJgBlo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzOJgBlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677DE1F000FF;
	Sun, 13 Sep 2026 03:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270272;
	bh=E9vmVQz8iIyusf9vl1vlxRmsNQJIE6hFfqex8tb9Li0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FzOJgBloeMp9Kkb4uuCcDngb/FAvxpB8FbxktKL5cgYYyX1JNTXaAokIxBylSTdF+
	 ohk6XUmzE2YU659weB6n0cB1xVm9K2TyhE88cIcBsLR1YcfQurqUXmW8WMmduKUf4L
	 EgdZWh4yK2nrm3H9xrEF4wixBWiwAD2u81PwXCPawNOZBWJAxVXxUA05+5hsjvKhgy
	 rCtX0M7KWEm/xvg/AdJjqlNQ7mknwj4xLCB8SbwFl8cNMFDydvjUizq64rmlRO0RAz
	 iMUJKD9jTW5L0qPaxex5zKyaZMrf52Bl8HdqieymY1RNJapxuGwYRROeNtr91mB3wB
	 EXzFbwEAURNUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] perf test: Skip data_type_profiling when the PMU
 cannot record memory events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913032632.116277-2-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
 <20260913032632.116277-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:31:11 +0000
Message-Id: <20260913033112.677DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The test records with 'perf mem record' in per-thread mode and its only
> guard matches one specific message:
>=20
>   perf mem record -o /dev/null -- true 2>&1 | \
>         grep -q "failed: no PMU supports the memory events" && exit 2
>=20
> A PMU that has memory events but refuses them per-thread falls through
> it, and AMD IBS does:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
> [ ... ]
>   Pipe C perf annotate test
>   Pipe annotate [Failed: perf record]
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913032632.1162=
77-1-acme@kernel.org?part=3D1

