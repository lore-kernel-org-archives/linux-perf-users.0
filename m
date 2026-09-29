Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE743E1688;
	Tue, 29 Sep 2026 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709610; cv=none; b=pNhvp6JweoK4tMLVmRXVcBikEDOpQgE6TGpevzG22SfNNyJFtZPCn54mnlzSpiEvN/BYU9VRPB+gnRysGmXyahMJ72/YTHTu8zIXBZDjPDwYmRwE9c64ATiEyXmJp1WA/D6RhWSd3yfExvzM2wtdjyC0VIIr8OCyMMQiWZxav4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709610; c=relaxed/simple;
	bh=INxxy56tTTNw+wpmvRiYmVDphGb9zWgB4gZ+ry8gRW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=beuB51elEpumQk/SdjKsgpbXR3eVX1Gro6nb33dKqrr5bCWD2tfMbfQsvLi7e+zeioWMlBSYYHDBtRYf2SwxBYKGYBN5JSBQF8WTeQk2o95QQIb2x9WtFOUEgjpuBhE0hBoFiCo7L8h6XGKbcG1Bl4fV+6MgONeSOxR9ao22JXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKGb5R2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKGb5R2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3685E1F000FF;
	Tue, 29 Sep 2026 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790709608;
	bh=1qzlXq55cXRH/6p3qQnNSeSnAxfYu5OWeUNKOL/US2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZKGb5R2d374v1LRq7wiR3R1ggnPfwavym/M4QTFMYd8WJIg/t7tfDHAyCJZ/i3mrD
	 82dOd8t1jACgvggImdJMWnGyq/3EQ2AYnzkcMRDk4XYM0KIyiiSeVMmUidKeYWnCeJ
	 f3LJ39UzwYFH78iyA5fp9YH/A4qW0N+v9VNGcnFE7sDnfu3MlUks5rOby8QFvsVK5G
	 HtsxGH1g0n3xref7194ZS8AIITzE5eV0Jx4XalH8H9/gveH7X+xKJ6Zv8dh321pLzs
	 yXS0BBlRsn4CbTOkmq7M0PINP/mca0aTFT3YdrBANMha45wIDUB7/A9lyW/Q45H925
	 67xW/36ltJ+Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 5.15 2/2] perf test bpf: Address error about
 non-null argument for epoll_pwait 2nd arg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260929191541.264038-3-florian.fainelli@broadcom.com>
References: <20260929191541.264038-1-florian.fainelli@broadcom.com>
 <20260929191541.264038-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:20:07 +0000
Message-Id: <20260929192008.3685E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> commit ed847e30f001b207013b6136c264454d7560557f upstream
>=20
> First noticed on Fedora Rawhide:
>=20
>   tests/bpf.c: In function =E2=80=98epoll_pwait_loop=E2=80=99:
>   tests/bpf.c:36:17: error: argument 2 null where non-null expected [-Wer=
ror=3Dnonnull]
>      36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
>         |                 ^~~~~~~~~~~
>   In file included from tests/bpf.c:5:
>   /usr/include/sys/epoll.h:134:12: note: in a call to function =E2=80=98e=
poll_pwait=E2=80=99 declared =E2=80=98nonnull=E2=80=99
>     134 | extern int epoll_pwait (int __epfd, struct epoll_event *__event=
s,
>         |            ^~~~~~~~~~~
>=20
> [ ... ]
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/ZMj8+bvN86D0ZKiB@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929191541.2640=
38-1-florian.fainelli@broadcom.com?part=3D2

