Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424176;
	b=hpB0nBGHVrjRM8pl/UtU+/FCWDZhtE7BUBuHgviInFqhxkTctO7oNCRODBqVXuP3YN3b
	 MDWmZ3Saqkid8eWzLKcwIlQoLLzPuMQuDQvsuvRaLKcYER23076ylAf8Gzl4n6l7X82hI
	 0BJzkKisKVjhRN6KTRwoyWeVgfCggx8wQqFfaDuXlgqC9u/uQvOHlL/N/bamsZNuPYnbV
	 61+5J4il42aNm/kTWMDgidxC1+L7UvyBiLzbyaORaoNfu/OMy19lYciyXWQFYU0nphzVz
	 KXdAs8AMiUfyPo0d67+vBjEjImTXVOh9s/q+IRdmDZZIc7UGfHBe2dgCgHWnVLiGakw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424176;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=GjGQbeEWEMac+4rVX6cAmri8jzhw4jbYojbGu9dN4QE=;
	b=oYvHMg78iP3KWDOGoB31E+FZoENXPVKIqYkmLtTiqbysAJsHuW5GY8gqzH0CCAjkyHdC
	 W/KdMj4bFp1jI4b3/sr3PLEGAunBNW7E15nTCx41BrWuHDfr1h14IA1nv6qGwf6KsRg7p
	 sVPmLuuUp98Sz3yJmSddWL3pKZu61ul30rJvzNXAvvgyQPRUGgiW+Sh23eUDPROGwpEjG
	 YFSCX+V+XudvbfXT21tPNVtavNxoAN3sRuPHxm+k9V0e5mk3AjUWTDv8jnlX3B0RTcQt8
	 KsQjTx+08J59OeX/T1EMifYfJJ/jiLVw2c23aZ8ETf4WnaeZQn8oQlq5IfhFIgyVqFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbXMqyZJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C6606A331;
	Wed, 11 Nov 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbXMqyZJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFBF1F00A0B;
	Wed, 11 Nov 2026 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424176;
	bh=GjGQbeEWEMac+4rVX6cAmri8jzhw4jbYojbGu9dN4QE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dbXMqyZJHwRIckzPmNUEliVS14wz8B0LmvLMCOEYCeNUcWjcAaeUow9L/lnWev5K7
	 rkQUscc9WwYLfIcjNvA0CVpjSzqqYlthi6NCgeKBwyUL4N0S20JJ/eRqXRFC7pSYDB
	 XfZUIhs5AmQ3VAXjFIAmiTVUEmZLy8txK/XJHts4UsT0ovO4iIzHgJeJahWZiRNB9h
	 z5JrRKmWqrbOkJrJ1hOM6ZttWa8ASR8748/hFpczXWlWq+crx3Y1cQXedecqRWSXVy
	 m4Aas9dKpX4CQMf1prDMjwH+dJ104IQ0d8DBiqE+NVZ51pTPBAfj27F4Z4+cdsqQsF
	 FUOkMXoxfoaew==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, 
 Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20261108184600.3810059-1-takano32@gmail.com>
References: <20261108184600.3810059-1-takano32@gmail.com>
Subject: Re: [PATCH] perf vendor events amd: Fix a misspelled JSON key
Message-Id: <179442417609.676192.2090618697803320246.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:09:36 -0800
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

On Sun, 08 Nov 2026 18:46:00 +0000, TAKANO Mitsuhiro wrote:
> ls_inef_sw_pref.all is listed without a description on Zen 4, Zen 5 and
> Zen 6.  Its three JSON entries spell BriefDescription as
> "BriefDescript6ion", and jevents.py reads the keys it knows by name, so
> the text is dropped and the generated table ends up with an empty
> description field.
> 
> Spell the key correctly.  Only the key changes; the text, event names,
> codes, umasks and expressions are untouched.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


