Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220304;
	b=caY7d0RqA2VUrvU8SGhhS3h76aO52hdYa0ENEPNoUblSm6GxdllGV66rr8E4PdO1nhUp
	 OzI4T99FNLGzG+7rInvYVWEe7F7QL7K3BaoI3IIgEY2IRvPBCOeOXoMJJGxCFn1vs8YlO
	 4Yz0tYUVO/rnUOkrIgU5IecK//cSTAKXZ0dCuEZSanv7PiFGOqFIfX2+HPr+fj31rXpt/
	 MKXmzXuuWaPJ78+JlDQS0ZcR1pH3RylEAJRfsWHJFf8jVqSfEUgDajj42vFkxe5jLtMno
	 PBVD/61k3haiau4ksPHHw7tWHcr4bw6T6gv3ESziWGL22HZj+kkhrDdvOtXt+d3uZyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220304;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CrYtaQlewUnQdLteoahoW5+khkg0nWbpHI9Teshcdjw=;
	b=H5SIpP/KNHIVfUvT/8CfnXQ6x8yltTrUq3U+FHjc1O8+a5NyUQhBBmRZAH5UwWJqC+oR
	 kHGSkI5ythiqnz+jjSxaw3b/0Gm6162m7Ht+jKrrieahWWDz9b8P6eUiyA4YyRUlr4Xsw
	 xH9gaxe0NjppzQT710BmGrVszw6tQcQ8I0/PvL0yWJZp1IjhKsdlvIL38W/FDVqws4X/f
	 HUJKf8pWbOVhEu0VuROxWfQKfTZbL4YjVjJdAqNLB6I1pvF5UGgurFRkrQJ7N+p2X1+ep
	 iRMJYdKo4+NmVoukPSwtP2O//8q6VmwlSyUlFo4tvb1DyQCqixzds+o7ssUTN7t7w0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSslyQo4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0B606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSslyQo4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0381F0089F;
	Mon,  9 Nov 2026 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794220303;
	bh=CrYtaQlewUnQdLteoahoW5+khkg0nWbpHI9Teshcdjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dSslyQo46rD+sUg4x+jRxiLiJfW9v8d5KTPYI05gDs7BDmW0U2lap8uvxMovrof0Q
	 tq3Z5DCXUkEHUn/Zugl0nBSTpFOIkh2q18kA9RGNWM7DDZCwVzp5kvGNo+ZGnN3l+W
	 tNAmqVhk6lwagbun5IiJZbcldXj3NYx7AjnpQNHUOTbVOhLi+hVMWD1SEtZ3pbVobi
	 9dza+/gXcB2R3SQXBkcfwqIC0HY2u8XnG3w2ygWZOCV0PGKRyFso1xjdgGHxIrWeZM
	 O4nhOXTTa1G1snj/3dFua+pMP9PVfxm+1xIeUigQb/XcYW4UPtGHuj2z/V00R06Y/j
	 zKOjkf4/7nsAw==
Message-ID: <sashiko-outbox-204821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/aux: Avoid reclaim for optional higher-order
 allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-perf_aux_alloc_optimize_psi-v1-1-d56ac4bf3ef5@arm.com>
References: <20261109-perf_aux_alloc_optimize_psi-v1-1-d56ac4bf3ef5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:31:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] perf/core: memory leak of rb->aux_pages in rb_alloc_aux() [1]
--

commit 2dcf33d1db6176542401bc5d602eab44c1364ebb
Author: Leo Yan <leo.yan@arm.com>

perf/aux: Avoid reclaim for optional higher-order allocations

This commit clears __GFP_RECLAIM and adds __GFP_NOMEMALLOC for optional
higher-order AUX buffer allocations on scatter-gather PMUs, and switches
PERF_AUX_GFP from __GFP_NORETRY to __GFP_RETRY_MAYFAIL.

Link: https://lore.kernel.org/lkml/CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak=
6LyV_We7yBQ@mail.gmail.com/

> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 95f4fbdfd2764..37bda4398724a 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c

[ ... ]

> @@ -733,7 +743,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_=
event *event,
>  		int last, order;
> =20
>  		order =3D min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
> -		page =3D rb_alloc_aux_page(node, order);
> +		page =3D rb_alloc_aux_page(node, order, no_sg);
>  		if (!page)
>  			goto out;

[Severity: Medium]
This problem wasn't introduced by this patch, but can rb_alloc_aux() leak
rb->aux_pages [1] when the first rb_alloc_aux_page() call fails?  At
that point rb->aux_nr_pages is still zero, and __rb_free_aux() only calls
kfree(rb->aux_pages) when rb->aux_nr_pages is non-zero.

[1] https://sashiko.dev/#/bug/linux-c1a2bb3b-5d2a-4fca-a697-ce07992a5cc1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-perf_aux_a=
lloc_optimize_psi-v1-1-d56ac4bf3ef5@arm.com?part=3D1
