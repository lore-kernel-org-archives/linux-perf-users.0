Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607264;
	b=OQ8UVzs2JskLzA/4irQApXalTxb1IUxGBLvUaVBtwNSPDo82L4NupeRcjMDJWapnRg/W
	 kdWgQrP0M5GvFPo5wSBziW0tcF7krwFgphv62Lh/SDyBpJuUyvlVKJ66mh2yRYxXTDs/S
	 4+W+xnjKVOj4LtEDagLevA9FQSppmRTXKawp7onhjhl3wRwceDDwOTW1h85sGTIga5UQG
	 0oGFh4w439zM4a9hFHeZY4wfR9TALc3bBBG4xlVV55tZOZyHLYLsmn0hDLkY9JCYj0lsu
	 EC/iR+U0NfyPNOlkgZcoAHry89AqtQt7Wpi6PK+MtupUrXSC7nLSqQCrzPch8UfTvNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607264;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pmpEzBCqGCx8n8LC97v1JjO0sastU1Cy8jEDmau0mJ0=;
	b=5MonhPysJB2oImvXMxcT8vsEbgcxN+e3Q1h9c6BUw35/Tdu4AyM8nlMOPDR37nmMJgPZ
	 P2Lh2NRR4Lb+81IGvpKY86VaNDHM6FOixNNHR64/cE3JABLoRAWAXGZA8nivwK0r3Q8qf
	 Zsj2buWM+Y3/RbRpORAdCX2P6mP3f3dTG1BAD0hMgIUTU4blzevgkKQ76bR3Lwp6ZdBHc
	 /wvZx3TiYeB+AcNlG1SsypiBAtIi9gdwGg5LwUHNB37OT5kLOOxTvYDHX9kGkWc3Q2DvP
	 VNnvWTS2CHHg5PukNZ5dXUskc3xdN7lLbV6m2R+aQ/SXulb2Pvi6x3BD7yBYwzi2LTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbY83exi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE0606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbY83exi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70231F000C4;
	Fri, 13 Nov 2026 22:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607264;
	bh=pmpEzBCqGCx8n8LC97v1JjO0sastU1Cy8jEDmau0mJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KbY83exipAc1OvDqztwmCzVhhT9hxTKTyJiI/DrHI6FWfSOWycP4pbFW/7wr7/LaF
	 oldkSAZajblWlf/laAeKml1SphbVCju9g9Tr9NQHIihpB7TOloopazJchb+HeIZODe
	 hq5th7t8OZHupLRsQ0ogveHXKGYZUuxG1sNLu+1yHJk0cR2xhxvkbhXRsGxJakvULU
	 yZ4UWVUw70t6Zw+V8JQmhYIkNox8b+SvSaa5Wl99okQL7kJU74j7eoeVyh8XaatKj7
	 T8To7mAShDxCJi6n5FIXNelnMj8z0hRDuCyanYJdfD4IO+K3kZjocMcvKowdodehMt
	 qC3tpC13M+Hcg==
Message-ID: <sashiko-outbox-213764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/26] perf hashmap: Introduce generic types and
 macros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-9-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:01:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add DECLARE_HASHMAP(name, key_type, value_type) and type-checked
> hashmap__* wrapper macros around struct __hashmap while keeping legacy
> struct hashmap compatible so callers can be migrated one hashmap at a
> time:
>=20
> - Encode key_type and value_type via phantom pointer members in a union
>   with struct __hashmap so wrapper structs preserve identical size and
>   alignment across 32-bit and 64-bit targets, with _Static_assert checks
>   that key_type and value_type fit in a long.
> - Generate typed <name>__new() and NULL-safe <name>__free() helpers,
>   plus pointer-taking hashmap__init(), hashmap__clear(), hashmap__free(),
>   hashmap__size(), hashmap__capacity(), hashmap__insert(),
>   hashmap__add(), hashmap__set(), hashmap__update(), hashmap__append(),
>   hashmap__find(), and hashmap__delete() macros.
> - Marshal output parameters (value_ptr, old_key, old_value) through
>   long-sized temporaries and assign via the declared types so sub-long
>   types (such as bool, int, or pid_t) are safe from stack buffer
>   overflows, endianness bugs, and strict-aliasing violations, while
>   allowing NULL output pointers and const-qualified lookup keys.
> - Implement hashmap__for_each{,_safe}() and
>   hashmap__for_each_key{,_safe}() using single-loop __hashmap_iter and
>   __hashmap_key_iter helpers so 'break' exits the entire iteration,
>   bucket cursors are internal, and element deletion during iteration is
>   safe.
> - Add a 'Generic hashmap' perf test suite exercising integer, string,
>   and sub-long bool/int32 maps, NULL frees, const lookups, early loop
>   breaks, and in-loop deletions.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D8

