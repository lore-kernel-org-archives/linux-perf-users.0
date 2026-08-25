Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A5394EB7
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654682; cv=none; b=Tmhz3HFxa/eUgVl+nXPLvY2lGWY+0nlNV0JVSjbIQjPT2LiO30du1bGFbKBOiNFtW6K5mk0mjvFQzxxEbTQZEppTIqAUcEKBfS0ayWy2UV/U17xgp0655G19rVwKYJ6snEXERLeLHuX6fNvmYD4RULMn8l4f+3pKJNDemOUmB90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654682; c=relaxed/simple;
	bh=7I03Aeu8emq7hINk9TeWO/6Ang/IZIAD+VxuZOpjwXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gt0O+LPZHtrklbUzNOCaoA3tcMlzkGUbmjvJ4BJIe1yfiRUVlrESb7u2iy/vgb2XQoYVBiyx5Qp27RMBdss+diAO5prOiyM+B+tnu2HEzHou3154ay7ohuNCCJNWI3fh6ca5v08FXpLcWjIrZ48CtWPYZyI5V/oolKwew8PQ1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1QJQ9f0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1QJQ9f0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E161F00A3A;
	Tue, 25 Aug 2026 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654681;
	bh=qJQ74P4OAIazVDQo0YFfQFiYz57jBP7q024QsTbDypE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a1QJQ9f096LGI0soEyK5+FpxfFC8eY1tQv2zTZeNsuzUiqobWjpC9/OMyPT5O2IXq
	 9J750xTW61ids6p8drATNXVx7SnWuvtQujlyItu9x3IhhiTMTeF8eHh7GE207FMk0Z
	 zSYELUnsN/qEWTMLa8xPLOKJwnOeWUCO9Myb6GAWlMpm/N99geUCobKxV3TRRr7kT3
	 t/av+rea9aKgvKvFpCJ5YN+MfjsWTQRjAJk5DLoXP4+rFZSzVfRWzrQ7DCJNXR2HrO
	 8obTAJTIuOuxCZB+KWEmnK8C7sel7rrbRwUdb14KrO3/3TP7gqaiiylJqe3Vd0m2gs
	 UI4aob1zygLqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Skip empty AUX records with only format
 flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260825-perf_core_fix_zero_aux_records-v1-1-23b95e8d5df3@arm.com>
References: <20260825-perf_core_fix_zero_aux_records-v1-1-23b95e8d5df3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:44:40 +0000
Message-Id: <20260825104441.12E161F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf_aux_output_end() emits a PERF_RECORD_AUX when the recorded size is
> nonzero or when any flag other than PERF_AUX_FLAG_OVERWRITE is set.
>=20
> PMU format flags describe how an AUX payload is encoded. TRBE driver
> sets PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW for raw trace buffers, causing
> an AUX record to be emitted even when no trace data.
>=20
> This is noticeable when tracing a task with strace. Ptrace stops
> repeatedly end empty AUX transactions, producing many zero-sized
> PERF_RECORD_AUX records. For example:
>=20
>   perf record -e cs_etm//u -m,128M -- strace ls
>=20
>   perf script -D 2>&1 |
>      awk '/PERF_RECORD_AUX offset/ {
> [ ... ]
> are still emitted.
>=20
> Fixes: 547b60988e63 ("perf: aux: Add flags for the buffer format")
> Reported-by: Tamas Petz <tamas.petz@arm.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-perf_core_=
fix_zero_aux_records-v1-1-23b95e8d5df3@arm.com?part=3D1

