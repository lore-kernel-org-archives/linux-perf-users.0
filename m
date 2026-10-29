Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249860;
	b=34XyAFCcm3anADDV9mNQvVYFESGteMWvRYGnjGHew7RkKNXxaw1N4Ez4gFpNGwJTfakW
	 udTQP/QkwlF6vV6dqm86/6uf4xmXoq3bfG8EN782qXxnDYlhg3T2tiWE7b7nZeMKp20qf
	 8/Kpk110odYaEUf9rBDGBK6jibEjRujvs8eKdaI9eRkf8BIB9Fd0a7Wkc17oNuXSf47Rd
	 oiPrDXI4WmRSuyKjcacILO7nc3cY4aNi1VA3UQvKjulZyDmF5f44BZEZHID0M2jv/fMuO
	 tI9Cf9dMHK1QgmjU521T/W4odtfpFlzoA0pIHwKWszCngAybdD24p3tHqL6UP8guBiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249860;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bhtIxhYppkZve6kFRaSkObvGnmKDnsQBKXQ81DlGOWk=;
	b=ksTVgyU6H/wvqBfMcOj7OSXSpoT6RIpDEHUuTmtWp/a7wIu/qdPvvWuKqlOtHH5bQWns
	 uNfTHi0T1ui7u4UKoHiQi2kjtNgqE3oXWAcWnDrJUIZ03aATZPpUOry1x/XPXIEe2elPH
	 5ZsAcfU9yBTQMaURjmC63omwshkSshLUHnbjUDZ6Wi/EdSWoUdBdaCDhN2HIWj1b8pE1x
	 Yw80DKb9GCHGsTgk5mDpnOGxceH54ldBxBzZKlcsWbWsJGblg5MJTMCGo1JXC/x9UNICI
	 HJS1jugeeEhcBhipPDNRgiydMNvNKV7nyedndQPfgZYNhbm4W88qf9DyyWbGQekvyfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwqSZ6uR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA78606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwqSZ6uR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BC11F01825;
	Thu, 29 Oct 2026 04:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249859;
	bh=bhtIxhYppkZve6kFRaSkObvGnmKDnsQBKXQ81DlGOWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZwqSZ6uRUC2tf/YL/SJix8xMduYetFuUlMOZK+YehvCAxggC0jfVvg6EojqqfjrbQ
	 tUI8NEsnEMYgzGdO3Bisi+zppxJrBkP8XQvDAf62LRG6b74weTThR6pimaP6gTYGLc
	 KdNK5QH2749ZBJuuCyaHxeKvAbt7rdvXOLq4iLqgmJhu2kEKqTBtr6loOyjeK1PVBQ
	 O4t9sHefof2WZjoRpW3PU8/aiYbfV66OQ3lCjY/Rv2FvJ4cds/+MLZsh2oBy1ltsa2
	 c5QdHu7Bug4fjZB4kV+1rysHv0ZLOAwiblhE5e+inSTq8vVhGZSuTFfL23cW8HZbSz
	 8awRDeTHXVdNg==
Message-ID: <sashiko-outbox-188719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 18/18] perf/core: Don't overwrite shared LBR stack
 depth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-19-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-19-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:57:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_sample_save_brstack() currently clamps the shared LBR stack depth
> to min(event->attr.sample_max_stack, brs->nr). This is unsafe because
> the global LBR stack is shared across all LBR events, and a small
> sample_max_stack from one event can shrink the depth for all others in
> the same PMI.
>=20
> As a result, later events may output a shorter LBR stack than requested
> even when they do not require a small sample depth. Do not overwrite the
> shared LBR stack depth in perf_sample_save_brstack(); instead, keep the
> per-event limit in a local variable so each event is constrained
> independently without mutating global state.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: c53e14f1ea4a ("perf: Extend per event callchain limit to branch st=
ack")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D18

