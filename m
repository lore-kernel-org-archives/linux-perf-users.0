From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] tracing: detect the string termination character
 when parsing user input string
Date: Tue, 9 Jan 2018 17:54:34 -0500
Message-ID: <20180109175434.77163e52@vmware.local.home>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
        <1515491748-25926-2-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752684AbeAIWyh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Jan 2018 17:54:37 -0500
In-Reply-To: <1515491748-25926-2-git-send-email-changbin.du@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: changbin.du@intel.com
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Tue,  9 Jan 2018 17:55:46 +0800
changbin.du@intel.com wrote:

> From: Changbin Du <changbin.du@intel.com>
> 
> The usersapce can give a '\0' terminated C string or even has '\0' at the
> middle of input buffer. We need handle both these two cases correctly.

What do you define as correctly. Because I'm not seeing it.

> 
> Before this change, trace_get_user() will return a parsed string "\0" in
> below case. It is not expected (expects it skip all inputs) and cause the
> caller failed.
> 
> open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
> write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)

That looks more like a feature and not a bug.

> 
> This patch try to make the parser '\0' aware to fix such issue.

Why?

> 
> Since the caller expects trace_get_user() to parse whole input buffer, so
> this patch treat '\0' as a separator as whitespace.

It looks more like we are trying to fix a userspace bug via the kernel.

I'm not liking this. So NACK.

-- Steve

> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  kernel/trace/trace.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2a8d8a2..18526a1 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1194,9 +1194,14 @@ void trace_parser_put(struct trace_parser *parser)
>  	parser->buffer = NULL;
>  }
>  
> +static inline bool is_space_or_zero(char ch)
> +{
> +	return isspace(ch) || !ch;
> +}
> +
>  /*
> - * trace_get_user - reads the user input string separated by  space
> - * (matched by isspace(ch))
> + * trace_get_user - reads the user input string separated by space or '\0'
> + * (matched by is_space_or_zero(ch))
>   *
>   * For each string found the 'struct trace_parser' is updated,
>   * and the function returns.
> @@ -1228,7 +1233,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  	 */
>  	if (!parser->cont) {
>  		/* skip white space */
> -		while (cnt && isspace(ch)) {
> +		while (cnt && is_space_or_zero(ch)) {
>  			ret = get_user(ch, ubuf++);
>  			if (ret)
>  				goto out;
> @@ -1237,7 +1242,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  		}
>  
>  		/* only spaces were written */
> -		if (isspace(ch)) {
> +		if (is_space_or_zero(ch)) {
>  			*ppos += read;
>  			ret = read;
>  			goto out;
> @@ -1247,7 +1252,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  	}
>  
>  	/* read the non-space input */
> -	while (cnt && !isspace(ch)) {
> +	while (cnt && !is_space_or_zero(ch)) {
>  		if (parser->idx < parser->size - 1)
>  			parser->buffer[parser->idx++] = ch;
>  		else {
> @@ -1262,7 +1267,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  	}
>  
>  	/* We either got finished input or we have to wait for another call. */
> -	if (isspace(ch)) {
> +	if (is_space_or_zero(ch)) {
>  		parser->buffer[parser->idx] = 0;
>  		parser->cont = false;
>  	} else if (parser->idx < parser->size - 1) {
