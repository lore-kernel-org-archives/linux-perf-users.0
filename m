From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Wed, 29 Jan 2014 12:18:44 +0100
Message-ID: <20140129111844.GA1869@krava.brq.redhat.com>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51770 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbaA2LSr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Jan 2014 06:18:47 -0500
Content-Disposition: inline
In-Reply-To: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mauro Andreolini <mauro.andreolini@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Fri, Jan 17, 2014 at 11:21:23AM +0100, Mauro Andreolini wrote:
> Hi all,

hi

> 
> No kallsyms or vmlinux with build-id 4c6ab941f31dde04c2a481430218994849927c8d was found
> [ext4] with build id 4c6ab941f31dde04c2a481430218994849927c8d not found, continuing without symbols
> No kallsyms or vmlinux with build-id 21f163b0a8a8b924efdd173b8f83ad723d378958 was found
> [drm] with build id 21f163b0a8a8b924efdd173b8f83ad723d378958 not found, continuing without symbols
> No kallsyms or vmlinux with build-id d0bd7dd69886c2dccde18dee760b6d39cc0b5a55 was found[qxl] with build id d0bd7dd69886c2dccde18dee760b6d39cc0b5a55 not found, continuing without symbols
> No kallsyms or vmlinux with build-id 8d13e6f0c4d4f8b4628c8c4bd6c660b0a00576df was found[ttm] with build id 8d13e6f0c4d4f8b4628c8c4bd6c660b0a00576df not found, continuing without symbols

hum, do you have kernel-debuginfo* packages installed?


SNIP

> 
> Problem n.2: sometimes perf prints bogus callchains (in particular
> when the various printf() variants are involved).
> 
>                  |--1.46%-- 0xffffffffa048a275
>                  |          0xffffffffa048c110
>                  |          0xffffffffa04909e7
>                  |          |
>                  |          |--80.00%-- 0xffffffffa0490afa
>                  |          |          0xffffffffa048ee8b
>                  |          |          0xffffffffa048ba8f
>                  |          |          bit_bmove
>                  |          |          fbcon_redraw_blit.isra.22
>                  |          |          fbcon_scroll
>                  |          |          scrup
>                  |          |          lf
>                  |          |          do_con_trol
>                  |          |          do_con_write.part.18
>                  |          |          con_write
>                  |          |          do_output_char
>                  |          |          n_tty_write
>                  |          |          tty_write
>                  |          |          vfs_write
>                  |          |          sys_write
>                  |          |          system_call_fastpath
>                  |          |          __GI___libc_write
>                  |          |          |
>                  |          |          |--50.00%-- vfprintf
>                  |          |          |          0x0        <---HERE
>                  |          |          |
>                  |          |          |--25.00%-- main
>                  |          |          |          __libc_start_main
>                  |          |          |          _start
>                  |          |          |          0x0        <---HERE
>                  |          |          |
>                  |          |           --25.00%-- 0x7facc1df12a0 HERE

this one could be caused by:
http://marc.info/?l=linux-kernel&m=134934717011451&w=2
I never managed to push this change through.. need to revisit it ;-)

if you want to try, I rebased the patch and put it in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  branch perf/rsp_fix1

  commit:
  https://git.kernel.org/cgit/linux/kernel/git/jolsa/perf.git/commit/?h=perf/rsp_fix1&id=5eed39431f9b1e65e740a2e3e197c79f0a1bcf6b

it still fixies some of the backtraces for me


jirka
