Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC7471423
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932397; cv=none; b=Q+/WaKFzpwfMAS5P8/sRbsiAt+GGuNEzlAYDTa5/s3e0mDOn5TikcyBb4kv8onRk0jYkDla8YPVVGK8eEPj8w+vjJkkgR4RqgpI4qI7pNcnHJf3Nm/6UYD5Xqa2kUCqPyuWxS1rCwbTPSG9ZmYqHRh010IrXNrGEx5p98wclJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932397; c=relaxed/simple;
	bh=Nt5P+I7AEwVVDe+F3x+z+4dMtsOgQ7kQcy1sdGF/lOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h32x/vLRn/lrZ2K4o3PU1nSIF/HEW3atKOUr37KYYcAE0uM3GwvDTOR2st86wxBWWmCsXfEhfYL7ei0r1/TD7tnnyX1LtQroh8XG3ldyXKVO75uT+OpeKzI+mGM3vmcRqmmTrpxPbNhKDuRD0K+NyLPdMU0WXL2KTDR4Bq9rtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3O3ykjY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3O3ykjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C072F1F00899;
	Fri,  2 Oct 2026 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932392;
	bh=4MYGs8Uth1R2sjiIVhdP4A84PUPLOsJycWKsF50c0+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3O3ykjYV98M2nlxulZnMF0b5/svp2OPiy2BYRHbgqLfMZQNpYReOhRwrRiS3qWg6
	 6+Wv6KXEIjSWPrNB4Kuwix5AYYSk7IaOgJOnkk7RetmhQSvsqEC/4ttU9eB1X3SEy/
	 5sAX/JvVBvNT3b2I2FJt3TRwcDBM5Ns/+6OwRv7NdAg6ZbVDfffv+9Owt3C50WB7rD
	 3Wwuyu08TqKJcjiEQ/pywbTz2poAoMx2+xB8Bgt5WnUUWA5iBo3tPJouydg6zJM/jb
	 ScXXxuAx3mXuSycx3ZuRX/xLpiPE4gvukEyqUxuZ7pAXmsJ52XDbLSOlK4BKoT8UKA
	 9z0DeASIKzSiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/9] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001185400.2754753-2-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
 <20261001185400.2754753-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:12 +0000
Message-Id: <20261002091312.C072F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Move perf_config__set_variable() out of the 'perf config' builtin so
> that opt-in features can persist their choice from outside it, e.g.
> util/debuginfo.c writing core.debuginfod=3Dfalse when the user disables
> debuginfod for the rest of the session.  The set_config() body becomes
> perf_config_set__write(), with the system_config choice as an argument,
> as the builtin's use_system_config/use_user_config statics are not
> available outside it.
>=20
> perf_config_set__write() checked fopen() but none of the fprintf()s or
> fclose(), so a write failure after truncating the file was reported as
> success.  Harmless for the interactive 'perf config' this came from,
> but this makes it an entry point a background feature can call with no
> other feedback, so propagate those errors too.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001185400.2754=
753-1-acme@kernel.org?part=3D1

