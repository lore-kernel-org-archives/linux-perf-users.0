Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCD346ADB;
	Tue, 29 Sep 2026 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709783; cv=none; b=VqxcqaGsKKIb/seX+QnyVCfh1+IWMiNU9PIh8ePXhObV61kv/hlsdkwETTL4uTwtSn6ka59PAYw9Zv5e7j5qGuSVZYkmx+a+c2Rm8YPv3cqCFIfKTkaAsCx95GMp8OQZLvOeNg0fygGd633LfsogZiTiM6yOn/Hn1AnMO3hwe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709783; c=relaxed/simple;
	bh=Op35jOFEVO8q1FpaZPLqCmdjlEUyMgZq4FjE74YSMO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PRhiqP08coPmYVVYbvsE2RZRwy4W0q1JNoZuvy/uHgYi6UQpvI/TuAXMSWZ3FBt1rPTDinI0s/KIutbfnvOrvPoUIyF6+G3/9Kz33YXYHz+9tgDaoR5mblaD+1Qzpjtxf7HzN+hDlkMvZO6eli8qy8bx+K/Yh70xUkA8mA3xG5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBip+Ryi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBip+Ryi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C29B1F000FF;
	Tue, 29 Sep 2026 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790709781;
	bh=s+HEq5AYNCtq+yb9nxheQ3wUZ4LJAr2Uxenvd5vaqRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBip+RyiYP+7zRteSGS0ClPlLvcl4yO/VsWXzy4dfJMf44ExrT+GyDXOXPDT/cKRQ
	 ir5QS5X5qy8dVhtNIktqavVEM1vyKNhLBv7j6+kTE315bI2XqogCewYvy6rOSzPv2Q
	 C9fLeQzbM5rnsXix18WRfZtcQI0ETEPzmerr9YliZ471xJl/d4flOXum9RMwZUO8q3
	 93Ht5Y0vO1SpL1VyrChOsWym03s20hE5c/TgYiKqcIaLv3w9bRO+DDK6VOAYjzAL5l
	 PEQnkUNrAMgsjAZDkLTwDus2FxivBFqNQ97yCrl83NeFUYy154T5MtCC6rvbVdTCNO
	 nXMBRRJfPOkIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.1 2/2] perf test bpf: Address error about
 non-null argument for epoll_pwait 2nd arg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260929191834.266354-3-florian.fainelli@broadcom.com>
References: <20260929191834.266354-1-florian.fainelli@broadcom.com>
 <20260929191834.266354-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:23:00 +0000
Message-Id: <20260929192301.4C29B1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929191834.2663=
54-2-florian.fainelli@broadcom.com?part=3D2

