From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v3 02/11] perf tools script: Support insn output for
 normal samples
Date: Mon, 4 Mar 2019 10:14:48 -0800
Message-ID: <20190304181448.bnuwf2gvtxdgs7tg@two.firstfloor.org>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-3-andi@firstfloor.org>
 <20190304144832.GI30476@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190304144832.GI30476@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

> > +	uname(&uts);
> > +	if (!strcmp(uts.machine, session->header.env.arch) ||
> > +		(!strcmp(uts.machine, "x86_64") &&
> > +		 !strcmp(session->header.env.arch, "i386")))
> 
> why is this check and native_arch bool necessary?
> i386 data will be overed by arch/x86

This is so that e.g. if someone displays an ARM perf.data
on x86 it won't try to decode the ARM instructions as x86
instructions.

It also assumes that noone parses 64bit x86 on 32bit,
but I guess that's ok.

-Andi
