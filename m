Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FFC39E6DE;
	Mon,  8 Jun 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950428; cv=none; b=Qzh+MwwL3h6Jnl4dg6mclcWCTOuv4WSPTA2YDEaWYtddlmzZbBIyLrsC9jKTwPisWOxMRhbjHgiZrNodD6vjRraxgLSgbNw071ZFmnsMMw9e38uhpC2Ua9IA/4hHRKTbAAPFzE2CCBSE+khOqrjuxEahuJ0px4ZoliDPRDhZR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950428; c=relaxed/simple;
	bh=NPG6ivw6tDOFUvLfyMhrWEMnlkiweSuuHUvIVBuwX7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuimFQtt84Rut2obJiKQcHklagqE1dkbHrL4ZBbaPsf+Rqzh3qIJLSIMG13m8vbh66WI1NsKzwGSPbcCaZkhmUKSy8IFg/aUh3jrTtbGiwn6jjtTgOMZ777t/WyKXxbR7oWd2LCAUz9Nw9p6aL6w2gs/SjovX4da+8yQLP24NLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWXCuzP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWXCuzP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7FB1F00893;
	Mon,  8 Jun 2026 20:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950427;
	bh=6kV0zlS9JGgrhr/gDWvJr7xCMqMAeKpiuhdZnhYO2M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oWXCuzP0AjEmKkYdFDwHyq6AbaaNyrpxenVFJg91Re+Lh/D+C6J2nfba9HfZIixS6
	 ECX9V/632rnT0+2WeYJUv2gAUW2prmJG8M8QWtvZqPCOgpr0j+R3xoDU0P67TlMAJC
	 WknYxWTo6y1KrFtQvzCEqHMeJUrCweEybeR4+h4xjkzEsFK1kAJDQ/yJKsMeD0q11W
	 8+jD1g7oeZYQKMlo/Xy2mIfw/dKL2bkXAWmRT7mLID37wOP3Htx78RHXDSlPoQHNq1
	 nKTr+IB8HDmrKxUVuVc+99Ng5DPIQ05crIG6s6BTmWvsp/fHc284K788LlEyPy0QEm
	 7oKXWLzPFCR/g==
Date: Mon, 8 Jun 2026 17:27:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Martin Kaiser <martin@kaiser.cx>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf riscv: fix register name strings
Message-ID: <aicll3FawrGwTQ-1@x1>
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

Strange,

  LD      /tmp/build/perf-tools-next/tests/perf-test-in.o
  LD      /tmp/build/perf-tools-next/perf-test-in.o
In file included from util/dwarf-regs.c:23:
util/../arch/riscv/include/dwarf-regs-table.h:5:9: error: ‘REG_DWARFNUM_NAME’ redefined [-Werror]
    5 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = reg
      |         ^~~~~~~~~~~~~~~~~
In file included from util/dwarf-regs.c:22:
util/../arch/powerpc/include/dwarf-regs-table.h:10:9: note: this is the location of the previous definition
   10 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = "%" #reg
      |         ^~~~~~~~~~~~~~~~~
In file included from util/dwarf-regs.c:24:
util/../arch/s390/include/dwarf-regs-table.h:5:9: error: ‘REG_DWARFNUM_NAME’ redefined [-Werror]
    5 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = "%" #reg
      |         ^~~~~~~~~~~~~~~~~
util/../arch/riscv/include/dwarf-regs-table.h:5:9: note: this is the location of the previous definition
    5 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = reg
      |         ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/util/dwarf-regs.o] Error 1


Trying to figure out why Sashiko is green on it but it doesn't buind
here...

- Arnaldo
