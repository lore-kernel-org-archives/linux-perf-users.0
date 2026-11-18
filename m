Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037436;
	b=0yshDHZYPjRcBUEr3WnIiS1QOADbG+3S70CgYG0tK64yXdrqfBFKHFw9gbPQ9k0AZqPA
	 MB4wtkYvpkI+RGol9/DR65PIhyoKUB14xO7UOsxD1/uIKF+ffmMDO5/AuTmmwOzjWfLh3
	 d4QkMWjfdE/lq0xDi8LXxvlHWJ9cJzktfvyk4LnKwcdyd2JIpjzZr0QFBrqVtA5QvwcWb
	 SJ3kUfP1k2h6cFU/6guOKxZ6atitvrYpDyFD1LYFkbrBZcmS16FS2ofwZweDt7lDvIiwF
	 zloIAVaMsTrNig+hk/d9bWZWqYRDT5H2+22F4AauMH03SHfqVovXY+jArWeHOXALewQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WMU4Ih4LQpRmPGnae9NQYq9WMMmVBBUSb/2kb16shJw=;
	b=juv6rOnbUQvgFSZggU+ts/LEbSRUKNwdjr5TOe4+e7ElBD12MKIdrN+E/Y4R0JkjvrHz
	 nmDraNlAEvSBLT60A9P5kOfch6SJ6NUDgxI+F8p7Fmu3Qdz++gSJ+Pl2zXxghuUyy62uz
	 +PMZSys6hq8KYezLt0WQO00ssdsGKwpRvE1DPxVBTXSLuNbJSHFyInflPA+umGvqqZ7+X
	 /Diu/0q0Z6n/cSPSQdeTf75eqTfbykZIYWm7/BD80HEwnDadM/RQ7fljsPfiXMcx+jvXV
	 ZZWSArOYcKPUORR0HIN15th9s7F77R89VUDRbw0VfwYbylHTUxYu0H25ebx58dacNdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8TrAuM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70D606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8TrAuM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BFB1F000C5;
	Wed, 18 Nov 2026 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037436;
	bh=WMU4Ih4LQpRmPGnae9NQYq9WMMmVBBUSb/2kb16shJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8TrAuM1Y/PSPi7salRizr+nNrYz9mikPuPrL9zYNTb7obZ88gpzsRnh6Ex6tfkgR
	 zSv1Rw7XfEDEY6f3HUg2rjocJWvUT3Yk8PKZzb0ngiS8t5gCQ4J5zx7gi8/yBzGPH/
	 sQ1OKUrS1yoYCEQqsaLcA/ba+iE3aNxUf4J0MA7HOEyYsSiU+KIRze1sJojrXOPN2+
	 1Ofe/fToQagjORrK9+mKnenTQIDjAZpj3Zkge8RK4JgflIqjGI6peteTRG4wmx5sU1
	 WpwnaL4+uax6Ez4FFLqShyn+63Mg+bzirxK7/4/KTvi9wI+1LiE3dvVG4Saox+P8Wu
	 ju20uBHIqoe0w==
Message-ID: <sashiko-outbox-221999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] perf vendor events intel: Update novalake events
 from 1.04 to 1.05
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118212655.2262601-4-ctshao@google.com>
References: <20261118212655.2262601-1-ctshao@google.com>
 <20261118212655.2262601-4-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:30:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The updated events were published in:
> https://github.com/intel/perfmon/commit/409ce6f3950c46f6cd3deac31b93d66a6=
ae82d6e
>=20
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212655.2262=
601-1-ctshao@google.com?part=3D3

