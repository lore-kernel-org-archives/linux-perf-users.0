From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2] perf report: distinguish between inliners in the same function
Date: Fri, 12 May 2017 07:55:13 -0700
Message-ID: <87a86igm5q.fsf@firstfloor.org>
References: <20170503213536.13905-1-milian.wolff@kdab.com>
        <20170510055352.GA2667@sejong> <1673560.Uk8cHjlLU8@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:23079 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932315AbdELOzP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 May 2017 10:55:15 -0400
In-Reply-To: <1673560.Uk8cHjlLU8@agathebauer> (Milian Wolff's message of "Fri,
        12 May 2017 12:37:01 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

Milian Wolff <milian.wolff@kdab.com> writes:
>
> I think I'm missing something, but isn't this what this function provides? The 
> function above is now being used by the match_chain_inliner function below. 
>
> Ah, or do you mean for code such as this:
>
> ~~~~~
> inline_func_1(); inline_func_2();

This could be handled by looking at columns or discriminators too (which
some compilers generate in dwarf). srcline.c would need to be changed
to also call bfd_get_nearest_discriminator() and pass that extra
information everywhere.

-Andi
