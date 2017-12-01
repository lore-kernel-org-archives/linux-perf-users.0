From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf s390: always build with -fPIC
Date: Fri, 1 Dec 2017 11:17:09 +0900
Message-ID: <20171201021709.GB30867@sejong>
References: <1512031765-9382-1-git-send-email-brueckner@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:35288 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdLACRL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Nov 2017 21:17:11 -0500
Content-Disposition: inline
In-Reply-To: <1512031765-9382-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Linux perf users list <linux-perf-users@vger.kernel.org>, Linux s390 list <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, jonathan.hermann@de.ibm.com, kernel-team@lge.com, jolsa@kernel.org

(+ Jiri)

Hello,

On Thu, Nov 30, 2017 at 09:49:25AM +0100, Hendrik Brueckner wrote:
> On s390, object files must be compiled with position-indepedent code
> in order to be incrementally linked or linked to shared libraries.
> Therefore, add -fPIC to the CFLAGS for s390 to ensure each object
> file is built properly.

Could you please tell me what was the actual problem?  I guess this is
somewhat related to the Jiri's Fedora build fix.

Thanks,
Namhyung


> 
> Reported-by: Jonathan Hermann <jonathan.hermann@de.ibm.com>
> Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/Makefile.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ed65e82..0833d9f 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -55,6 +55,7 @@ endif
>  
>  ifeq ($(ARCH),s390)
>    NO_PERF_REGS := 0
> +  CFLAGS += -fPIC
>  endif
>  
>  ifeq ($(NO_PERF_REGS),0)
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
