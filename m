Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903585;
	b=CVopctS707u7CNVp0GP825uwRVoniAw92y1pI3gRRY16/FVBoe+e+AgI4/KRH2s5iAvt
	 dvbbIKKc9dagsICVZ+CdOO8Y9BomxFB4yrc+DRWoxwnwyKGScGJOUxeJGQy8r1d7lrE8m
	 lAgT9g6r7sW79M0UnzVAIAcCxuX570FW0QrbB5bFOHkb1HnCzyz+5bbEQQHeDBI/jkG6S
	 KIogWntjtuqIEjziYeJF7Jay5nj86ujgfi5LWpYSIe2ifioSNOSBF+WlftUi6Z1AO4jIM
	 EBsjgXvLUlsjG4h6MithRM2uDhLW4CHHkUox+jjn8G/zMjRsTJHNMzpYeVbNPqiQ6GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZUc6zu5Qnd18KlpFtqt7jQqDfq0QDFCisjqU2zILZpI=;
	b=1yxGsqdlHqoMAcQ5083j4oFaIfwQifvC26sHE5kl+PR/B5wN90ERheLt/ywCZH25NSut
	 QTusQ5YlMHYrkvvXEw32bc/rcGX5iervxd6ZZMS1AQJrJzV3SfXw87TGEXfpBJfj0CPMS
	 U6rqZieBKYKavViPAUSzwO4KHWo6wekdKMIgT2tTtWJvGeQlDosORrTUlvwgH5+3J1x12
	 kN0QYQhCMlaXVS4rnkCQqYilaNM6vVbWX7I/4NBKCr6sSeasALrdQWKyXuSy/F2W34vbW
	 6GseNKrtLzyQlSe622eDBHiZ1r60cFuhUJPu9vFBD0iQps/hQSP0exJNA/0Yupkhbdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBF+eyOC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5F606A326
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBF+eyOC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907A61F0093A;
	Thu,  5 Nov 2026 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903584;
	bh=ZUc6zu5Qnd18KlpFtqt7jQqDfq0QDFCisjqU2zILZpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBF+eyOC6HQj6TTk4JfQchaZ6xUtazHw9U6wuVHwIeqLMkCplluPW/I3kBo7UfIhq
	 nGLKprDdF8E3JJeWCdN7S7WtkSGfZVrLE7O1v4rBxUfBe9lAkqueFjzmWvPUL9IBhz
	 RnRTyA019APHkeeJLZD9oiUNXEDSym4CtR4o1dmoPuGkcuinygW7wKZKOHpCkbdz9v
	 vpoHa/CPwUMuTMN8WpEwnzglSFzK4pbfIKcKpljY4BetCKzMKtQmHBi7onunZRyx6w
	 5WssryuxgMAdJnZM1RwbIWGh1emMqw9FobvuAr/UpCz4BPBjs08365H1gdQcjSDZnq
	 /1zMZssvHsy7A==
Message-ID: <sashiko-outbox-199775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] perf dwarf-aux: Add C++ vtable helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105181949.43198-3-yzhao62@ncsu.edu>
References: <20261105181949.43198-1-yzhao62@ncsu.edu>
 <20261105181949.43198-3-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:33:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add DWARF helper functions needed to resolve C++ virtual function calls
> statically in the data type profiling:
>=20
> - die_get_vtable_index() returns the vtable slot index of a virtual
>   function DIE from DW_AT_vtable_elem_location.  DWARF defines the
>   attribute as a location description of the slot but GCC and Clang
>   both emit the slot index as a single DW_OP_constu, which is also how
>   debuggers interpret it.
>=20
> - die_find_virtual_func() finds the virtual function DIE at a given
>   vtable slot index of a class.  The (primary) vtable of a class starts
>   with the vtable of its primary base class, i.e. the first non-virtual
>   base class at offset 0 which has a vtable, and the slots for virtual
>   functions introduced by the class come after that.  So it looks at
>   the class first and then follows the primary base class chain.
> [ ... ]
> finds Base::set() through the primary base.  The vtable pointer at
> offset 16 belongs to the Other subobject, so it's looked up with Other
> where slot 0 finds Other::hi().
>=20
> Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105181949.4319=
8-1-yzhao62@ncsu.edu?part=3D2

