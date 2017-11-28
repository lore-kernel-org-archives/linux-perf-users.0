From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Question to perf annotate handling mov ...(%rip) instructions
Date: Tue, 28 Nov 2017 11:50:30 -0300
Message-ID: <20171128145030.GG3298@kernel.org>
References: <f241fe0b-7a3f-cb6a-51ee-4833bce81e70@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752233AbdK1Oud (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 09:50:33 -0500
Content-Disposition: inline
In-Reply-To: <f241fe0b-7a3f-cb6a-51ee-4833bce81e70@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Tue, Nov 28, 2017 at 11:42:16AM +0100, Thomas-Mich Richter escreveu:
> I am confused by perf annotate internals.
> 
> Perf annotate examines a perf.data file and shows disassembler output.
> However the output differs depending on the output option specified:

Well, we started with the --stdio code, and then, for the TUI, went on
improving to be able to navigate, etc.

The --stdio code was then left for us to compare outputs and see if some
regression was being added.

I think that the right thing is to have the --stdio use what is in
--tui, modulo the interactive bits.

The --tui has knobs to disable its beautifications, see H in the tui
annotation browser to see the toggle hotkeys.
 
> ‑‑stdio: Output to stdout, also selected implicitly when output piped to another
> process or redirected to a file. The function call sequence is 
> 
> symbol__tty_annotate() –> symbol__annotate_printf() –> disasm_line__print().
> 
> This output style does not annotate the branch instructions nor does it use special 
> printing functions in the util/annotate.c, for example mov__scnprintf().
> 
> ‑‑tui: Default. there are annotations to augment branches, jumps, fct returns 
> with arrows for interactive usage. The function call stack starts with 
> symbol__tui_annotate(). 
> There is also special treatment for the Intel mov instructions of the form:

The cases where intel has special treatment are bugs, should be moved to
arch specific callbacks.
 
> 00000000000060b0 <_init@@Base>: 
> .... 
> 60b4:       48 8b 05 35 cd 22 00    mov 0x22cd35(%rip),%rax   # 232df0 <__gmon_start__>     
> 
> Commit 6de783b6f50f7f1db18a3fda0aa34b2e84b5771d ("perf annotate: Resolve symbols 
> using objdump comment") added this support.
> 
> Special code for Intel platform handles the mov  at address 60b4: 
> This is dynamic linkage against the PLT. Function mov__parse() is always called 
> to parse the objdump comment following the '#' character. 
> However the function mov__scnprintf() to replace the text '0x22cd35(%rip)' by the 
> target function name __gmon_start__ is only called in tui mode and not in stdio mode.
> 
> Now to the confusion:
> Function mov__parse() calls comment__symbol() which contains:
> 
>    static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
>    {
>         char *endptr, *name, *t;
> 
>         if (strstr(raw, "(%rip)") == NULL)
>                 return 0;
> 
> This is architecture specific and does not work for non-Intel platforms.
> 
> I would like to fix perf annotate for s390x and above move instruction on s390x
> is
>      
>     655a:       c0 10 00 01 9c eb       larl    %r1,39f30 <__gmon_start__>
> 
> There is a need to handle PLT resolution in an architecture independent way.
> 
> Ideas and suggestions?

Some historical background there, busy now, but you seem to be on the
right track and IIRC you already sent a patch for this, right? I'll try
to look at it.

Jiri may as well, since he worked a lot recently in this codebase, to
refactor it some more to make it useful for annotating python code, perl
next, other scripted languages should follow too.

- Arnaldo
