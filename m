Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818366;
	b=3y/9Zq0z7rAa/VeSFG1kK7HBacUP6TuxWKyqYyhK9sQaP+Gy0DJ1otddV1++3DE9acwx
	 d2d5hH/Q2vGyD4r0hAwxtO7agNYKihwRQixCO0PNX0qrF65+wxbRZBIK00r/2nWEZZ1t7
	 ucj4fJkIZUUPplDOXT7+3+mUj7KgljZhMJEV/q5TgZagbxQqhO8LfyEV47vUe4Anp6hBe
	 oyJHAQ4Jql9xhiFuYDG6nTA+FwXAOjQNbrsr6WG7GCuA0aHwLkSnaPfun66uCd/+VdgOC
	 zwecfT+qrjCR4jA8PK6E5o5Ym50C/qAGq0aL+PoDb6FxSXqw9WMSCtm6Tm0BpymWaxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AGE+3OmcrAhKiu1EUHBPmJUfQQ8UnycWymejYJH0LFk=;
	b=R2EweFYS96n1Hlgubi1LXXJo0OL+i79OEGb7cCJlaYv8rfY1YedptwuM0RZwtiszZSlQ
	 v/HOr5bDsBWKR84MNtD7zRJrU+1x4St+SBlq96tKPUh7VkxrdGcYwda63NWKByTkfaqqs
	 /NisjJ1SQ8WEkvXkEQNUHbTGvCfqCGcHz5KBEvf1euKJBxgfZEpjDwQNZkG32YEPzc5mq
	 8jErKEjtJgPNlDdxOketFn9jMKtIPOCEoyCJPNYhBy1MGJZwb60c4VFk6v1K5WGP57F9A
	 HGsEpucftni+oItboSgbiHZcBb7zkM/P/Y2OxgArWlT7XSzHtqZcixGQAPNyMowwWaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cs6J+Xs3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20665606A32C
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cs6J+Xs3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1B21F00919;
	Wed,  4 Nov 2026 18:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818365;
	bh=AGE+3OmcrAhKiu1EUHBPmJUfQQ8UnycWymejYJH0LFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cs6J+Xs3Mq13nC8djQ+ZqgtIUqQHKwEFPwAbZtt1nBDtiOUxSuCXeJbkWIQVZAOQf
	 m4u9pwK8Wdvkm65yJuuuh+7VoL0o5VMzBanSKzDDW+sjROTPM8t9qlproZ4kCJvvLZ
	 o0pY2oc2GzNymnEMSEdhVpl2dgHDXJZXHAXSIpz5fteZMOSj+SfiYJg4De285vRvJk
	 xvOTD6r82IgRjL8n2+Q9bmEGAu5ackLSUON9XhTbpTC19C/Koy60mI1Yfy49qE9Vb+
	 hXDY/FbdHmHk/KhKLs7idOqqISRxhsojE3OpUu5dXS2qA8aUL7zD1myFenXyzLQFN2
	 iQISzK6FbKGjw==
Message-ID: <sashiko-outbox-197885@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/13] alpha/perf: add sysfs format and event
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-2-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-2-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:52:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Alpha PMU registers with no attribute groups, so the perf tool has no
> way to learn the raw config layout, and the PMU's own events can only be
> named as raw hex numbers.
>=20
> Describe the event field in format/event and export aliases for the four
> EV67 event types. mbox-replay has no generic hardware event, and can now
> be named as cpu/mbox-replay/.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D2

