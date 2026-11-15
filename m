Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715974;
	b=3ALhXr0zkdBxfVbaHsJQsZOAtEPAD6UDJbCD4TGOuwdX1v8muGTakVS/dlo58OgC+z2r
	 zRIDHFu0BXUyjF0spudPqj0wtAOcbcQKl4Drgry185fRqJD6d2HkfH83D0JCXeusWivqW
	 KX6sSOgoXqUiar0F6vI1gMwMdAZ+LP3AEo4hgtv2shG9tYkw9+HBoVvDROV67I5toj5Bs
	 K9yreEkN/B9lANRzVBcf9vgDhlH6bFELrajrY0t5obh8fhb2gWCi16Q/XAmdz1VdwksxL
	 2Rw0SBfp4Ngeqhz3sY+xaEqkpjHPlT+2XwCPTiD3hGdhwEQh+PYRRkBHjhaLpItGtfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715974;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=CX8cSwdsyuSz7g3NBmOb908j6e492h4dqcob8NrP5OI=;
	b=2H2lHElPnpOz24SggJ7/583SJx5gZnA5erc71J+G0nqqSvdqyBYQdHpFn9tUTQ3HLlxf
	 XdLx+Bjd5SnDkiQ2DdYIdEmz/91d/AvyXqbzJkNvlj3y0vbq7Li0cKE104uSfWca7GI4r
	 mZZN+6U/gMWcfo6zLrn6UGgSP7XqulXTSSC5I2MKVQT4HuWry3gc5TYyA0SvT2GaPu95E
	 PnkOokkEB/8D/Y4GtuVnycK+YAakgwkvogeacZve3KRY7vDFhuEXT0JzXtwJk/eGY9Wwq
	 4P5BYBUgsXFwBI3FDZtKKH35eA1ORrtLeNlW/nDIsEVUcXJ2Mq8A1h7/kFg22kmP36A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRzltPf9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6A606A8A7;
	Sun, 15 Nov 2026 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRzltPf9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6385F1F000CA;
	Sun, 15 Nov 2026 04:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715973;
	bh=CX8cSwdsyuSz7g3NBmOb908j6e492h4dqcob8NrP5OI=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=RRzltPf9Wp75bDCC1THA8JSg6FEtR97GKUGehf68jAtDQcIb+N4YFTIeQYnATaJsx
	 BnuBepaJZ39N/Jcu55qzVJEHnC0tKcyfe7kpGi3Gw89+4wIPEoxXmg+O8lfr1oiwKa
	 T39qc/NtGJrWuH4Cn5YkFOkQdC7XIMG0p+OrTAdZx3AEwBW5sXVZzl6+bMSdsLoaxZ
	 oHZnOVYVIKA3mi6vZnU+cFYxoUnJIEECPe7x7f4uYNQMxJLdvochJdu7Lhs/GKCkeI
	 E9NCD0SpNEmLrVaRnUv4p4sH6fUMxsSVRj5deuENSklVQqN7VYvFFC8IQWMKbt6nve
	 jkc0Km+ut8ABA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20261025220349.1244499-1-irogers@google.com>
References: <20261025220349.1244499-1-irogers@google.com>
Subject: Re: [PATCH v1 1/7] perf session: Fix minimum event size for
 PERF_RECORD_CALLCHAIN_DEFERRED
Message-Id: <179471597185.616307.11506852468610341426.b4-ty@b4>
Date: Sat, 14 Nov 2026 20:12:51 -0800
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

On Sun, 25 Oct 2026 15:03:43 -0700, Ian Rogers wrote:
> struct perf_record_callchain_deferred contains header, cookie, and nr
> (24 bytes), but perf_event__min_size[PERF_RECORD_CALLCHAIN_DEFERRED]
> only checked for header + one u64 (16 bytes). Use
> sizeof(struct perf_record_callchain_deferred).

Applied to perf-tools-next, thanks!

Best regards
Namhyung


