Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC82E7BD6;
	Thu, 23 Jul 2026 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785782; cv=none; b=iw5t+LxKbvOcyOR4eoneC/UAN4p7EKKX9goXVjBpfxfbu0H7F7cxRIsNyXVBAgNVqh7p6yXuF/0nL2mN7v21kN53Ta93ngZCD7LdFQwGL2aTJJGxgccTz9g8YgD4a/to/VdSNW8FOsMwCeaAmBdGYvsmuX+HCpxwDKV+zKe7M48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785782; c=relaxed/simple;
	bh=JoMYRDTGk+lDO9txnrVgY4wk2xfcickhNIWRrIsYdTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrTyJTX3cEIjuP5LqhMHYtDs2EozxBt8b2h1j+RAPy3ziG3iCwpvidBY6pn8Irbd2tnFzTATB0VRBe4f00ZICK3xyqwfTOZCY81r8g+hrV5GzeqmEyjWlA22B3Li6yNEpg76igXzmHpuhTiQg2nZsY/B2BZ5b9Ba80W/lKnuO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJnjFEmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJnjFEmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6FF1F000E9;
	Thu, 23 Jul 2026 05:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784785778;
	bh=Nl/G+KJMEvwU1CjNGUnUznUzNxhS5CNkYAKnITe32LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MJnjFEmYAyBj//wQm3WFO7O3wkA1CYDyRZiRKwXyOZFCfMBSJxf8IX7VZB551OvZW
	 TQYo72wK/S3nFe/m0zG1bLF94Gn3ccooWAmZxtRwoOT2OhLREzT5Bu1JsLRD2M+Xpr
	 9awhGVbp7HGrk5GCBmknlARvl/gBNZWvjAX21e7HDb0J1ol/he/FLGoFLZJE3Ge1oG
	 NNuDwKasLSK8y+KPHd+bQBpf/L1y0HQRuBzW/LSfL+XBc573UB7rjroXuGgaqCjF7o
	 e3Rika3AvDeb28hRIsUkCf3kPgJzrsnPNe1r0/uThe/mdiZhOLngysBbH9AW1P8S/h
	 CBaJ2ruvl0+zQ==
Date: Wed, 22 Jul 2026 22:49:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, steve@abita.co,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf trace: Add --bitmask-list command-line option
Message-ID: <amGrbXzdup2hvg3k@google.com>
References: <20260722155050.503516-1-atomlin@atomlin.com>
 <20260722155050.503516-3-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722155050.503516-3-atomlin@atomlin.com>

On Wed, Jul 22, 2026 at 11:50:49AM -0400, Aaron Tomlin wrote:
> Introduce a new '--bitmask-list' command-line option for 'perf trace'.
> When this option is specified, the formatting of cpumasks is delegated
> to bitmap_scnprintf(), enabling cpumasks to be displayed as a condensed,
> human-readable list (e.g., "0,2-5,7") instead of the default hexadecimal
> representation. An example is provided below:

Do you know any other places than cpumask use bitmask too?  I'm just
curious if it needs to handle other cases or not.

Thanks,
Namhyung

> 
> ❯ sudo ./perf trace --show-cpu --bitmask-list --event ipi:ipi_send_cpumask --max-event 5
>      0.000 [000] Xorg/1434 ipi:ipi_send_cpumask(cpumask: 2-3,6, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)
>    694.527 [002] chrome/2894 ipi:ipi_send_cpumask(cpumask: 1,3-5, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)
>   2666.608 [003] Chrome_ChildIO/2948 ipi:ipi_send_cpumask(cpumask: 4,7, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)
>   2673.638 [000] Chrome_IOThrea/2920 ipi:ipi_send_cpumask(cpumask: 2-5, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)
>   2714.228 [005] chrome/3375 ipi:ipi_send_cpumask(cpumask: 0-4,6-7, callsite: 0xffffffff9994f8e4, callback: 0xffffffff9994fdd0)
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/Documentation/perf-trace.txt | 4 ++++
>  tools/perf/builtin-trace.c              | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> index d0b6c771a1b9..d20b43ea3d37 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -247,6 +247,10 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
>  	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
>  	better pretty-print integer flags and struct pointers.
>  
> +--bitmask-list::
> +	Show bitmasks as a human-readable, condensed list (e.g. "0,2-5,7")
> +	instead of the default hexadecimal representation.
> +
>  --bpf-summary::
>  	Collect system call statistics in BPF.  This is only for live mode and
>  	works well with -s/--summary option where no argument information is
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 5808adad52ae..9307c2aae4ba 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -226,6 +226,7 @@ struct trace {
>  	bool			force;
>  	bool			vfs_getname;
>  	bool			force_btf;
> +	bool			bitmask_list;
>  	bool			summary_bpf;
>  	int			trace_pgfaults;
>  	char			*perfconfig_events;
> @@ -3280,6 +3281,9 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
>  
>  			if (syscall_arg.len == 0) {
>  				printed += scnprintf(bf + printed, size - printed, "0");
> +			} else if (trace->bitmask_list) {
> +				printed += bitmap_scnprintf(mask, syscall_arg.len * 8,
> +							    bf + printed, size - printed);
>  			} else {
>  				int i;
>  				bool skip_zero = true;
> @@ -5590,6 +5594,7 @@ int cmd_trace(int argc, const char **argv)
>  		     "start"),
>  	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
>  		       "to customized ones"),
> +	OPT_BOOLEAN(0, "bitmask-list", &trace.bitmask_list, "Show bitmask as a human-readable list"),
>  	OPT_BOOLEAN(0, "bpf-summary", &trace.summary_bpf, "Summary syscall stats in BPF"),
>  	OPT_INTEGER(0, "max-summary", &trace.max_summary,
>  		     "Max number of entries in the summary."),
> -- 
> 2.54.0
> 
