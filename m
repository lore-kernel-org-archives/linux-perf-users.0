Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E526E17F;
	Tue,  9 Dec 2025 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765269891; cv=none; b=b6cfAAQDKdXFPmlagK9lyefAyyQA40ZdL21zBrxCu+b9AiusI6nGWRymXDtcCFusm6+zI1EtH1J2u/z7e95p4HZh0D/G0XJNYq2D7Snu83EN2bNZWOJ298gmq/q/dBcTnDIEMuDcg4C+vv7Sgyfs9Aom+BGZS4e9WbFXVV+elCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765269891; c=relaxed/simple;
	bh=DR18GExPTmcQqod2lxUbxnExnZkKCyWLGIry4MZVIoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1rwY4feXh5pJdlBh/d+UCv+MEN2GDVPseOU8W6wMfJrpwl20b1Thfo0FNOlZnMxUVQGGqh09rrjrVdjdNgVLaLOukhDXDtVzh1Sf8LAk+HoTNHY0L70bPEPz0jVnUvt2g61piKYd6x3qb54SrSS2vZ3ljO3mFD2IlcTsKGicAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA0oRUDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA0oRUDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0F1C4CEF5;
	Tue,  9 Dec 2025 08:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765269891;
	bh=DR18GExPTmcQqod2lxUbxnExnZkKCyWLGIry4MZVIoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EA0oRUDWMAL1JUgFw4QirHyWFeomIXlGgDLhO7hlEU7dw3KUTEtZpWB1CJNdFDaVO
	 yWrb8GA81GCS4c5Xn+aYwfbQb5THZePti0S5D/InmAaO/I7b/MFzaAxbB3MC63FMRs
	 fZcBPzVAiGCzFO/pmQ33cdE3dZzJCkZcyIvVzFFcauSKsOZNf+bPiQWO2sE6GDIEjS
	 PhoNrN9+Sjki/EB9/6vMwRfSdId0a9S5nIIAl/x7GOtVzY/qpvPaZMS05nsr5pMnif
	 IdMo05tFoerOwIWD1zWXJlPJgOb1pcdNf8MXFpyIws+FDtUJqZrRd7RoKmHG9h1d3n
	 7go4ltjiNkbnA==
Date: Tue, 9 Dec 2025 09:44:45 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Perf stat --null/offline CPU segv related
 fixes/tests
Message-ID: <aTfhfVywjweJyCHw@gmail.com>
References: <20251203214706.112174-1-irogers@google.com>
 <aTP4zSy87wEZlbsO@gmail.com>
 <aTQRgAOpKyI53TEq@gmail.com>
 <CAP-5=fURCzNLC8izLAbu50AV7nhLmCDwaDpfiWkQp3ihgHMNxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fURCzNLC8izLAbu50AV7nhLmCDwaDpfiWkQp3ihgHMNxg@mail.gmail.com>


* Ian Rogers <irogers@google.com> wrote:

> > There's one more perf stat QoL bug I'd like to report - I frequently
> > do repeated runs of perf stat --repeat and grep the output, to get
> > a feel for the run-to-run stability of a particular benchmark:
> >
> >   starship:~/tip> while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed; done
> >          0.1017997 +- 0.0000771 seconds time elapsed  ( +-  0.08% )
> >          0.1017627 +- 0.0000795 seconds time elapsed  ( +-  0.08% )
> >          0.1018106 +- 0.0000650 seconds time elapsed  ( +-  0.06% )
> >          0.1017844 +- 0.0000601 seconds time elapsed  ( +-  0.06% )
> >           0.101883 +- 0.000169 seconds time elapsed  ( +-  0.17% ) <====
> >          0.1017757 +- 0.0000532 seconds time elapsed  ( +-  0.05% )
> >          0.1017991 +- 0.0000720 seconds time elapsed  ( +-  0.07% )
> >          0.1018024 +- 0.0000704 seconds time elapsed  ( +-  0.07% )
> >          0.1018074 +- 0.0000946 seconds time elapsed  ( +-  0.09% )
> >          0.1019797 +- 0.0000524 seconds time elapsed  ( +-  0.05% )
> >          0.1018407 +- 0.0000658 seconds time elapsed  ( +-  0.06% )
> >          0.1017907 +- 0.0000605 seconds time elapsed  ( +-  0.06% )
> >          0.1018328 +- 0.0000868 seconds time elapsed  ( +-  0.09% )
> >          0.1017469 +- 0.0000285 seconds time elapsed  ( +-  0.03% )
> >          0.1019589 +- 0.0000549 seconds time elapsed  ( +-  0.05% )
> >          0.1018465 +- 0.0000891 seconds time elapsed  ( +-  0.09% )
> >           0.101868 +- 0.000117 seconds time elapsed  ( +-  0.12% ) <====
> >          0.1017705 +- 0.0000590 seconds time elapsed  ( +-  0.06% )
> >          0.1017728 +- 0.0000718 seconds time elapsed  ( +-  0.07% )
> >          0.1017821 +- 0.0000419 seconds time elapsed  ( +-  0.04% )
> >          0.1018328 +- 0.0000581 seconds time elapsed  ( +-  0.06% )
> >          0.1017836 +- 0.0000853 seconds time elapsed  ( +-  0.08% )
> >          0.1018124 +- 0.0000765 seconds time elapsed  ( +-  0.08% )
> >          0.1018706 +- 0.0000639 seconds time elapsed  ( +-  0.06% )
> >
> > Note the two outliers, which happen due to some misguided
> > output optimization feature in perf shortening zero-ended
> > numbers unnecessarily, and adding noise to the grepped
> > output's vertical alignment.
> >
> > Those two lines should be:
> >
> >          0.1017844 +- 0.0000601 seconds time elapsed  ( +-  0.06% )
> >          0.1018830 +- 0.0001690 seconds time elapsed  ( +-  0.17% ) <====
> >          0.1017757 +- 0.0000532 seconds time elapsed  ( +-  0.05% )
> >
> >          0.1018465 +- 0.0000891 seconds time elapsed  ( +-  0.09% )
> >          0.1018680 +- 0.0001170 seconds time elapsed  ( +-  0.12% ) <====
> >          0.1017705 +- 0.0000590 seconds time elapsed  ( +-  0.06% )
> >
> > (The zeroes are printed fully, to full precision.)
> >
> > Basically random chance causing an apparent lack of significant
> > numbers doesn't mean the tool should strip them from the output.
>
> Ugh. I'm not sure why the output is like that.

Yeah, I'm sure some dim-witted kernel developer requested it,
without thinking through all the consequences.

> [...] Searching back through history it seems you are to blame :-)
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf/builtin-stat.c?h=perf-tools-next&id=bc22de9bcdb2249150fb5b3c48fdc4f6bedd3ad7

Uhm, never mind, what a brilliant feature! ;-)

> Perhaps we can drop the precision printf flag and just make the flags
> fixed. I think this output is obscure enough that nobody cares about
> minor changes.

Yeah, sounds good.

Thanks,

	Ingo

