Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA441233D6E;
	Fri,  8 Nov 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090824; cv=none; b=pIJKppp1N2px/DSUbxUTvwPfqmWsjj6UGRcTP5T5IpLHNwwWPnxiv6/sKVGQvj1PDQzUDWwlu9H/qKQYQ2Iiu/a9bpfoAf45EXEs/T6jqtP2iDJoNWxc80OQifZ4JDAO1QAyufO9gAGnTZzQEYSKHvyO1+Wmu/KHsFyWeNehieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090824; c=relaxed/simple;
	bh=VzEbzDDDCKoTnPd8x/oSFG034TYCChkZgRP7+dq472E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/EXUXr3kZzmIm8zn1L36eRwQn6oLMbS/L6BJ8385R9Oeu2+zHzBY0CqKs+4mJBRThnEI8qcJbvkDc7JjU3GtzfF4uSIBp0F4QzNy7kOz5MpTz6uM0HDq1MapqgxgJK14/elBdEL4/kwzcFlQg/GE68AhTajQN6+xs2eO0It3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKWdw4dt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKWdw4dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAA2C4CECD;
	Fri,  8 Nov 2024 18:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731090824;
	bh=VzEbzDDDCKoTnPd8x/oSFG034TYCChkZgRP7+dq472E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKWdw4dtOsyG2l9hbiWydQ1TnG8L029tR9tk+z7q4b3lIIF4lXesQFKkddDShPeD5
	 t/Uz+EOE8qGMIyapBmMtyDp8x+24QLsBXddT5coFXx+LKgFKZxlhYcoE8hDvmmIXRf
	 nHCDyVWctUwu24IB9tLWGSsdQ/93cpgRcOdULI611PVu2fdRobxluKhimvwjy9OYkP
	 zGoSu4Lw/CuU6foFRozyU245RiqebWSDjqUoCZZQU35630F3ovFt8YRQDs2dNO06yK
	 V7V1aBXWTE3++VwykuGm7TjQ9cMfZERo5ax7IM5r229srFwfNOeYRRHtlYiQtytK6V
	 3eknASrwCH0kQ==
Date: Fri, 8 Nov 2024 10:33:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>,
	Changbin Du <changbin.du@huawei.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>, Atish Patra <atishp@rivosinc.com>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Anup Patel <anup@brainfault.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 00/20] Remove PERF_HAVE_DWARF_REGS
Message-ID: <Zy5ZhX-ZWRCQRHVs@google.com>
References: <20241017002520.59124-1-irogers@google.com>
 <Zy0VHro3wE-ZTKsq@google.com>
 <20241108090040.463cb3f0820e7ac22d1bb6c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108090040.463cb3f0820e7ac22d1bb6c2@kernel.org>

On Fri, Nov 08, 2024 at 09:00:40AM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> On Thu, 7 Nov 2024 11:29:34 -0800
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hi all,
> > 
> > On Wed, Oct 16, 2024 at 05:25:00PM -0700, Ian Rogers wrote:
> > > These changes are on top of:
> > > https://lore.kernel.org/lkml/20241017001354.56973-1-irogers@google.com/
> > > 
> > > Prior to these patches PERF_HAVE_DWARF_REGS indicated the presence of
> > > dwarf-regs.c in the arch directory. dwarf-regs.c provided upto 4
> > > functions:
> > > 
> > > 1) regs_query_register_offset would translate a register name into a
> > > pt_regs offset and was used by BPF prologues. BPF prologues existed
> > > for BPF events and support for these was removed many releases ago.
> > > This code was dead and could be removed.
> > > 
> > > 2) get_arch_regstr duplicated get_dwarf_regstr and so it could be
> > > removed.  The case for csky was a little more complicated as the ABI
> > > controlled the string. The callers of get_dwarf_regstr were updated to
> > > also pass the ELF flags so that on csky the ABI appropriate table
> > > could be used. As the argument is only used on csky this a no-op for
> > > everything else.
> > > 
> > > 3) get_arch_regnum translated a register name back to a dwarf number
> > > and only existed on x86 where "al", "ax", "eax" and "rax" could all
> > > mean register 0. This code was moved to util with similar
> > > machine/flags logic to get_arch_regstr and for consistency with it.
> > > 
> > > 4) get_powerpc_regs a PowerPC specific function used by annotate that
> > > should really be in util.
> > > 
> > > 2 and 3 required the wiring through of the ELF machine and flags in
> > > callers to get_dwarf_regstr and get_dwarf_regnum. When these values
> > > weren't dependent on an ELF file a new EM_HOST and EF_HOST were added
> > > to give the host ELF machine and flags. These 2 #defines got rid of
> > > the existing separate arch files and #ifdefs.
> > > 
> > > v3: These files were separated from the rest of the v2 libdw clean up
> > >     in:
> > > https://lore.kernel.org/lkml/CAP-5=fVZH3L-6y_sxLwSmT8WyMXDMFnuqUksNULdQYJCPNBFYw@mail.gmail.com/
> > > 
> > > Ian Rogers (20):
> > >   perf bpf-prologue: Remove unused file
> > >   perf dwarf-regs: Remove PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
> > >   perf dwarf-regs: Add EM_HOST and EF_HOST defines
> > >   perf disasm: Add e_machine/e_flags to struct arch
> > >   perf dwarf-regs: Pass accurate disassembly machine to get_dwarf_regnum
> > >   perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
> > >   perf dwarf-regs: Move x86 dwarf-regs out of arch
> > >   perf arm64: Remove dwarf-regs.c
> > >   perf arm: Remove dwarf-regs.c
> > >   perf dwarf-regs: Move csky dwarf-regs out of arch
> > >   perf loongarch: Remove dwarf-regs.c
> > >   perf mips: Remove dwarf-regs.c
> > >   perf dwarf-regs: Move powerpc dwarf-regs out of arch
> > >   perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
> > >   perf s390: Remove dwarf-regs.c
> > >   perf sh: Remove dwarf-regs.c
> > >   perf sparc: Remove dwarf-regs.c
> > >   perf xtensa: Remove dwarf-regs.c
> > >   perf dwarf-regs: Remove get_arch_regstr code
> > >   perf build: Remove PERF_HAVE_DWARF_REGS
> > 
> > These look all good and I'm about to apply the series.
> > 
> > Masami, do you have any remaining concerns?  It'd be nice if you can
> > give your Reviewed-by.
> 
> I think it looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks for your review!
Namhyung

