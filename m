Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126272DCBEC
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350250; cv=none; b=U3sny66QEjvX29iAAfRqb59IQ73LCfKyBiAX6zQCNE9RegYHbSgH7Db7FB2pX6rOnq2j9zQLrMnXIGpgU2O3OrL3yENFDavdIDrOCXdrNi+QKmoJASD5dqKzigBDintvc+55WzixEGM/3axRMRl2obKPdChLc9FSErN0Pa238GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350250; c=relaxed/simple;
	bh=GysQ+KcScAt7Zqy6ZYIqfqp6tjYoQtZcd3hQR6vR3as=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tViehqHnH2+H3jDtv/zDKE39Ja3xJFrChbn3D1Pyvbd2uSx781WPmMmZsRqeBY25OYe5LVnqpW4PXVHaiJrPcXLZvbe1eGqWOK0p2LDQkEmVb9EaaNvB9V4DyUFQUIrDKjdoBhKsOBPRLF5BjCp8BOocWCcIlsxbVKZyyOo/s4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg9kT1Xw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg9kT1Xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FF21F000FF;
	Mon, 14 Sep 2026 01:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350248;
	bh=LbmtTsgBueCtp2/vnLbfTc8OSplYmGH9ESxHnJzGDZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kg9kT1XwBBI0Hxk5XCKU45ueA+qOo6l0ZFI9Kr+KqTZxY4IWeqXebwhMDlmjZ25bb
	 Pto/cfW1w08msxteJop3TCVFqaoNuaqIFfoWOCZXd7x8yi7F0RD41RTIVfoD6I67Je
	 KIQRXIg3dv1aGYgdP237NBy/YOzic3vSnQ3V+No+gQEaRqRo0+KVnQN22NUQCDhTga
	 6T5ZNvs1n7+bBUMwFdZd4H1t2UTx6xicFJjP15K4rK9TlsUIIDpdfSBdHzjqIBkh/v
	 EKi5KzCHhtDHoAxix/HgMMi/ad8Ow1MqpNxYHxl9N9jy+LtZQ4VgCYammsTJJzpsXQ
	 WUDbPfaoY22+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914013604.7702-7-acme@kernel.org>
References: <20260914013604.7702-1-acme@kernel.org>
 <20260914013604.7702-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:44:08 +0000
Message-Id: <20260914014408.84FF21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A perf that takes forever is hard to tell apart from one that is stuck
> in a loop, and when it is stuck there is no way to know where without
> attaching gdb to it and looking around, which is what this does, from
> the outside, sampling /proc/<pid> at a fixed interval:
>=20
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$ tools/perf/scripts/perf-stuck.=
sh -i 15 -n 4 -l ibs.log $(pgrep -x perf)
>   watching 2297313 (perf report --progress -s type -i perf.data.ibs) ever=
y 15s
>   09:39:34 state=3DR cpu=3D+0 (0.00s) rss=3D664295kB stack=3D7ffc3ae31000=
-7ffc3ae52000 size=3D132kB  Merging related events... [ 39.0%] 197574 / 506=
686
>   09:39:49 state=3DR cpu=3D+1496 (14.96s) rss=3D665383kB stack=3D7ffc3ae3=
1000-7ffc3ae52000 size=3D132kB stuck=3D1 Merging related events... [ 39.0%]=
 197574 / 506686
>   09:40:04 state=3DR cpu=3D+1497 (14.97s) rss=3D665383kB stack=3D7ffc3ae3=
1000-7ffc3ae52000 size=3D132kB stuck=3D2 Merging related events... [ 39.0%]=
 197574 / 506686
>   09:40:19 state=3DR cpu=3D+1497 (14.97s) rss=3D502250kB stack=3D7ffc3ae3=
1000-7ffc3ae52000 size=3D132kB stuck=3D0 Merging related events... [ 61.0%]=
 309026 / 506686
>=20
> The CPU time used grows by a whole interval on every sample while the
> [ ... ]
>   [Inferior 1 (process 2342826) detached]
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013604.7702=
-1-acme@kernel.org?part=3D6

