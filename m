Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663823DAAD4
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135861; cv=none; b=eVFKSPf3HgLuMITUDXPZOMnLGXzoNByqBaUOU3uxhxAL2yaVJky53GzQoEg/Et/bXhtQVjUeaRD/loLIhDIKQVY3C+zwv3sTMsH4C7x/mp1a8pFNSGyDclkmw/7I38p58k79AAV29QeSQIMsTylbwNhOo0rLCuzApGnG3SQNr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135861; c=relaxed/simple;
	bh=jD/v3qU11QgutUngbOzBDj0io18lsUskz2yYbR6Eaco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIaWIQfNpQKVV+BHObw1G1v5ihdSDeAg/tFSGybsFpc3d3DxHM76JIaMoikverQkEprDoGPEQXreUue48gyNlC0W6wDLPxlFgxCrHa1Vt+ArevSnG4jVZ36amzG/lSUUEv340eplIona6soZ2ZtzwvZjUJmsb78mqtXEScLCJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PB47s2zL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB47s2zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43471F000FF;
	Sun,  4 Oct 2026 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135860;
	bh=KXiyucUFRHN7+VeR4+9ft8tN6C4du4ZXiZ5Mhei9l28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PB47s2zLHy2AQ2r19M+i4hb554XukPgYyfqoa3yFAfKIlMW30jdpePxuJ+J/zZtDl
	 SYBjr+kHuQWIu6UiRFJdSfsZlENmdJKmBRZ0c0Yu8Uch8LHKdFCgQ+fsLz1kURTYwp
	 r0oh5sbgcFRwYxFlFHzcfH7aYAsY5PvnsSOJr4DLnqNLDfjbYYiZW2gkF2PPPVg/ax
	 iIv4AHjzG5VKiyUe8fzieBa7qmNS0b3VfZGggtQwvc2zbfcFdd52SDS5OcYUgBvGKP
	 QQutOcbsBxTq3qICLrALYMAukngvluFfwqPq/fuUpUzdB4zV5csFvVUl4pptTywqrz
	 5eu/61r2njaig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/9] perf config: Move perf_config__set_variable()
 to util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173000.2863935-2-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
 <20261004173000.2863935-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:44:19 +0000
Message-Id: <20261004174419.D43471F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173000.2863=
935-1-acme@kernel.org?part=3D1

