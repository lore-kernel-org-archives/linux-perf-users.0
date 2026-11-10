Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349992;
	b=iFLvr4lehu6/OrTkOMXr1saBJSo8cClZmg+AdJhLa84KQL+SxXQ4WvrkwRyL47hFEVRE
	 IQoL5CqNo/hRM0ulgzR9t+Ul9+HP274lhZVy5iXz7+a+nGRDASLjqyxT+fMYr0g9l4o9m
	 aiddmw7S0q8m+8O8vW3zlSJnD9d7g1kdFh3CXucP/EoYgtpM2WJbSd8RdhbJTAN4oZ8eR
	 f6JSCh2fOK0WNhv7rtevYVBmklz1OJj3YTcYDVtJFLO3m1GD0FEx6GwWrA7JZwiN5dV6H
	 B+IzbMhAvQlJmYIMuvLtW9USXT/rquRq/rZ+Q7o0kfepTL8uPj/Lep3RmLTtvvgZ7pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349992;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=50+TQjeNKG9LKoqz3P54OBKma8JynJo1tVRgf+J31OA=;
	b=ca/rV/uUMGvA/ipkbsU8rccLkD4ljG8KuI0W4Tc5XmHMy4D6T8aQpEMhV2+TGOGoRTDV
	 Jk81eDYGB9kE1e8JQlB4VFKETfSq6SLlAKXRZ2Ulo3silr30qr612EzSkOHZmol2gH/5Y
	 da+aOSgsC2KcDzW+4R7MM/3LwcVB+QiNW69df0FiW4Pn/OPXdldFI4vDE/qzh6pZbs/9s
	 amvS3/Z5PjmIwTgVbWhOyYZsykcCPv1+kCoaDB2D7r2sRNAlEPz19uFNpjT0F98pwWzNs
	 IWKDAkuEpb43yrgyW2zQMU+OjX8Fb6OCPmf+Ic4VCAOTBANNFrjRCpbrY1Sd06TtEcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvqtRz+V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F18606A325
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvqtRz+V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2094A1F008A4;
	Tue, 10 Nov 2026 22:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349992;
	bh=50+TQjeNKG9LKoqz3P54OBKma8JynJo1tVRgf+J31OA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvqtRz+VxEDGf4VnPTZFYek5wqr8Y+Tp485qiAaP6gOFLEOlW0RqUH0ePdj8iBbVO
	 FCVJ6r4rpYisq1Eqw+N/SE3vhUfrsF6vR0R4JaqCMqDk/AOxj/q08zIaWHDPZglhFF
	 CcVXr4ATzdoWbWJHf2fYh08RjITqIyYicR0v4twbxY3J3WFZMkXUpd9CAJPXF1rLqQ
	 x3HhsKQfRRc7l+RkyJc7+QCxrS9BadvFzauGVh27apE584ULK5naBo6l8KodE85GhP
	 zKLU116+qmm4PAT3KKbTHUfmWzE9P/mQMnaO5ThRHOlmOZ4LW3ZdY8flGE3+6GBuuH
	 bE6B/c8ucqMtQ==
Message-ID: <sashiko-outbox-207831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/20] perf rwsem: Add down_read_trylock() and
 down_write_trylock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-5-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:33:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> On-demand memory shrinking (perf_session__shrink(), dsos__shrink(),
> symbols__shrink()) can be triggered from OOM recovery inside allocation
> wrappers while the current thread already holds a rw_semaphore (such as
> symbols->lock, dsos->lock, or machines->lock). Non-blocking trylock
> primitives are needed so shrinking paths can safely skip any locked
> container without deadlocking.
>=20
> Add non-blocking down_read_trylock() and down_write_trylock() wrappers
> around pthread_rwlock_tryrdlock() / pthread_rwlock_trywrlock() and
> pthread_mutex_trylock() along with SHARED_TRYLOCK_FUNCTION and
> EXCLUSIVE_TRYLOCK_FUNCTION thread-safety annotations.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D4

