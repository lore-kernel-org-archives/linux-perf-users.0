Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5C29992A
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094610; cv=none; b=Dtarmh57vT334q0Y/Bf1Mnm4OvE1o1hmlE+Hqugia2fXPok/V6kzix72f0nwBZg1FZdem2sJrDdV3cJAjRcwZT6fYA6Uz0bdXgwDc/v+x1bVXbB26hjO0Pwy8Eot8lydgVE+wMsovr5PTY2azIF2YxfxARA9F6Z+LIkCKRilNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094610; c=relaxed/simple;
	bh=S2Lzs2WuY+rJ78bu6jKXN/wRQ0AsJsxLXIaza2icYKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aEwU80LwRo2d8S2qK6maeeNZQZrU6U2Ghtr9pqILBkl2MNgzV6R+fY3uHyWmKIokYjI0jNjBrjYmbWoc28+j1vAcH0VSvikIGIsLUBnJwwa2IwRpy0Jbff2R8dQxV7nGbZDNf9VVHqAq9iIf1t+wPp/qUgw6hFDViC2ibNKslXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN+OQyDV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN+OQyDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BF01F000FF;
	Sun,  4 Oct 2026 06:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791094609;
	bh=hSVcy5PlTAoB/R0O8FmIGWYZnbUBrxgQfvcwEKtrW10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AN+OQyDV80pTWC6S8hvJfVFrByd3QQw4vw6cwUBbgsxxXWVwqW7MmhWk3+8LzWbqk
	 CbqOaSDHIPbuSJkuFYe3zhYDTw66WH70oakDzUDFdtmZet44CFxWIL0defi2gT46y3
	 LlVnmAGhrL/OyIOkddKb+bXyEgYaZy9lSctpiTjOaGwPdGAIHYKscFaIFgfN+9a75p
	 kU1Nc+Q7seCKYQZE2KWs8evqKaqg1RrNVgopL8gSCkqituOAbvdc1t/gFEAMjNSPK1
	 18gQuvxWAHvStYiJmp6giCFlbKy2F7mTXIh6istSnakuj+Ft/760UHoPj+r52JOx93
	 bCFDJa4vTT3rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/9] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004060457.3353-2-acme@kernel.org>
References: <20261004060457.3353-1-acme@kernel.org>
 <20261004060457.3353-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 06:16:48 +0000
Message-Id: <20261004061649.42BF01F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004060457.3353=
-1-acme@kernel.org?part=3D1

