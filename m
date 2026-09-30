Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDE4A263E
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768241; cv=none; b=EL4U8M/7KZfqfvUUfGiXphQtnvRHv6WE1KrMbYC8Kajpqu1jDRZwb4bbv+XIuKiFVaONL+kSzyDir8UcyYbPVpC1ZPE0FwB/q09XpMAxiJo+Gns9UUd6sWdmPCWUVOMfZ9ob8OSaTY+vd5TJ7ak5LR5acjGaMl4wMj0jTBA399M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768241; c=relaxed/simple;
	bh=CE7fnTzDmUjSuILPSvMGdZQ2kycvvSGCnvdHGKueupk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j+IBP6SbqEwRMWqM1vL9jb7IzXvJkkNecTnY28CMM9i0tjsCNjl/zgRVuQ9k8rVNXOIn4WKFbSluiG2hHK2KTTWPeG4BD4KtHsyfxpOxQDeheRzHi3YhZNwayWmdoplZ8P1qZkww53aQSs/UFGgHwk6OS5sbexPE4LHrAHZyyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYnO0PQJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYnO0PQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543BB1F000FF;
	Wed, 30 Sep 2026 11:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790768239;
	bh=Drk1y3QpOTNEuX1HHIIkUL/6x2gUAf6+nsqxIQwnKDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYnO0PQJB8aVVGDNj2XukUfjrNWOTebCn6+P7TotntqNV/8Z2xfgGLxt6xvIjkp2s
	 m3DR6oubF4Y9CDSnbscxWQCJUKyFmDUgiAn8sN+TKG7sAi66AHtU3vv6pwrnKdfQ+Y
	 3DFCbvnflaiGeyBX9358Ax/eb/d+eBOWud0MB1YVhmr3vjI7CNfsrDHSkdb/vwcZPH
	 88jJ8SC3MxAv554xZJ1H5a2Xl+LYZIwHqOhPaf/6myi1G7hAMguYrOVKqAaJavu1W7
	 Hkr3/ayGp+bovDyhv3kUw3D2f/S2SrGAPovEbSH9Csd5u+5Yfs/iylpzS6SPwrNIeR
	 jwypKdJIM9X1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930112454.16331-2-acme@kernel.org>
References: <20260930112454.16331-1-acme@kernel.org>
 <20260930112454.16331-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 11:37:18 +0000
Message-Id: <20260930113719.543BB1F000FF@smtp.kernel.org>
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
> debuginfod for the rest of the session.  The
> set_config() body becomes perf_config_set__write(), with the
> system_config choice as an argument, as the builtin's
> use_system_config/use_user_config statics are not available outside it.
>=20
> All config file access shares the static parser state and can now run
> on more than one thread, with a feature writing the config while perf
> top's display thread reads it, so serialize parsing and
> rewriting with a mutex, and the whole read-modify-write of
> perf_config__set_variable() against itself.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930112454.1633=
1-1-acme@kernel.org?part=3D1

