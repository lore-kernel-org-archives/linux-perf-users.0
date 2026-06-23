Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550C8C1F;
	Tue, 23 Jun 2026 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242824; cv=none; b=hPG2bNJexRh3o4Vo6fwpbdPGupOZokoeQpsH7TaOTmntt8snijCK1Rb2ER5ZnpwNmRNnUZvabvUNtalMB7Y3xsahPm858yzGxwFPQAkQYH/vufmbFMHdj+NaNxJ9+h3aE19+84LRGnVNDduYRuAsOZq8vIRvLTZAXXFQYDeMhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242824; c=relaxed/simple;
	bh=D3nCft0vxfjMywUYbOZIqNqsoM6c+ZmPEcwDzkup7EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeDYXmo7SDr5jTc5rlWCXMiMn7m8YB7a9igi8Gib40fG6i0wyleCME3Ebi6dQ45r0rA5DhoLZTI2WKlMqqqZcnW/i0GWIp4fShiEAzqebo9lbjs7FtMS7BFENvSbckp6GevEfFOl6J+/1YSgvL+fl3HcXPnZD+KRFUv+FMqdkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1iCsJyp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1iCsJyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1151F00A3A;
	Tue, 23 Jun 2026 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242823;
	bh=jQNEVGoe5emprUlvHPvodv4IQ/CcvNhe8TbbVqTnuw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D1iCsJyp6n0jD44+9YviFtH/raW8/DAAm+jiAcJTs1eHvznQjkFDiIo/tGiHISWac
	 N17huNFRPcLkgBF1PwjN+GXHLRPINpElzbFw+CL0wrTw/+S0KzO40O4Ydc9vWjiIFm
	 fF/5Ue8woF0Abb600SuFkJqRPIFXtDMdS3j3F1YpQ4N1YgF7RdOdAHrToAzMMnq+Nf
	 nRgi0h9vpi3j1oRnsU05TNjWRXdEDsUTZl2AOi7h6d9pYYPE/NjbvJX8VWXd7fNXi2
	 9WkN4Mi7AG/iSUvxq/JEXkJhGYuzXLqk6SpoEg1VWay/6wfHBhcvOm4p/7sKmHjAr9
	 A/yasVj8Esrdw==
Date: Tue, 23 Jun 2026 16:26:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCHES 000/343] perf tools improvements and fixes for v7.2
Message-ID: <ajreA1h8TeG93myW@x1>
References: <20260622192158.12927-1-acme@kernel.org>
 <CAHk-=wh=P369M9juK_Q8nzzTAFXy31BdizDeVFx1RTGGzaTXHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=P369M9juK_Q8nzzTAFXy31BdizDeVFx1RTGGzaTXHw@mail.gmail.com>

On Tue, Jun 23, 2026 at 12:01:45PM -0700, Linus Torvalds wrote:
> On Mon, 22 Jun 2026 at 12:22, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.2-1-2026-06-22
> 
> This may be pre-existing and I just happened to notice now:
> 
>   Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>         tools/perf/bench/bpf_skel/bench_uprobe.skel.h
> 
> that's after a plain build.
> 
> I've pulled this, but you need to be more careful and fix the
> .gitignore files for generated content.
> 
> Not just because it pollutes "git status", but because we have a
> history of people carelessly committing stuff they shouldn't, and then
> there's even more cleanup required.

I'll add checks for this, thanks for reporting and for merging it
anyway,

- Arnaldo
