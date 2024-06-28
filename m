Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403421AC244;
	Fri, 28 Jun 2024 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578854; cv=none; b=QgXwEd5OmMGxYmN/BL6oCzJe7Xe5rIxlAD059NoPXJKLD8egkuQ7M6QTiozHMdCX1shccuSddRxnsk6P1QzJ5yNUDLdE+PQdm3NtOE4auIKpAFPkHqryCYTyAnYExYm8HASkI79mMnJJ4hNaQodEOkuw9bvy/9f2o8xANxJzYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578854; c=relaxed/simple;
	bh=LHijR0kl7hNylO84H4MwHL6n5jNx5enYAaT3OgCdYX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpNsc1Q9auiuWvDKm+7LWtAS5xEUynOkuWuxv+JV6So32M36KQurS80oABlZ0vYMwD+J9Vdg+X4aM9f/ixN377uniA/IqkdY1vQR0Sgqdcy7rtyhZWD+Lq9izzHpcBP+Zze4NiAzETSEZDkL8MxBYhOIKi6u553icb/9ZH2CIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKMyiVYs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKMyiVYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679CFC116B1;
	Fri, 28 Jun 2024 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578853;
	bh=LHijR0kl7hNylO84H4MwHL6n5jNx5enYAaT3OgCdYX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKMyiVYsyRe1/pt43HihCWtQxR3ZEwpB9M7ibE6ziN+SrgD+Ss8kcyDdkoBGAfhQr
	 FawZLNmO6T64KgF9Xqi8r/UbCSZQR9FA6lgsPKMEC/ssBGwSYAIbJJXUy73oq2MFTf
	 jeAqUpcOaBM5MSEgl7KhA6NdMXKkrhsyy6DI2fkRAUANbA2l969qNLYm7+UTJK5Kzo
	 ZENn2tWegXElhOjphbcLlGGU2rQEbNq27K07KUUBkfC26K7qnu6WWJZk2xmmx+W8p0
	 Ayzt97AC1lmzfnhyUXMoxJYJL38XGrDRm+6Emw3S/F+9RLZW7OQUUa0KUI1eu2XAaH
	 uGx/YqiBu/K0w==
Date: Fri, 28 Jun 2024 09:47:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH 2/2] perf stat: Fix a segfault with --per-cluster
 --metric-only
Message-ID: <Zn6w4pO7VkU4IFYm@x1>
References: <20240627200353.1230407-1-namhyung@kernel.org>
 <20240627200353.1230407-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627200353.1230407-2-namhyung@kernel.org>

On Thu, Jun 27, 2024 at 01:03:53PM -0700, Namhyung Kim wrote:
> The new --per-cluster option was added recently but it forgot to update
> the aggr_header fields which are used for --metric-only option.  And it
> resulted in a segfault due to NULL string in fputs().

Before:

acme@number:~$ sudo ~acme/bin/perf stat -a -x : --per-cluster -M tma_core_bound --metric-only true
Segmentation fault
acme@number:~$ 
acme@number:~$ sudo su -
root@number:~# gdb perf
(gdb) run stat -a -x : --per-cluster -M tma_core_bound --metric-only true
Starting program: /root/bin/perf stat -a -x : --per-cluster -M tma_core_bound --metric-only true

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff6f7f8dd in __strlen_avx2 () from /lib64/libc.so.6
(gdb) bt
#0  0x00007ffff6f7f8dd in __strlen_avx2 () from /lib64/libc.so.6
#1  0x00007ffff6e97a3a in fputs () from /lib64/libc.so.6
#2  0x000000000056b805 in print_metric_headers ()
#3  0x000000000056e084 in evlist.print_counters ()
#4  0x0000000000432513 in cmd_stat ()
#5  0x00000000004c5fb9 in run_builtin ()
#6  0x00000000004c62c9 in handle_internal_command ()
#7  0x0000000000410e57 in main ()
(gdb)

After:

acme@number:~$ sudo ~acme/bin/perf stat -a -x : --per-cluster -M tma_core_bound --metric-only true
cluster:cpus:%  tma_core_bound:%  tma_core_bound:
S0-D0-CLS0:2:18.2::::
S0-D0-CLS8:2:26.7::::
S0-D0-CLS16:2:14.2::::
S0-D0-CLS24:2:10.6::::
S0-D0-CLS32:2:0.6::::
S0-D0-CLS40:2:42.5::::
S0-D0-CLS48:2:21.1::::
S0-D0-CLS56:2:36.8::::
S0-D0-CLS64:0:::::::1.0:
S0-D0-CLS72:0:::::::0.8:
S0-D0-CLS80:0:::::::1.0:
acme@number:~$

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Fixes: cbc917a1b03b ("perf stat: Support per-cluster aggregation")
> Cc: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index e8673c9f6b49..462227f663cb 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -38,6 +38,7 @@
>  static int aggr_header_lens[] = {
>  	[AGGR_CORE] 	= 18,
>  	[AGGR_CACHE]	= 22,
> +	[AGGR_CLUSTER]	= 20,
>  	[AGGR_DIE] 	= 12,
>  	[AGGR_SOCKET] 	= 6,
>  	[AGGR_NODE] 	= 6,
> @@ -49,6 +50,7 @@ static int aggr_header_lens[] = {
>  static const char *aggr_header_csv[] = {
>  	[AGGR_CORE] 	= 	"core%scpus%s",
>  	[AGGR_CACHE]	= 	"cache%scpus%s",
> +	[AGGR_CLUSTER]	= 	"cluster%scpus%s",
>  	[AGGR_DIE] 	= 	"die%scpus%s",
>  	[AGGR_SOCKET] 	= 	"socket%scpus%s",
>  	[AGGR_NONE] 	= 	"cpu%s",
> @@ -60,6 +62,7 @@ static const char *aggr_header_csv[] = {
>  static int aggr_header_num[] = {
>  	[AGGR_CORE] 	= 	2,
>  	[AGGR_CACHE]	= 	2,
> +	[AGGR_CLUSTER]	= 	2,
>  	[AGGR_DIE] 	= 	2,
>  	[AGGR_SOCKET] 	= 	2,
>  	[AGGR_NONE] 	= 	1,
> -- 
> 2.45.2.803.g4e1b14247a-goog
