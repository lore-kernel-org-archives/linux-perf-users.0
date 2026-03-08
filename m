Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D83451B2;
	Sun,  8 Mar 2026 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773012114; cv=none; b=ky3uKZ3HiKEUFKESzsTYXw8/jIugAO51Z4dfF9MrkA+I7ZXVNgoFuvGD1afJPS9W4rVgbfnrf7SaB0zy/y5UmkSkZfQDzWdcLAd+4oL9aswAQQZFUIocW8DCvDLe8cdb82CG6aTSoEyzwV0BaqaeX3MHI1GV0xfWuTgMPI3mPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773012114; c=relaxed/simple;
	bh=jNNNkiII245/C2khGGXc20U20DAStk9w4iZlI1E7WFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiibQkOr/uqCbdikHIRx/iFZyF/4SJ62o4CyPffohWfXnzno4ZZnpk1agTbtPnA/Gg5jJeLTHPHQiQ6OFJq2uqLEMMiV2tHx5muoQpibFHU2MQeoSSAi7lC2u1jNq+zGkiTRCMKNmKq2QCpBSgeDjPOXfs8X8lLnVYiunWB+4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8fbwXVR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8fbwXVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35013C116C6;
	Sun,  8 Mar 2026 23:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773012114;
	bh=jNNNkiII245/C2khGGXc20U20DAStk9w4iZlI1E7WFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8fbwXVRyzt7joHpimPPusIIVcOaPBEvManQZGiJbXP9GBvSp9LRNh05ryrfqKPYT
	 A5ds8yd81qL0fJu1d3uqEJlie6bjJ6EmBkCYXJmmuXnJzGZ0E7s5JjGNHGRyf6/C7r
	 LEWGUpewkZmOAZB6IO8TopFR/xl0LKtzpSWCyKNjgNXLIcBSS37C6vaT1YhPvOg1HY
	 BIAkjuyiA2CuloOEogHHtSNV2WGgsSQLHkPTIzIN/yetZary0m+uI05cq01A1Dt3Cf
	 l9lTfVmZwC7rm7rh3v8tRoxc+VkHCXcDRtyWfCOOjI72e75Ajo3VeEN+7I+3oI9/e5
	 ujaKhQgsY8HuQ==
Date: Sun, 8 Mar 2026 23:21:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 23/30] tools: spi: Append extra cflags
Message-ID: <ce4286b5-06de-49ac-8e5b-bf071d921540@sirena.org.uk>
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-23-6477808123b7@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L8PNT90XVIA9M/yR"
Content-Disposition: inline
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-23-6477808123b7@arm.com>
X-Cookie: I smell a wumpus.


--L8PNT90XVIA9M/yR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2026 at 04:46:28PM +0000, Leo Yan wrote:
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.

Acked-by: Mark Brown <broonie@kernel.org>

--L8PNT90XVIA9M/yR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmuBH8ACgkQJNaLcl1U
h9BYQwf+P1392LjsZ+ZPhzWbmpcXpIDSBO1qdtzXtehmsd1v1HNPYaENqJo5vgxe
Amfy1Q45rQqkRUuYlUXjqQF6V3D+Z7/XTiWPl40Q7lWNI9E7XhBMpfNq5G8iqFL5
mk1IwfmX0SpyUt2OSLKKJjqTuMHRUjIt0b0DjeyrskTbNaRwT2UTBB5nQLdFXo/M
lLeZdLJwsnEjFcRmRmMmW2903FRxLfLKoD1Dx+83BnkCh7jbN6F94LEzV8VDCNHN
+0EDJXOp+uLfO3pX6u1HWbV2+pSZnveCgK2wN6U8yDjUPGe3mz/K0phasCkLe6BL
8SW+S9YNSL9O8qMn6FjPoTFwIoArhg==
=ZxZe
-----END PGP SIGNATURE-----

--L8PNT90XVIA9M/yR--
