Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1903F074A;
	Tue, 22 Sep 2026 04:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052166; cv=none; b=oZryTB7ytuGjFYrP76fl8x5qo5BaixvaBN4Lr7Gjvg1TvL88YaLnBDFYj292D71+lfCMwMDfJX5SDX0jhDW5nB/NrwqW+UFSGeHFgadwbBsazk3lXC18z7Ilu8E96lmwoZ5wNPid+18whaRA+FkTDQXDzypMEKBDyP6AHM2F/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052166; c=relaxed/simple;
	bh=ElwzJbfwYv2emvb4nja3djxgPYqKRCgFccdi1fn5b4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sTrpAx0LTM61qmdRLYyQaEKjzw6MUucqHySL9C2SdxA1O/rkSJXBFitJEDnpzZN0gvBBSBQ7vM4viwHkVA0I8FAgUcexk9hsoOcageq3EPaubw/VWO+hpivlnv9tjzlIH/oRoTtcDrpXps2Kr47gtOmL+b6qMsEFK7UYSGi2MNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtq9K7HL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtq9K7HL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C78F1F000FF;
	Tue, 22 Sep 2026 04:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790052164;
	bh=eRUTGSmBI+NgeuqydjhWBMSB9D5xPQSqhB+5LcxX8I4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mtq9K7HLmM1y1uyttndc2+tk4EpHcTSSBvOyia1l5LfZOocCJDmx3HibZg/6tYa5J
	 3AyrVOZT0b148hZORzEfd9+7KapWWXpAMW754Gd046ZNs1lJV7Dpx2N3kjZxg4VJMW
	 zRFRiQzuO25ttjT+HmmCylRVRvEN4LYsYIaYtKseZbWk76uqW5qe9WP4VFSSVK8gaq
	 sjdlKHCcO8e3IimjyWOUPNuIF1Ht6oXZsTZk/FeLD2a46r7N3Eeh5RcdSoV4zUC0Gz
	 0K0d+50A6Ex+HNILFtj4OiCrSSaxxg9DtUyZMvn/9rr7FhXjamsHj0TSwOrwrKLtpZ
	 I2N9BL5rnk3Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 12/13] tracing/wprobe: Support BTF typecast in
 fetchargs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179005122765.388919.3824091331444647185.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005122765.388919.3824091331444647185.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:42:44 +0000
Message-Id: <20260922044244.7C78F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Allow BTF typecast syntax (STRUCT)FETCHARG->MEMBER in wprobe event
> fetchargs. Previously, handle_typecast() rejected any probe context
> that was not a function entry/return or tracepoint event probe.
>=20
> Wprobe events use $addr (the accessed address) and $value (the value
> at that address). By enabling BTF typecast, users can now cast these
> to a concrete struct type and access its fields directly. For example:
>=20
>   echo 'w:watch rw@-1:8 dflag=3D(dentry)$addr->d_flags' >> dynamic_events
>=20
> With a set_wprobe trigger pointing the watchpoint at a dentry address,
> the resulting trace shows d_flags being accessed at that location.
>=20
> Note that $addr and $value are restricted to kernel-space memory,
> which is consistent with the existing TPARG_FL_KERNEL flag used when
> parsing wprobe fetchargs.
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D12

