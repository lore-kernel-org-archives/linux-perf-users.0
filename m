Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973B22AE7F;
	Tue, 18 Feb 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872587; cv=none; b=jhFs2p01OVlBWyiqnEbxrwApmFkd2slmyY9P9aRhuedKGIIK4SN5ErCBAbgVXHwFRS7FkJODn++wb57UW9ib/gNxlnngmuGjWw0noZIZyviXEOCAiqyV6KDTX3DrrbOlmpaS68Nh4QCxzQJuvMBPQmcjcpJESMv3t464+HOv/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872587; c=relaxed/simple;
	bh=qdz6v5u9AENOho3Z4k20JoDNSJyrhwjpfVmj3CQVAIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFmgtKgxR3V+Vt8Gpn1KPoj7UH0p9MbY+Xw8tKLKxUP8Of9MykzLW8Wx4KHF47YWLneT79u0QfEoHlgtDEDOs9UyoWsRowqr9SkJIT+JQ6W4loZd7IAkqHDvF9AHUNcXJ2snePLYVMB2sEm9zksISnMkK+aHVgu6UTsU4GCA2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iJDuIZOT; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iJDuIZOT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739872581; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=N8XCSr1gSHReK69ZBra+oD3DdxbDjt85CctNSIF9ow4=;
	b=iJDuIZOTAF+XyqadtpgzMq8vVjFaHbtFxJd40J7DvyGFxheehZwizAjcXkNEhuYhC+9ZU4+eBcIO96hzaKHWhSpYYaSPNICLW5hwXARAPmaUViiZm/l15crEp+lHGfzRCih3FLnaFfl1E7n/P4V8FMXiZ0X9RsCk11vZI3xypao=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WPlRUKM_1739872578 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 17:56:19 +0800
Date: Tue, 18 Feb 2025 17:56:17 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [RESEND PATCH v6 0/8] perf: Support searching local debugging
 vdso or specify vdso path in cmdline
Message-ID: <lytsbawzokllz3nh36at3bi6322sk5br3vrqp5lr75eiwdqqj3@ozmbwylc5gdg>
References: <20240816105811.1812897-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816105811.1812897-1-changbin.du@huawei.com>

Hi Changbin,

On Fri, Aug 16, 2024 at 06:58:03PM +0800, Changbin Du wrote:
> The vdso dumped from process memory (in buildid-cache) lacks debugging
> info. To annotate vdso symbols with source lines we need a debugging
> version.
> 
> For x86, we can find them from your local build as
> 'arch/x86/entry/vdso/vdso{32,64}.so.dbg'. Or they may resides in
> '/lib/modules/<version>/vdso/vdso{32,64}.so' on Ubuntu. But notice that the
> builid has to match.
> 
> If user doesn't specify the path, perf will search them internally as long
> as vmlinux when recording samples. The searched debugging vdso will add to
> buildid cache as ~/.debug/[vdso]/debug.
> 
> Below samples are captured on my local build kernel. perf succesfully
> find debugging version vdso and we can annotate with source without
> specifying vdso path.
> 
> $ sudo perf record -a
> $ sudo perf report --objdump=llvm-objdump
> 
> Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
> __vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
> Percent│       movq    -48(%rbp),%rsi
>        │       testq   %rax,%rax
>        │     ;               return vread_hvclock();
>        │       movq    %rax,%rdx
>        │     ;               if (unlikely(!vdso_cycles_ok(cycles)))
>        │     ↑ js      eb
>        │     ↑ jmp     74
>        │     ;               ts->tv_sec = vdso_ts->sec;
>   0.02 │147:   leaq    2(%rbx),%rax
>        │       shlq    $4, %rax
>        │       addq    %r10,%rax
>        │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {
>   9.38 │152:   movl    (%r10),%ecx
> 
> When doing cross platform analysis, we need to specify the vdso path manually if
> we are interested in its symbols, because they are not installed on local
> machine. At most two vdso can be given. Also you can pack your buildid cache with
> perf-archive if the debugging vdso can be found on the sampled machine.
> 
> $ sudo perf report --objdump=llvm-objdump \
>       --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg
With latest upstream kernel, I still can't annotate symbols in vdso.
With your patch and this --vdso command, it works great on x86 and arm64
platform. So
   Tested-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>


Regards
Yin, Fengwei

> 
> I also improved perf-buildid-cache command to recognize vdso when adding files,
> then place it at correct place.
> 
> $ sudo perf buildid-cache --add /work/linux/arch/x86/entry/vdso/vdso64.so.dbg

