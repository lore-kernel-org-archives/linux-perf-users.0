Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827169;
	b=2cvH1hLR2bLon7hsrkEUcfplggcZqseXprNVXlVL13TxlaCjxPtZ/kApXhypiJZOqdhY
	 BqPSmsTmXS1noaVHqtxCnpJidm4sbmWSmvN7y6s4J4hyqjl+ffobjwR1HJ0rjBLlu4XL1
	 gQootEKHsDRdRpNMaignUAamEr5klksCrPbPX6nXWkfRTrjZ7APXG3uvAvxaE8dsB/fUr
	 H0kBawgnDMwI8HQvGkVWbdb4mloYlkRefk0anXA7xIGWX9J51YuoBYhEipIwo9P+QYeRD
	 WElM2CXRmeQzEvPJBT3G6EsJW5rY7N/dYsiKYrBmTrbFHYyyqGTaqTScLTTwkVCbjbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827169;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dqv7130npN2VJ9BaDnO2Xcckf3AY4niswDVqVMQ5hTg=;
	b=XQTXNcPVxL1wft1EOOE5a7MhqJfFOBUZ+tCQLKd5wTlLaDnxETL1jnOQ6T4DusiOoioY
	 VizbZ4UE8chwMvWJwCKefIaL8hPhjE64/TkvbsMDUItBRF5IYL2JpkkM2lbUVRozUYmTc
	 HTkw/rkQWbyB6jL6/q2AAe27gVzOKinXObgw2ckNfZ28rBtj3vqgwG8DDziAUU62lwSul
	 MybZMF6v2J8nSBGsQOIhuKexmMw6LmUB2dduO4v2UYlYBWnY2lpJ7/6ajwxQ8jsux6yKQ
	 LinWpgezuUHwhJYDKZXAciC+HvATwMS45A+Rf44AGK2aGfIo2YhlUX7ES4+H0myr0NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AT13itWw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8941606D83F;
	Wed,  4 Nov 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AT13itWw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90C41F00A1D;
	Wed,  4 Nov 2026 21:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827168;
	bh=dqv7130npN2VJ9BaDnO2Xcckf3AY4niswDVqVMQ5hTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AT13itWwcs9AtlV90JbeNmR8DAmEk6ryFDsl7arWGWfMl4hCRD5PT6AA1kiySzxZz
	 e0KLn1YKZZCRrEbGUT/CFCy7mDVHSedjtM6VhnKfAiOuk+xM9v1FLLoxqToky5B3d0
	 iN8XhtHAP3doj7qDa94bbSiNDPcX1vqiPC+/yyeNDi9Eccue82VXDeGN2jSc4WYMCC
	 PTCWFfHSdhJCePylkQ6XebJYQRXhqIRLq318B+Bw1Ii1ec8R2KTPqOUEFqsffWOh0I
	 Wl3Mw3InAqNyj1rTCTOdtJthrtBzhC8xngA2BaeuT9TzLXVD4JNSGqIxTRV4WA9r+a
	 SZPjiqvcHShTQ==
Date: Wed, 4 Nov 2026 18:19:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: lirongqing <lirongqing@baidu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf kvm: Fix arm64 VM-exit duration accounting
Message-ID: <auuhXYYpDW3UZn90@phoenix2>
References: <20261031120123.2312-1-lirongqing@baidu.com>
 <20261104111751.GG9176@e132581.arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104111751.GG9176@e132581.arm.com>

On Wed, Nov 04, 2026 at 11:17:51AM +0000, Leo Yan wrote:
> On Sat, Oct 31, 2026 at 08:01:23PM +0800, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > Use kvm_exit as the start event and the following kvm_entry as the
> > end event for arm64 VM-exit statistics. Keep decoding ret and esr_ec
> > from the exit sample.
> > 
> > Before this change, arm64 measured guest runtime as VM-exit time.
> > 
> > Fixes: 1218838d68f5 ("perf kvm: Add kvm-stat for arm64")
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> 
> Thanks for the fix!
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> Since arm64 requires the exit reason, we cannot directly use the common
> exit_event_begin()/exit_event_end() callbacks as other archs do.

Thanks, applied for v7.4.

- Arnaldo
