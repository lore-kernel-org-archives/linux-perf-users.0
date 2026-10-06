Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A1E49C4C9
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299424; cv=none; b=m2BZfGPVcMNkg03BAciMTxfGJxmBz1H812IFc4F8sobffgnZtx0wm7dRXdOPBD/sflVWGvs4aFUGrZrZBsZDx4oP4zdSc6KaNYS1jUXnOjDNqlUF8xMWiWq4RQLSG9vC4Zhnu47QjSCcT6YNe6UZJCWcwX7vDB7DKbsqshPcbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299424; c=relaxed/simple;
	bh=T/2r8I/+TNIswMvQ7P8Z1dELhEAI5xQ3zLVmVHB22WY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UPMUGgCiFyxOr2P07+7sxMT4znIyTC0DCyee0i6woDhurqiH9SGWyFpy0kz+lLcNTU9QefhsZhF7WSBbpLCThyB4hsCJbLvmvWTOE0gXEgXeofuGoPOP9Qg31KnVb4n0CQ7OksydXPpAoEtQ/0SWM6psc8YhJFFJYP+V8iurtEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD1oPhnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD1oPhnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545391F0089B;
	Tue,  6 Oct 2026 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299423;
	bh=VI7huZuYrArEGTWUbWSXei+ifiHzrZIUoBnD8HLY308=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hD1oPhnLUdPWGKafO1WrF1tS8LHM8ZRqfN0qlV8GPYmkmqaR4lZcRw9+lmXw1SBMr
	 d6lQSBWsibtaS8ajOhz9ArMcBRJQDnFmmPPw1uk4CHvtprPfw5AH3sIJegluL5iz/5
	 +SGidwZaQJ2OEd6pCA4TAF228qBcA2UKnUbCWGH9Lhu0+3EuSKQzFMtM427DnK0vSa
	 XV4ysEV0cI5Dv4Rq/QOMwZ+SKCEnZjWr3lvg5mpNg4TG9W279Jyfvxg6nh6tU6M5A8
	 tfzHvadS05SOd5eTf6EgD5lO1hsN16P/h1YcYEno+09FrGps3Rd1kOPiuzBu+FK0Wt
	 JSbEzQiGCw5pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006145729.3028247-2-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
 <20261006145729.3028247-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:10:22 +0000
Message-Id: <20261006151023.545391F0089B@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006145729.3028=
247-1-acme@kernel.org?part=3D1

