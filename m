Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4047DD78
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937289; cv=none; b=rBza5pp9AA7S/srG/+m5yr1vYGtICWFV3mTFt/PwCR6T+J9fJJHwoCUeVKqQbaLYt3a5QQlrA1MaPwOG1mnHprrV13Db4fhIsKlU9xck7fyItfUFPqQ07vBrXgswEBxACj8Xf47fQxpbkqXBgB0JDKYNq+JRxH+MWYgY9yce07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937289; c=relaxed/simple;
	bh=SywR1lfbmaXWFBHdlMiL3aAkD12tOWO3YU0FUQJ7120=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UgQK9hEAZOJ3HcQFSEkVuIL3EVI9NA6M4zNhlqdwy8DvqKbMHWkYA049v30qx83W+gr0Cs3KtrjgW4GHBMTwqfnNa3XbUVTNLgAcJ8xDMZ0rmiNw9tfFScz2RpPr5jCUNPtlisOOo0nTdxb7tunE2IPmwG0gtJG7se9jtfuCkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdOMdd6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdOMdd6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A901F000FF;
	Fri,  2 Oct 2026 10:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937288;
	bh=wRE1RrDXNnrMYy4jiJj3lJmWWK9iGW+xAYKd4HV3u3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdOMdd6Qt/lqznRbR4W3P+Y/5Ja09fQPp0RvgmSUUBLcr9uzWNxdhsthE3NouGCa5
	 n5aLvsxHEWX4Btpmcsxgx/ZCfWxnvtI98GBQB+siDBHvTxiYsEPjxIrkcqP3mKgQn2
	 PO89tH3kzh89CfgVcrD9rt1sdMuXsqDLz0ZLE+7RTuONKY52aOIUIOSZ78aiwcV+iJ
	 o2xEy+JTofxs+tJ3KwdH2tryh+xmnYTzd9x05Ni9dkYIhEvJteE9tvIAtq1L64APUP
	 Hyq0enuwdVMzP1J2RuUKrxw1jN+ozuT6nBijKWY6ORRzBygy2jX1U/3eQiaN1ef1Hq
	 Y2ud/9TBf+VmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/9] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002102110.27587-9-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
 <20261002102110.27587-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:34:47 +0000
Message-Id: <20261002103448.02A901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A perf that takes forever is hard to tell apart from one stuck in a
> loop, and there is no way to see where without attaching gdb.
> perf-stuck.sh samples a running process' /proc entries and its progress
> line at a fixed interval, and with -g runs gdb (perf-stuck.gdb, adding
> the perf-die-chain command) when no progress is made across two
> samples, printing the DIE chain a DWARF type chase is stuck in.
>=20
> It is a prototype: the plan is to turn it into a first class 'perf
> stuck' command.  The process name is resolved with pgrep among the
> caller's own processes only, as root an unscoped one would attach gdb
> to the first process of any user with a matching name.
>=20
> -i and -n are now validated instead of failing later inside the
> sampling loop, -x now requires -g and gets the same readability check
> as the default gdb command file, and gdb_done is cleared whenever
> progress resumes, so -g can fire again on a later stall instead of at
> most once per run.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102110.2758=
7-1-acme@kernel.org?part=3D8

