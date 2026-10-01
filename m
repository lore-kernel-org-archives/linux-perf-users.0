Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA313815DE;
	Thu,  1 Oct 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871131; cv=none; b=JoTC1wD8MCfl1ySr2UrkKJsyyem2spRUXIorvdanxy6P+KCzNMotI6ao7Kvx0+pe01+yAbu6lOAPw/2BATvb71QwJF+45NchVWvCZBvaUrviP6pzbrOtGC/bxA/07OW9NGb3ieJELX6GuGlxs08KOQZk2fcOrtSd5oHV35jr6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871131; c=relaxed/simple;
	bh=0p16GShUQodnrorTlXklQYvwCZZ8PxBeyWesheEwh7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T6UMGcr66D32KNL1jnQngs35DmyCWr9dFr2xgV45Ld2M1FMCpnTcnrjo+TEuGXK+Bzq0FkU8r4CsEXIT06/cZDPnTiZC7Ta2u6mAhy2MvirOC5RZuQ0v8d+31WAhkS5IjoBXQEsHPceu85GV58lk5wqWW0moccsOQLbKRAVPmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iscanODI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iscanODI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5201F000FF;
	Thu,  1 Oct 2026 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871130;
	bh=v5qed4INy2lQqb9dq8qW6fGvevy5vLR+rm0OKi9YzHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iscanODI0kZkWMrv6fnB+kFGu8Ow9e86hHgEcqzJSyU8Ekyy1dR2p8s5kpdVU19ny
	 WE8yRF97cZ9sX1Cwk74hFcFiHYox61k2+MlXoe+Y85BlEnJVK1WmWcCrk6qcqQ1rcu
	 zL+jgeB4MEEjpAJhT60xCyJ9lin+ehES+2U+5tKBzDzYbTJATpYPL7aCeM2iFwhKZx
	 iJqw2Nvhl/m3i9tAtSbG7uEtUcxGSkiNT6ZifVOhdMfP6qTyT+mZLilESY6Ovc9wqN
	 3hao5acwECIAW8DUBj2DQC20IMieHI4my6KbtqqtVJoTT6aFlNILWXUJQNtm2eIQsn
	 qpNlhyEar4xtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 5.10 2/2] perf test bpf: Address error about
 non-null argument for epoll_pwait 2nd arg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001160114.801948-3-florian.fainelli@broadcom.com>
References: <20261001160114.801948-1-florian.fainelli@broadcom.com>
 <20261001160114.801948-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:12:08 +0000
Message-Id: <20261001161209.DC5201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> commit ed847e30f001b207013b6136c264454d7560557f upstream.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001160114.8019=
48-1-florian.fainelli@broadcom.com?part=3D2

