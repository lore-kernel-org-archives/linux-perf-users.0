Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776412;
	b=X2DJpdjrO2iJ1f/7SXk5w2aYbA9T/OaR71Is52/22jkXEh2iCpuSFZTXyfQiK15dnqTm
	 XpZDpLlC2OG6JxMtvlHn8H6nHEQHi9UfJTLptQhSy1gOpdWTfBOxQ6QFxqF1MmmUqvYRa
	 caOkW2LyGcVWm8hrnGJzYTUnVNA9Qi+brYd03IG6LD3VdDT4HcEPN094jHhpm/BUhWI5C
	 eTWCB90BRvhnCxhfs3QM+z63U7IG2g+Kf0HjE0Z+8sQPzHps5H9/uDyhrESijfdeKU0Zj
	 7Vse/V4TFRBI6LnjmAH2uVEwHAz/OcK07s1RB+YKTFdKC5KkradHvEyehPgS597f2Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776412;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9ZyTJ6M7vxJWtT79VQHcMTD5/XB5Or36Qop0komMpnk=;
	b=tvtNlyNME02sZ00GRSE7HM5hGeY+KkaCjdhVeEoYzKspNBtKh20mQEjgP4Hcnd9saeSP
	 TMm1GqbaUgi2QrKQVkGkXEzH5mjmyq7eVp6jVUfVOUZCuZdj9a7fT5udvqxTpMbj+dp/U
	 SsBIXPmt8RGNZ3vuygNPeKal2jxAKnk27QfEnjTwweNERxISWRsCzhZM+gSok3QTuv+Eb
	 Ild09NjXKdr9eMi83FE3iziRIFDDlXvcrA4zUy1MO2dAe8SInbKTAsZFrE9RkQRGt2nyp
	 wJLZdXAVaKhlvqcvWtf/9eJLGa3y2rfqVNIoAEgmqqSStvqsLUqa0hUmiIyyqbPs3RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSUY2dgT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54600606A31B;
	Fri, 23 Oct 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSUY2dgT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A841F01825;
	Fri, 23 Oct 2026 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792776411;
	bh=9ZyTJ6M7vxJWtT79VQHcMTD5/XB5Or36Qop0komMpnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MSUY2dgT2SjWI/SgGOFLET07IDk/Na/Zzqj01/q71Fc+rLDWj4RhWd8k7kf1hbxPg
	 z+0JoLxc/QuZFycJDBw4GaEN6823K4OiSAktlNwb/29LvNYo2FTuiHRynb0KGX1wFg
	 keqCp0sVv5duKyNs7rq/ruS657ZkaXrqeY8sIyAa0MKy5yP6AKxJGpfwaTx63msvu4
	 F0+qOn01SFUwYBfP8PdYsgIifFpK9SycZmKdvhYLT2zVvdTIP4pDoBX0xZdzAez9hx
	 PKeB7v8ePOokIId118WCdCQaMXaJi8T+nLg4PGV6ABnmCfGRLtLFBedk62uOXfe0E+
	 TVJlJhvyddCpQ==
Date: Fri, 23 Oct 2026 18:26:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Subject: Re: [PATCH v8 00/19] tools/perf: Adopt kernel
 compiler-context-analysis.h annotations
Message-ID: <atuV4Yye85LQG9uU@gremlin>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <att_boYgsUyMVBQQ@gremlin>
 <CAP-5=fX2+o1CCV7pEx9=CbAftRse1m5uTLmrTxQ4NWrxd_SnTQ@mail.gmail.com>
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
In-Reply-To: <CAP-5=fX2+o1CCV7pEx9=CbAftRse1m5uTLmrTxQ4NWrxd_SnTQ@mail.gmail.com>

On Fri, Oct 23, 2026 at 09:36:09AM -0700, Ian Rogers wrote:
> get_maintainers added you presumably due to the kernel header change,
> I'm happy to drop you and stop the noise - sorry for this. Fwiw, the
> different versions are addressing locking issues the annotations are
> throwing up when adopted more widely in the perf tool. Whilst I'm
> using clang and internal AI to minimize this, the stochastic nature of
> AI means that new things pop up from Sashiko.

Thanks :) I did suspect sashiko or AI review, In general useful to put that in
the changelog so people don't wonder about it being some 'oh hang on' dev ;)

I would say it's best to wait longer between revisions, however. [0] says:

"Wait for a minimum of one week before resubmitting or pinging reviewers -
possibly longer during busy times like merge windows."

Perf not my area though, just conscious of how busy all of us are these
days!

Appreciate you taking the mildly cheeky comments in good humour regardless!
:)

--
Cheers, Lorenzo

[0]:https://docs.kernel.org/process/submitting-patches.html#don-t-get-discouraged-or-impatient
