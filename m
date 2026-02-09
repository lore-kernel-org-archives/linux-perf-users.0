Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE0423A94
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665955; cv=none; b=oUOqHv/e0eM9l7wy53jIA7hHyvz/ijDtr1iFoIImYpS8hw/9uDTj45pSXIBl+1QjdbruE7C0LQGK+upDNLzEPXtTlCbG9UVZYv3J9VxlKC1ruRoPSAnDVkUgS1WkrzSYbd5AkOhmP+R12UljnOT5p54HRlC6wNwRiYt7xOvj2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665955; c=relaxed/simple;
	bh=Dt/Vi7azwYTvedr8KcPR6YplVzxvmHPXQyw9syBzzsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOPw+pNrpnXvEb/B8QlasqNfjlKhlS5m8Q4peOxJVx3QG4D6h4J/i8sHzHW53waM9+siQGoBq/a5pz2x8Gv/9gH+MDyyrLAMShyfmRxk886Omq1tPcPWdmCVPCQYFC/+IxDksfPGWk3sCED+Mm/7+US2pSZM/v9CFaRsslTl9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn+/yNjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn+/yNjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE84C116C6;
	Mon,  9 Feb 2026 19:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770665954;
	bh=Dt/Vi7azwYTvedr8KcPR6YplVzxvmHPXQyw9syBzzsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kn+/yNjSFgwhQv6aIvD+0cLiA+3GboMDG+Bt34T2O6kJqQ1gYYEee7nSqPYlJbhzq
	 aLKmgE0PGQC1wcM+UcgKNZmTCjYFCbO973juEYzyef9lXTsENVe5zWPUytU3MbsBwm
	 xt7560VxL+3fxijk/7R7ICTSumC8Ic7hAtdc2UEAhly46dNumNjjTQrOI5fjnWPYIJ
	 HUiRPbWkBfmwbsb1d4gJAHZukH0rCo4w8dW1MBVKzkkzn18yPw7SkFkob3/fXx6n14
	 Xqt1HAywjeEigVZWv1NagkywlzW52ZnTEpoOteu6UZv3/SRsHUbDdWH+/eqZscMt9y
	 Gufu8vanV4p0Q==
Date: Mon, 9 Feb 2026 16:39:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Noel Grandin <noelgrandin@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: why is 'perf record --call-graph' using addr2line?
Message-ID: <aYo334TnekI8UgpY@x1>
References: <CAFYHVnXddP=V-q=0Z3Na1FOBaQRT3RA55ruDY=O0pNpbaSc4jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFYHVnXddP=V-q=0Z3Na1FOBaQRT3RA55ruDY=O0pNpbaSc4jg@mail.gmail.com>

On Mon, Feb 09, 2026 at 09:24:47PM +0200, Noel Grandin wrote:
> Hi
> 
> I am running
> 
> $ perf record --call-graph=dwarf,32000 my_program.bin
> 
> quite a lot.
> 
> Until a couple of days ago, I would do this, hit ctrl-C, it would
> finish writing stuff to disk in a few seconds, and then I would
> proceed with using KDAB hotspot to analyse the data.
> 
> Then I did a routine 'apt update' of my ubuntu box, and now....
 
> Now, it takes 30+ minutes before perf exits, and it is spending all of
> that time running addr2line.

Are you sure? addr2line can be used when using '-s srcline' or '-s
srcfile', but then in 'perf report', not on record.

Doing some systemwide recording here I don't see such calls to
addr2line, be it the function inside perf or the addr2line utility:

root@number:/# perf probe -x ~/bin/perf addr2line
Added new event:
  probe_perf:addr2line (on addr2line in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:addr2line -aR sleep 1

root@number:/# perf trace -e execve,probe_perf:addr2line perf record --call-graph=dwarf,32000
         ? (         ): perf/1708890  ... [continued]: execve())                                           = 0
^C[ perf record: Woken up 302 times to write data ]
root@number:/# ls -[ perf record: Captured and wrote 89.499 MB perf.data (5420 samples) ]
la perf.data
-rw-------. 1 root root 93924024 Feb  9 16:37 perf.data
root@number:/# ls -lah perf.data
-rw-------. 1 root root 90M Feb  9 16:37 perf.data
root@number:/# perf evlist -v
cpu/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 144, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CALLCHAIN|CPU|PERIOD|REGS_USER|STACK_USER|IDENTIFIER, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 2, sample_id_all: 1, exclude_callchain_user: 1, sample_regs_user: 0xff0fff, sample_stack_user: 32000
dummy:u: type: 1 (PERF_TYPE_SOFTWARE), size: 144, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, build_id: 1
root@number:/#
 
> Any ideas?

Can you give more details? Do you have anything in ~/.perfconfig, etc?
 
> Thanks, Noel Grandin
