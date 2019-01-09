From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [GIT PULL 00/16] perf/core fixes and improvements
Date: Wed, 9 Jan 2019 10:04:44 -0300
Message-ID: <20190109130444.GA25192@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
 <20190109070528.GB29753@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109070528.GB29753@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Jan 09, 2019 at 08:05:28AM +0100, Ingo Molnar escreveu:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >   . Update linux/{fs,vhost}.h, grab a copy o linux/mount.h, where the
> >     MS_ mount flags were moved.
 
> We still have two UAPI warnings in the latest tip:perf/urgent - the patch 
> below fixes them, at least on x86.
 
> The if_link.h looks trivial enough - but I'm unsure about the powerpc one 
> and didn't test it on PowerPC.

The PPC one I already pinged Ravi Bangoria, as it is used to generate
the syscall table for 'perf trace', now it works like x86 and s390, he
said he was a bit busy but will tackle this.

The if_link one I just updated in my local branch, will go in the next
round.

Thanks,

- Arnaldo
