Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952231;
	b=wnKvPDndy9587O/4Z1e0qrxF2ivw8uMdfj4NbHSMd1u3RKHzKBbKQePsi0vxb8T3vwBI
	 mqa8R0H7ww7y2Orc8Uw5CUuo5Jxc+DB4h1jxj3tPILdXGXuf498pO1k6An49Gk4e5NyAZ
	 ij4nNO7EZTgdBdRywckYSDfZlqdripIkergAHzWJM9uIEMjyBvi+ysVl+4tOBNXl+WTYi
	 tk0nnr5M8OUns9pjQNWEFunmZUCvjfH2hfVNd97dmH/vUUvMGOAxYxgWiaxXDzKFYRMJA
	 FzD46AT4sf+CxEPfxoONZc/VFshGsJT+LoirK/J30qTgkFP7RUspjCe35/TdGIYUzuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=keC4b93GWAAkVL76YWzCbGB8TTsfZqreVdI3zf8U5vg=;
	b=CY99xCVA0oTEx9amRNE3fCZmBW+ch4rm7cFoLlz9SCfWe743VzUApu5fPuooiotcF63K
	 3/UT8MhCQoxRGfKw2cAjSDQ/ivuiYAnIeMUtsH5AShqkAAC6Gow5RZzAxwVYxWDakB6vn
	 AgNh75NRj36L3cUa9rR6tVeV9Pb4JBoKY8D3oxkf9TmfSjkdIU2IfeEEX+kn0AiOELksx
	 lh+4004Pm47EDKBVO/qEjMWIkyb7IvRbSZmEGd27MM0TWc1QdE+EtLH6EhOgMdIdjIdbv
	 PfHuAAOEK/yvflDGHXNU29ijTnkXANbFzW5QnG2dSeHDww7WSdkf6D/b9qUz9qqzrFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ng6WXL7V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C90606A31B
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ng6WXL7V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8831F01825;
	Sun, 25 Oct 2026 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952231;
	bh=keC4b93GWAAkVL76YWzCbGB8TTsfZqreVdI3zf8U5vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ng6WXL7V3iABNfKRVx+F7QsVlRWUq5mYtN/PGT07xA+uB1L4gXPFYgMBTIkKPd8li
	 nvgnS6xnhL44KNEgiorN5ELWX7Q9lcBdK01mxDbCSMlC7Qt8ksPP45c6lDxrAEySlG
	 O1vZ7JK/P6fP+GpjK47MlKJDuOm7fY+DnzgZOLdVsvp+j1yiXMje6tOwZcW0iA/l5W
	 LHLiOTObroHzPgpJ9XZSOHfpHl2SBFv3tlBTlsJB2pHRlOJYxZNC9QQJErA4w9WxOy
	 Y/qpJa1K/zTQjY5Ov0NY84E5fYBQ6GXPEmDnp6Z3TU+2ny62pC/n5Wtoqk9s8C3IYD
	 6KyvAoVOCyTsg==
Message-ID: <sashiko-outbox-184319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 04/10] perf ftrace: Add basic task
 call stack management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-5-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:17:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The function_graph tracer records kernel function entries and exits with
> nested indentation. To perform call graph analysis and subsequent inlined
> function reconstruction, userspace must track the active call stack on a
> per-task and per-CPU basis.
>=20
> Introduce basic call stack management for the function graph tracer:
>=20
>     1.  Data structures
>=20
>         Define struct ftrace_stack_frame to track function names,
>         indentation, and inlined status.
>=20
>         Define struct ftrace_task_state with a dynamically resisable call
>         stack array, tracked in a hash table keyed by PID alongside per-C=
PU
>         active task bindings (ftrace_cpu_tasks).
> [ ... ]
>         ftrace_cpu_states__clear().
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D4

