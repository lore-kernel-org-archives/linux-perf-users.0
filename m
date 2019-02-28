From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tools lib traceevent: Fix buffer overflow in arg_eval
Date: Wed, 27 Feb 2019 22:12:50 -0500
Message-ID: <20190227221250.74996869@vmware.local.home>
References: <20190228015532.8941-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228015532.8941-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, linux-trace-devel@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Michael Sartain <mikesart@fastmail.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, 27 Feb 2019 17:55:32 -0800
Tony Jones <tonyj@suse.de> wrote:

> Fix buffer overflow observed when running perf test.
> 
> The overflow is when trying to evaluate "1ULL << (64 - 1)" which
> is resulting in -9223372036854775808 which overflows the 20 character
> buffer.
> 
> If is possible this bug has been reported before but I still don't
> see any fix checked in:
> 
> See: https://www.spinics.net/lists/linux-perf-users/msg07714.html
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Tony Jones <tonyj@suse.de>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I have to say I've let this slide and it is not the first time a patch
went out with this fix. But this one has the correct fix because we
should use a buffer with a multiple of 4. Anyway, Tony I believe was
the first to report this anyway.

For reference we have:

I first heard about Tony's complaint on a post to linux-perf-users on Jan 18.

But then we had after that:

 Michael Sartain reported it on 1/24 (and fixed by Tzvetomir)
 https://lore.kernel.org/linux-trace-devel/20190125102014.19600-1-tstoyanov@vmware.com/
 
It was later fixed again by Mathias Krause
 https://lore.kernel.org/linux-trace-devel/20190223122404.21137-1-minipli@googlemail.com/

But since Tony was first to report it, and we discussed that it should
be 24 bytes, I would say this is the patch to take.

Again, sorry for not getting this acknowledged earlier and everyone doing
the same thing multiple times. :-/

Arnaldo, please take this patch. But also add:

Reported-by: Michael Sartain <mikesart@fastmail.com>
Reported-by: Mathias Krause <minipli@googlemail.com>

Thanks,

-- Steve


> ---
>  tools/lib/traceevent/event-parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c
> b/tools/lib/traceevent/event-parse.c index abd4fa5d3088..87494c7c619d
> 100644 --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -2457,7 +2457,7 @@ static int arg_num_eval(struct tep_print_arg
> *arg, long long *val) static char *arg_eval (struct tep_print_arg
> *arg) {
>  	long long val;
> -	static char buf[20];
> +	static char buf[24];
>  
>  	switch (arg->type) {
>  	case TEP_PRINT_ATOM:
