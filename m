Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904035;
	b=zXlyKQzbH9Dvl+EAGqZ0828hP//KoaLa8gHETO5V9U/VNQUmC20B5XIauvlBXbsIU9ls
	 Hsa9WyFu6RpIetxVOhogPMVQykuwWInYM/M/TuArqFrnNvhbdSmJroL1EjieWSSAfhXMz
	 l/249lLXDhft+MPc0pGeqURePdTECC97nEIg4+Qttjkydup9EZj8UbJzKC6yWUVozluWx
	 pk68Pn8ayLHVqGwuTgIDBofhNwjk3xyzjCXMPLa/eBdLtiuySQAmgZusXcfwwAYxZ5eb6
	 P1Rpf5RM9iO8zHTy4Pzb1Uu/xAysq95s0/Lgkm0ptX3zghOdgYJTdLum3KFYE2rgHoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XdNIE0XN9APhwnsmlcyUqcIzn832C3AoKIbUq8A2c7o=;
	b=WrQ+vzUEGZJ0QCGyEPaMFYWsR8z9t9hO/BVkVnu/DqHviW2wGLhMR48yrjqYv+gO9pg7
	 2/USQu+SROBO1iReACebt7ARXcQJk/Qph1u0Krq0Vx4nbLAjDAmxv2bhKI3qfCYOEpNCS
	 4pvvGZLIRXr2lqRxDsBJMVUngP7fNlR9uC5iq/jCGTXzCmtahEEWKDsx0t52EtzqqOhXx
	 fuRcfUdkYiN13hTzY5sgJ2sVdiGhUXm63Udi7LWu/AuNOXIde8CWjoJ3glgmwzcby44Ae
	 pwDTyQoaYXeHwOyJYZqlE/S67X1XjJtgx28au8m4h3hYGJi3bXWJg+A/e4E/5HoN89g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5IcY5B5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87241606A33F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5IcY5B5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146BE1F00A16;
	Thu,  5 Nov 2026 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904035;
	bh=XdNIE0XN9APhwnsmlcyUqcIzn832C3AoKIbUq8A2c7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5IcY5B5jjBkX4U7mMpBcIAHqmKwpvhB7qc80ckWAXWslkB+bkIYman0xUWggHnCw
	 indYqZlSyOY0edaVy1KoPKJqtXbVoQ5j1X75oTjpYn2JU64YEb/uL0/6GZLJNt1ttY
	 mD39Cw859lnuaJtFyABITk44OMv31bAMuaTjgtLTwjixYn73jWvlH5rFNSexzuOhri
	 Xhf4oCrUCJb2z5WdLIsb0II3mfbHmTJPGjKrKi+KCUKLP5SjkuLwI0HeQSzQ9a5WwH
	 9G8tKwizvjZ1EAvBo+HTXwpjBl9vVgb+HGcLIMeq1OViGt/1hkh1Wx3gnkQgCi9I7/
	 nVtDEmt7GNFuw==
Message-ID: <sashiko-outbox-199787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/47] perf/arm_pmu: Move CPUHP_AP_PERF_ARM_STARTING
 post stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105163045.38862-20-frederic@kernel.org>
References: <20261105163045.38862-1-frederic@kernel.org>
 <20261105163045.38862-20-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:40:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> all the teardown callbacks while stopping all CPUs in the system. This
> doesn't mix-up well with running RT or isolated tasks.
>=20
> In order to transition smoothly from global stop_machine to finer
> grained synchronization between teardown callbacks and the other CPUs,
> a new stop machine post function has been introduced to be executed
> after the main one with IRQs still disabled while other CPUs can exit
> stop_machine().
>=20
> The teardown callback here just disables the IRQs for each PMUs, which
> shouldn't expose any specific race while other CPUs are running.
>=20
> Move it to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105163045.3886=
2-1-frederic@kernel.org?part=3D19

