Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EB9C636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212D8613D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbhGOT4C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345576AbhGOTyy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 15:54:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18E9A61073;
        Thu, 15 Jul 2021 19:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626378721;
        bh=XBqQm/qyQmEIVPgYlJirxh3AhpJzp/fXOspqXaszJhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWI4/VjdPWxyaFNDCvqb4MfF2OS84B/SJBa/xK4iSBX/iFYjosXhjhcDhxcftnLen
         VrT22NbJLEkf/GvaAvH7Uo1vvQPx85WmWwAX7Y4Wehgsba+aqfPQ1EwMOnjhkyEmLw
         XX3zGL4VvpUW/IegsjTAhqEM/17UZ+4F86s4dJ91p+94vPeqo4HWwbFG6+/osO/y5b
         vIPoWbEK0a6vbSeKp43lap1JDQ/j1r6067eAfMhQxj91l7f+E25k0Z1IDD5+DqQZc2
         GGmWRMo1giNIR8NPbEQKbB/RWrMWnCRgKoMIdj/D4VriDm5yANmFUjQ1oUpGyuXDbr
         ITF19iKvSQygA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96B4D403F2; Thu, 15 Jul 2021 16:51:58 -0300 (-03)
Date:   Thu, 15 Jul 2021 16:51:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Kan Liang <kan.liang@intel.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 03/20] perf test: session_topology: delete session->evlist
Message-ID: <YPCR3idcrZV0Zifh@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <822f741f06eb25250fb60686cf30a35f447e9e91.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822f741f06eb25250fb60686cf30a35f447e9e91.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:08PM +0200, Riccardo Mancini escreveu:
> ASan reports a memory leak related to session->evlist while running
> the perf test "41: Session topology".
> 
> When perf_data is in write mode, session->evlist is owned by the
> caller, which should also take care of deleting it.
> 
> This patch adds the missing evlist__delete.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/topology.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index ec4e3b21b8311f57..b5efe675b321746e 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -61,6 +61,7 @@ static int session_write_header(char *path)
>  	TEST_ASSERT_VAL("failed to write header",
>  			!perf_session__write_header(session, session->evlist, data.file.fd, true));
>  
> +	evlist__delete(session->evlist);
>  	perf_session__delete(session);
>  
>  	return 0;
> -- 
> 2.31.1
> 

-- 

- Arnaldo
