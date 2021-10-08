Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD3C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 18:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA74360F90
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhJHSSc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240433AbhJHSSW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 14:18:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89E8860F9D;
        Fri,  8 Oct 2021 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633716986;
        bh=RBdgHRPobT+q/p6q5rP1sGlm6ImbduyR3N9DAmiw4zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5oD1z3uANS36vuHpUyTLWe/ZKbVJT7AFsa/Em8DGDufs7xvtRoTLLfl2Q74YeNP9
         mA7ZkqfQnhhLU+Wt5bIV7nRSp1/9TTjUGLYRVdjPWW5CjAtn4npsyrFn2DQ1sw8gDv
         EGVcqvV2ViEG5tFITgtDTQxlgUslVnjxAGc3MOcdZYNjxzEyM158xy4MQAk8/3oLvu
         efVooiYD6DkacWlDNir9izZtT9Z+axk2EwyYNhqFm9ESCErwx98Cr46joIURpIBYH0
         eH3UncvxP1rpHp0vDoT/ClI4QvFwF4Ao/0TpytwaLBEKy9HIc3UEtrioQK331+ERU5
         TsBLZexq7IgzQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0FAF3410A1; Fri,  8 Oct 2021 15:16:23 -0300 (-03)
Date:   Fri, 8 Oct 2021 15:16:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] perf daemon: Remove a duplicate #include
Message-ID: <YWCK9mHs9vTwynfo@kernel.org>
References: <20211006062235.6364-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006062235.6364-1-guozhengkui@vivo.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Oct 06, 2021 at 02:22:34PM +0800, Guo Zhengkui escreveu:
> There is a "#include <sys/file.h>" in line 10, so remove a duplicate
> one in line 1124.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  tools/perf/builtin-daemon.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index c13201fb09c3..6cb3f6cc36d0 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -1121,8 +1121,6 @@ static int setup_config(struct daemon *daemon)
>  #ifndef F_TLOCK
>  #define F_TLOCK 2
>  
> -#include <sys/file.h>
> -
>  static int lockf(int fd, int cmd, off_t len)
>  {
>  	if (cmd != F_TLOCK || len != 0)
> -- 
> 2.20.1

-- 

- Arnaldo
