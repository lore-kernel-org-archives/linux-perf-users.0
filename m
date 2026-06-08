Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20423EEAD6;
	Mon,  8 Jun 2026 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949922; cv=none; b=nIO5XHHaUU+u+km+nCRGxY8Y3pNkcnTrQqGds4y9xsRfuiq4zVHS9PuCMA8SQBBJCe7NwrstrkxfwC4xOGNGpZ2itJG3saUKIeFucRiZUlLuZkPdfBEed7JN9S5zCfNLpYPM2WNHBpGu2Uqgl6g3PV33C2deaHfxn+XoPt4oCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949922; c=relaxed/simple;
	bh=hN4oWFEvM5GzZHMIP8vMempnkxiQfo1DR2z/FgfcDFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnB0FSqNg1QQuyr4eQOT0bnFCPo+7WRnleXDB1pGh7oSDWRX+FRFPSQ+mVvd0B96p+MkWldmbRYNkk0pByZdhizSBbx/aBgGdcLeUprNQK8995hjEHyFiJa5B3OYfMAkQOB1O/FIVWuenp9wfMLnug9J39IfoDnK1T6v6za0P3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2KjRrt7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2KjRrt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0973E1F00899;
	Mon,  8 Jun 2026 20:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949921;
	bh=EuEE3kOkE1Z3oSkx3O2SZZKsZzuOi2qcYsWuh3xM0l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O2KjRrt7eo4j8TPv4j7gfiutL5RbXWO3L4ygfIKvymxIxD+JftUFoei0CoeQEMr/j
	 0DLKXoyy4HTYv/j1rG7RP8joIW+9S52ERwCrrsjo4nE7G2Fft6QhQDOUJKUNR6nibK
	 Rmb1DGJ3smhk4mDgh0ch31m+31hYvmzw/HVaUtLUcadJ/atGyPkN1F8VOUBAkJfmR0
	 C2mzpzxPpPtaA2VGJFdseZ+L5f7AXrMnHce4JdBjYC5nE41zkG5MlCWcTq/ZGPHErB
	 GvIgkSDw7oUOPPEB78zyz/JXtuiviCCkWAC4X3slpGw4Da8zb4msvTcXHF1sPUE1Qv
	 V3ZlnUrOfjMZg==
Date: Mon, 8 Jun 2026 17:18:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Martin Kaiser <martin@kaiser.cx>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf riscv: fix register name strings
Message-ID: <aicjnnXo1blrTFgB@x1>
References: <20260608192731.708606-1-martin@kaiser.cx>
 <CAP-5=fV6tVQA1TO_j9TDzPXV+ik3ww-mxX-VaO_XCGkAWYffag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV6tVQA1TO_j9TDzPXV+ik3ww-mxX-VaO_XCGkAWYffag@mail.gmail.com>

On Mon, Jun 08, 2026 at 01:08:28PM -0700, Ian Rogers wrote:
> On Mon, Jun 8, 2026 at 12:27 PM Martin Kaiser <martin@kaiser.cx> wrote:
> >
> > On risc-v, pref probe generates an invalid syntax for a named register in
> > a kprobe.
> >
> > $ perf probe --debug verbose --add "n_tty_write tty"
> > ...
> > Writing event: p:probe/n_tty_write _text+8922528 tty=%"%a0":x64
> > Failed to write event: Invalid argument
> >
> > The problem is the combination of
> >
> >    #define REG_DWARFNUM_NAME(reg, idx) [idx] = "%" #reg
> >
> > and entries such as
> >
> >    REG_DWARFNUM_NAME("%a0", 10)
> >
> > where #reg will escape the quotes of the first macro parameter.
> >
> > Update the macro definition to produce the correct syntax for a named
> > register in a kprobe, i.e. the unquoted register name with only one
> > leading %.
> >
> > Fixes: a90c4519186d ("perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h")
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks for catching this! Sashiko is also green for this change:
> https://sashiko.dev/#/patchset/20260608192731.708606-1-martin%40kaiser.cx

Thanks, applying.

- Arnaldo
