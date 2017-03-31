From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH v3] Allow user probes on versioned symbols
Date: Fri, 31 Mar 2017 14:38:11 -0500
Message-ID: <095e1578-81c6-c62a-007f-1238445406a1@us.ibm.com>
References: <e12df271-9336-28c0-7441-2c20c6824b86@us.ibm.com>
 <20170331173123.GA18286@kernel.org>
Reply-To: pc@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170331173123.GA18286@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On 03/31/2017 12:31 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 31, 2017 at 11:06:16AM -0500, Paul Clarke escreveu:
>> Symbol versioning, as in glibc, results in symbols being defined as:
>> <real symbol>@[@]<version>
>> (Note that "@@" identifies a default symbol, if the symbol name
>> is repeated.)
>>
>> perf is currently unable to deal with this, and is unable to create
>> user probes at such symbols:
>
> On top of what tree/branch should I try to apply this?

I worked from torvalds/linux.

> Trying on acme/perf/core:

Pardon my ignorance, but where can I find that tree?

> [acme@jouet linux]$ patch -p1 < /wb/1.patch
> patching file tools/perf/util/auxtrace.c
> Hunk #1 FAILED at 1875.
[...]

> Apart from that, you are not checking the return of strndup, that
> however unlikely, can fail, so must be checked.

It's in the middle of strcmp-type function, so all return values are valid.  Shall I emit a message and call exit()?

> On the style front you sometimes add a space after commas, sometimes
> not, please make sure you add one.

Ack.

> But apart from those problems, I think that one should be able to ask
> for a versioned symbol, to probe just apps using that specific version,

I agree, but wasn't trying to tackle that at the moment.  I can look into it, though.

> for instance, we should consider the whole name as two functions, which
> in fact, they are, no?

I'm not sure I understand what you mean here.  Do you mean we should set a probe at every version of a given symbol name?  For example, if there are symbols:
a@@V2
a@V1.1
a@V1

...for a request to set a probe at "a", we'd actually set a probe at all 3?

> Additionaly, I can't reproduce your problem here, on x86_64:

I just cloned from acme/linux, and will rebase to there, if that's the best tree.

PC
