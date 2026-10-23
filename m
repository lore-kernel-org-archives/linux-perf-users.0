Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783099;
	b=q47KcebtDA/u3TFhX+5ZedJt+hLDc9iLqGgVUaGwAt2qEjJU9E8MjL9R987NEmcyW+KY
	 tmpe+maDyVGivPBoIxMuRts0kGIeBpBbql5jQ8HjFAZo4zXkpxrVyN+coRfhx8aJrRsk4
	 IASlqKQ1/5+1u9xdTWeaiNAkjSHHZI4Fc+blg8hXek4mZV5s+l2fVz9J2S9d8hjWifCoL
	 glBNNHNNIX6JaQ72kHintT22szucmfPjJs3xb6/tlf2Xd13F1DtbOCttEl9SLVYfYWIW9
	 N4wgdVI+mHMNJeKduEGluR3aKT0GvaPxyQyy+kwmpOHbG9KlLyjkvRjaKHDTWtVTWsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783099;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5XuxF/PYnMduYTeNlMz3AgFqM5bLrJEreenYUua/Z/4=;
	b=Ozw2SclIZyHvZMjV1ohUwbt1ZnTNAEs/UY8jEnGBkY1KoQruHLH4dnBe+Py1eDIVdNn9
	 XZeijptOoZCu5NHceL4VkTwCLBBV2YMK2WrcH6JpFEzhNUkpQpc/P7sbO60n4HmCsn80x
	 +cj/CU1Z66lRZofxK9CIIJWJR6kXq2+wpUKqT/3BkrwqtiCS/xwMaDAOsW/1MD60BmN6z
	 6gHzQHw6C/0BRgssLjry9SSAIP88dZCGiTARhUP87/FTWjBi5Qd7XXyQB1kdjXC7p60g/
	 6Lk4iO6NQPqa3odRYZ1QJqdEu2WrloPLQ7cQIsRZ5zY09h1prPxBqgB29bBoMbWOiRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNSRK2n8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19E606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNSRK2n8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036E81F01825;
	Fri, 23 Oct 2026 19:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783099;
	bh=5XuxF/PYnMduYTeNlMz3AgFqM5bLrJEreenYUua/Z/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WNSRK2n8ShUEEIk0Lhq+aa3DBM0cbW7uE+VvE6vc5wPvcrmF11hJrV6bEp8GRIurI
	 yzMKQCBG0TQ1ySwFB71P6Ui/H/L/Na3BOjy5KnuCYgHSvyujAWQ05mnvWLrdJTOHj8
	 1ornIFFM1XtRyBLY4yWeQZ0Yo9ROIs0PPJ1Slic9vSsx74vpKaYiRiE148Ht6kfXc2
	 p/fsakMJLChNK/OXdRmGF4rYMM3U7ZZkpG9WGazhdCeHehUc7SxiQgejUky0rpRXJO
	 clYt1qipwfVvw6+RcQY9Y9Ww2Jw6eq4cTXume6Zyd7scwiwExHrgUaegbnlf/i0nDc
	 y618RZ7vPZ9XQ==
Message-ID: <sashiko-outbox-183104@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/11] perf bpf-filter: Support slab cache locks
 (&<name>) in lock_held()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-9-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:18:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend the lock_held() BPF sample filter to support dynamically
> allocated kernel locks inside slab caches prefixed with '&' (e.g.
> lock_held(&dentry), lock_held_read(&dentry), lock_held_write(&dentry)).
>=20
> Reuse do_slab_cache_iter() from lock_data.h via a SEC("iter/kmem_cache")
> program to resolve the requested slab cache name to its kernel
> struct kmem_cache * address, and use the bpf_get_kmem_cache() kfunc in
> record_lock_acquired_owner() and record_lock_released_addr() to match
> held locks allocated from that slab cache.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D8

