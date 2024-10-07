Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD736187332;
	Mon,  7 Oct 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288486; cv=none; b=lPV9G39G+Xtlg5tI/LvU9Awfv4I8gvlXEY3JI7oYpkwZXy+p9ijDgNJWVsjqKayod04Wmbw1+VG5d3mVrNHyyvB/ix56w90cme/ZPBk674lS7TXUjtjJ8aKT2oNGa1tpVjW6rBH+fx2NUuW908RihfJmGGx23pWHAObkqceNSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288486; c=relaxed/simple;
	bh=Jj+bA/iDpKmZb0BWsx4i5xD4QtvKKl6H4sm84kO751s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XBF8FU7vk4/biU10q42AYdKYzGvY4qUzCYpLlaW+BDPoo3TjI4F/74mat7TLJuHSxGWHPLS7s5j8rBQojrNskaYcmkp/YyhoIwcfP1P9x1igXeJtkOyqrWLa5JnZNEeVx5TAvKqD8Lura9r8buD/bhRjKO2lC6tEHk5kyGG/6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSBUatO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSBUatO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E985C4CEC6;
	Mon,  7 Oct 2024 08:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728288486;
	bh=Jj+bA/iDpKmZb0BWsx4i5xD4QtvKKl6H4sm84kO751s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SSBUatO0qMA5dwFmh8IuLOyc7n5tIKqA2wt4O/zfGXHKcKYOZerci4Z76ljfggMxc
	 EUeu/tC8AmSPGGTVkYP5FvJuXTQkM6nPbST+BStybCFdaZ1V5egNlRRcp0Uc3rroXz
	 8g7IInruEhFSW+tjIHXeCmSWuu+cwgWBA0kp0npQoSa9dP6V1Oj7RHXz8kyQ7U9Pty
	 bBbQJuqnhg/Ant9iT/xEm2Tz7vL6xlwmKyvDmTO8eCeF+Cw0N7ocJSvXsYdcllQVz/
	 I7c+a4NHzoGbyu/dvKORakrrUlo2VihEZXOFexj1yyxExL6jIQWodQVYR4iyeGi6EP
	 lHRmLpAmGWz1g==
Date: Mon, 7 Oct 2024 17:07:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, Will
 Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren
 <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nick
 Terrell <terrelln@fb.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner
 <dwagner@suse.de>, Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Kajol Jain <kjain@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Bibo
 Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>,
 Oliver Upton <oliver.upton@linux.dev>, "Steinar H. Gunderson"
 <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Chen Pei
 <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, Yury Norov
 <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 16/31] perf dwarf-regs: Pass accurate disassembly
 machine to get_dwarf_regnum
Message-Id: <20241007170755.03697b9178ed3dcac24dfa21@kernel.org>
In-Reply-To: <20241005195541.380070-17-irogers@google.com>
References: <20241005195541.380070-1-irogers@google.com>
	<20241005195541.380070-17-irogers@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Oct 2024 12:55:26 -0700
Ian Rogers <irogers@google.com> wrote:

> Rather than pass 0/EM_NONE, use the value computed in the disasm
> struct arch. Switch the EM_NONE case to EM_HOST, rewriting EM_NONE if
> it were passed to get_dwarf_regnum. Pass a flags value as
> architectures like csky need the flags to determine the ABI variant.
> 

Does this change the command output when we use it for cross-build
environment? E.g. remote arch is different from host arch? If so,
please add output examples with/without this change.

Thank you,

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c           | 6 +++---
>  tools/perf/util/dwarf-regs.c         | 8 ++++++--
>  tools/perf/util/include/dwarf-regs.h | 5 +++--
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 37ce43c4eb8f..b1d98da79be8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2292,7 +2292,7 @@ static int extract_reg_offset(struct arch *arch, const char *str,
>  	if (regname == NULL)
>  		return -1;
>  
> -	op_loc->reg1 = get_dwarf_regnum(regname, 0);
> +	op_loc->reg1 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
>  	free(regname);
>  
>  	/* Get the second register */
> @@ -2305,7 +2305,7 @@ static int extract_reg_offset(struct arch *arch, const char *str,
>  		if (regname == NULL)
>  			return -1;
>  
> -		op_loc->reg2 = get_dwarf_regnum(regname, 0);
> +		op_loc->reg2 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
>  		free(regname);
>  	}
>  	return 0;
> @@ -2405,7 +2405,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
>  				return -1;
>  
>  			if (*s == arch->objdump.register_char)
> -				op_loc->reg1 = get_dwarf_regnum(s, 0);
> +				op_loc->reg1 = get_dwarf_regnum(s, arch->e_machine, arch->e_flags);
>  			else if (*s == arch->objdump.imm_char) {
>  				op_loc->offset = strtol(s + 1, &p, 0);
>  				if (p && p != s + 1)
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index 7c01bc4d7e5b..1321387f6948 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -70,7 +70,7 @@ __weak int get_arch_regnum(const char *name __maybe_unused)
>  }
>  
>  /* Return DWARF register number from architecture register name */
> -int get_dwarf_regnum(const char *name, unsigned int machine)
> +int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags __maybe_unused)
>  {
>  	char *regname = strdup(name);
>  	int reg = -1;
> @@ -84,8 +84,12 @@ int get_dwarf_regnum(const char *name, unsigned int machine)
>  	if (p)
>  		*p = '\0';
>  
> +	if (machine == EM_NONE) {
> +		/* Generic arch - use host arch */
> +		machine = EM_HOST;
> +	}
>  	switch (machine) {
> -	case EM_NONE:	/* Generic arch - use host arch */
> +	case EM_HOST:
>  		reg = get_arch_regnum(regname);
>  		break;
>  	default:
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
> index f4f87ded5e3d..ee0a734564c7 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -93,12 +93,13 @@ int get_arch_regnum(const char *name);
>   * name: architecture register name
>   * machine: ELF machine signature (EM_*)
>   */
> -int get_dwarf_regnum(const char *name, unsigned int machine);
> +int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags);
>  
>  #else /* HAVE_LIBDW_SUPPORT */
>  
>  static inline int get_dwarf_regnum(const char *name __maybe_unused,
> -				   unsigned int machine __maybe_unused)
> +				   unsigned int machine __maybe_unused,
> +				   unsigned int flags __maybe_unused)
>  {
>  	return -1;
>  }
> -- 
> 2.47.0.rc0.187.ge670bccf7e-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
