Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831112;
	b=cnyg8icrxdDDEY1fD4TSzrqVwbQNyfCfbqLgbB5QCX4NSxIaZ9MsKkwtVuyBMSlXK+q5
	 NEhS2GS0sK+vkQyOKzcmZjy0BEhKvS6rk2LWjeqNZoRK3Ek+HQ8SkQwe8FUyl0UbADYbH
	 6KQkM/08IyjXBrKFwLI7BCH7SYEiJ3BWGe/LW0J0GvUPvDjBts25J4JlX77qcXXeQSr5N
	 hF2UvqMyF88CmNOOyauZfxfqj+TpRmyFtD/g6fsBVIw1UqCCoo/tjlJpDx5/OTAI61oPo
	 BfQQH5zGr+ZVnTdj0qFrWmWCazASGHcUoQz46WaGiTJWr9T+UISPIEULqY/U2qlQRyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v2otf5CLoBxNheESy/FX0zrwueCxq+vuQ6gthk9pRAc=;
	b=eKjyIwHB/a3wYGGGg6gl6Vx0YRX7mM0YcRby9UMkqL9PJ1FHRIKVS27HG4zp8LvTEOXu
	 QAH7bgkvyur43BB7Pw2VURYf4mRquCGmPjAEIjzn6xxYMAT+xIJPcuTTpjIHhJTA89FXf
	 MuORR1J+XspSL5viGzEVOfwbG9V0SYN5Ucrtvn3YefWkG55alGwSAyT2LUIeV6Pzw5Pjz
	 zpzaH3CYzq+B3alibo1eAye4GGjjZtAn41V0PLLaBWeKYMX/DRDgKmsE8gfjcQM2qUyxX
	 0i4ZIR+eG2KDF0cSJs8oeNGXo2tRFHVjRFTznWbhs8woe/GiMroGT2XBSaMDIhhpiGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxTOAlOM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD5606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxTOAlOM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212031F000C4;
	Mon, 16 Nov 2026 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831112;
	bh=v2otf5CLoBxNheESy/FX0zrwueCxq+vuQ6gthk9pRAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QxTOAlOM8rnci3LEo/ReAvWcicyvHyU2lqqEbKae1BlDFytxIbLAfdttWiR4iHw0a
	 VwO4mmEbermNiOhbYV2R7F3Cgq6gLt0DL66Iy3B1Uz8XaJFsnpxcPCnBmBCLgh1vEJ
	 ARZxpY+hTiK3xTk/avvEn+YDv6/1I5NsJAUbJsbbheCUbUk2TpG9k9x32nS2SfLjCd
	 AsEcK99jKmRv09iklX0mPQdms5l68s4YT/vaKYkdtZ3MwZE2oEbyVeXVT3jnzL60LI
	 WnO1WCOV2W3OyG3AUyK09N3Vg93I3I+k0LdpnTJ+tkuuevgzpXoSTSbecEFBmfs+hF
	 BdVlfoyr60McQ==
Message-ID: <sashiko-outbox-216989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Protect ctx after dropping its reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoli Zhang" <26031212468@stu.xidian.edu.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116120452.22269-1-26031212468@stu.xidian.edu.cn>
References: <20261116120452.22269-1-26031212468@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 12:11:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Take an RCU read lock before decrementing the reference and retain it
> through the non-final branch's tombstone check and wakeup. This keeps ctx
> alive until that branch has finished. When the decrement is final,
> release the read lock immediately; that caller continues the final
> cleanup and queues the RCU callback.
>=20
> Read ctx->task with READ_ONCE(), matching the WRITE_ONCE() used when the
> task context is marked as a tombstone. Keep smp_mb__after_atomic(): it
> preserves the existing wait_var_event() ordering, while RCU protects the
> context's lifetime.
>=20
> A similar fix was posted by Weiming Shi in October:
> https://lkml.iu.edu/2610.0/09721.html. This version releases the RCU
> read lock immediately on the final-put path and uses READ_ONCE() for the
> lockless ctx->task check.
>=20
> The report shows the access in put_ctx() reached through event release,
> and the free callback was queued from task-exit context cleanup. These
> stacks are consistent with the post-decrement lifetime race described
> above.
>=20
> Fixes: 59f3aa4a3ee2 ("perf: Simplify perf_event_free_task() wait")
> Reported-by: syzbot+56ad4cdaff8716472033@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=3D56ad4cdaff8716472033
> Link: https://lkml.iu.edu/2610.0/09721.html
> Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116120452.2226=
9-1-26031212468@stu.xidian.edu.cn?part=3D1

