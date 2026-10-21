Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602993;
	b=tl/Yk87NsdeLP64Ev/wgQvX0V8lvtkeDrASEr9fkLjpMzJzRzFcRCIWDKQtzcxYK04xq
	 v7ZANpc4uyhCS+we7u50Fj3yPCDiWXboefxnqUkAjT/fV7SbjvV6jNfw6w+O8tLOs/p7l
	 MFieZNwkMKjIQnuSyuAmvRqFybKlYfIgL2FMsRv5d8g7MBZBSa4crVnPPBS2AsCswq3DW
	 vo2p7DNn1VqyuLS7ZY1eihL5tQF0P/+0b4xv8CY9ij9/CI00+ccDUByA08T6wgfiLDQFc
	 4yO3vc/vSZtGk7hQZDZBReGn8mqW5ZwdA3ZoXLP0my25XYGbX4b7uJE5ObwK+H+ELag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BQPsLHC5CULpvcBowOBygusdPCsEZa17zvNgZ8lMGRs=;
	b=BTyIctWi2V2IyGkUgeiLTcVQ6NCviDsLLL/TKTRqj9/6CXR07l9v7V+Hk9dznS1dAGs+
	 x28feUxpkyLE2DQLDrjoPUeQG/fgKsCmo/pMDXXJR0FP/2EpLSBnMQ8oAK+OXfl/EtT+u
	 egTdVCe6ap4+Z2VSiH3rMTIdDODrTQu3ywm2Z8GmSjABT7bSmKyEsNHcmcSaEfO4FDsgf
	 Am+V7wCqPKTVx97ISgUK1D87IjzlWFI3H0TasYHRFA5gqKfFd8AY1Hiv/vbpnZhMf1zyK
	 EFiRMT75zfx0ULLFR3DfG8uXezLx9EqUjzEt17UNApuHtNxvOLv0KaTUBAUSit7vsMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lFZz/VNO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D7606A31B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFZz/VNO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37C41F000C1;
	Wed, 21 Oct 2026 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792602993;
	bh=BQPsLHC5CULpvcBowOBygusdPCsEZa17zvNgZ8lMGRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFZz/VNOj453r5RbBRW2wJWQDb/vh1eStrLOIt0cp/1MqET//QPWDxcpIO4E0bGsK
	 bMJduFKUPf+YU2OmDNRoI21B2u3W1VhWBtb/8Oqi2JbDj0ZJ0WT0iIikpneeIuZwBZ
	 d5XLQg2JmyQLtphgkBzs/agysFMXf/gaQn86UOEaXJ2riKfOjlviQKWQ07AwJ4oP9+
	 NKzyGWd9u0MOb4LpEjly3zkHfqvMY0QNHS/Hpi0yI3XsYcZ+LvmF7e4Iswoi1/tXhm
	 7mTLltU6Zz2MPuvA9yCakoEODkqxvawJvbG6YdaG9RjwHmPsDsZJ5jU5hbDGfNkh9B
	 6K4ggajWwuBkg==
Message-ID: <sashiko-outbox-180505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/17] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-13-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:16:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D12

