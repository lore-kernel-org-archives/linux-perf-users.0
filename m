From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH 1/4] perf, x86: Allow multiple stacks
Date: Mon, 7 May 2012 16:46:45 -0700
Message-ID: <4FA85EE5.9030102@fb.com>
References: <1334961696-19580-1-git-send-email-asharma@fb.com> <1334961696-19580-2-git-send-email-asharma@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33828 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757349Ab2EGXrN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 May 2012 19:47:13 -0400
In-Reply-To: <1334961696-19580-2-git-send-email-asharma@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

On 4/20/12 3:41 PM, Arun Sharma wrote:
> Without this patch, applications with two different stack
> regions (eg: native stack vs JIT stack) get truncated
> callchains even when RBP chaining is present. GDB shows proper
> stack traces and the frame pointer chaining is intact.
>
> This patch disables the (fp<  RSP) check, hoping that other checks
> in the code save the day for us. In our limited testing, this
> didn't seem to break anything.
>
> In the long term, we could potentially have userspace advise
> the kernel on the range of valid stack addresses, so we don't
> spend a lot of time unwinding from bogus addresses.

Ingo/Peter: Did you get a chance to look at this patch series (Support 
multiple stacks v3)?

  -Arun
