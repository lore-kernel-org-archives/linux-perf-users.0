Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FD241441C
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791110009; cv=none; b=bTRnxKGG1R4ZL1cK1zx7ma2JBQzD/JGe7AJFi6+HKC43GICcVCD841zEnko6EOSD2L1zvuGn07R6i4VypOyIVTqMGbCRfSHHSylYqsGnXCcci1E4iWHIUCJs+LRYkcwF2bZDbeXVrCeIwaJbzeb+tb2chRz2hUvjr5MWUzoAODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791110009; c=relaxed/simple;
	bh=Emd6rTOq02YZ1jTxrR+0gthK7P08edMLDK6BTRdMXx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uU8lTiMF4A7V57ml8wT7zHgie2Ffr/27mvdUxcVKuM/DBSuYYWDjLAjjUPcH6GtqauN9aa8p3iDs6K7HTy7vuSVDSTLOtRv1QNWQ7m/dJLlKPQEpx6phCAGzyzKRS/LuaTaP2f0u5D7Nw31xMGZfwylU8fQUmGe19ccTuwEFTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5z2Rkdf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5z2Rkdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFC81F000FF;
	Sun,  4 Oct 2026 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791110007;
	bh=V0i7qPoZO6eR/LEA6tnjOmSCoy2iN/kP3rKdRJ8VeBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5z2RkdftUvbrZGE3Ps5ry9u5ZPaloaeZQSXcMwVVzkM2YXOdAOO436WGiYNSWOZU
	 I1dmglLw3Km2y9vqyg3V0XXlf94jVepBxb0TWgaZSc8BBzJh4gQB90t/IHKQTqTUF2
	 lDhcOWB2RkwRbOI9RiLGT/SB3REeBpU1vHlA4qfWOkuEorzqWCj6KZBPzL8DUo9UBp
	 +6FcjseroWtDOyYxMv48qTk06uoHs6TjyLoVH6xbn4vi45Fy62zMVnipzNtCFmBrb8
	 CepdW35VDJ8h4hPzmvCQcg79SwsKSte8VMOXUBDPpmntbIsgvW2pSbgyf4d2cmBbz0
	 BDuXJ2w9FwIfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/9] perf config: Move perf_config__set_variable()
 to util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004102133.26392-2-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
 <20261004102133.26392-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 10:33:27 +0000
Message-Id: <20261004103327.6BFC81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Move perf_config__set_variable() out of the 'perf config' builtin so
> that opt-in features can persist their choice from outside it, e.g.
> util/debuginfo.c writing core.debuginfod=3Dfalse when the user disables
> debuginfod for the rest of the session.  The set_config() body becomes
> perf_config_set__write(), with the system_config choice as an argument,
> as the builtin's use_system_config/use_user_config statics are not
> available outside it.
>=20
> perf_config_set__write() checked fopen() but none of the fprintf()s or
> fclose(), so a write failure after truncating the file was reported as
> success.  Harmless for the interactive 'perf config' this came from,
> but this makes it an entry point a background feature can call with no
> other feedback, so propagate those errors too.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004102133.2639=
2-1-acme@kernel.org?part=3D1

