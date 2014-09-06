From: Milian Wolff <mail@milianw.de>
Subject: Re: [PATCH] perf tools : adds support for native scripting
Date: Sat, 06 Sep 2014 17:06:07 +0200
Message-ID: <141010294.FOuOkOaNci@minime>
References: <1400727182.19852.0.camel@desktop> <871tvmqco4.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871tvmqco4.fsf@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Adrien BAK <adrien.bak@numscale.com>, a.p.zijlstra@chello.nl, paulus@samba.org, mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Thursday 22 May 2014 04:24:11 Andi Kleen wrote:
> Adrien BAK <adrien.bak@numscale.com> writes:
> > As it is perf-script allows one to use perl or python scripts to parse
> > perf events.
> > The following proposal aimed to introduce support of .so files as scripts.
> > This support allows for better performance when parsing perf's data
> > files and a complete access to the raw data.
> 
> You'll at least need some documentation how to use it.

Ping, any news on this feature? I'd welcome the ability to create native 
scripts to write efficient tools based on perf.

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
