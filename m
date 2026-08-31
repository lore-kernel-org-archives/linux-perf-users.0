Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281242046F
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182575; cv=none; b=SmSn77yvKQaYGlo/KShaJiEPsUvRC02XZfQWxl0YoogzrFPeTn1Wk4dZlsQ49jUbaRFYbguxtFc6EHR5Eng//O8FARZTilcysDi2nd8YZRr58BaE6U0TnhCofBGUwKKWE+pAXdkMg7qb8EO0TLU5CGuMUzJeVpR4+f9UEoda9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182575; c=relaxed/simple;
	bh=c5R5ukOT2Ol+MPUQROyQXtMljz+0fH/KADBAVIsII5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kkoo12p55KuVzL1a1Co2YNDrRGgmhcDe6DOVX7LLPazKRQx9fvj2Wf4b+MtqOcJI6Z3deBYTMGS2gAoPoMrnj3q8oeGw0gXBKrdU3UCix4yjIFOPbwx9A/Z6p8DUhIu3PUzDpRuDqm9aHUjUleinr1YXXj3/AweDDYp7Kt7Q1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdyB/pM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdyB/pM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38881F00A3D;
	Mon, 31 Aug 2026 13:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182574;
	bh=qptxNvOiWypNNAQALmn3ECLaTb8F01mdOgeHQachN/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bdyB/pM6IlU3ySirRBY20EAa58nX+qI1miunUQGOz9gstvgALoTd/BPAatxhZkkzg
	 6LgP7H8BQKHj8xeGCpERFZ7YG1FVp5HlVbZq08yOOyA5d/2SIMdto6eJzM6pNB6ZvR
	 spcLrr61HVYI/oomr4S4xXYwBXxOTzJa7CxBCK1qWQl7IlvJF/R0NlqNptmyS8Qc63
	 bKvS4mxPq8qlx0MQrFbXxBMrn3cRgKFbDXU8KelN9MtCQqQAN1Dqchx00RAGwuM3+u
	 eq5gGZd3Rsw2F5UllU8o2UqtsXtOMqc8Y8TZre/NTQxxt3J4gy0F/VITIVErJk+a/y
	 yTrvXHL9gSE4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] perf jitdump: Fix extended header read that
 always fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-2-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:22:53 +0000
Message-Id: <20260831132253.F38881F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> jit_open() sets bsz =3D bs before the fread() that uses bs - bsz as the
> read size, making the expression always evaluate to zero.  fread() with
> size 0 returns 0, which triggers the ret !=3D 1 error path =E2=80=94 so e=
xtended
> jitdump headers (total_size > sizeof(header)) have been silently broken
> since the original implementation.
>=20
> Additionally, when 0 < bs <=3D bsz the if (bs > bsz) block is skipped
> entirely, leaving extended header bytes unread in the stream.  Subsequent
> jit_get_next_entry() calls then parse those leftover bytes as a
> jr_prefix, corrupting the record stream.
>=20
> Fix by separating the buffer growth from the read: realloc only when
> bs > bsz, then unconditionally fread bs bytes when bs > 0.
>=20
> Fixes: 9b07e27f88b9cd78 ("perf inject: Add jitdump mmap injection support=
")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D1

