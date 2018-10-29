From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf util: take pgoff into account when reporting elf to
 libdwfl
Date: Mon, 29 Oct 2018 14:40:14 -0300
Message-ID: <20181029174014.GG21857@kernel.org>
References: <20181029141644.3907-1-milian.wolff@kdab.com>
 <3361238.noN1Jb7VD2@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3361238.noN1Jb7VD2@milian-kdab2>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Oct 29, 2018 at 04:26:27PM +0100, Milian Wolff escreveu:
> On Monday, October 29, 2018 3:16:44 PM CET Milian Wolff wrote:
> > Libdwfl parses an ELF file itself and creates mappings for the
> > individual sections. Perf on the other hand sees raw mmap events which
> > represent individual sections. When we encounter an address pointing
> > into a mapping with pgoff != 0, we must take that into account and
> > report the file at the non-offset base address.
> > 
> > This fixes unwinding with libdwfl in some cases. E.g. for a file like:
> 
> <snip>
> 
> > Note that the backtrace is still stopping too early, when
> > compared to the nice results obtained via libunwind. It's
> > unclear so far what the reason for that is.
> 
> The remaining issue is due to a bug in elfutils:
> 
> https://sourceware.org/ml/elfutils-devel/2018-q4/msg00089.html
> 
> With both patches applied, libunwind and elfutils produce the same output for 
> the above scenario.

I'm updating the patch to remove:

"It's unclear so far what the reason for that is."

Adding:

"See https://sourceware.org/ml/elfutils-devel/2018-q4/msg00089.html for
a patch fixing that."

Ok? Or are you saying that that "unclear" part applies to both libunwind
and elfutils?

- Arnaldo
