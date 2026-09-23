Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C740D58F
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189356; cv=none; b=QwV12um79gZgyZoEdsytF24A9LuQPIK1B6+DpDwePPtCjak2OPOdHWFXR3Eho+XmevJM7ibu0na47XTp8nY32nBbaET7iKqiiO9kyXb3fHeNDiTBSxroOf+grh+L5iBi6rzwIVjJxXXum0he9OIXmoLmGyhIlJoH+RqobQecegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189356; c=relaxed/simple;
	bh=TQjF2g7WZZP0byDkAC81v8mTNQzDdUt4XiNOy2Yx3Ug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rok2GWhyplXzO2MF82Xx5PS4qzdMZdI2H2qMn935jOn/dw9of1ZMcmCC/sNWy3Qqjz0AXRbLJgCoXauZ7/c48PzBWmJBrgc7vp20gNa8sgcsEZTHqtI9bIGJomyUeue1OXtGeY70p4ILUb+iiDY+8L4XwWdcTLjTFTtpF/MsRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzLkOT9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzLkOT9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2296F1F000FF;
	Wed, 23 Sep 2026 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189352;
	bh=TQjF2g7WZZP0byDkAC81v8mTNQzDdUt4XiNOy2Yx3Ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzLkOT9TIv9rdnEyCJYYFJjBkevzLUF+EHJl/kpZF4N4Qbg5vp1qg36VLVjago/Xo
	 5JAMDuiXMiD8jeYPMtT8A9zHY9op+KGgBHS6ryeoE3I8JGlHu+OECfqx/YYx+GGai8
	 WP46uc/3AfAwGu1OBsWjdtjWqzibpy5veKZFWT461dXuUZ/8OKT0xacfFUAc76rdSM
	 N66qL6mZ+TxwDL/EhMLYKbhqMU3rwIqlE1MhL+MEM5x05LpTXy7OhslPCnN1w2d7Wr
	 dREs5ePMqu2konhfl9KALXOXJdGB0n/Br/x9VRfb8+BKT/qkdewZE5vPgNadpVJOIC
	 BXZ9YFYHGITaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 47/49] perf Makefile: Update Python script
 installation path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-48-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-48-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:49:11 +0000
Message-Id: <20260923184912.2296F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the libpython feature test with a python-module feature test
> checking for Python C extension build capability, and update feature
> test references accordingly.
>=20
> Remove references to the legacy scripts/python directory and install
> standalone Python scripts (python/*.py), type stubs (python/perf.pyi),
> and the compiled perf extension module (python/perf*.so, when built)
> directly under the python directory in libexec. Update the TUI script
> browser (ui/browsers/scripts.c) to discover standalone scripts from the
> updated installation path.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D47

