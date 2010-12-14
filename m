From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH v3] perf tools: Add symfs option for off-box analysis
 using specified tree
Date: Tue, 14 Dec 2010 12:35:51 -0200
Message-ID: <20101214143551.GD13425@ghostprotocols.net>
References: <1291926427-28846-1-git-send-email-daahern@cisco.com>
 <20101214122428.GA13425@ghostprotocols.net>
 <20101214125245.GB13425@ghostprotocols.net>
 <4D077EDE.8090005@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50063 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab0LNOf5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Dec 2010 09:35:57 -0500
Content-Disposition: inline
In-Reply-To: <4D077EDE.8090005@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "David S. Ahern" <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Tue, Dec 14, 2010 at 07:27:42AM -0700, David S. Ahern escreveu:
> On 12/14/10 05:52, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Dec 14, 2010 at 10:24:28AM -0200, Arnaldo Carvalho de Melo escreveu:
> I was not aware of realpath. Simple change to symbol__init?

I made symbol__init use realpath to reduce the arg to --symfs.
 
> > [acme@mica linux]$ find /tmp/bla
> > /tmp/bla
> > /tmp/bla/lib64
> > /tmp/bla/lib64/libc-2.5.so
> > [acme@mica linux]$ perf report -v -g none --stdio --symfs /tmp/bla > /tmp/out
> > Looking at the vmlinux_path (3 entries long)
> > Failed to open [kernel.kallsyms], continuing without symbols
> > dso__synthesize_plt_symbols: problems reading /home/acme/bin/perf PLT info.
> > [acme@mica linux]$ cat /tmp/out

> strace -e trace=open /tmp/build-perf/perf report -v --symfs /tmp/f14-mnt
> -i /tmp/perf-cs.data

> does not show any attempts to open a file not starting with the symfs path.

Probably because all the files you need are in the directories you
passed to --symfs, remove one and it will leak.

Anyway, fixed in my perf/core branch, still not propagated from
master.k.o to git.k.o :-\

- Arnaldo
