Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586045;
	b=PN5laQ+iGymIlMwSw4sY9zOcrvidg3lQLRuf9D2n1VuxtL45VFrW84kUKEC3Wrhh5opz
	 hKksdZeBJ8NmjdDbKOwFeQdAz3VBdevcUv7NxN+WG/yhSHVC3mbwmpoHJy/GiW5Y5aEAy
	 aoQWsE8kvUEK2bRH18MMZHLFncHEgyKRHAgbF+5mqL7/XoOMAT1BCgqOJQyr1EI8CaCHW
	 KZOh6+c7ueXhku77udwe5TzT2ftGih54ChRw8Sw6SrjReyUm3OW6PeKGPB6ZhVABruZR6
	 Sy5t4uScFXYn7LrHWERcnunrIkDdDnLO4v1wEObUnWDY8iC+1HJIn9pGJR2OQ3GiOLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586045;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JSpJeOSCb1e+Nppl7Za1J3lhR0uIc6ZOwkyMf9Scmak=;
	b=VZSjIy6wqlnuUVnBEY3QA4l+9gvIDnhqAou3j0iroZbjIriLgKniu+5TALDaKZA8htV+
	 S+1x1WaL0vIsqC1Q1g8lHn3FEdhw1W3GCUhSYmXPpzfoCBGIKvZATc+kWjAclZLda3gpG
	 /+c9KPMFx7G6+9dkwAgIWq+Avapb2lcJk7LsmNI4f3JFtzb5W8fgoV9lcsYgzS1TlQjZ6
	 m9dW3aMWzmHvYhZZZAaby8M2tGZ/yJEYGt+edACvvudPtJTQk9mf+QtlEAC1GbDRxFdKV
	 tiskhyE6Cy1mT+TAVjq22eSuWVMXGTPH9J2LX5rbn4o3uLzuO58PyndR4gpnq7gFVZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiiqZyHl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE4D606A327
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiiqZyHl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4F21F000C1;
	Mon,  2 Nov 2026 02:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793586045;
	bh=JSpJeOSCb1e+Nppl7Za1J3lhR0uIc6ZOwkyMf9Scmak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NiiqZyHlRghwqR5ftKb+vYNYvfQyDZNwHM/zluCPgJxX5gZpo5+vKx+NvPYC8ipCh
	 4egjv/Pqmpo0dGtkkP6nZb939bgPpUMHNp+pCAo3JONmlejJYYIGGJwAgtotwZvYOR
	 imO0ONyIoNSup3upeVID9JbkZt9ZpqVyXBfR3QUyFP6G1Qqx5D+jCyy6LGuKd81G0c
	 ihfZ9WB+NPD32nTF9EO6/bVGutk6yVxDf/jTfagbDE3uH1X6Lyjbp/tjAwe7hYLfqs
	 avDYFnNchMyVfhVxgUPydm7OHYOCEuHv0D7OsYQe9nvRqOSN+HpuTIG7lDbQvF+oWA
	 zx+BN+UR3u0zA==
Message-ID: <sashiko-outbox-192831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102021355.650671-1-wutengda@huaweicloud.com>
References: <20261102021355.650671-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 02:20:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
>=20
> This leaves a window where an NMI can interrupt task_work_add()
> and re-enter __perf_event_overflow() for the same event. Since
> pending_work is still zero, the nested invocation can enqueue
> the same pending_task again.
>=20
> The re-entrant call path is:
>=20
>   __perf_event_overflow()
>     task_work_add()
>       kasan_record_aux_stack()
>         <NMI>
> [ ... ]
> Also use READ_ONCE() when checking pending_work in the
> exclude_kernel warning path to avoid an unsynchronized read.
>=20
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102021355.6506=
71-1-wutengda@huaweicloud.com?part=3D1

