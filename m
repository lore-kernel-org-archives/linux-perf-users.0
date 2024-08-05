Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE768143879;
	Mon,  5 Aug 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885737; cv=none; b=XZQ04v3yvia5VBROWvS7oACaJUXUKqKoNFGKcXlWoy2/gHezrg/Bb9QPudt/tfHnTlRkNdx89T0Q+BcnGf48syleR0GAx89VMhAkZeulHohuKddPKelsBl5d8mgODVWUTeaZZMceSY/zZ2KVnRsY0GH1BLpOwh5Fwm+ix1H6G00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885737; c=relaxed/simple;
	bh=DGOzK2PWu7iR/Pl1Zurti91STFNXq7Fpx0TjVIcH3Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeoYEZ3CwFhcZmb0pm47vqDReynbIhmgX3KOy34Mmfp5/jyuo5f7op038h1axT6fc5PUj31E8sY1zqsVAseCKvg16aIDEcPedSV9R7Rygwuk6ECo5qmxuQs3ObSCXbJcMkUKB6TBEh8zJkM3zo+6PddhaLlLrDzETSwx97gssho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWk720IZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWk720IZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3AFC32782;
	Mon,  5 Aug 2024 19:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722885737;
	bh=DGOzK2PWu7iR/Pl1Zurti91STFNXq7Fpx0TjVIcH3Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWk720IZuIIqaVsxFjKKiu9IrL9/wcHNcj7xqlJ+tNpnVIYzgqiEhaJdvEZOu3PXw
	 zAx2td1hVCwPNKJQcmku1HmMYMe2HddDoL7GcpIg88810mCwsnxgslrtbbWKX+meJg
	 z3FEblxhD+tg0QEsc/wotK/IBWvTaaC7p7lIaPpgDRAzmrI4XlePbpKe+0jblHUAga
	 pB5jVARCGpKddCRw/CBqTGBdlbURLum42C+iLy7BesluMWxUvnNb6clE9AathE8sLj
	 SuBzz+9di/wBqtntlLa+/+JGUKxtp5HLDqtzzCua6RZUW2cLSQdpC4hAOXz0zNJ2Ha
	 tw65bg5UTKHCw==
Date: Mon, 5 Aug 2024 16:22:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/5] perf annotate: Add --skip-empty option
Message-ID: <ZrEmZLV0vgU6GUcN@x1>
References: <20240803211332.1107222-1-namhyung@kernel.org>
 <20240803211332.1107222-6-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240803211332.1107222-6-namhyung@kernel.org>

On Sat, Aug 03, 2024 at 02:13:32PM -0700, Namhyung Kim wrote:
> Like in perf report, we want to hide empty events in the perf annotate
> output.  This is consistent when the option is set in perf report.
> 
> For example, the following command would use 3 events including dummy.
> 
>   $ perf mem record -a -- perf test -w noploop
> 
>   $ perf evlist
>   cpu/mem-loads,ldlat=30/P
>   cpu/mem-stores/P
>   dummy:u
> 
> Just using perf annotate with --group will show the all 3 events.

Seems unrelated, just before compiling with this patch:

root@x1:~# perf mem record -a -- perf test -w noploop
Memory events are enabled on a subset of CPUs: 4-11
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 10.506 MB perf.data (2775 samples) ]
root@x1:~#

root@x1:~# perf annotate --group --stdio2 sched_clock
root@x1:~# perf annotate --stdio2 sched_clock
Samples: 178  of event 'cpu_atom/mem-stores/P', 4000 Hz, Event count (approx.): 565268, [percent: local period]
sched_clock() /usr/lib/debug/lib/modules/6.8.11-200.fc39.x86_64/vmlinux
Percent      0xffffffff810511e0 <sched_clock>:
               endbr64        
   5.76        incl    pcpu_hot+0x8
   5.47      → callq   sched_clock_noinstr
  88.78        decl    pcpu_hot+0x8
             ↓ je      1e     
             → jmp     __x86_return_thunk
         1e: → callq   __SCT__preempt_schedule_notrace
             → jmp     __x86_return_thunk
root@x1:~# perf annotate --group --stdio2 sched_clock
root@x1:~# perf annotate --group --stdio sched_clock
root@x1:~# perf annotate --group sched_clock
root@x1:~#

root@x1:~# perf evlist
cpu_atom/mem-loads,ldlat=30/P
cpu_atom/mem-stores/P
dummy:u
root@x1:~#

root@x1:~# perf report --header-only | grep cmdline
# cmdline : /home/acme/bin/perf mem record -a -- perf test -w noploop 
root@x1:~#

I thought it would be some hybrid oddity but seems to be just --group
related, seems like it stops if the first event has no samples? Because
it works with another symbol:

root@x1:~# perf annotate --group --stdio2 do_lookup_x | head -25
Samples: 20  of events 'cpu_atom/mem-loads,ldlat=30/P, cpu_atom/mem-stores/P, dummy:u', 4000 Hz, Event count (approx.): 769079, [percent: local period]
do_lookup_x() /usr/lib64/ld-linux-x86-64.so.2
Percent                       0x9900 <do_lookup_x>:       
                                pushq      %rbp                 
                                movq       %rsp,%rbp            
                                pushq      %r15                 
                                pushq      %r14                 
                                pushq      %r13                 
                                pushq      %r12                 
                                pushq      %rbx                 
                                subq       $0x88,%rsp           
                                movq       %rdi,-0x50(%rbp)     
                                movl       8(%r9),%edi          
                                movq       0x10(%rbp),%r12      
                                movq       0x28(%rbp),%r10      
                                movq       %rdx,-0x70(%rbp)     
                                movq       %rcx,-0x58(%rbp)     
                                movq       %rdi,%r11            
   0.00    5.73    0.00         movq       %r8,-0x68(%rbp)      
                                movq       (%r9),%r8            
                                movl       %esi,%eax            
   8.30    0.00    0.00         movl       0x30(%rbp),%r9d      
                                movl       %esi,%r15d           
                                shrl       $6, %eax             
                                movq       %r8,%r13             
root@x1:~#

Just leaving a note here, no time to fully investigate this now,

- Arnaldo
