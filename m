From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf crash at util/symbol-elf.c:154
Date: Sun, 2 Mar 2014 14:34:31 +0100
Message-ID: <20140302133431.GA1655@krava.brq.redhat.com>
References: <CAAvaZB0fFuD=Lb3R9eu4F=riedZS0JtQ_Z6zOtw8RYBNTsWqnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64137 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbaCBNef (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 2 Mar 2014 08:34:35 -0500
Content-Disposition: inline
In-Reply-To: <CAAvaZB0fFuD=Lb3R9eu4F=riedZS0JtQ_Z6zOtw8RYBNTsWqnQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Albert Strasheim <albert@cloudflare.com>
Cc: linux-perf-users@vger.kernel.org

On Wed, Feb 26, 2014 at 12:24:07PM -0800, Albert Strasheim wrote:
> Hello all

SNIP

> <commands+264>, argc=argc@entry=3, argv=argv@entry=0x7fffffffdce0) at
> perf.c:319
> #13 0x0000000000419230 in handle_internal_command
> (argv=0x7fffffffdce0, argc=3) at perf.c:376
> #14 run_argv (argv=0x7fffffffdae0, argcp=0x7fffffffdaec) at perf.c:420
> #15 main (argc=3, argv=0x7fffffffdce0) at perf.c:529
> 
> The Python build is available here:
> 
> https://docs.google.com/file/d/0B0b-iwt-kSG2Z2dOYWVDYVEyZ2c/edit
> 
> To reproduce the crash, all you need is
> 
> ./python -c 'while True: continue'
> 
> perf top -p `pidof python`
> 
> Any help would be appreciated. Thanks in advance.

hi,
thanks for reporting, I sent out patch (and CCed you)
http://marc.info/?l=linux-kernel&m=139376715924685&w=2

jirka
