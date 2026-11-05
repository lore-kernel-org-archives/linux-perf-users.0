Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871641;
	b=pt+m1p5j6fNbu5nHD3dOIwU74GaR8QpMukeZPlnh0PajDS6n11+1BgIRBVmzph4P06ed
	 4k9+IHGx2kKGrwA3yvkSoOfEY48V1Lx6ntUbUwRpIs5wRG2BRw6IzTGZSYWku3boR4DWz
	 PHcXvmaO9z99nFzA0iVfJcj8WiqlUhMWVYuHvVaNhTsEYNZqJZXcZXuAsbHCFHAkzL4YH
	 Qh0Z8nmWJoDQ7Ecv7RiZmFMoENKyM5Sn8J5ep+XKPPAb0MZaQ1WEqEHYjJ5EUERpfDTru
	 4huS2jtCT8FhG5eYyRa1LysvScAmsc1x9mHy/BJHjBoyY/sMnXea+VAsm6uvp1cP+Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871641;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IJYrKfD6UBJNnUo6Bova2y+n2el0/U++PsPc7I2Jb2E=;
	b=euOi2vNw6cxct2XYf7Pu8/IldLlXG2o2nUpiO5ACRzady9axLZpAYKEyBpbo25uT6Xsv
	 cANguAdcqzGdP3RkPSRPnE+MK9TEWmL7pd1qoD2J8wXdJPydwjrWYL5JK0/N7nB7qCWtB
	 KTOpfbj7NM/ubIqWGM+7gl30zK36nLVqz9NdQt+7iW7k4RVJQDalOf3AWe4Rx+YkqeaPZ
	 4I2AMA9ehY8gU+BRLiuuQ1iwkuqQWKlZM/oM9LPfqgJf/JFxJSHjCnSp8/tRf3i/9YlFL
	 qFqqe6fgfH4uFjdmymchNs+oJfDnZpnNFWabwpIG9fJ1DgKuS3gznFgTMtiUB3pmqQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4re44Q8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DF606A326
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4re44Q8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4761F000C1;
	Thu,  5 Nov 2026 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871641;
	bh=IJYrKfD6UBJNnUo6Bova2y+n2el0/U++PsPc7I2Jb2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4re44Q8J4M6pxQt5CYWZrROehNYAIr5Eok9qiilctfQ/eXgnf5PQvgUzIkW3jrDj
	 UrB+zYfLgMRrSeKQLiqdaLNwxnWBonT9nzjBhRfc5bYgF+KxiM99SUJITi6Aafc2Do
	 bnO/xtof1e23ezD1sR6gkSJsG1Y0CzapMeTM3+C6ictaFFOtGasi9/4qFz7sPA8k5J
	 aGLUvxPWnYAlxoISJbOI4PAjqNuPm+djR67XoQYK/xSSxDhyW5xARG6sy6PDcy2NxH
	 mbzkwFysB4zky04bt1ZzP+Pf6qb7c7K/QMl0pnBh1hoxRtYugvHAp53NPu0Wc17qkV
	 eS1PG0U3BOU0w==
Message-ID: <sashiko-outbox-198770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ff842e802e9ecb74510a90964f8ad2c4825834b7.1793870900.git.wutengda@huaweicloud.com>
References: <cover.1793870900.git.wutengda@huaweicloud.com>
 <ff842e802e9ecb74510a90964f8ad2c4825834b7.1793870900.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 09:40:40 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793870900.gi=
t.wutengda@huaweicloud.com?part=3D1

