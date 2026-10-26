Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007468;
	b=IOann1YFD1npOTnW9oU6S+cFwh76hlnET4Imutk2+GRN4y5z7TkSSXuV3Ui8E8/N3Xz+
	 8vSUOZqNOySTDSn7mluNIwX4TBfSTgvrifK7i8UlWA+yvzoIVhjEVkR48enT31U7/Egow
	 /ycDShUHCgiE4gKQD1H9QWQCgLnCdFTEpUrjlodyabtdAU2AYbHKnXNTGTQe7cO1u96gT
	 ABXD2bjvnnvAzdlNs6cAlBQVZlTiwMo97VNxJrJ4VKxtmk+0RsPnOCXt9VGDRtF4kdxZm
	 4W72rpkYQLdAxKOOPT+EfxIB/wrMsScZS7DiFfbNeInx5X8kJk3+RTUtRSAPRTMYs1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BYc2HInoRHdSbriuiOfFWNEVrkV7wNqrvuZU9P2//8A=;
	b=nSogZ1+deoxOuESfqva+AVxdNwB+K3rgnOLzNYs19o/1plhKleRuW4Ie+R+DD/I8qRPQ
	 Y9BSzuZGRk109PP5ZjOs2AuY0FyAc39U8JXZzypCe24/kX4U+nzrFmleUIqom/+mNxSa1
	 Z2eXGCR3xs51SQPLwG59mwzKUkYe160Haly8ON12V4/NbuBaKPSr8pDF1nOjhchpWlkx9
	 bzJZezrbRP5nxH5rVqfDRY43bm8Xkjb0QBhQC4/gX8p3dXBudHGEp1rj+SDSwzBChcZLB
	 KoQGoZ129OEKws8L6WsmXoXm30P1Y8YR7GZU6GvrRvS7vgiaCGxSFpGM1fG4wJHb2pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMaE4k2Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610A606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMaE4k2Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6A31F01825;
	Mon, 26 Oct 2026 09:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007467;
	bh=BYc2HInoRHdSbriuiOfFWNEVrkV7wNqrvuZU9P2//8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMaE4k2Ye/U+PA6Pj8LL2ykvoiQq4OVhmhmsKYX0j/oUY7FafZI1uZlENNPAVASub
	 5clwY+CXy+GBhzq+bXkBvvwid+dpwOZIPz4ZF9oFjkYLoSXYK4KT0yI1LwnPY+6yr5
	 qwwO8yakBapx1bBjuBa8ySbBYqJujMm/WRQ4ZnGyHL+ABnQmLmlXI4P7uVcJo0GFT1
	 kG9MmJKVLGS2qLypouvHFJl3xVLGw1VERayueFPRC4DyKl97fUPIcYS/nVyeGgenDX
	 sDnbA3VfqpwO/wWBhWuzBNPwi1O0n1mieWdMj70Vp/0CW7fP4ZVLCTZddIx0O8MIPu
	 fDOpgWoylwWxA==
Message-ID: <sashiko-outbox-184813@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 04/10] perf ftrace: Add basic task
 call stack management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-5-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:37:46 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D4

