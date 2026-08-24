Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACE345724
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578785; cv=none; b=EY12VK7lWsJHyuCFFtEbxd4YTX9e1HGeMhxKJq+XhOHaBMFbcx4+1XZd467pAO5fORUur9xkHIqousjanrDuJwwGqOOWG73W9DhpmnuwVToC5Q7RAQPW2u3jWny6OJkQiHtgn19yJgjb1oNSXci0Ixsk7D6YoYrDjFwf3MrGNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578785; c=relaxed/simple;
	bh=TXJtX4EKygUI+Fut/24Iar7sZsjEZbxQ8UsdK84oKto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwi5LG4xgtkGImeuwc7n1r5eRRwZH+Y74FJbjEWY2QiIwwv2l36hgo6so1/yQjqdiU8gtb8s7NWj5yHcYFMpToLPyiG5bUD8giwk1tyEDJz/Vghpgk44dHBbhnMBoaYEe4Pzv02MKWM/wc4I6KRkMrmLvFJgDky/P74/cyIE9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfhlD84q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfhlD84q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6914E1F000E9;
	Mon, 24 Aug 2026 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578780;
	bh=bypEIe9K2/Zscs5dVElfdigGSH0VRcmOHSBZvRNQ+5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TfhlD84qC/efgNpCOLuJJqdn7GHi2nHioziJ3r82OQCxMKudg9H0+/hea8pXAleO5
	 J5xYIkw1lAoyBgW+ro8dqCiM2P+4mMDtCZx3LFUhCTQGocn1UfHfmgDdrlbkNDzqj1
	 mvdn7/E1YSNahWWbpdhCMXCv9yKlEwyzZPoNWv6gywq+rme7jiejoT/f8rxmsnww7A
	 uDGnOU7GbCSfFEqE/Ikc4r71vcnIlkpr8yHiwcDMjilYGnfhz+9QMPtsAQSLnXxowk
	 lTU7vu9W7rp403bRSHb6xrrWdG28QoPUxj8ED3N+d+ClTDiBshoks2ZtfQuaVASDc/
	 bqQU50Mhw7A0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 3/5] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824133122.751733-4-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
 <20260824133122.751733-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:39:40 +0000
Message-Id: <20260824133940.6914E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Tracepoint fields that convey kernel function pointers, callbacks, and
> call sites, such as "function", "func", "fn", "callback", "action",
> "handler", "caller", "caller_ip", "location", "callsite", and
> "call_site" are currently formatted as generic hexadecimal pointers by
> default.
>=20
> Enhance syscall_arg_fmt__init_array() to automatically detect non-array
> function pointer fields by type signature (e.g., typedefs ending with
> "_func_t" or "_fn", or C function pointer types containing "(*)") and
> assign SCA_KSYM as their default beautifier.
>=20
> Additionally, register common function pointer and callback field names
> within the sorted syscall_arg_fmts__by_name lookup table. To prevent
> misclassifying dynamic string arrays, enums, or standard non-pointer
> integers sharing generic names, guard SCA_KSYM assignment to true pointer
> [ ... ]
>     =E2=9D=AF sudo tools/perf/perf trace --event workqueue:workqueue_exec=
ute_end --max-events 2 --show-cpu
>          0.000 [000] kworker/u32:15/236682 workqueue:workqueue_execute_en=
d(work: 0xffffffffab2f1420, function: toggle_allocation_gate)
>          0.132 [000] kworker/u32:15/236682 workqueue:workqueue_execute_en=
d(work: 0xffff8ac2c1adc010, function: flush_to_ldisc)
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824133122.7517=
33-1-atomlin@atomlin.com?part=3D3

