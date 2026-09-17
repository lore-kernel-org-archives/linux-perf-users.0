Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CD37C109
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621978; cv=none; b=mlIFmfgRhT+7qwaD0a2aSj8YUllOsE03E7vdXYlJwQTppUfXnDLdQjqWbFjoNtSRU4XNiFDLYZZxMxE7xhkuN/9Gyw0CWpM6t77PsYhRCIRPoQN4tasXAUoqMv4vt5yhHZ1xcLs6hF4wvoB/dV4ChndIpnZk91+RM4SKTxjCHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621978; c=relaxed/simple;
	bh=u0KzEKwXASGIBGItN5tcLb2KpUI2JPOEC63WC/ZgSZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NIKXkC2ioBW7eVTxLeldO7eWZibqJUkKmYdliZVSQ7jogzxrUSft22myunKfNrx61I33iGsVw6ztxAHh2fL5LDfKjkcj8wfemSlXXwfZ7LTjj4m/pkWLchdUPkUb4GYAhpxOB+EkSyfWSUCuLpIzvzP5K0yThNmD2/1V2I1qQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwtWQuza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwtWQuza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196E01F000FF;
	Thu, 17 Sep 2026 05:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621976;
	bh=u0KzEKwXASGIBGItN5tcLb2KpUI2JPOEC63WC/ZgSZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwtWQuzaG+26xc8KAHy0XBajsqoZab5Snqoh5oKvPCXFytSSKuqknj5N1YJDzQ3b2
	 ZK91bf49gzEEyTWRlb1DVFt8ZB83wJG6FFLp0N1u6j087Qn4e7Kkd4hDin1BzSK+3X
	 9OvzGBbKoGw18eTxEEHVD3Obd7YIjS6/iOuiAwNz9QmFRy7e0aEBlhtm2TCPL6EP0f
	 W0HFBx+npb+smAME3VODy1FW162eu01b6pG5QZrpHSb1nVtoCVNxysj7jVo/i5XZ/u
	 NqvCixn49VpFuMAAs4fe3gXq1Y/L6c4tvGyUIIkTWmM5xRhpOvwiu6uzbVoCUiD9u/
	 wYYbbssabAkNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] perf dso: Separate libbfd and cmd addr2line
 caches to fix confusion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050450.703018-3-irogers@google.com>
References: <20260916234402.437113-1-irogers@google.com>
 <20260917050450.703018-1-irogers@google.com>
 <20260917050450.703018-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:12:55 +0000
Message-Id: <20260917051256.196E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a dso executes addr2line via libbfd it instantiates an a2l_data
> pointer. If the DSO later executes via the command-line fallback due
> to an inlined bug, the a2l pointer is unconditionally populated with a
> child_process process wrapper. If libbfd is queried again, the offline
> reader attempts to cast struct a2l_data into child_process, coercing
> random arbitrary instruction addresses and causing silent aborts. This
> cleanly splits the caches.
>=20
> Fixes: 257046a36750 ("perf srcline: Fallback between addr2line implementa=
tions")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050450.7030=
18-1-irogers@google.com?part=3D2

