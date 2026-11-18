Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019797;
	b=0mmJWOX/m8Ni6gl55IxwcknfDLZBHSAacLeneEv3SdBKfzabt7F3Del7kcjN4dL68TGx
	 Wq++XWmohJgZ+bVSkv0adyAAcV64A8hMaIAfe22iVM9oe7zgdPCapKj9oIDX8xj6qzuWM
	 yxKjcDh4UXKW+mkqaFLz4/ojOgYqrRCYXoLqecVSSPvnaHJEpFLt5PE6pUyfVbF5wREYX
	 tQWDgRlcwK0cIiXl1ztD2gYjGDtpwMonPfUq7Li48M6UshROzKQ9orOmuGzSD/M3qgjj2
	 AVD2sfZSZzgRYmwb/WEdLmWWIFFMxwHNdQL9bYhTk71D5XI9QIe0kdLwRJOC20mThag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019797;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GtLYARAYPZN6BDsF86/tY3pz3tCs88JVAED0H81531E=;
	b=YM5VbH0wAvn0d1hJcgfvNCB6HfsIfQ4CL4M/2SSH4Sg+4qva3hvFfvx2CUd3tKTLq5t2
	 xWtkMOrAXp5FYwnQ6zEen5I3FVmyt3i2pos9a0anRqz9GcWKtzroHrXIkFk0cNT+lgNkk
	 KqmrDypjbQK710uOgRbg5gCnV6kp6NR0lPNpJX4gnVh9ld+myiqRlUa6H6nSeZvOHFmk1
	 gcJYzr6SURQyydt9+yVC9Lrf3v5+Ppj6jtl71N8Ir1EqfaNBmIwmp7Y+Cs9MShX2hGKkt
	 CO650xGeh/rmxS9CtofEtaNHSr6QjvQWWP5j0tcz5W2ehfLa062udXhxB4Q5nBjoQqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Je01v+sn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09D606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Je01v+sn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B7D1F000C5;
	Wed, 18 Nov 2026 16:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019797;
	bh=GtLYARAYPZN6BDsF86/tY3pz3tCs88JVAED0H81531E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Je01v+snmBQKQGb5Y5f8PhdtzZK1xANw+deFgLOe7FlMnb9YhhcVyFs7mRyS3ctP+
	 I3n7TLDJhWnORjDMlLwlJ39JhhcHafkn1avphh1bquCKXlHdVcBZWr3I44FBEZxCbU
	 dzgOITQO8W79Gw1WUfIM6IBtVzfbRUDA9c/3K5zuBFnleBVC1XLHVQmTGmNIyKaFkO
	 Y9/eRXlDYTCxGqTbby91x37lXhNkJEno/qgF+xj7hj5VUTXAM+Ld3/0S2AMqtbhknB
	 BVF1uCtL4fpyP87UufIyuuU74dJRYfexPBW0spOpoG1vi58trO3+bB7++ROODBGX6n
	 5NtcLLu4ULA/Q==
Message-ID: <sashiko-outbox-221509@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/34] perf cs-etm: Handle PERF_RECORD_SWITCH events
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-13-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-13-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:36:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Task bound events use PERF_RECORD_SWITCH events instead so handle these
> too. Furthermore associate the current PID and TID on
> PERF_RECORD_SWITCH_CPU_WIDE events as this is just as useful as the next
> PID and TID.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D13

