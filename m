From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 05/13] tools headers uapi: Sync linux/fcntl.h to get the
 F_SEAL_FUTURE_WRITE addition
Date: Fri, 29 Mar 2019 10:24:26 -0400
Message-ID: <20190329142426.GA122290@google.com>
References: <20190329133801.21004-1-acme@kernel.org>
 <20190329133801.21004-6-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329133801.21004-6-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 29, 2019 at 10:37:53AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get the changes in:
> 
>   ab3948f58ff8 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd")
> 
> And silence this perf build warning:
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/fcntl.h' differs from latest version at 'include/uapi/linux/fcntl.h'
>   diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-lvfx5cgf0xzmdi9mcjva1ttl@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!

 - Joel

> ---
>  tools/include/uapi/linux/fcntl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
> index 6448cdd9a350..a2f8658f1c55 100644
> --- a/tools/include/uapi/linux/fcntl.h
> +++ b/tools/include/uapi/linux/fcntl.h
> @@ -41,6 +41,7 @@
>  #define F_SEAL_SHRINK	0x0002	/* prevent file from shrinking */
>  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
> +#define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
>  /* (1U << 31) is reserved for signed error codes */
>  
>  /*
> -- 
> 2.20.1
> 
