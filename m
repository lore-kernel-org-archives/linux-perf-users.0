Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002547ECE5;
	Mon, 14 Sep 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395595; cv=none; b=BCELmWVDKLlbw4EHeHRTgZD4lhrUXodss5DGtgnl/gNUpxJiF4VkC1Jh8WewCXHx0A/8SUry4ay1XoNo81sWUqC7luTXBrILUOEOlt1gQFmSIr8UbzfqEYjV3jPeTmOqwQDw3isUoTNRWtyBT26zuE7C5/W/FhUMR8StGhQUyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395595; c=relaxed/simple;
	bh=jBhOEv8KsmkFEP90l5bcQC0FGpq8zqVBcca2hH4pHM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=njMzV1XIXpZiEsbXnaRqToLuMPurP1bg02T6pzmROZdufCwAsxDqkom3m5HlJdXVzAHuIGvfeyozCjjcJ4iJZl0jOARw1n6EuPuPhNka8DM4SyHZ4k4TB78M7OnocRTWsLCFjEm081Dbl9eThau7ppXmGU8LbaPmHOR7J20lAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHTvTxq+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHTvTxq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA90E1F000FF;
	Mon, 14 Sep 2026 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395590;
	bh=jBhOEv8KsmkFEP90l5bcQC0FGpq8zqVBcca2hH4pHM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHTvTxq+pRVW7TBKREyXLlMitgSCSFWTC2QOnxl/PTSRqclY54E6fxr8mMEPAqlez
	 8KNtVyG0ueaRCTWepcuFw1kLbggI3x/G4XGYWKyUjbU6eg6fiAngNPTjj9Ijln50Ee
	 EM2N7KbahvF+tKIWy72CvDhkkvmHLrj1alHQqwGhLfhDYq66k2qHZBWSZotEc+ZpFa
	 12RleP9VAK7P7PW+PgYjv29+QZkyaoaqlvn7l+O3ApBO0YcW95DrnQ4FIh8SiJxDA4
	 hAkqglFXLl8fIZI5sEmzJvmSUUEh0JHeokKWco1JlDRlQVLLBGcwTWvAM0l8jpTaV3
	 Q/5fYixqbZ6NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 07/13] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <178939025972.94750.16829369548375355435.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939025972.94750.16829369548375355435.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:19:49 +0000
Message-Id: <20260914141949.EA90E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
> on that architecture fires after the target memory has been modified.
> This is currently x86 only behavior.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D7

