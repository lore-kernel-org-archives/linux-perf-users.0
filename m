Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952759;
	b=LSZCfnLaoFCU6xYOlb4rKst7nQJGmv1DeHby51/fkPvjnG0Zdwyoe+2yx7pET7ThJ12I
	 gRyuO7t4RxrkEjUu5y0ndgavfCeXs6Nr63HrmQWATyZzG6EnE8vPJN6K/46qtXMrHp1kC
	 /Jph98J3KTrqsY0z0ps72XiTQ8zl7iA5pTYD/hzAEiLW+Z/vngTIXhURhkDuBPY3ocx04
	 eDrNqc7Kx6oTrmJd9gt6hEMLGsAsCpNW1U8gqzfayjMslLKR9lGAexnbNGmAGUgjasS13
	 A+nd42HHc1ZEqL5H0NA62QaeLGCp4036nBsL/bq52aTdfjUzIZYJzkjxyM+ddFhrPhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OloSzkcu0M9yAJ5kCj+i0ebJJgQFhmQv+bCjgH5WB6k=;
	b=A0A3MPRpD9mc6pM37QDyx0uwgT/Dm1OjBL+a1c2RZ1TcPgAWJyzR9Z0VSKQAhVa4PlqR
	 OtlsH6VD5WpYaeDhCT+oCxO0LkiN3k025C05z3LqzeE2ng4QVjLgzaVxVw/zawE6qdVaN
	 fp3oIC6WDauie0J/doxuKuQUfZ3V620gS1LXrIZXRaF1R4uI6P47GO5djtrX7vULTa9fK
	 IQ/erS6oNRi6sYoEZVWzvjYMahRUs2P9CiH36/+3xcTK9Jq52/aVh0WgbSl7zLUkUFyXH
	 AsRyIztHMhB0ZN/EsTTJdwvKJfmWuWqaio5lGR4CWQVJ+ejCk0GYaE5IxHvi9WkQl7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWSUvbuF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DC606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWSUvbuF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBD71F01825;
	Sun, 25 Oct 2026 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952758;
	bh=OloSzkcu0M9yAJ5kCj+i0ebJJgQFhmQv+bCjgH5WB6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWSUvbuF65hDpBx76ugjO2ehHT/1hspFQwBU80/YNP9eSQz9RdiKQ0IVclp6TigMt
	 ZsaQ6NbyshQltOb8p7qSRr1l7hCeV0SCpHs/Thia9i/i92usiWgkBzqhAn4L6ZA3V1
	 677ADDApA4W37aeIRFr8wKTDYCRkAQU4QHXYY3e5hzZQGmbigmbf4liOy87CQQiTQH
	 E6sThEZI6+7Ql73enHv4PY7DZNBvishr1HRX6xu7vBmDffWaK+Qiyy9UqJZaZJ4kOM
	 bxjICZQ9aFFNql5ImOdfJVuAkZQ/ld4yIkOgl9N8K4QzzxVNdzm04dLxXQl1sOkcQl
	 awRUUoLiebgbQ==
Message-ID: <sashiko-outbox-184334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-7-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-7-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:25:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Linux kernel's function graph tracer operates at the machine
> instruction level via compiler instrumentation
> (-fpatchable-function-entry), recording entry and return events for
> physical function calls. Consequently, functions inlined by the compiler
> are invisible in the resulting call graph, as no discrete call or return
> instructions are emitted for them. While technically expected, this
> omission frequently obscures the logical execution flow when analysing
> kernel subsystems heavily reliant upon inlining.
>=20
> Address this by introducing the --inline option to perf ftrace for the
> function_graph tracer.
>=20
> When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=3Dy, the
> funcgraph-retaddr trace option records the caller's return address on
> each function entry, manifested in the trace stream as a comment
> [ ... ]
>         tools/perf/Documentation/perf-ftrace.txt.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D6

