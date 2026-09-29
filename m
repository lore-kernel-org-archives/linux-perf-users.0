Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F774542806
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695412; cv=none; b=piGj0zPtvEo09tfEPCnI/Dy3NDQZ9qeia1inxhtP9G0eWEFIABU8qg/XgwpYEHS4F4TC0Lj7JU3uzuRpapZFkKpej9exGAptW6RlCdUpEOi3EZYG0qa51UrthhX1B+I6Q2ENVTEzIGf0sJGF/sXMR7lgxth74kqfgcWk4/ULzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695412; c=relaxed/simple;
	bh=L/FdXe4LI4RyZ1Ym/o3wxbSTF7iQCF+GKzi4vFJ3K30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uR7Q5eV9zY1Mn8fIxGCc2wGdUnOi39MxvXZ4KyGuzQt5wNVUvw4uidgJb6NBgHH5Antfu7QX796SoWKG2BdAetSBMZLLoP1ldR2SX5Wwpvlqop9OpFaxOWt6yVd6pYgLhePx7oHhJYfxi5NK9Itej/CjDfmwBZ891e+nWr3H8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgr9nS38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgr9nS38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AF61F00893;
	Tue, 29 Sep 2026 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790695402;
	bh=RJmSrbzLu1Z6ZEDrjnU3c0fBzlLdo5q85vld39UjNv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tgr9nS38491YFERjq9ynPK154uJ6DvhjwOmVgEXBbRzjK+/2vmQKuv19ZrTutxGH/
	 UubzIsYDLnZ0Zxif/woP1euEwB414PtoCD0/oBdKaX0zNkotA9YoY58JHWPnBhWM9J
	 /xOrfj2OYAWg0MkGQ+HVIEXVwph4sMSsQro1yZzTaJSdynsMKpzhx/K5W1r7xV2V/j
	 Uxet17X0UrCLMC7Cpvya+4NpzCBB1NSxXNoS0NyhqeyXynH+jYUB1YxrYD3k2VK+8p
	 7wWmEMzFTIdsOWF+8fFbzMfKDzbJnoNGK1kONoaU1F9tolsFXK1OGwv7H72btAzoPq
	 KKqhQhrtogbzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: Fix ITRACE start suppression for
 inherited events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929-perf_core_itrace_start_fix_inherit_event-v2-1-9361a946ed56@arm.com>
References: <20260929-perf_core_itrace_start_fix_inherit_event-v2-1-9361a946ed56@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 15:23:22 +0000
Message-Id: <20260929152322.A6AF61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/core: data race on attach_state via cross-context RMW
--

commit d3d316cfe645aab199ffb03f9db1a44478297ef1
Author: Leo Yan <leo.yan@arm.com>
Date:   Tue Sep 29 15:08:32 2026 +0000

perf/core: Fix ITRACE start suppression for inherited events

This commit modifies perf_event_itrace_started() to apply the
PERF_ATTACH_ITRACE flag to the parent event instead of the child event for
inherited events. This ensures that the setter and checker use the same
event to prevent redundant ITRACE_START records on subsequent schedule-ins.

Closes: https://lore.kernel.org/linux-perf-users/20260901164705.042781F000E=
9@smtp.kernel.org/
Fixes: 9a6694cfa239 ("perf/x86/intel/pt: Do not force sync packets on every=
 schedule-in")

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 634d2ccbab82d..85d924cce387f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10568,6 +10568,9 @@ void perf_event_text_poke(const void *addr, const=
 void *old_bytes,
> =20
>  void perf_event_itrace_started(struct perf_event *event)
>  {
> +	if (event->parent)
> +		event =3D event->parent;
> +
>  	WRITE_ONCE(event->attach_state, event->attach_state | PERF_ATTACH_ITRAC=
E);

[Severity: High]
Does this introduce a cross-context read-modify-write data race on the shar=
ed
parent event's attach_state?

perf_event_itrace_started() is called from the PMU schedule-in path, holding
only the child's ctx->lock. It performs a lockless, non-atomic update on the
parent's attach_state.

Concurrently, the parent event might be undergoing teardown and modifying t=
he
same attach_state field using non-atomic bitwise clears while holding the
parent's ctx->lock:

kernel/events/core.c:list_del_event() {
    ...
    event->attach_state &=3D ~PERF_ATTACH_CONTEXT;
    ...
}

Another concurrent update to the parent's attach_state occurs in
perf_group_detach():

kernel/events/core.c:perf_group_detach() {
    ...
    event->attach_state &=3D ~PERF_ATTACH_GROUP;
    ...
}

Because child events remain fully active and are detached only after the pa=
rent
is removed from its context, a child event can schedule in and race with the
parent's teardown.

Could this RMW race silently overwrite and resurrect bits that the parent
teardown just cleared?

If PERF_ATTACH_CONTEXT is resurrected, it seems it would bypass the
double-detach protection in list_del_event(), which is legitimately called
twice during exit() and close(). Would this result in integer underflow on
ctx->nr_events and list corruption from double list removals?

>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-perf_core_=
itrace_start_fix_inherit_event-v2-1-9361a946ed56@arm.com?part=3D1
