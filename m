Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256902;
	b=46uNibP9doOt9psqYU6l06nmTcyblp7AllLkQCpeEdR3EHZ8AJzyr1GtscK8lwbbliGA
	 3C5NnoTQQp1sWP9DWTe6Re1JDW2KjKnX67rtBrZXUpDzWyYUvXnVzxXI2y9iIUuHuAbC2
	 mn0q74ZklPh/4Cdzslq9MaNK4n1tlOSQ2R6kvmsGcAdWKiCk4dKx+AE/jW0HQE4EhqmZ9
	 GL3RZlgPOH5mVMqv3025YNU2KfnIfyKePqpHMEkUy7PgwPncZyW9xDFuZroohesYw3rqI
	 bUsGuddIUvdcSuCR1Q932ZIxi36krWJes8vhtG3qnZmeZY+bCADozhhrJf9xXGuovlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256902;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pFbSpciGUR2gDJNANarOsm+8gptKZMxKdkUCUx3Nfrw=;
	b=xidx+zKypda5yCFEGd19gl588D1puNIE6Pb42TVko0Z/LlNW4QghScYkPL6rcTWMC4vH
	 3efSUH7fJETTUQqoc9xlEUhQjLHg99fJFq5DFDYj8CjegI/6c2py+zo3yepg+sUBoEs/M
	 ZAnL3VBOetac4uQ82CdqSCbbGhetHTrdmAF1YUxD/3HODnAEgiSZnSYTToSAIQ1cgIfAg
	 mjFHlQmnuaPUqRBa4vOwZ4lWr6H0eKUGbD2dSJXw5UdgWD0DIkEr/Bwv8MLspx039Fvs1
	 W4qdWPz745f0JV4wC8FCA7NdfoLqdVF4dk0hAIWuxcB/B/jRXGco+5CAEPT0+iTABDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnE6X7Gz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3F606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnE6X7Gz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4023F1F0089F;
	Mon,  9 Nov 2026 20:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794256901;
	bh=pFbSpciGUR2gDJNANarOsm+8gptKZMxKdkUCUx3Nfrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gnE6X7GzUglmckZm2Pq0akia5cesiA6Y1lMRUxgoWK8RLwptIDpwGEKfFCLV1TXm8
	 OrlLQwkeRJVRP6vWDaEGi/FcO3gFzvY7aoyKv0glaBP5ReUk7KHAMoj626CHW0ioGy
	 eym7QetK7EFEisTYckcF97jRycTMmAEmH3Q0JAmU0kLyBxnrP8sJQCWj9DHQvx1R/7
	 NNXkQOGbl8LwbUTNbTGIqVFGGqFOjpVVeaoAxHpIfpbpJ2d7XajxLjhCgKoIoQqfCD
	 GzERqmplmyCn/JeE3/EIu5lLJUuGPfCsa7YMljrCH/ZE1837oeZ7jflxNo6Cwdt8Wt
	 nUbLjJCPUs/vw==
Message-ID: <sashiko-outbox-205595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/20] perf vdso: Fix unlocked __dsos__add() and
 race in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-8-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:41:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
> holding machine->dsos.lock, and machine__findnew_vdso() and
> __machine__findnew_compat() initialized machine->vdso_info and created
> temporary VDSO files without synchronization. Acquire
> machine->dsos.lock in write mode across machine->vdso_info
> initialization, duplicate checking via __dsos__find(), temporary file
> creation, dso__set_long_name(), and __dsos__add().
>=20
> Fixes: f649ed80f3ca ("perf dsos: Tidy reference counting and locking")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D7

