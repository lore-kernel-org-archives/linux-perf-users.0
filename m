From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 05/10] tools headers: Synchoronize x86 features UAPI
 headers
Date: Tue, 6 Feb 2018 11:54:45 +0100
Message-ID: <20180206105445.x3gqpaa3rwbnhugo@gmail.com>
References: <20180205195620.9010-1-acme@kernel.org>
 <20180205195620.9010-6-acme@kernel.org>
 <1517911838.31953.208.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46606 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeBFKyt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Feb 2018 05:54:49 -0500
Content-Disposition: inline
In-Reply-To: <1517911838.31953.208.camel@infradead.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Ahern <dsahern@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>


* David Woodhouse <dwmw2@infradead.org> wrote:

> 
> 
> On Mon, 2018-02-05 at 16:56 -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > None will entail changes in the tools/perf/, synchronizing to elliminate
> > these perf build warnings:
> > 
> >   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
> >   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
> >   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> 
> Ick. Have we considered just using a symlink? Why have copies of the
> same header file in different places in the tree, and tooling to
> complain i̶f̶when they get out of sync?

In the past we had incidents where kernel changes broke tooling and vice versa.

This is basically a soft-COW mechanism that decouples tooling source code from the 
kernel source code, while still having a technological mechanism in place that 
encourages the syncing of header files.

Thanks,

	Ingo
