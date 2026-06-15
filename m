Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFEB33A6E2
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563947; cv=none; b=KV7qFJ3Iaw419RIYXz1uIGdt5mkGyX6+YAYd4ZoDi4eC4WLFtypsW7xoL/zFb5noW52kCGnJdaNQD4YwFsXVnLU3UcEW22M94X/lew/KouVyZ7O5NZRXOfwDtDD6qaNEHrst73L6XH4EfvJYy+iBVZPIPV2GTygNd9ILHJPB380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563947; c=relaxed/simple;
	bh=TDDBx1ELWRVS/MMECjANVGs92CyNfD0hnJo+mu07oQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FzbAq48BmObZNs/UZ9df+Q/c/QBFG0+FEHJPOevQp8Kx3W8eqzjFwT/5oIhw9jLC2SGIUAITS0emEhso4UpGZN5LAUt3omf9KHcbgfdxn/7mG59rcKEoeBqIKYs2EfFfnf3fzyFvQ1SE1ajcmDhRVo4F/8n6sz8R7rcE3d5Oc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1uCXA/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1uCXA/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8B61F000E9;
	Mon, 15 Jun 2026 22:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563946;
	bh=lIQw5jhgQ1SEfRGYanodh9p4QLAIz1qZ8Ykob3xnh1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y1uCXA/Zewgz7oiKT48+upFWSJt7EdJgza8Xlz9R0uU6oxGPOAudsjpWM1tUZcoL8
	 o+r+CFkPCxEVZK+faJs/W4tRHc8qpiM/PbtfrWMLRH2scIIlEg/pi2kQyoaO7zC01h
	 kYdS0Xgvy21ZxagKADxCRrfMnXU0qi9BCd+sq+mH2oGU+0HtjCz4IKVtbWqRHvo4g6
	 hpfxqV3JtOt8rt15+VnSVUYibizalOJ3HO+OunCeZro4Z+72aTE7ihSqg+9m+jhUkl
	 bZs7EqmwrLB5CBBaaWraYcXWWSAXSBjnoNkY/8VwwAl2hGhhcVoshXe2qgbyG1fcBf
	 DzJECMh9laZkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] perf machine: Propagate machine__init() error to
 callers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223249.36598-2-acme@kernel.org>
References: <20260615223249.36598-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:52:25 +0000
Message-Id: <20260615225226.1E8B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling `perf_session__delete()` on early failure before `perf_e=
nv__init()` is called attempts to lock and destroy uninitialized mutexes an=
d rw_semaphores.
--

commit 0e04858ad5c2ebb0c7b3cfa94d694fd312c0bd25
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Propagate machine__init() error to callers

This commit updates machine__init() to return an error code upon failure
instead of 0. It modifies callers like machines__init() to check the
return value and propagate the error further up the stack.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 1a9a008ddda35..26bacb6c1a572 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -160,7 +160,9 @@ struct perf_session *__perf_session__new(struct perf_=
data *data,
>  	session->decomp_data.zstd_decomp =3D &session->zstd_data;
>  	session->active_decomp =3D &session->decomp_data;
>  	INIT_LIST_HEAD(&session->auxtrace_index);
> -	machines__init(&session->machines);
> +	if (machines__init(&session->machines))
> +		goto out_delete;
> +

[Severity: Medium]
Will jumping to out_delete here cause a crash when cleaning up the
environment?

When this goto is taken, perf_session__delete() is called, which in turn
calls perf_env__exit().

However, perf_env__init(&session->header.env) is only called later in
__perf_session__new(), meaning the environment is still zero-initialized
from the zalloc() of the session.

When perf_env__exit() runs, it does:

perf_env__exit()
    mutex_destroy(&env->lock);
    perf_env__purge_bpf(env);

And perf_env__purge_bpf() calls down_write(&env->bpf_progs.lock).

Could attempting to destroy and lock these uninitialized synchronization
primitives lead to undefined behavior depending on the underlying libc
implementation?

>  	ordered_events__init(&session->ordered_events,
>  			     ordered_events__deliver_event, NULL);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223249.3659=
8-1-acme@kernel.org?part=3D1
