From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
Date: Tue, 28 Aug 2018 11:10:47 -0300
Message-ID: <20180828141047.GG22309@kernel.org>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
 <20180823141219.GA4766@kernel.org>
 <64684c59-492c-3310-a5d2-14b467602acc@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64684c59-492c-3310-a5d2-14b467602acc@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc: linux-perf-users@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Aug 27, 2018 at 11:06:21AM +0200, Martin Liška escreveu:
> On 08/23/2018 04:12 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Aug 23, 2018 at 02:29:34PM +0200, Martin Liška escreveu:
> >> The patch changes interpretation of:
> >> callq  *0x8(%rbx)
> >>
> >> from:
> >>   0.26 │     → callq  *8
> >> to:
> >>   0.26 │     → callq  *0x8(%rbx)
> >>
> >> in this can an address is followed by a register, thus
> >> one can't parse only address.
> > 
> > Please mention one or two functions where such sequence appears, so that
> > others can reproduce your before/after more quickly,
> 
> Sure, there's self-contained example on can compile (-O2) and test.
> It's following call in test function:
> 
> test:
> .LFB1:
>         .cfi_startproc
>         movq    %rdi, %rax
>         subq    $8, %rsp
>         .cfi_def_cfa_offset 16
>         movq    %rsi, %rdi
>         movq    %rdx, %rsi
>         call    *8(%rax) <---- here
>         cmpl    $1, %eax
>         adcl    $-1, %eax
>         addq    $8, %rsp
>         .cfi_def_cfa_offset 8
>         ret
>         .cfi_endproc

Here I'm getting:

Samples: 2K of event 'cycles:uppp', 4000 Hz, Event count (approx.): 1808551484
test  /home/acme/c/perf-callq [Percent: local period]
  0.17 │      mov    %rdx,-0x28(%rbp)
  0.58 │      mov    -0x18(%rbp),%rax
  7.90 │      mov    0x8(%rax),%rax
  8.67 │      mov    -0x28(%rbp),%rcx
       │      mov    -0x20(%rbp),%rdx
  0.08 │      mov    %rcx,%rsi
  6.28 │      mov    %rdx,%rdi
 10.50 │    → callq  *%rax
  1.67 │      mov    %eax,-0x4(%rbp)
 11.95 │      cmpl   $0x0,-0x4(%rbp)
  8.14 │    ↓ je     3d
       │      mov    -0x4(%rbp),%eax
       │      sub    $0x1,%eax
       │    ↓ jmp    42
       │3d:   mov    $0x0,%eax
  7.84 │42:   leaveq
       │    ← retq

Without the patch, will check if something changes with it.

- Arnaldo
