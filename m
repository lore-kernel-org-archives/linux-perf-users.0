Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8819CC14
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Sep 2026 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649503; cv=none; b=leW7Wv2+ZfNdFqQ2e4MlFmv1tAXDykM4rWY4nnViWQC89RY/aPp0nP3mfcMdVFa4hE12N0qYKTDzeK9nSyATBxy0cqCOeT2u017bax6wXSt/LeGk1+9T7sS83wJt71/KRURTu8cqY1lhZRi/8vXJhf3taHGvA1QJlKzAlDQs7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649503; c=relaxed/simple;
	bh=QHKWbW0PjLJ4j4N+VVCdqZTJRL82ezf+Iifhd1vfZSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YI40+Y64/72kUbINOb1YsayX/EUYocMJMBm6ivE9lk+Buztpmk/7CgeMwtl5zMDUAbNwyplCpfkVCujYAsBiJ07wLFlV69/eQdkAutXdOgly0zX1ghGkuoJzywYwOVncdyjaoCJEAQjzSiVNh5/w/Ks5TbFjfCpIH7yo7KgXWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHnWVfzY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHnWVfzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C421F00A3A;
	Sat,  5 Sep 2026 23:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649501;
	bh=x9cDKc2LqyrG6eNXmu1YJPGDEJuk+AEGFh84ae4YpgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHnWVfzYjoUAzlplXBjZ4qjO+KOtoFOm8+FpVz+NrDJXWNbsbhl0envuubCwGcxbF
	 vsycd362LqIOshqa6oM3HZqInSRJwWXt0sHQL8FZx7+b/ve2I0eNUEJgLgueCDO0n6
	 z1T8As7tIzpNh2ueMYRtc1TytnRgIyFDJvNR2kV6r4KXFjfgOVoofZflVhvq1IK5fd
	 psoI2okSvKclXAMNGJ0QCnLSI71nb1L15AhZc1TNPqKG2Lu+pKIFXU9NRqJpD08fe+
	 2+vl2pnC+8ToSg0BgiOyhwJ/ZrlBX9ImbozauYld+Jkp6jgKIqpL1VZJRUr7oVKgzu
	 dq6u88QJjrUyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf thread: Fix live-session detection in
 thread__e_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260905-perf-alpha-annotate-v1-1-97380433ccb6@gmail.com>
References: <20260905-perf-alpha-annotate-v1-0-97380433ccb6@gmail.com>
 <20260905-perf-alpha-annotate-v1-1-97380433ccb6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 23:05:01 +0000
Message-Id: <20260905230501.B8C421F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When the per-thread e_machine cannot be determined from the DSOs in the
> thread's maps, thread__e_machine_endian() decides between reading
> /proc/<pid>/exe and falling back to the recorded session environment:
>=20
> 	bool is_live =3D machine->machines =3D=3D NULL;
>=20
> 	if (!is_live) {
> 		/* Check if the session has a data file. */
> 		struct perf_session *session =3D container_of(...);
>=20
> 		is_live =3D !!session->data;
> 	}
>=20
> Neither half of that works.
>=20
> [ ... ]
> machine__findnew_guest_code(), which machine__resolve() only calls when
> !machine__is_host(machine).
>=20
> Fixes: 70351029b556 ("perf thread: Add support for reading the e_machine =
type for a thread")
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-perf-alpha=
-annotate-v1-0-97380433ccb6@gmail.com?part=3D1

