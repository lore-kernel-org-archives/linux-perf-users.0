Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE7346D572
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582441; cv=none; b=kRcMCLN0eOqL+UroUlSrfqGTwya0LQkw3Sdiv9Gj7L9tk+4WCilbdZbfKuyaq9piUmtPpwR6ko6RVToDiAZDjxOvPPKtkvXc1CtF6eEHG1TQk+2Hdp2kr7TDpyIdZrK9Tw3ToYF48TcBdbtd4X/cy7X+HZ/kgr7fAvEfkhl6gRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582441; c=relaxed/simple;
	bh=FiDr5TUMnAD4h3F9CaOUBq6ARJwGl5TOAAvykQTcrIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tpGFG+NTVVvDHpIzbsXvvXLnop6MDjrEELkmhzOQ6wwepqR5onwPiX1q3oo4+SQeQy4uL0EG5BrmJLuYXWKrEsnWF5jqT65bk5l3B2RuBndZsVyUuFoq0d9bj8c7PqrPUQBkc1fEts9uVGnV9OsP9ussTPduvgO9EjBPUA3J3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+43XFiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+43XFiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6151F000FF;
	Mon, 28 Sep 2026 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582429;
	bh=nDRy3Uu0gMqq+u2ZG3H15oexEx5U6BysgjzqcTMKho8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K+43XFiR5yo1L6zmAiUAbDBI3pog3x/NSuGSbQEyGNRBMRZOyKNw9zcc8tBj1SLXN
	 b8V5a7aJPf6/hWindQ+o2tOmwPRkFghNWQMGSJU99KgLgbC0I58OSphnKS7GI6Ehej
	 R9rpw5Vtp3OSyyRzXt7ltZ37JDgjKidKl02fcgMdEO8ohf9WovyY1LB2s/jqjK7+Kw
	 Fch/bl5Sx4NiUA4q30nqM+ZOZZdrrsuX5VGLlgW2lpf5gyTF80vWZ4vQQRvcfFAoEG
	 3uqqIhRIjKCfFZw9esJX5GsfKRe0OIP32WdVOuIEmxMQ1O36kUxydNbP+aIxU6OLcF
	 IvYC9iRfyLSvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] perf/x86/intel: Fix invalid PEBS counts with
 counter-group support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-12-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:00:29 +0000
Message-Id: <20260928080029.7C6151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On platforms with PEBS counter-group support (for example ARL and NVL),
> running mixed PEBS events can occasionally produce an invalidly large
> count for the instructions event, even exceeding the hardware counter
> width (48 bits).
>=20
> $ perf record -e '{cpu_core/instructions,period=3D100000/u,\
> 	cpu_core/l1-icache-load-misses,period=3D100000/u}:pS' -- ./foo
>=20
> The issue is caused by PEBS drain ordering. To avoid scanning the PEBS
> buffer twice, current drain helpers defer each event's last PEBS record
> and do not process all records strictly in sampling order. That is safe
> when no counter-group PEBS event is involved, but it can corrupt PEBS
> count updates when two or more active PEBS events use counter-group
> snapshotting.
>=20
> Add intel_pmu_handle_pebs_records_in_order() and use it when two or more
> counter-group PEBS events are active, so records are processed strictly in
> sampling order for both adaptive PEBS and arch PEBS. This preserves
> correct count updates and prevents invalid PEBS counts.
>=20
> Fixes: 8807d922705f ("perf/x86/intel/ds: Factor out PEBS record processin=
g code to functions")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D11

