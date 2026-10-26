Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009051;
	b=KAdjmXIvOuof/vialq89xg4V3pRHUBmhJ3wLKkH3etzM6CO0wmXdO/QLaJktq0CcwLLH
	 2Dqogr6o/FWbs+rkpf7k3DwSMjjOfivhFgmRXdpNNJarcmihxsobmyRAx18McvmaAOl/H
	 EMwlxdjZKgggGBay3qJNN0WmNpNCKV5wMeNm+qgvdYwklo3HNK9/Lk44BHVJnZmRL2372
	 sGjOE7OE/gYkE0SVBDnf9E9Y5md71zo78iBdqJDuV6NcbnKhdbnpUqRdPoQhvHdpvye7t
	 b6y3z5SIj/AHZFvxn3UWh+dHhE+v58Pe/fEXCvKbpSgz4mQ1xuTbhY7AVLZuwySr7Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009051;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XnsVlTWgg+izpsLicNKwoJK78bEo6dd+D6m/T44r+nI=;
	b=d632If6pm7Rh+a+TxM8ZXBrUcmQlU2s7Hd+l6a2OIISwXEochEEITp6uHpDdv67rpbKF
	 Kcws8tqkqkNh79sfxb1ijvZu/ksv8+bZ6MSRBxSpMoeNrj48oXYegSFjou93P5Am9SVEM
	 1Wby8URfW2mS8KT/VdY/diBhO2fA5dQwn557J9wf1bH02f6+M8fBZXmFqKAPfyRbz1e9c
	 HGhyesASdCFNZugYYjhZAGNQzZnAcOhehukAVlfQlOmefLAok10VWGNKaFW/RUc/5gYok
	 tJYJDsAYbiFDOxYEOFzsVV2hlVXcLdPD9JGT0ngEn4MIVXgB54SpZEJfQiwhb9R2pRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xm317wT+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29247606A325
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xm317wT+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD851F01828;
	Mon, 26 Oct 2026 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009051;
	bh=XnsVlTWgg+izpsLicNKwoJK78bEo6dd+D6m/T44r+nI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xm317wT+0UDqOcldmAUKRqp82DJaq3KVeduXiKZD7jJIi0KDJKB27TIOazI+r/SRi
	 jXhad9O4vr3m5MxOYt8w5HNojYLPLMn7r/+9GQ8slJ74g3/Z/rrJ3J8aVGNkQNKvEt
	 utjcDTkkVSIEzavwFAneTZ/RGJJKzXvEayqn0P8G9bEtwrJmfvfmL5O9FmXtLsM8+q
	 F2efPjqvvnBrUAA1K5B6Pyow+tOcKhy2z0fyqGcZ5gLaO88mZXqWvtcsFyT2xrg+tR
	 ytml7tP8A2+K5TfIHYR9lN1PsXR/tB4PbUITxfFuP1c/muAP7Ee3Z083Bj0NKaXVZS
	 ihmoMzvpGJOrg==
Message-ID: <sashiko-outbox-184871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 07/10] perf symbol: Introduce
 vmlinux_path__find() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-8-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-8-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:04:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The vmlinux_path array maintains standard paths used by perf to locate
> the kernel image (e.g. "vmlinux", "/boot/vmlinux",
> "/lib/modules/%s/build/vmlinux", "/usr/lib/debug/..."). While
> vmlinux_path__init() populates these candidates and dso__load_vmlinux_pat=
h()
> loads symbols into a DSO/map, callers (such as test suites or probing too=
ls)
> often need to verify the existence of an accessible vmlinux on disk before
> attempting machine setup or test execution.
>=20
> Introduce vmlinux_path__find() to search through the configured vmlinux_p=
ath
> entries (or symbol_conf.vmlinux_name if explicitly set) and return the
> path to the first readable vmlinux file, or NULL if none is accessible.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D7

