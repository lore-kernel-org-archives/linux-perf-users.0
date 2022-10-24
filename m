Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8DCC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 02:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJXC46 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 23 Oct 2022 22:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJXC4z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 23 Oct 2022 22:56:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DFD6DFA4
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Oct 2022 19:56:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id io19so2446687plb.8
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Oct 2022 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=52ptKGNfmbX1uxGEzkFghT6X0CkJCXi2HelvrGHJZz8=;
        b=V08yZy6ZSIWOZvpu7vA1gigZ6PLtaHu/HuetAAtfaFoZfLi6t2V8V9XtGAIZwDr4Xr
         SC+MrVF55dt06BYZBIRQm0WKQLvg42w2a+T/f90usUkI6RR5wNejuLdMEslw2N5FezIV
         +eJzdxzcVkAElEnDI2GUIiw3BG80mxZiItvTfg3qloxxzk0wvJdtqlWWFb/3ll7LLvK1
         +ueB6sJ/b1mEa6DCAD01QRXDmr7j/tnD8Sgzx0x4vE7ebvwg5ubelaZQ9OVRCTTn+fBL
         wkwZXPKmcbBJINJB+QsiN/3BHIIV5SoWyL6MiW4/L5L7DlRJuA+q8gKKHn02VomDMici
         oGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52ptKGNfmbX1uxGEzkFghT6X0CkJCXi2HelvrGHJZz8=;
        b=Vi3G+gA9pCpPmhbhmQTkbCF48O2iAytULp06DK6GQI3FxyWVF4Sj0RV9HahaXX+jKX
         9JZ4HTBtoNk8FGZIknypKyDlrBHphuhaZXMBGkoW4bRYSanrp3ICYhOfwj0eGLRtOUKb
         7F84SwrDcghQ9UDvtkSuKWJiTtsNgCeRNEJd4c8Wj4NiRII9XebhcZJHHxMJfVwsXF8o
         SV7c90ckGR2r1DTB47r5JItFSk4hQwiqvPU7pXFDkJeU8EV0ZURV3URek7cPXVD3OypX
         /zjpblEHCxVzhYpIBb5NR3Kq5X2Q+MUdDZnlMhhuViJBgwelTSo2VPoY1K7iBNEuLxAV
         Wyrg==
X-Gm-Message-State: ACrzQf3qmnmDyI/5+yQWA0V4tSSt5Su+Qgy+ip+1BuX4jbV/z5tbRhlD
        YD03LbNpuzcCEN81Xa3zVehnVg==
X-Google-Smtp-Source: AMsMyM789SjV3Fu+gB5BvwSY+hoNB31thUybkYF8PeUuvZNTIyA6zjiBdg2M9ZOs92MHOQ5hbEHs6g==
X-Received: by 2002:a17:90a:4bca:b0:212:e3df:abfc with SMTP id u10-20020a17090a4bca00b00212e3dfabfcmr11279253pjl.242.1666580214253;
        Sun, 23 Oct 2022 19:56:54 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b0017eb2d62bbesm3478361ple.99.2022.10.23.19.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 19:56:53 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:56:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Greg Thelen <gthelen@google.com>,
        Anand K Mistry <amistry@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf record: Fix event fd races
Message-ID: <Y1X+7FCemionnepj@leoy-huanghe.lan>
References: <20221024011024.462518-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024011024.462518-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Sun, Oct 23, 2022 at 06:10:24PM -0700, Ian Rogers wrote:
> The write call may set errno which is problematic if occurring in a
> function also setting errno. Save and restore errno around the write
> call.
> 
> done_fd may be used after close, clear it as part of the close and
> check its validity in the signal handler.
> 
> Suggested-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c | 41 ++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 52d254b1530c..e128b855ddde 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -649,7 +649,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  static volatile int signr = -1;
>  static volatile int child_finished;
>  #ifdef HAVE_EVENTFD_SUPPORT
> -static int done_fd = -1;
> +static volatile int done_fd = -1;

Here is a bit suspecious for adding volatile qualifier.  See the
document: process/volatile-considered-harmful.rst.

I know the document is mainly for kernel programming, but seems to me
it's also valid for C programming in userspace.

I not sure what's the purpose for adding volatile for done_fd, if we
really have concern for reading any stale value for done_fd, should we
use WRITE_ONCE/READ_ONCE?

The rest changes look good to me.

Thanks,
Leo

>  #endif
>  
>  static void sig_handler(int sig)
> @@ -661,19 +661,24 @@ static void sig_handler(int sig)
>  
>  	done = 1;
>  #ifdef HAVE_EVENTFD_SUPPORT
> -{
> -	u64 tmp = 1;
> -	/*
> -	 * It is possible for this signal handler to run after done is checked
> -	 * in the main loop, but before the perf counter fds are polled. If this
> -	 * happens, the poll() will continue to wait even though done is set,
> -	 * and will only break out if either another signal is received, or the
> -	 * counters are ready for read. To ensure the poll() doesn't sleep when
> -	 * done is set, use an eventfd (done_fd) to wake up the poll().
> -	 */
> -	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> -		pr_err("failed to signal wakeup fd, error: %m\n");
> -}
> +	if (done_fd >= 0) {
> +		u64 tmp = 1;
> +		int orig_errno = errno;
> +
> +		/*
> +		 * It is possible for this signal handler to run after done is
> +		 * checked in the main loop, but before the perf counter fds are
> +		 * polled. If this happens, the poll() will continue to wait
> +		 * even though done is set, and will only break out if either
> +		 * another signal is received, or the counters are ready for
> +		 * read. To ensure the poll() doesn't sleep when done is set,
> +		 * use an eventfd (done_fd) to wake up the poll().
> +		 */
> +		if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> +			pr_err("failed to signal wakeup fd, error: %m\n");
> +
> +		errno = orig_errno;
> +	}
>  #endif // HAVE_EVENTFD_SUPPORT
>  }
>  
> @@ -2834,8 +2839,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  
>  out_delete_session:
>  #ifdef HAVE_EVENTFD_SUPPORT
> -	if (done_fd >= 0)
> -		close(done_fd);
> +	if (done_fd >= 0) {
> +		fd = done_fd;
> +		done_fd = -1;
> +
> +		close(fd);
> +	}
>  #endif
>  	zstd_fini(&session->zstd_data);
>  	perf_session__delete(session);
> -- 
> 2.38.0.135.g90850a2211-goog
> 
