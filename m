Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818767;
	b=d3tWwxBD9Pb81YackRIpwmJqgxXF/XkDjkW1jdyp3bQTro9QbfyXsUPElBkXo0x/XXX2
	 WtrTkTEX120TzsyR92Mbf8nu7x4yStk4vnXoBWIRCyIPFQCGUaf68qHeX4QWrXqRri8aW
	 UKZjnjkIWz+6USe5hWnVCPJI/BTB3rzQU4KMMVN5RgZYt6M5GHesj+fDwVEUE95g22wdO
	 H3Ec8nUVt7lZeAV7K164xnOmyJkuk4lcJ9wDO4fcxKF4RwK68tVg6hCqJU1A7QvHAlDdD
	 yN4bh/qcTiIuKegQtfobT9eaoWIKNmIIE+/lqctDkpxx5Bo+Oq115+hnALajqMJA+EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818767;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FA/j9UqmRbnacdiRuNtAQ68aJ8/fpccTWV7cQxOYlQ0=;
	b=YUZ7y1/s/qBWPSTz98im6hA9Rj/aWp4Ec/ApRqB81renpFozJJ6p1eCrwAg+EZxi2W7m
	 Ii0nkoFdIkwZLM0PJg6YoGI8Hygcy6Hv3zQT9pN0f3h46hS5E8ht5tDrdBi5oFF2t4AZG
	 Ap9IIY7Vx9fos0tJt0vWT0IYJ2jINtMBuHVnjf5rlSYtuJcLud91H6rIwzpWkXIwUHq6Z
	 Lb728uL+xt89c9nWe//aofb0L+dyIWJ0Em5KE+OfbG122vy6k+TWncCo/Ba+yp3ZEX3tV
	 mdGvCfs9+B90tgQ7CWau4pRUpQMfze1/e2ah8/FDChyWA0SNhZS02CTabvdcklIJP9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdzcSKuh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906F606D811
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdzcSKuh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995241F000C1;
	Wed,  4 Nov 2026 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818766;
	bh=FA/j9UqmRbnacdiRuNtAQ68aJ8/fpccTWV7cQxOYlQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TdzcSKuhRqRiasuh2eTtLq/yO/S38m9uElaiUSwH/l2cb4wtlqe+jZ/RKpkQOWn78
	 F2/LhTnmdgkVEfalHXwRGiUFTEQExzV7ss44cPOtvmEOJTm9/qJOFvYg3aom0Ytzgq
	 7t4upF4cCVXJKMhvWPbH39HDNA2W4K/q/JSwNwkcQnXDzLOaUmrdv5+7EPlm3+t6XQ
	 uOPUol3zCi1g9mU8mi3OQUb6pcBhn3W+sVjGXBaM6XValo6NiGXwbUfKj77bhJhPSQ
	 h6a07pqohBTCRl67a+ARbY0X7IEm9f1xoX+9yAQP0QP6H/Z2lUf3w5D7OHUxrkBM0O
	 DyM1115uHLw5A==
Message-ID: <sashiko-outbox-197900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/13] alpha/perf: report the data source of
 ProfileMe memory accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-10-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-10-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:59:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Whether a ProfileMe sample's memory access missed the DTB is only in the
> PERF_SAMPLE_RAW data, as a DTB miss trap.
>=20
> Set PERF_SAMPLE_DATA_SRC for the samples of memory instructions, so that
> the memory sort keys see them. One that trapped on a DTB miss gets an L1
> miss in mem_dtlb. PALcode fills the DTB, so one that retired without
> that trap hit it, and gets an L1 hit. mem_op comes from the opcode, as
> I_STAT does not say whether the access was a load or a store. A load
> into $31 or $f31 is a prefetch, except for ldq_u, a UNOP that is left
> out. Samples that fall back to the interrupted PC get none.
>=20
> On an EV7, a loop that loads one word from each page of 64 MB in random
> order had as many DTB hit samples on the load as misses: the miss trap
> aborts the load, and its refetch hits. A prefetch into $31 takes the
> same trap, and its samples are reported as PFETCH misses and hits.
>=20
> I_STAT[TRP] is ignored for an instruction killed before it was mapped. On
> an EV7, TRP and MIS were seen set for killed instructions that are not
> even branches.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D10

