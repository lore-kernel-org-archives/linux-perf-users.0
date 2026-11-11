Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364126;
	b=ZwFu0MPvUpdVeMnR6NtcCwNHoD2d417+Txky7ImHJDSyQ6+4SSWzxJDzEZV4Ied5jCyM
	 TIjoLerJVzJ4yyoog8kR32+t7x+JHokhr07Tp+VgOibBvTpAEUasKJcm/m0yNpTASZ6JR
	 l75oHPmNLiQCC/mdaZj2FERoQLuHhxHTJ6y3JIApfV4K828dADV7GglwA8XPZXqVOXgKA
	 qSTN0UJHfLQr0tvmypyT5jw9BANeKPrTdBHcoagumOdA7mks0zkOH8K3zWNcbon21+7m+
	 HE4Ai3//HqEsjBdEInZlsqdMvIFoXlKY4GJ1dAxBzvsJG3+0tmcHC2R9ISNMjzbF4Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g6Xjzp2KEC/KsY4ldRVTU1kARx9U0BwdSrSZ4yHnd30=;
	b=cUvud7fYhyTwrlXIcLaZLNnoWXscCkONBY6Yorl6lpbleBx4QK2c8FI8WK2lo6MdSMQV
	 AinUP+CRa2J4uQdXOWcqQWFmkd1XM3n388ccmsNK1aDKEHVyrBb5GdGiDlmWvxXZhS397
	 optrq4RAQGviFOkfZepEZJSzsu3YCunDCEslBlBw7rhQrcJSuQHGRY+dGQ52cZou7lh2l
	 nDSF9NpBrf9kFwfOgOzr7dzVSHObgn/qS9/a53hB0hQtOGkeYg2hSWsszrSkk5CxxXXC6
	 7DO3xKAus4ORTL0SnNUMUitre6l9BIkb0yi4cwbVnS4dqVSGmnElp4hw1BL+kD6p+5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ci9Fw38w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6B60A2625
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ci9Fw38w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F181F00A03;
	Wed, 11 Nov 2026 02:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364126;
	bh=g6Xjzp2KEC/KsY4ldRVTU1kARx9U0BwdSrSZ4yHnd30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ci9Fw38w8qXtOZC/LX+YZDnYumhZhWnDZKq2K/P/OSKA6ZFNAcNmqbYK9EtlpOUbe
	 gCc/yxBELQLY74KzUPuO3vwG4jxX+MgwJSo6nFW5WS2eKmfoffkLXgtYmz3QaQJlJ3
	 CP9Z4D46OLr912JHLTonvDpimrZYGeBtYxnNmHQOcfICJyUFZ30Ry77p08utZ3mXEu
	 54CHrwlTrltF98zT0iBEbLFDSO+9qYb8SFLfoUULYShxKYKL12qlJKjE+0b4drCcoH
	 EZMbqKHpGU/71CJQnHAuYY5NdmCoUc4e5LRpfOvkcaiLWLwKA5iwz2C7LVlzNrPB+M
	 AMiKLpCnTfOIw==
Message-ID: <sashiko-outbox-208086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf parse-events: Don't report unreadable
 tracepoint globs as unknown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Zhengyang" <hang.zhengyang1010@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111-tp-glob-errno-v2-1-ca45efb07d31@gmail.com>
References: <20261111-tp-glob-errno-v2-1-ca45efb07d31@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:28:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
>=20
> As a normal user, a tracepoint glob gets the wrong error:
>=20
>   $ perf stat -e 'syscalls:*' true
>   event syntax error: 'syscalls:*'
>                        \___ unknown tracepoint
>=20
>   Error:  File /sys/kernel/tracing//events/syscalls/* not found.
>   Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this =
feature?.
>=20
> add_tracepoint_multi_sys() returns ENOENT when nothing matched and
> drops the error from reading the directories.  Return that error
> instead, so the glob reports what a plain tracepoint name does:
>=20
>   $ perf stat -e 'syscalls:*' true
>   event syntax error: 'syscalls:*'
>                        \___ can't access trace events
>=20
>   Error:  No permissions to read /sys/kernel/tracing//events/syscalls/*
>   Hint:   Try 'sudo mount -o remount,mode=3D755 /sys/kernel/tracing/'
>=20
> Fixes: d002aab87de8 ("perf tp_pmu: Factor existing tracepoint logic to ne=
w file")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-tp-glob-er=
rno-v2-1-ca45efb07d31@gmail.com?part=3D1

