Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39BB248881
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559631; cv=none; b=X7RKfKBd6URiGllcsLsU0H5laDKm7NzEHE34vSsEp7S5th9QjVAiDnVFtxPAC1XgZAIC4L59PF7nDZXkjSrEEvqpNJLobxmB2EfR+vWIcBaETL5pjCcg3p3UNFqgZIlOvd+om3anW0DqshWfp6ZvBVEplJQth3KdgRJ7LlrD4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559631; c=relaxed/simple;
	bh=7rPtS/huZZ1c6xEdVyhbq71OVKUoHUJv/Xfw38ry0RA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G/3KODboPKkjJVQSy6+VzJp5VIeDNrDMLun1012EYKgoDC2Ze6KpUlR2zmI1akNuLruBpFtKu2trB9dMbyLBngCvCBwSi75+pWyjBheCyW1ouzC85K2NvagljVQJBVuAMnj6AO4OSTTB22qUKeCHKGoM0CYfBch2/5+U76vkPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmdeZUJn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmdeZUJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A0B1F000FF;
	Wed, 16 Sep 2026 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559616;
	bh=7nPgSXZ9qluNkkLm5I8ORKCRz8iog156pXKQqgc69UU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TmdeZUJnJrpjxcg2DwpV2OsmB4lvo0kZHi8YEcliULLtLzaK211zpCwClWwNUWjns
	 n52YF1+QaorOJT1G+O1TzxHlk/w6LsC3Ad/GbKAjdFmJFK9DdZ8/Ocsdawr0UZbaI/
	 B5uhgoUPDAM4tbdZYm19WJBtpDBCrTTIebavqiNHRMzXksAfHPwTBIcwSR8cjmdIWG
	 D5ZfWgLhjeys+nN8ixbvSHU14aLtgJ41wxRrg6eIOemZKH3wDktzLnVZyG8IJ2WCEi
	 GQk+6Z6F9tf9eW8ofD8uk/TONgWqx1/BLkgyfShwr1ub55ZD7C7VWdGxGobZ0R5T+l
	 jfNRe7M2hkufg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] perf test: Skip data_type_profiling when the PMU
 cannot record memory events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-2-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 11:53:35 +0000
Message-Id: <20260916115336.83A0B1F000FF@smtp.kernel.org>
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
>=20
> Fixes: f60a5c22967b ("perf tests: Test annotate with data type profiling =
and rust")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D1

