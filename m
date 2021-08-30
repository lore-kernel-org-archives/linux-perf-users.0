Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96444C432BE
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2BF60F3A
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbhH3VaZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238487AbhH3VaW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Aug 2021 17:30:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC4DA60F6B;
        Mon, 30 Aug 2021 21:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630358968;
        bh=/ZzvcQQRcd4ZkBiyfo3gJZBP2yDFIC6sed0Nv3ouAoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4BbWLzsmjRH0RdnXDYyq5tMra9z0BJJLqlczxgGdDtPkPOqXdfsXU8nM+Na/8fu+
         A9E76d2bEYdJBt/BI5wDheqfaz000E1kNMTOKS3XGN0qoYu1e7MGWPfOcvSMU5Qa00
         zBVU5LHX9JbPeKXlmU8lMfpbLD6Zn3hYNF4If/XRnEYmKHxZKWl29yl7G7wxkCKMV5
         jON4vLAJCE0N+fUaZq/QK4s+zmOG4bzEA9y8nnJKfUdtEuxzkMl+COTiIXojFUrv1X
         AQj96QNiU/Bf2nTpmFxEcNTcLfVyILG3XeRR2kn7v7fS51jentWpXlKFycPyeGdcX3
         pWL0SQjR0Jflw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C55604007E; Mon, 30 Aug 2021 18:29:24 -0300 (-03)
Date:   Mon, 30 Aug 2021 18:29:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] perf bpf: Fix memory leaks relating to BTF.
Message-ID: <YS1NtCLgQzB7GILt@kernel.org>
References: <20210826184833.408563-1-irogers@google.com>
 <767e90d9-fb3e-93e2-ac67-940ab7e9ae28@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767e90d9-fb3e-93e2-ac67-940ab7e9ae28@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 27, 2021 at 12:58:09PM +0530, kajoljain escreveu:
> Patch looks good me.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Kajol Jain
> 
> On 8/27/21 12:18 AM, Ian Rogers wrote:
> > BTF needs to be freed with btf__free.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/annotate.c  | 2 +-
> >  tools/perf/util/bpf-event.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index d43f6b5e5169..0bae061b2d6d 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1833,7 +1833,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
> >  	ret = 0;
> >  out:
> >  	free(prog_linfo);
> > -	free(btf);
> > +	btf__free(btf);
> >  	fclose(s);
> >  	bfd_close(bfdf);
> >  	return ret;
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index cdecda1ddd36..17a9844e4fbf 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
> >  
> >  out:
> >  	free(info_linear);
> > -	free(btf);
> > +	btf__free(btf);
> >  	return err ? -1 : 0;
> >  }
> >  
> > @@ -486,7 +486,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
> >  	perf_env__fetch_btf(env, btf_id, btf);
> >  
> >  out:
> > -	free(btf);
> > +	btf__free(btf);
> >  	close(fd);
> >  }
> >  
> > 

-- 

- Arnaldo
