From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf script: man page fix
Date: Fri, 13 Jan 2017 15:43:05 -0300
Message-ID: <20170113184305.GB32549@kernel.org>
References: <1c3f6e9cbe4a3c9e8b36aea8b0f71b2c48ad5bb5.1484319836.git.mpetlan@redhat.com>
 <728644547.14560155.1484320012612.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751033AbdAMSnN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Jan 2017 13:43:13 -0500
Content-Disposition: inline
In-Reply-To: <728644547.14560155.1484320012612.JavaMail.zimbra@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org

Em Fri, Jan 13, 2017 at 10:06:52AM -0500, Michael Petlan escreveu:
> The "--dump-raw-script" is not a valid option.

Thanks, and added these lines:

    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Fixes: 133dc4c39c57 ("perf: Rename 'perf trace' to 'perf script'")

- Arnaldo
 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/Documentation/perf-script.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 5dc5c6a..4ed5f23 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -36,7 +36,7 @@ There are several variants of perf script:
>  
>    'perf script report <script> [args]' to run and display the results
>    of <script>.  <script> is the name displayed in the output of 'perf
> -  trace --list' i.e. the actual script name minus any language
> +  script --list' i.e. the actual script name minus any language
>    extension.  The perf.data output from a previous run of 'perf script
>    record <script>' is used and should be present for this command to
>    succeed.  [args] refers to the (mainly optional) args expected by
> @@ -76,7 +76,7 @@ OPTIONS
>  	Any command you can specify in a shell.
>  
>  -D::
> ---dump-raw-script=::
> +--dump-raw-trace=::
>          Display verbose dump of the trace data.
>  
>  -L::
> -- 
> 1.8.3.1
