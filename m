Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC49157A5A;
	Sat,  3 Oct 2026 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014474; cv=none; b=fnstZcBmgOGXB0gCjsSWwVi2RBFPBcuCDi2KUWs4OFDKK+f8Da8ebTM2ZiRxbDY/oafv+lLmcU4Iq+RY1e5crIaS+HI9TmW2AcnCTzpBJ0ml379HJGkh0ML9ZfdJGRP3IRMgUqTNAM3oIENtj+hTXUVAgFbEpQgYsUAsHM+jfsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014474; c=relaxed/simple;
	bh=JhTK9S6r+Ur0kofVHn1n3yArjxoGbwZd8wK6MhXRzPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HL5uc7e3xiNMAy4+LGAthSeaDadXtmAq7v3C+2VudsUKkiFuN6F0EIDkC/BuYcQQFEuzLzFeQQ317j4suY5+eYN6KEjrpGce9RMAmRYpqoVIHu5e5CxVGNJzItwgMtfdtKUckYobewaOlyJu0pqk+7fAOeLgTnATLsj6KwOj1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahMMP8aL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahMMP8aL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BFC1F0089B;
	Sat,  3 Oct 2026 08:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014471;
	bh=JhTK9S6r+Ur0kofVHn1n3yArjxoGbwZd8wK6MhXRzPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ahMMP8aL9SVXJkkrodooaYdibTt0y3aIM9oURb+AS8Tp+g7YCBLD9jMKBTPT/Qslw
	 gHilN5WrzbGtonEswk2icUz7R8FcBGP8uiWr+4voCQ3uHvf42uwCnUIF4HbtGL7FrA
	 zw6EgatlRFomYUy5slpOrueaYdyqs0gxgbR6su3j2zJdbYuQtu4OLfwjNp7NGzLXGc
	 4ktCH0D0EidhQMKjJRZVYllLJU3OVkUc6KSu4iX5CqPiQPjG0PD55HBuweqJHjqjTV
	 hl1e6oDfcW5ZWmWWLiv87M43+DFi3kTq5ZbHl3ask3fDX+wAMZYW9UCu0wmCO8ux16
	 ji148EEek0ZKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 03/11] perf/hw_breakpoint: Add
 register_wide_hw_breakpoint_cpuslocked() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179101396937.22872.545144610777427663.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101396937.22872.545144610777427663.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:01:11 +0000
Message-Id: <20261003080111.72BFC1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add register_wide_hw_breakpoint_cpuslocked() which registers a wide
> hardware breakpoint across all online CPUs while caller holds
> cpus_read_lock(). This allows callers who need to perform additional
> setup under cpus_read_lock() without releasing it to avoid races with
> CPU hotplug and without triggering recursive lockdep warnings.
>=20
> Refactor register_wide_hw_breakpoint() as a wrapper around
> register_wide_hw_breakpoint_cpuslocked().
>=20
> Assisted-by: LLM
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D3

