Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD43890E4
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620653; cv=none; b=CuWilr2uQqIGkzlkmsyW3SVoIfiQCAsJFou40MXhtOsCHgUymCz4XDLuCKjdc4OQKYc1uGib0ZIi14kuN3JLDX9MJ1LuOAP6xX4kD5rfwXfR5w3P7zO5dwMgsvcJhnjZLjOtqfSOKKG0PTKTLVWkyIOGuutJQg1k2zb8iSSoRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620653; c=relaxed/simple;
	bh=snON0KDR054PNXKy1qXPTC1B4iNe6W5H/pb9ITrtChs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Iju/XWMETHnEKX7al3yi5UyvVeJTadwz8C2C5rCbrXoNSB5SQ4F8cKg/Pm1ZKzvh+Vpt37keaYABwaYJsVnnZ1shvUoNttnoyxqYif7ImaGueDU4mqQm7G17trxRH/s8EvoCQUs8sy2jRDEimCMOpQUSfMN2ZIzn69ONt1PrdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUn+vBF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUn+vBF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D26A1F000FF;
	Mon, 28 Sep 2026 18:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620652;
	bh=49hWnOwGjhp9XbjbvFc0EfTWjXa7UmGzNexwI6Wu2Fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XUn+vBF96eGzDSmKgjcvMUG1Pk3GftOPyncPWO24HjnmdPka/HXGyPfM0AFn6V+LF
	 c/w/Q79V9VcqGCg9P1IzyBQgF73vOfQxUoMhMYn7d/ZeJ8Xi+hVK6t5LGRSXPrzKR+
	 81xfSvc1Kol9tOHZf8TAPlEWLpyGMDpwexuaOhI0dOvhtDhVgA8sl5kvl2bgaawSWN
	 Z6l+uhlrKC7FrbcfYAUua/F5VQZevpd4wnnEo+ymbVzJ4ebFQb+X5Wt43s/3q7N3Ds
	 OfnNu5wlrFW5yC2FXcQ0P5s29jxaZTfWHTwEfDJ5mTcxAJQwTGbzggHY7upBFcGwJq
	 KHUBW9Fy2Aiig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/26] perf trace: Bounds check augmented arguments
 before reading them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-5-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:37:31 +0000
Message-Id: <20260928183732.0D26A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> syscall_arg__scnprintf_buf() and syscall_arg__scnprintf_augmented_string()
> trust the augmented arg's size, so a bad one reads out of bounds:
>=20
>   #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
>   #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
>   #5 0x4c33ae in syscall__scnprintf_args builtin-trace.c:2722
>   #6 0x4c43d3 in trace__sys_enter builtin-trace.c:3094
>   #7 0x4c7865 in trace__handle_event builtin-trace.c:4013
>=20
> Move the check in btf_struct_scnprintf() to a helper,
> syscall_arg__augmented_args_valid(), and use it in both. When the check
> fails, syscall_arg__scnprintf_filename() now falls back to vfs_getname or
> the pointer.
>=20
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D4

