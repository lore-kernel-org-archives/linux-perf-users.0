Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793448333;
	b=pZ4PdBUkc/8vmym3s6jn9KEM+F6eXWLXRrX1aTdnNPtsF382Th0erWeaKpqrcW3dd2FK
	 3VfPBlFnyw034J7HEofG7VEE9dq2mUXbDnDsdN0LJHTuav4uBqv4LDhBSdRrnikQRbpHI
	 1fq7Jz9xLp2VKZfVwq0aYgoBqpJJubZKlgjJ/Ox+eCQFhZ8HumRZMrudifLoOK0zAOE+D
	 0bX3JXzHY4fihOcpb1/ERoaRf3DqY2tnqiRhbT6xs7FI+0Y2V+MFylbL32cf2sqBXWjLR
	 5bLsTyEwDBsbmeJnK9LV+khf11WmF1vZJKzJljS00skdrM8zBpRwQ0nMVkMyEHqOmGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ys2UUU/naEHr6TucCgUZlkCxXm07ql+DbzmI6hSaXeg=;
	b=XpLSEmn7nr5miDXf/mFKafbxr78xS34wCtD42c0eFlpN3UKwSxYN0nyGguwYy861Dx1+
	 XGK//C7Ldwyjtt7s6Q+KVTaGyAG6FACb4LMBUkdQQlWCuyiQG3AWyMj61gIkPpGN9v0sr
	 e+SgSm+Wp8nY3tzvCNUeLbEwOnQzsb4gz+Ej0XDce/474YUh4Fkvv3VmqoerQE5HbEDNP
	 U2n5aYpk6b2xjyraim3+JK7kBjF2WyO4YGtjo0nYLOEHB0dsy878Q38mQDA0ptxxNyofu
	 4WWrtkYUYa7sbsMGJzA/xmuVIguHpC3I1Qs7hpqHj383kj/eXxZW9byTxgvihc70jgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AiC/qXak";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE2606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AiC/qXak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840601F000C1;
	Sat, 31 Oct 2026 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793448332;
	bh=ys2UUU/naEHr6TucCgUZlkCxXm07ql+DbzmI6hSaXeg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AiC/qXakWzQuAjLhAyCBpLi0wTCMFzkVEW4oATif69OePySIe5JaxMYf9HZZ1HsfW
	 8SRQc+OCNj+xO0vTKK5Z7sCvtjKkEFdJ24qSxVR3PwK+pqJjAAAHNq7LNvoVk9G7ZI
	 gtNxWaKgb0f1cnTf0wrz4I9K748T6ZGT67vwNbO39dgXi5bZGIZTfUtIyZ+kfneLws
	 gGjEBu/675xq55fu50dJj4VQu3cow4TKgy8vPrp1wfJUVhKySsPS3eYIwD7moHEQLp
	 6C87IB4trHfMpgD/0PgCx0FwyxrtQa1EGQWd+cqDkylEfP8RPewWTgw0WY4KD7Smwn
	 +RkOfuPVLZJNw==
Message-ID: <sashiko-outbox-191930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf kvm: Fix arm64 VM-exit duration accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261031120123.2312-1-lirongqing@baidu.com>
References: <20261031120123.2312-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 12:05:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> Use kvm_exit as the start event and the following kvm_entry as the
> end event for arm64 VM-exit statistics. Keep decoding ret and esr_ec
> from the exit sample.
>=20
> Before this change, arm64 measured guest runtime as VM-exit time.
>=20
> Fixes: 1218838d68f5 ("perf kvm: Add kvm-stat for arm64")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031120123.2312=
-1-lirongqing@baidu.com?part=3D1

