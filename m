Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8031C576;
	Wed, 12 Nov 2025 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949714; cv=none; b=T/rfwHDG/PsHTmNXAULlvR3wWSG4DOt/UU/gzIWw387pkcLkoyDpH6N2ShFHMQLUxMRoQjEmFvt+bsYfygZz330YozfxCor6vC+y88E9FL0W6voyynqPYwnJyHGCEOdv+5mnknFVplnMHkdTLHn/b8KM56jYpvsIOus7xdc8/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949714; c=relaxed/simple;
	bh=LvobtyzxlyPW6gIKJxQAWAM+dxTFPbpGzV/jL86QCLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJFsVtxFROKnwgb4aiP5jQ1l/RqeUvSvNxnKdVA7Ufn6xbjdSZVEQcBzAM9snx9fImiulBm1ED1xpXGSXe8nMhZpZP77Lsj6ZDjNLm5bzFP91VvZOjqzp2VksJNNOYK+oI/E8+Aea6DObaEFaTrHlxzLJo9wl28KK6hcLXXYcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prAb0eP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prAb0eP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48254C4CEF5;
	Wed, 12 Nov 2025 12:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762949712;
	bh=LvobtyzxlyPW6gIKJxQAWAM+dxTFPbpGzV/jL86QCLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=prAb0eP4AcbTYSrYYW+jPicB1nCpcnL7P97XANaRsiFnojz1LNBQGFDSgqL8dHh3B
	 cx/voQvFyQNak+DarWcaqx6Hwo9IGzFtHbfa9XC2PFj7+seYWykiYXA70itm8zVLKT
	 SUNZASy6DF0eWSokGheOXaGSkTZa1wPLVLtluBAvN79H8hsDZBjNFIycLB06U+spuD
	 nxQUETKLzI0akNDsPuJaCt7qdMXuKTNag2cTCm40AeaUHxTlRQ4KBQbFGTEOFxWutE
	 y9Jpzy78lQfigxl871pKJCCoyuPw/C98pJBbZzqYzwCz1SI2VX9pZnUtgPEICDQp+L
	 Z/vn5/gj36XMw==
Date: Wed, 12 Nov 2025 12:15:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/8] selftests: tracing: Add a basic testcase for
 wprobe
Message-ID: <af8f3543-4af6-48d7-a55a-bab24b6c7c7a@sirena.org.uk>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
 <175859026716.374439.14852239332989324292.stgit@devnote2>
 <aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
 <20251027224347.4c887cc956df63602f377550@kernel.org>
 <20251028084222.a3c1ae97d125d9bd88fc565b@kernel.org>
 <20251028105549.ae94e8eeb42f4efc183d2807@kernel.org>
 <20251029004219.dc9cda0eb56ae46c55855844@kernel.org>
 <20251029114317.167b7d908533385c1c9e6782@kernel.org>
 <20251029172004.a0aca144735f20a6a59d2aa6@kernel.org>
 <20251030090952.befea7f0cecd5518c7fda02c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cP5LvKoSdHfjRefq"
Content-Disposition: inline
In-Reply-To: <20251030090952.befea7f0cecd5518c7fda02c@kernel.org>
X-Cookie: "The Computer made me do it."


--cP5LvKoSdHfjRefq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2025 at 09:09:52AM +0900, Masami Hiramatsu wrote:
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> There is a single step execution code but only for default overflow_handlers.
> This is a bit strange becuase other users can not set it up outside of
> the arch dependent code. Even if it can, it is simply redundant.

> So I made changes below which allow users to set its own custom handler is
> compatible with perf default overflow handlers.
> I confirmed this works on both arm and arm64.

I think everyone who knows this code is really snowed under at the
minute - can I suggest posting this as a fix for now?  This is still
broken on arm64, we'll need a fix (or to disable the feature on the
affected arches) one way or another for v6.19.

--cP5LvKoSdHfjRefq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkUekcACgkQJNaLcl1U
h9C16Qf/cGOgECwcc5I4jFkLHhS2AK4mgV7AWZ9YuvlpINTMhR0OvSRr3zbp9xKa
82Qnc28I4WwMg1h7715oStzw77gTfADaOQWrwXKW277LgR0koUlvmCeCphL4jOLM
gLOpy8jU0ZjFrlY3Cvepm8xk5eZtGCDnlJWKJ50ZMolCzUs+YYK0l0adx9kfTiqY
XjBAIJEOD95YAMJgTfp5VeUqwnTqie555SL5mkT9BQzhsNDMqFbUpSlDBpkAzWoQ
Mz+jgpvcfJO5N9wmB3Jt31d4415sfLtMn2ka1/Gzh8Hqr6jvwAIdXW48wX6LiPMz
+X5qczEDyGpOlL94BtgksbrjfJ1+9A==
=RYDB
-----END PGP SIGNATURE-----

--cP5LvKoSdHfjRefq--
