Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D551D0DD6;
	Tue,  6 Aug 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949955; cv=none; b=qW/DQ5RPVgRlSSsU6Oi0sf9ln+NZ9wkoJwnxMcWlD5KR1ZQAP0pXZsBKkfrnbTIeZGvthhjchh1PpPgessiEGADIa9r16HPDA+ZhtWMml08mattp6lLjRgynHgzRIFOsttlyZH0nt6j++q+qZ4EJaeYTD6yeE5o77FQVues0UWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949955; c=relaxed/simple;
	bh=DGsYcTK6eGFALIQNZ8BJVb+gMAQQ1GHI0TB0nXuutCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbIZ8qQKUiRiyhqIDPxyjWQlBaQ2KugtRN+52tLmNOhlXBm0sD/lZMBu1kCmtA2sGmMrET+N5YGeg25vsbzJQhhtiTRyuLYMunIvBjglTTpMLJg8rzceVlidvvD0Ox+4iUeDD7RGYxl5hcqNHiv1Iv0KDA8MJmP2TFVS4RZC1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2ReV+3V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2ReV+3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78888C32786;
	Tue,  6 Aug 2024 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722949954;
	bh=DGsYcTK6eGFALIQNZ8BJVb+gMAQQ1GHI0TB0nXuutCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2ReV+3V/aDyaWy/h4SdEWcIkxvvw+4wm2KNoGOyhSAavyMRnDIptwNzCm5wjZAAw
	 u3E7s1UrKWqXRJHECe3+MPO7RE9VHEc+C7bw9HLHnFNWh6WgfAnUqBbh48RB4A4oxA
	 RS0bfz20PlvLyuc1/l5Qv/v1rNOX7OupHjRitxjWdyE8vOzD5D/CtyqBr1ln5qasal
	 iKS7we6ArZsJDNQo0VGdOUswwwrHuF+/NjrOsgEgk4izFbYEmx2Useju7TIskdJGzq
	 Sxalru7NKCvjsXmANp92I8GjrPaulpW9+BnYodha0eQ8hHBpgeVmvQ2P3dL7OADnhS
	 7If6Brgy5Cq/A==
Date: Tue, 6 Aug 2024 10:12:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/5] perf annotate: Add --skip-empty option
Message-ID: <ZrIhPuFee8R9ZvVi@x1>
References: <20240803211332.1107222-1-namhyung@kernel.org>
 <20240803211332.1107222-6-namhyung@kernel.org>
 <ZrEmZLV0vgU6GUcN@x1>
 <ZrEyo4CSm6nKU20s@google.com>
 <ZrE011BLww0LQQha@x1>
 <ZrE7EWyFJ3hThopM@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrE7EWyFJ3hThopM@google.com>

On Mon, Aug 05, 2024 at 01:50:25PM -0700, Namhyung Kim wrote:
> On Mon, Aug 05, 2024 at 05:23:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Aug 05, 2024 at 01:14:27PM -0700, Namhyung Kim wrote:
> > > On Mon, Aug 05, 2024 at 04:22:12PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Sat, Aug 03, 2024 at 02:13:32PM -0700, Namhyung Kim wrote:
> > > > > Like in perf report, we want to hide empty events in the perf annotate
> > > > > output.  This is consistent when the option is set in perf report.
> > > > > 
> > > > > For example, the following command would use 3 events including dummy.
> > > > > 
> > > > >   $ perf mem record -a -- perf test -w noploop
> > > > > 
> > > > >   $ perf evlist
> > > > >   cpu/mem-loads,ldlat=30/P
> > > > >   cpu/mem-stores/P
> > > > >   dummy:u
> > > > > 
> > > > > Just using perf annotate with --group will show the all 3 events.
> > > > 
> > > > Seems unrelated, just before compiling with this patch:
> > > > 
> > > > root@x1:~# perf mem record -a -- perf test -w noploop
> > > > Memory events are enabled on a subset of CPUs: 4-11
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 10.506 MB perf.data (2775 samples) ]
> > > > root@x1:~#
> > > > 
> > > > root@x1:~# perf annotate --group --stdio2 sched_clock
> > > > root@x1:~# perf annotate --stdio2 sched_clock
> > > > Samples: 178  of event 'cpu_atom/mem-stores/P', 4000 Hz, Event count (approx.): 565268, [percent: local period]
> > > > sched_clock() /usr/lib/debug/lib/modules/6.8.11-200.fc39.x86_64/vmlinux
> > > > Percent      0xffffffff810511e0 <sched_clock>:
> > > >                endbr64        
> > > >    5.76        incl    pcpu_hot+0x8
> > > >    5.47      → callq   sched_clock_noinstr
> > > >   88.78        decl    pcpu_hot+0x8
> > > >              ↓ je      1e     
> > > >              → jmp     __x86_return_thunk
> > > >          1e: → callq   __SCT__preempt_schedule_notrace
> > > >              → jmp     __x86_return_thunk
> > > > root@x1:~# perf annotate --group --stdio2 sched_clock
> > > > root@x1:~# perf annotate --group --stdio sched_clock
> > > > root@x1:~# perf annotate --group sched_clock
> > > > root@x1:~#
> > > > 
> > > > root@x1:~# perf evlist
> > > > cpu_atom/mem-loads,ldlat=30/P
> > > > cpu_atom/mem-stores/P
> > > > dummy:u
> > > > root@x1:~#
> > > > 
> > > > root@x1:~# perf report --header-only | grep cmdline
> > > > # cmdline : /home/acme/bin/perf mem record -a -- perf test -w noploop 
> > > > root@x1:~#
> > > > 
> > > > I thought it would be some hybrid oddity but seems to be just --group
> > > > related, seems like it stops if the first event has no samples? Because
> > > > it works with another symbol:
> > > 
> > > Good catch.  Yeah I found it only checked the first event.  Something
> > > like below should fix the issue.
> > 
> > Nope, with the patch applied:
> > 
> > root@x1:~# perf annotate --group --stdio sched_clock
> > root@x1:~# perf annotate --stdio sched_clock
> >  Percent |      Source code & Disassembly of vmlinux for cpu_atom/mem-stores/P (147 samples, percent: local period)
> > -------------------------------------------------------------------------------------------------------------------
> >          : 0                0xffffffff810511e0 <sched_clock>:
> >     0.00 :   ffffffff810511e0:       endbr64
> >     5.11 :   ffffffff810511e4:       incl    %gs:0x7efe2d5d(%rip)       # 33f48 <pcpu_hot+0x8>
> >     0.13 :   ffffffff810511eb:       callq   0xffffffff821350d0
> >    94.76 :   ffffffff810511f0:       decl    %gs:0x7efe2d51(%rip)       # 33f48 <pcpu_hot+0x8>
> >     0.00 :   ffffffff810511f7:       je      0xffffffff810511fe
> >     0.00 :   ffffffff810511f9:       jmp     0xffffffff82153320
> >     0.00 :   ffffffff810511fe:       callq   0xffffffff82153990
> >     0.00 :   ffffffff81051203:       jmp     0xffffffff82153320
> > root@x1:~# perf annotate --group --stdio sched_clock
> > root@x1:~# perf annotate --group --stdio2 sched_clock
> > root@x1:~# perf annotate --group sched_clock
> > root@x1:~#
> 
> Oh ok, it was not enough.  It should call evsel__output_resort() after
> hists__match() and hists__link().  Use this instead.

Ok, this works:

Before this patch:

root@x1:~# perf annotate --stdio sched_clock
 Percent |      Source code & Disassembly of vmlinux for cpu_atom/mem-stores/P (147 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------------
         : 0                0xffffffff810511e0 <sched_clock>:
    0.00 :   ffffffff810511e0:       endbr64
    5.11 :   ffffffff810511e4:       incl    %gs:0x7efe2d5d(%rip)       # 33f48 <pcpu_hot+0x8>
    0.13 :   ffffffff810511eb:       callq   0xffffffff821350d0
   94.76 :   ffffffff810511f0:       decl    %gs:0x7efe2d51(%rip)       # 33f48 <pcpu_hot+0x8>
    0.00 :   ffffffff810511f7:       je      0xffffffff810511fe
    0.00 :   ffffffff810511f9:       jmp     0xffffffff82153320
    0.00 :   ffffffff810511fe:       callq   0xffffffff82153990
    0.00 :   ffffffff81051203:       jmp     0xffffffff82153320
root@x1:~# perf annotate --group --stdio sched_clock
root@x1:~#

After:

root@x1:~# perf annotate --group --stdio sched_clock
 Percent                 |      Source code & Disassembly of vmlinux for cpu_atom/mem-loads,ldlat=30/P, cpu_atom/mem-stores/P, dummy:u (0 samples, percent: local period)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                         : 0                0xffffffff810511e0 <sched_clock>:
    0.00    0.00    0.00 :   ffffffff810511e0:       endbr64
    0.00    5.11    0.00 :   ffffffff810511e4:       incl    %gs:0x7efe2d5d(%rip)       # 33f48 <pcpu_hot+0x8>
    0.00    0.13    0.00 :   ffffffff810511eb:       callq   0xffffffff821350d0
    0.00   94.76    0.00 :   ffffffff810511f0:       decl    %gs:0x7efe2d51(%rip)       # 33f48 <pcpu_hot+0x8>
    0.00    0.00    0.00 :   ffffffff810511f7:       je      0xffffffff810511fe
    0.00    0.00    0.00 :   ffffffff810511f9:       jmp     0xffffffff82153320
    0.00    0.00    0.00 :   ffffffff810511fe:       callq   0xffffffff82153990
    0.00    0.00    0.00 :   ffffffff81051203:       jmp     0xffffffff82153320
root@x1:~#

One example with samples for the first two events:

root@x1:~# perf annotate --group --stdio2
Samples: 2K of events 'cpu_atom/mem-loads,ldlat=30/P, cpu_atom/mem-stores/P, dummy:u', 4000 Hz, Event count (approx.): 22892183, [percent: local period]
cgroup_rstat_updated() /usr/lib/debug/lib/modules/6.8.11-200.fc39.x86_64/vmlinux
Percent                       0xffffffff8124e080 <cgroup_rstat_updated>:
   0.00    0.24    0.00         endbr64                         
                              → callq   __fentry__              
   0.00   99.76    0.00         pushq   %r15                    
                                movq    $0x251d4,%rcx           
                                pushq   %r14                    
                                movq    %rdi,%r14               
                                pushq   %r13                    
                                movslq  %esi,%r13               
                                pushq   %r12                    
                                pushq   %rbp                    
                                pushq   %rbx                    
                                subq    $0x10,%rsp              
                                cmpq    $0x2000,%r13            
                              ↓ jae     17f                     
                          31:   movq    0x3d0(%r14),%rbx        
                                movq    -0x7d3fb360(, %r13, 8),%r12
                                cmpq    $0x2000,%r13            
                              ↓ jae     19b                     
  25.00    0.00    0.00   4d:   cmpq    $0,0x88(%r12, %rbx)     
                              ↓ je      6b                      
                                addq    $0x10,%rsp              
                                popq    %rbx                    
                                popq    %rbp                    
                                popq    %r12                    
  75.00    0.00    0.00         popq    %r13                    
                                popq    %r14                    
                                popq    %r15                    
                              → jmp     __x86_return_thunk      
<SNIP>

And then skipping "empty" events:

root@x1:~# perf annotate --group --skip-empty --stdio2 cgroup_rstat_updated | head -35
Samples: 4  of events 'cpu_atom/mem-loads,ldlat=30/P, cpu_atom/mem-stores/P', 4000 Hz, Event count (approx.): 31851, [percent: local period]
cgroup_rstat_updated() /usr/lib/debug/lib/modules/6.8.11-200.fc39.x86_64/vmlinux
Percent               0xffffffff8124e080 <cgroup_rstat_updated>:
   0.00    0.24         endbr64                 
                      → callq   __fentry__      
   0.00   99.76         pushq   %r15            
                        movq    $0x251d4,%rcx   
                        pushq   %r14            
                        movq    %rdi,%r14       
                        pushq   %r13            
                        movslq  %esi,%r13       
                        pushq   %r12            
                        pushq   %rbp            
                        pushq   %rbx            
                        subq    $0x10,%rsp      
                        cmpq    $0x2000,%r13    
                      ↓ jae     17f             
                  31:   movq    0x3d0(%r14),%rbx
                        movq    -0x7d3fb360(, %r13, 8),%r12
                        cmpq    $0x2000,%r13    
                      ↓ jae     19b             
  25.00    0.00   4d:   cmpq    $0,0x88(%r12, %rbx)
                      ↓ je      6b              
                        addq    $0x10,%rsp      
                        popq    %rbx            
                        popq    %rbp            
                        popq    %r12            
  75.00    0.00         popq    %r13            
                        popq    %r14            
                        popq    %r15            
                      → jmp     __x86_return_thunk
                  6b:   addq    %r12,%rcx       
                        movq    %rcx,%rdi       
                        movq    %rcx,(%rsp)     
                      → callq   *ffffffff82151500
root@x1:~#

So, I haven't done further analysis but I think this is a separate
issue, right?

Thanks for the fix!

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
