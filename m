Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607086;
	b=NPCYA4CthpiiNFBBWQI2KVk6bbVXJbafPwSUN/SUqG704DsqDWyrcZVSMY5ov2+llqSl
	 BVb35EF+9huvcUz1n2VV8Khk3+tdOftlqGeK3opl43LwEEikcKx+RRRJet43u2c7DQFar
	 MzRHMTwrvKR8tt+C2JMBxLeBNtalzTJ6CPpUIgMOzZpxR1CUXHCFfJqPe35+JYamnXAEI
	 DroVtG6FQaepcmo7R2gqDSLAU9AHnttMyhYRr4dG9GSOx6QaxcWWdm36y7bShXxRfHO8w
	 r624alsKDV8WN69Q5GPLo7trD1NFYCUEXQqLYy0dLvnwjpKVXzJDJ4jrc3jCv1RcBUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607086;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EGR7ElmHWJ3uZ1aJ15XQlJOGzgFfuK6NaoYjuvToLHM=;
	b=fiNQ2hP28s2o6bKnAw2Fk6y9ONfpO14CdODJys5JVbqamYwQ1jDkkVqUEJgLUkGgXCLZ
	 WFqMBKJikivo7Y3P4iFARuQh7Ft7y9VnS7itzVgdkUy6ow/aNAovt9gMb4o0onHV45K8S
	 sQpZtrKBYgJ35YstdFyBWrCBn1qkd86UBUGGhy5J1CyvnVffoEnc1EBGON9o6QfLIhQcy
	 QAVr73XlyQ2kQNGMCY9UW/O48nw6MFRCiuebP7AcLkH+hYIlVhg4hbg7iFPGqRCQJszwN
	 /rVNt/Bf92pO+sjuCOOikWx1gOwOSxlw40kt6eJEFjzcZPZjTNtqRCLm2L6dpnXinQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deTPAeNx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F3606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deTPAeNx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F471F000C6;
	Fri, 13 Nov 2026 21:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607085;
	bh=EGR7ElmHWJ3uZ1aJ15XQlJOGzgFfuK6NaoYjuvToLHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=deTPAeNxGjuKTLuHbGA44kqLu8jwF3MqicYzvyjOYRTbhWl1xErqeFoa4UFz2+X1F
	 cWfEjS+vOqYs9jgY5+wuNSqRRgPpiAm/U/iSpQTcdSyukrxUQaCitoMyozFqjnIUJp
	 +o08lmsGsY9hyHoT3V+43X5GTH3AOtj/3TPIDdAeGHMtzNmedQ3yuAx996ns4FELk0
	 sJoUkDi1I9sTzqtBc1RiiZ+20O5gn+Ma2jmE0ZvKBmvabw+ICi7mcSR4cENJQesbdC
	 GWpxDqPxDtWgr+5mEs+WzQGBAD3dBDt6Im+q7YKFXomOIyTyIb3JCOOyvyaNWj3cMm
	 U/I8eusGETNiA==
Message-ID: <sashiko-outbox-213755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/26] perf trace: Use generic hashmap for
 bpf-trace-summary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-13-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:58:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert the syscall summary hashmaps in util/bpf-trace-summary.c to
> DECLARE_HASHMAP(syscall_data_map, long, struct syscall_data *) and use
> hashmap__for_each() instead of struct hashmap_entry iteration.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D12

