Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903180;
	b=5g+40M+vnwiKb0ZDKxfWPDagHro6XVNVkkEoi4wnzcEmN/GXhQXbZaPm5XZ2ZvhmqjBA
	 Rv+rmDyJQehiKwKUPNtDHSDSjgo2+3PmNa5LdBeE7iRDVpKD1ZwhpgxwCO8wsWmG5+Bxl
	 7GbcOg6NU5b0P6KPli6v2LM1yUK/NrrXL1P9MFvlUYzaSCyDkNrEAnxr+R6XQh40+XJVC
	 J0EplrlENRIYtRwgSeow609uwsmefDDtFSbuY/15TKNS05I63UsMh6/xu+hvS+Ce4SwIQ
	 XNgRkQqUB2zXf9azPw+uYJDKXRkyHjAcTh0Y8kkS72Y6HRLK6JBTfUcQ9f+tq/NRGTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903180;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Na8Ud6xh15e4hwafYXbf2rd3ixNvCAhtA6jcta0HKiQ=;
	b=T494fk3u+0vqoQsVlE+qVQhcTndcdAn0OQ/18DyOEnK2g4MiLjEo2DX0X87fjECHack5
	 pban7owclvJffWrBescGTEz5TJvRc+dgbDTNyx9YcDkIE/rMngulaTrELUBtb4SjMc7qE
	 GabesmOhVPpsC/bb7AYbru7uGmx4EItCUfYN+ESfn0n9AdTuhUG7KfV5KjQZtWKHcHSHb
	 FAN/v2uqFewXktZQkrpqj/loJjRS9GMqd6GTfS9bKRqWoUUSt5d8hXY/pANUGG5fC/1Q1
	 Xlf6hagb/Z+LDzk6B6ZTx/+QjhLCAdBLSNZwimUKokKwPTLwcR8lzmrmYxPUeSWcy6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+xjx73R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D7606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+xjx73R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55191F00919;
	Thu,  5 Nov 2026 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903179;
	bh=Na8Ud6xh15e4hwafYXbf2rd3ixNvCAhtA6jcta0HKiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+xjx73RRZXLdp3N0yakoRAs43sfOLej+0ij6ZzyNqgVS1I4qNII9sjK+n2FetzKp
	 3kkCc6nyovhpEb7QYr08OfTA+OT6brHitBIjpnsTfyRLl4WpVE4zBm/cRNOy2sKjEV
	 vp/YLPoNnDIhf5huYNx7fmn+BoSCotClRwimeKPgzEKoY2V+UuupZwcoEsaluk0bhn
	 rUuQ0KUoKY1rZMjUvX37iPO1v2QJQn1FL7sK4qr/UD0+L+BbAnF+VtLwjxSqX0x/Dh
	 K4R55PH6fNLNrHH2+2wmGRebHOrSqnMe5DBo9q1kT9uR4FmnqN4r9dKCTAuzKaeVZR
	 4Q8jX5piQ7Q0Q==
Message-ID: <sashiko-outbox-199761@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/47] perf/amd/ibs: Move
 CPUHP_AP_PERF_X86_AMD_IBS_STARTING post stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105163045.38862-16-frederic@kernel.org>
References: <20261105163045.38862-1-frederic@kernel.org>
 <20261105163045.38862-16-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:26:19 +0000
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
> Here the callback only restores the IBS interrupt to the normal priority
> on the local APIC and running it concurrently against other CPUs
> shouldn't expose any kind of race.
>=20
> Move this teardown callback to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105163045.3886=
2-1-frederic@kernel.org?part=3D15

