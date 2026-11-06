Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943873;
	b=WEdiqUnheGz01OkE278IVX7RuXOv4woWfzXg4y16BaogLToTpL1yjdt9YobIxNzWsFxb
	 5EzOzNvnAtLAjd2kP9Cwj7+FPePX6dV6lirXV3m9cHmyt29YjURLzU4oaK6jFrfqQ1YxZ
	 0epfL8BGMUC+LfqNySz1+SzIP9KhTc0HZjAm+8yD4/0Dcq3s7+MbMcNTIYZRMXmKijJs/
	 AYTC7NvOEzArRBF0kc0B6PuuuhTAlkXjaSZ+EWgUtdLq0yLQV0/1uS/71U5Oxi0Pyzhwg
	 B41J0ywW80Y6EnYuOWyH98bO9wRwDgdFTjMQj31pSdiDhqWXLxROm3wiVWX9qQb8qfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uN+lBU+OgPx259O1NSDBxpBhjw2gGF2ziZzz6cgbLgk=;
	b=Azi9ctGGB/39prRgHP3DYI3Oc4Wxa7fvZyOl8tqL45THFLK8bp85SKwQI2bilclrYQ2g
	 dw89MKPdB8OGs/+t2fqsLgnfWG/gecYb2YqBBPRaTjzSsLIj5xGtP26fn8xOuQQ6LqSfG
	 MKNCII8DObfo6l8AcOVB2dJ0zkBDEdRbOAfnB4W9fbnVzV3PZXYVjAmn8ajQ8deAhwEAb
	 8mOqX03rUP72OUheMDX8h6PlCtYhLMVfJSImlVUp3UNpieyG6BVeWMALcwslwPmduZ7q6
	 4bLZ9aLZ7ZN9j/YAPsA/zTwpUdtuNTG0GRcOgSZt3bWqTTzWOPpGT1+NyNS+tR6PesA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCBJMXCk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB59606A333
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCBJMXCk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B221F008A2;
	Fri,  6 Nov 2026 05:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943872;
	bh=uN+lBU+OgPx259O1NSDBxpBhjw2gGF2ziZzz6cgbLgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oCBJMXCkks87DUfQVEIFqqme9KWjqzRFVf1mxoLn5HTlGUHZPRucJ9ID5c3R1GlOX
	 fv/9Mb6hBwxqzoEJh7nmDQnxGqhtKrcT42PmOfdBzR+m050VKmRyMjB3b+oBXqVlCz
	 GX8CKS8xd58GXDy+2A3Sd7UKAOm3kyLosYoD9ba/EQQfAeyFJFSmXntgnCFoGOMwL4
	 8w3Wt5dWwdk/2rZ3TsUbSDd2JfGnfohY8mcsLcUjRkKTNq+WdaLwqy1rSMA+KNOY7w
	 jlYvm6IOdtg+by2U1ePaZn+IS6jzYBiWyjL/xOCSbDWjtebGN6wKC00SV/r3RzNgag
	 u1wE514kg7GBg==
Message-ID: <sashiko-outbox-200851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/14] alpha/perf: honor exclude_user and
 exclude_kernel for ProfileMe events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-14-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-14-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:44:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The PMU sets PERF_PMU_CAP_NO_EXCLUDE, as the counters count in every
> mode. perf record then fails for unprivileged users: at the default
> perf_event_paranoid of 2, the tool sets exclude_kernel for them.
>=20
> A ProfileMe sample says which mode the profiled instruction ran in, so
> the excluded samples can be dropped, as AMD IBS does with swfilt. Do
> that for ProfileMe events, counting PALmode as kernel, and ignore
> exclude_hv, as there is no hypervisor. A sample that falls back to the
> interrupted PC is dropped if either its PC or the profiled instruction
> is in an excluded mode. Aggregate events cannot tell, so event_init
> now rejects their exclude bits itself, along with exclude_idle,
> exclude_guest and exclude_host for all events.
>=20
> The event count, and what PCTR1 counted during a window, still include
> the excluded modes.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D14

