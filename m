From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/2] perf test: Adding an entry for the
 perftool-testsuite
Date: Mon, 07 Dec 2015 12:45:55 +0100
Message-ID: <1449488755.24573.190.camel@redhat.com>
References: <1449249064.24573.184.camel@redhat.com>
	 <20151206155317.GB11852@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33242 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658AbbLGLp5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Dec 2015 06:45:57 -0500
In-Reply-To: <20151206155317.GB11852@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, =?UTF-8?Q?=E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3?= / =?UTF-8?Q?HIRAMATU=EF=BC=8CMASAMI?= <masami.hiramatsu.pt@hitachi.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Sun, 2015-12-06 at 16:53 +0100, Jiri Olsa wrote:
> I can't get this applied on latest acme's perf/core
> 


Hi, I send patches that apply to latest Linus' tree:

https://github.com/torvalds/linux.git

Should I use some different tree? Arnaldo's? What is the URL
of the proper tree I should send patches against?

Thanks.
Michael

> [jolsa@krava perf]$ git am /tmp/w/
> Applying: perf test: Adding an entry for the perftool-testsuite
> error: patch failed: tools/perf/tests/Build:34
> error: tools/perf/tests/Build: patch does not apply
> error: patch failed: tools/perf/tests/builtin-test.c:170
> error: tools/perf/tests/builtin-test.c: patch does not apply
> error: patch failed: tools/perf/tests/tests.h:68
> error: tools/perf/tests/tests.h: patch does not apply
> Patch failed at 0001 perf test: Adding an entry for the perftool-testsuite
> The copy of the patch that failed is found in:
>    /home/jolsa/kernel/linux-perf/.git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> 
> jirka
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
