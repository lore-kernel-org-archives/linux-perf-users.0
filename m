Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280318;
	b=wZRwZdx7it0gDPqT6KA1Z4CXxUvt3klGj0kQvve6kPFcXurnL6qfhclmlA0Sps1xBRV2
	 ghd8CTRpxBuQWokwKTzMwq+mCRl8rjWcfmzpOSppGXOB+gjLVLVYSBDQQD3VPg4epy3QQ
	 y0I6Ql6X8fg6eNAjcYqtD2pnbssv2D3HTEpYsuAtg8RftAildevCCfXtFyTcHE1jkXf+E
	 2LL5o33wX+ZiHG8C2DKjDF1fposM45SLnaqSa9NqvVhApWKBKrqmF/wNxxsQcuZ9jFiiH
	 2WzV/RGPerTuwFPao5oGHotct9nY4rmsW8kUO8rz+dh67vIBAApbUtRvfD7MLkhRd4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nggN0m4R3VDZlo9LdcLa3io/p/vsqB/WXYJER/bWNDQ=;
	b=gGOKcTWSaOB+rhjaalEKr6eIIN3hyaoYdRTNQDWwZnJn85XvvAQ5Ka3iVS2U4QVHlDly
	 mTcPYpQcDM9qqvku/Hv213VQLSJyiAp1Kc94WZj5Gl8DVns9Tn2xL9vCru5xBxWDhcBaW
	 1sOQWTjrcYysF5bk3DrPTCxCk1wHy3/AOvK///PgLAdESgeN0WlzgoYVjIT0/1uncaInb
	 Uj/QyZxTaVfbb2mepzVTsYHHoqDZnvYOQXZAJMs3JykYiPiFh8RPFMfG0mDAUDplI8/kM
	 O0u64fh9ncZWBMcOOZWdvNhqI6JyJC2Q1MGDefdthhcXQFeGASk4DRNVmLOJN2I3vmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kTh/KTmW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8D606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTh/KTmW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4211F0089F;
	Tue, 10 Nov 2026 03:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280318;
	bh=nggN0m4R3VDZlo9LdcLa3io/p/vsqB/WXYJER/bWNDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTh/KTmWiqaTdZflPo4sLWlNhYHhSK1nWFM9rRNacWz4K3OkPSd9d9kMiWWja5PQT
	 WQkZCbdB833ogSfq9a+k7KObVA4ZrsyO57MJapqBwOPjMsww6KjznDNC8ilzoChLN1
	 6rOERkfdOUs8vyx9ZEVPJFBZvqldGKUm8rCyF8sCkWkQD2VxQuEYSoYKdxujxdp44M
	 3sgYm8ikUW+8WBZJREZwYqqgSUPx785zltksZSkMAPvmAzqGMYLEXk0tIMZbzndiZe
	 YdOiu8tBOrDcdQhug6t55+ioIS9DZEbezxnMhDAtGpMh0aGSwu54Qc6rMN3qmxvkGt
	 aZaF07qlZD9Hw==
Message-ID: <sashiko-outbox-206093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf parse-events: Don't report unreadable tracepoint
 globs as unknown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Zhengyang" <hang.zhengyang1010@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110-tp-glob-errno-v1-1-6c2cb609c590@gmail.com>
References: <20261110-tp-glob-errno-v1-1-6c2cb609c590@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:11:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] perf parse-events: event enumeration abort in
  add_tracepoint_multi_sys_cb() [1]
--

commit a63217b652c98d06df0265b3b5da9302408c378e
Author: Hang Zhengyang <hang.zhengyang1010@gmail.com>

perf parse-events: Don't report unreadable tracepoint globs as unknown

This commit preserves the directory read error in add_tracepoint_multi_sys()
when no tracepoints match a glob, rather than always reporting -ENOENT.

> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index f3ba70d4f76b2..8a6d5a13863d2 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -572,8 +572,10 @@ static int add_tracepoint_multi_sys(struct parse_eve=
nts_state *parse_state,
>  		ret =3D tp_pmu__for_each_tp_sys(&args, add_tracepoint_multi_sys_cb);
>  	}
>  	if (args.found =3D=3D 0) {
> -		tracepoint_error(err, ENOENT, sys_glob, evt_glob, loc->first_column);
> -		return -ENOENT;
> +		if (!ret)
> +			ret =3D -ENOENT;
> +		tracepoint_error(err, ret, sys_glob, evt_glob, loc->first_column);
> +		return ret;
>  	}
>  	return ret;
>  }

[Severity: Medium]
This problem wasn't introduced by this patch, but can concurrent removal of=
 a
tracepoint subsystem directory cause add_tracepoint_multi_sys_cb() to abort
the entire enumeration [1]?

While tp_pmu__for_each_tp_sys() iterates over subsystem directories,
add_tracepoint_multi_sys_cb() calls add_tracepoint_multi_event() ->
tp_pmu__for_each_tp_event(). If a matching subsystem directory is removed
before open(), tp_pmu__for_each_tp_event() returns -ENOENT, which stops the
loop in tp_pmu__for_each_tp_sys() instead of skipping the missing directory
and continuing to enumerate the remaining tracepoints.

[1] https://sashiko.dev/#/bug/linux-0b2ec2f2-377b-4c58-91d0-b8dd34e637ac

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-tp-glob-er=
rno-v1-1-6c2cb609c590@gmail.com?part=3D1
