Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD238A718
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428719; cv=none; b=uOyxK1OJF3ZBb04FjNkgU9PUygI4qKpMqrZ+ZtfGVq/RyHUdsTnbhJFiSO40Czopm7D55JTohBC8tBLg54fj9hElA+Rh4t31s5qa8wg7pbIcZpEPmhN6PeHhVWrbZ4NoITxXK8Msj40mxvvRyNZ+2kX8el9tyia0LfJkx3rEn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428719; c=relaxed/simple;
	bh=1aiTcZ/MXAwYKQPwWAcQEX4jPTNfcCXbnLRTMSArqTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pA296me+wUvg2PNvkQaZNbCgUsK2hRxcgswaat2eLN7QoBVMAZXlKTYz39QyjnnA6gxhM1v8ldgRXtqjfrc60G4jFblIeauNsERmgJSZlrJAeHY3y32BkMWYKwGDRRXHbTr2bseH0nD+/zDfTEeAZcyG89eMDYhoPE/+vyvgO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGIwvlIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGIwvlIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5661F000E9;
	Thu,  3 Sep 2026 09:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788428718;
	bh=1aiTcZ/MXAwYKQPwWAcQEX4jPTNfcCXbnLRTMSArqTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oGIwvlIQ1QVi7DZzSNxB4ts3cKdUqzKHUtlGd9sbDAzgLMs403Ds/rj+kpcKWKp4B
	 zA0sdw7kSKWyzNORhij8JZUypdzd0ogCt89eiGqHbFoI35JEQDdDWdwK3r4wGE8HWD
	 cj1U3qDsJtZmyAvF5zP7RI7KPT54o+3TBJUXMbCa26/8PWGzTGIaeFMnN0vFb82Rfh
	 sHkvzQUxN1dfd1pxoFsPQh/UCHjGQPGx9EO62naeuMlvAw5cJpHtf4tO8KO8hiFSBu
	 syG6PlO4fWwRILIlWUs0Ritcfn1MrXw+thMAIA1QJVkSazznSdj1lkbazoJTjlAYZq
	 W/Fn4QLUpGB6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Fix ITRACE start suppression for inherited
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903-perf_core_itrace_start_fix_inherit_event-v1-1-6bff7e675af5@arm.com>
References: <20260903-perf_core_itrace_start_fix_inherit_event-v1-1-6bff7e675af5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:45:17 +0000
Message-Id: <20260903094518.1F5661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PMU drivers call perf_event_itrace_started() for the event that has
> started tracing. This sets PERF_ATTACH_ITRACE in that event's
> attach_state.
>=20
> For inherited events, however, perf_log_itrace_start() replaces the
> child event with its parent before checking PERF_ATTACH_ITRACE. The
> setter and checker therefore operate on different events. If the
> parent's flag is clear, the child continues to emit ITRACE_START
> records on subsequent schedule-ins. If the parent has already started,
> its flag can instead suppress the child's initial record.
>=20
> Remove the parent substitution so that perf_log_itrace_start() checks
> the same event that the PMU driver marks as started.
>=20
> This is safe for tool consumers. Intel PT uses the ITRACE_START record
> to set the current thread context. CoreSight ETM uses the record only
> to find or create the corresponding thread. Neither decoder depends on
> the parent event.
>=20
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/20260901164705.042781F00=
0E9@smtp.kernel.org/
> Fixes: 9a6694cfa239 ("perf/x86/intel/pt: Do not force sync packets on eve=
ry schedule-in")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-perf_core_=
itrace_start_fix_inherit_event-v1-1-6bff7e675af5@arm.com?part=3D1

