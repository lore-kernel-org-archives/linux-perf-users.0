Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442598;
	b=Ph5X6tksheC1M5QJ4jX+ZYoBmFE/JIWy7PEornyKOpRRqpIZaM3QxNPQ8u6wTSTj6Mjv
	 PK0lZce+V0iGN9pB9ANohv8a1pwW5z5w77o7iRWRQUHNvdJ5qB4vN4WzSRFM2wBOVR2eM
	 OjS+jnarclRGJ0MVV8VP1PEPtfANtqT6zvZNYXCHvZXJ6jn1M5FAMcuADqcsxtws5CDEq
	 XnTPtv6r6BfFF2ElD47sEt2LgpifFK5r02sUw5shpOy86QHJcl6f2IJ1RgixleZ84pEP9
	 apoxtVE9RNrkT6tMI8PnjL6FqU2xwm1PGfSKbkNgPcV+lp4Mft+MkMEc+ykfYjkulkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T9aNBTdIwONe0XSwU2BhlpGT0KyFngnROmMQeH8RCxI=;
	b=xayn0SnjdNCywcwOVLkwGggCFrkFfqV7IoFPgUz6WDF1dvNg58D6NERfq1X4+066rLyU
	 rGmghHT5Nq2KaESQ8lNy//VtVLi0mfQmOcC7//oveyZAIuJP1xw3cJ/dL/RyR+kNpLyZr
	 Ql467QXDvOkKgdXpnMwsfixNbaYVEsMPbCoAHE0Mn2X1fQ2vWjs1h0s92uBWwy1fs4uRM
	 o0vCkMNyaTWTY83xLwJmICIn07P76AEasxjgEJ3xGhF/fUMzg0Dig+fkG5gQ86YtlsULl
	 oNREjP9MM2wCX2YB+nxlC6ZXKyFqchybQcluRVpTW9c/nZ8ZZVmcF1yZFmbVC+nFfog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLku3Kc0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC1606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLku3Kc0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28C51F00A05;
	Thu, 12 Nov 2026 00:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442597;
	bh=T9aNBTdIwONe0XSwU2BhlpGT0KyFngnROmMQeH8RCxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLku3Kc0fvo2qe4GDbB1y6opp1HymqKohPPCDK2cJXJeDbLt7pha3Q/HKw1zezPTc
	 J6I8DKiy7MRCMimlHB1NcpOAxDY7201Y52DM30KEBgeXGmEjx5yOFdSTQOYvWD6tut
	 hzRSQp9LLjGCrZ0zI1pGduVIwPAmuwBuwzBmDu/xrmzdHSuFTmGwYcDJFARe/0k21U
	 sYiFUhnFndKsF6tGCSkzKvuJlms9Ol9ANoc6bTsrANw57fYY8V18n8i0lDDyBSLeQu
	 s+54IGNrKgA4r9IsxPemKSwbKhdFjSmGxwoTtRJmhOWbKhHCp7mNY0dyvOdkPBrpk2
	 W5DwtifOgMXaw==
Message-ID: <sashiko-outbox-209892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf hist: Don't update the map of a hist entry to a
 NULL map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Casey Chen" <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111234156.2276500-1-cachen@purestorage.com>
References: <20261111234156.2276500-1-cachen@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:16:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf c2c report, including --stats, segfaults on c2c data recorded on
> a loaded system:
>=20
>   map__find_symbol
>   hists__findnew_entry
>   __hists__add_entry
>   process_sample_event      (builtin-c2c.c)
>   perf_session__deliver_event
>   ordered_events__deliver_event
>   __ordered_events__flush
>   perf_session__process_user_event
>   perf_session__process_events
>   perf_c2c__report
>=20
> When a new sample matches an existing hist entry whose map differs,
> [ ... ]
> an AI coding assistant.  The patch was also reviewed with Sashiko, which
> reported no issues.  I reviewed and tested the change.
>=20
> Fixes: ac01c8c42465 ("perf hist: Update hist symbol when updating maps")
> Signed-off-by: Casey Chen <cachen@purestorage.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234156.2276=
500-1-cachen@purestorage.com?part=3D1

