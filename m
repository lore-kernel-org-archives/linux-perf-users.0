Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614987;
	b=0Pu4XSvWpX0CUOCuRDJBzAB6iUPZhiFytUCNeWKQW6PR1qIpjHD/s9ajP19ouPa2uyn5
	 C6v/gB81M+RwvIZ8CXQsDO73W+S//9te8IxXFDFHxtJD9rfkBwvJ9t+0VgVujTjQRFCZ1
	 hEAj7pcPqpi3OyCLB1fBUnemgQhvnxTHNS4GwMcJQlD1lwkVbELHUEku/yDhvATtBu6ES
	 w7pLk725h18mwLxIXSj4yvc9U4VW225KQZQagXDOhVfW8QvjrAJ+RFDF6YeURZIAavvcJ
	 dCYSp9RIz49yahZAnVEICFMBE0qCJOhEhEHCG1MyOuyFx2/fcvPLG8lIGyO1UC58mpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n6zET22Lj899WAS1xLP0ZTkuQDIq2FSl5o/XHjIUbLM=;
	b=5fVluOdW9yQkIGkZOMvs4uqUE24Z9g55ml7oesrGigVDxGTA/r5+dfngdDUTq3/8V+BG
	 7wr0c9KAdjM3UFhtNs9YvX5wlWOZcBzNwfZLR995wjpcpXoAPeF2AwaJCEyTdhXjxMw5k
	 Jfzl4EEUR7uC5gt01PuaKpb8MmQdgBPKFe7rU3NJsDXi7XfO32zHzzt/SYwfjCGmfkf5Z
	 Jhd3GkJQkPQY5Fo8Ae/zcM2iswSWiyZ3eCeOewosrSTcU0YD2TFv52US5Mmvwrg6/4gyW
	 CYKu09gtKJo0UzV5wdQIw8sy6rrBjIYa9SoKDGfBKAsea3XqADj6JDNrtvvuCJ+YjrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LY8GmaDu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9C606A323
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LY8GmaDu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9221F000C4;
	Wed, 25 Nov 2026 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795614987;
	bh=n6zET22Lj899WAS1xLP0ZTkuQDIq2FSl5o/XHjIUbLM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LY8GmaDub4vGlisoGMM++7Br2qP3XFFINIEl4R5bd0Kewzvkjdm9+/4gIq0HCd7SF
	 8EftsvVMJWeGgot3VD1dG0eEnzIfSMgzbJ9mN8wjDZu4aFqKtZWnkyMOixCfrGBAEw
	 3o2ROqw42eQU1T+4jRvp+f6YllJfZnoO4+q3Si6k1zteKF49zbBZDPjJqbMU3aYbrP
	 cAt0dZ2+UXewSz3KtU9HBdTKLM2LC5LhfVwLMFDTzfKJsLvCxrSN6XTX72PSfFM8Aw
	 rr96bxltsYavcgn7ZjkfuskLf9OtFbEPZhOTclKiwQxLF97BLAQYOARK8552B/oMie
	 jfWGoTbrgPbCw==
Message-ID: <sashiko-outbox-233510@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf stat: Refuse a group mixing tool and kernel
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261125133854.2180695-1-takano32@gmail.com>
References: <20261125013826.1495729-1-takano32@gmail.com>
 <20261125133854.2180695-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:56:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A tool event has no kernel counterpart: user_time and system_time read
> /proc/stat, or /proc/<pid>/stat for a workload, and duration_time keeps
> its value in perf itself.  perf-list(1) says events from different PMUs
> cannot be grouped except for some software events, and the tool PMU counts
> as software, so a tool event stays in the group the user wrote.
>=20
> The parser splits it from another software PMU's event, such as cpu-clock,
> and evlist__check_cpu_maps() removes members whose CPUs do not match the
> leader under -a or -C.  What is left is a group that cannot be counted.
>=20
> Before this change, with user_time or system_time as the leader,
> get_group_fd() handed the procfs descriptor to the members and the kernel
> rejected each with EBADF.  With duration_time as the leader there was no
> descriptor, so the members got -2 and failed with EINVAL, "broken group
> leader" appearing only in the debug log.  A DEBUG=3D1 build asserted in t=
he
> [ ... ]
> Link: https://lore.kernel.org/all/awC_aZXD5FBGu4mO@google.com/
> Link: https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/
> Cc: Ian Rogers <irogers@google.com>
> Link: https://lore.kernel.org/all/20261123071913.653315-7-irogers@google.=
com/
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125133854.2180=
695-1-takano32@gmail.com?part=3D1
