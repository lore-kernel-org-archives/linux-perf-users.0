From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf record: Fix failed memory allocation for
 get_cpuid_str
Date: Wed, 17 Jan 2018 10:31:56 -0300
Message-ID: <20180117133156.GG30880@kernel.org>
References: <20180117131611.34319-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180117131611.34319-1-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Jan 17, 2018 at 02:16:11PM +0100, Thomas Richter escreveu:
> In x86 architecture dependend part function
> get_cpuid_str() mallocs a 128 byte buffer, but does not
> check if the memory allocation succeeded or not.
> When the memory allocation fails, function __get_cpuid()
> is called with first parameter being a NULL pointer.
> However this function references its first parameter
> and operates on a NULL pointer which might cause core
> dumps.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/x86/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
> index 33027c5e6f92..c6b5204e0280 100644
> --- a/tools/perf/arch/x86/util/header.c
> +++ b/tools/perf/arch/x86/util/header.c
> @@ -70,7 +70,7 @@ get_cpuid_str(void)
>  {
>  	char *buf = malloc(128);
>  
> -	if (__get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
> +	if (buf && __get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
>  		free(buf);
>  		return NULL;
>  	}
> -- 
> 2.13.4
