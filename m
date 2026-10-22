Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634673;
	b=G+alV8ESYF2XYmNzUvylmt50rkq0+X7nXszqfnCU3OXbQEm9e0xF8b6bW+lQdkClunfX
	 y6cwishbwdRpGlxv5rtabpWSswa9wyIit4EvHdxhVF8WhIIKgQ46myPXOcyjL9gLWUapJ
	 Mj4xMVehdGi6UkjLXTOCDaD6iqXdgWEPg4i8DKAAMNNVAfsLIBqV50ScQBNhaCy28uvYg
	 a6PXutkl9Vj/1QeX1eie7jqNY88EVypRhVbvjyviaLvTsnY6QZi6nx+TRMgl2GKxc4yZx
	 1oJjmVqsRWVJ2RRok8X5QDfhtY4r0iyA+gP7aA2YaQh4XtRDM2IO0IDiXnB+voQ1j4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eqG08q+mOaPJr6Hs6t1hAWjekBZ6x7QFVHA1/dLiM0E=;
	b=T7ow88wDvmwoT+Xs4JcDquR8HGhjAEgWjpa2mPHpz9sSN3EHZdRLeK7/tjM17HUCqpZz
	 Hefh2ijd/AlHh5Eb/qFt/mT8ns5VFs9u/SuZLUxZr3zfiEsw1C1jeeMt+RsqEPA5LcAUo
	 9x1ySlenKvsgq0YdaLoy9aDUbsRV5jh1am5K30FbGa++rmaX3+N7C/n9hB5QblTW0I+p+
	 Y+9qf9iCZonAmxiIkGJJ82A3zrCNFNIQGgvCqEJn0NZJQ+7j/xIgv/M72cuEgGiKauSr8
	 7myon9V/WoJ71bsPzmxrU+33oAXgtVEt/O2PDs0GN89VuYDvjR9siDFhdUIOl+SktnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyrzQrYF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEA60A2602
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyrzQrYF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2295C1F000CE;
	Thu, 22 Oct 2026 02:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634673;
	bh=eqG08q+mOaPJr6Hs6t1hAWjekBZ6x7QFVHA1/dLiM0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kyrzQrYFgvaGLuW98lhVgMePmIDiNQ6Nziyer89Qeo61p/iApnz3CLL3dFDSfgRNN
	 0DydxuQBCmovQa/r4GBQpcMbMSAumz0fLihaiev53rKSD6rQ1JWSJrzvw7z3oiz61i
	 n488jzb0RFieOnq4D94MnUY79w7YCoVdK1awrSU0QoGPi2Cj11K/+pH8ezXhozMmiT
	 b5e5fY9FdUQQzNElIq51T798QcCo4EcAKaHX33GgNG/mTCley3htuhIZt6bUSNzTHg
	 1ZsIFzh/Gh+A8JYRvfWGUe79D4UbpGrIn7FOvAGmaT9n+OeKS3QTRKbj2NBSr0ymJN
	 Y919cLKsX6mPg==
Message-ID: <sashiko-outbox-180855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/9] uprobes: Don't run exit_mmap() under
 dup_mmap_sem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022015712.1297331-3-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:04:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alexei Starovoitov <ast@kernel.org>
>=20
> build_map_info() takes mm_users of every mm that maps the file and
> register_for_each_vma() drops it after the visit. When the process has
> exited meanwhile it's the last mmput(), and exit_mmap() of a large mm runs
> with dup_mmap_sem held for writing. Every fork() in the system waits for
> it. Use mmput_async().
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015712.1297=
331-1-alexei.starovoitov@gmail.com?part=3D2

