Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146848;
	b=Cr0IZ3gyJJXkQyANE1FfOkM8JRCdq4Y55EIh+1ucK1YDpzNibox9iOl8YYElGN2X3c+C
	 zDhvEpGqtaEVhOMxLSWVm+1R9HFnmkBRR9zILMusd7Pdnant91IjHjwtcIg5S5pG74/FO
	 R/egrHLE/QNReFEiNaYjJv1Lj0/cSUOd+Jav4h3xbDSuaf8mCDASse+P55ic++7egOT5o
	 l0KCEqFNUaqxiZ+yl4f3KOd0K0W9EoUeULBxQDnDRRPvpF6JvMxefWO4ETIk4hg7nCLrt
	 Nij/RXYoHkxp2NSmQG3B1vt23vCVaHtTMa0XZOfOZbixlywNmmeyapezLoHJHrWD9RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146848;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=iTp8Z0DYDzZW9afegIwbqdFGF61y/6+TmOsS06iOSoo=;
	b=c1Kx1Hfo/QRrpk1ciUkU3qusFXRaLc7Vf6E+XNe9UM3NTunbZ+Q9SCj1Ir938hfbLLuE
	 vVinMWTUvP53KFG+lAdSl/AFDUSyS7KCGULXIhoub4GTpSeAJPh45zI1+Qj04K9hxGUU4
	 UCa73MTAZBrDZqrWvzRpCSwCGUDnnWDUzcBzqt0vmv8gkIsP0l0d7COjmFec1paEg8RoY
	 cRFeid/2ilhE8Q4uWE/08kmtoVegPEAvx2905DaQWyyoCiIwXB4Hdf8MPUlmFOB4bJIaF
	 gVejbXQNWM143Odj5nxH2Y+n/D+bYWCN20htqJYciXrZJ3y31aB6A7mnKEDQsQ8PW3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ni4deC1G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B660A2603;
	Fri, 20 Nov 2026 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ni4deC1G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A771F000CF;
	Fri, 20 Nov 2026 03:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795146847;
	bh=iTp8Z0DYDzZW9afegIwbqdFGF61y/6+TmOsS06iOSoo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ni4deC1GizhRbzM98GdofcfV54MhH6NLR08NyBnf8oBGpwxma/FjyAa/vehJMcfYx
	 Gus2XTQnoIzeL3mPaF+gEwZ09xwpJulHFoibSPCY5HXw0ooi1n7TJYyFg83FpiuSk7
	 pzbGoi3F0aqjBDrCUOslgqf37c/83dQxADFkOVNYQefBQdbbkLSyY9oqWHzFqyxOrv
	 Yw5bz1JnKLXiBYT+r23KVk5uGhHpaZkc3niciNGX77/ArEv7DrQ6ee1pZ0t/kqbsY9
	 g+kT1kR9bOLPUKajS3uen0yEedVR8CKkBTqLJpoYJ0z4OSlr04oPK09C7TtpDMlH0+
	 OV1R3c8UbnsQw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Gu Bin <gubin@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@redhat.com, irogers@google.com, 
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261112080924.2082-1-gubin@cmss.chinamobile.com>
References: <20261112080924.2082-1-gubin@cmss.chinamobile.com>
Subject: Re: [PATCH] perf trace: propagate evsel__set_filter() error in
 trace__expand_filter()
Message-Id: <179514684642.638421.13798397954169665034.b4-ty@b4>
Date: Thu, 19 Nov 2026 19:54:06 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 12 Nov 2026 16:09:21 +0800, Gu Bin wrote:
> At the end of trace__expand_filter(), the return value of
> evsel__set_filter() is ignored. When the strdup() inside fails with
> -ENOMEM, the function returns 0 anyway, leaving evsel->filter holding
> the unexpanded filter, which still contains the symbolic constants the
> loop meant to resolve. The failure then surfaces later and indirectly:
> evlist__apply_filters() passes the unexpanded string to the tracepoint
> filter parser, which rejects the symbolic name, so perf trace fails to
> start with a filter syntax error whose real cause is the missed
> allocation.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


