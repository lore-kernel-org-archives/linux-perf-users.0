Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009393;
	b=u4uyDsJSJvcx1XHg3RIN0fedJfdob/hEZCFqDDAngz67pF6q/YTO/LR7KJSa9zUIwcq1
	 SfJ+HbuSOXJz83D0G5QsQ8cgw9JTcX+891/KhmKxMIvbELBDTi2TmXLQ+RyrUcyLOxlHE
	 ttERz73HDRKTQdP8o1DWs8/UkAbSB8M/RVfckPyqyffPtf/ayapg5YDe559LQkBQLKrvE
	 jDeH9JbEqzVJJ5czDUdxYR4iFqka0l/nqK8wSQADrTcJjqXr1D8sEt2a5vImIsqWYi96/
	 cxQTEfCourvM1CkbYIceWCH6BWkrGJZ19RC2man6OI7fzcFabiLG1g81Knm6HQQS6cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e7T30EXVT4OeC+A9Y8LJSKzj1FnFRFEjdYQG6MjDuoo=;
	b=dpD3VlPEx4sS1HJDTGnVhT9qBtg+nU0oCIPSyhLxXf8nMKmz79YChfP8B5jPc4YzosNq
	 y3DSxNgl4M1VsODK+68hEEha76h7tbgF7HYR7ABQcmA48V5/5sMtIMDpdJ331ccWV+DYK
	 YzXBDTC0MnJ3lxL/N6AnL50dweFqSOVZKq/xwvEW6F+oBeKE46YfFN2v4QdrNfvpIZXHw
	 A589/+ko5ZtA+DNi/UugtnPoQjrdtGcnzRvcn/suI72TLsehWYtaKBZyZzNEZAqIs7Czd
	 Eo/6I5g0UlGlyTXYlBNOkoI4nHCPUUwPISWa57ZdOKwOrLgU2XIsmnHaiE1V2Oghusg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLBwXssh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9460A2600
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLBwXssh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4371F0128F;
	Mon, 26 Oct 2026 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009392;
	bh=e7T30EXVT4OeC+A9Y8LJSKzj1FnFRFEjdYQG6MjDuoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lLBwXsshRCfaoE5i28fBtON8FVz0vS0zL/L7jZWXt6Wj/CpN0HVG8nfAhaHqcMBAS
	 t4e4PlU4Y0uoNuU0KRWuNh6uW0CqucAecuwYS/kVE435zCpSiVZTAGh6Iu2ris8h+9
	 CkaBleivBZfsFsW9cT8J8mZKHr7IU5K8pBJi8FdQNNPvredCBJXOpZTxzhh6UHt06h
	 KpNBU7/8PwUpIZdSwZ2+OPLtiGnncXZEGh7quzoWA50OHIFQKpystNEN/0AeoC85gc
	 HM4zeObvqMFUnTamavOONgYTPZF84I/3xQVqrSjZ36wr4OxDddpS8Nnz+XYyZcYWeO
	 XZNRCjBvIYCmA==
Message-ID: <sashiko-outbox-184891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 08/10] perf test: Add test for
 ftrace inline and task stack tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-9-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-9-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:09:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add an automated unit test suite ("Ftrace inline processing") in
> tools/perf/tests/ftrace.c to validate the function graph call stack
> tracking and inlined function reconstruction implementation.
>=20
> The test suite verifies:
>=20
>     1.  DWARF inline symbol resolution
>=20
>         Uses vmlinux_path__find() to locate the kernel image, setting up
>         symbol resolution and validating activate_task inlining within
>         wake_up_new_task at offset 0x1d1.
>=20
>     2.  Inline presentation and return address filtering
>=20
>         Verifies that synthesised inlined entries and exits are
> [ ... ]
>         FTRACE_MAX_STACK capacity.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D8

