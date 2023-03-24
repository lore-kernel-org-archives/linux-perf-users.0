Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D195AC77B61
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Mar 2023 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCXUJc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCXUJb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Mar 2023 16:09:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B79B158A0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 13:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D799CB82422
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 20:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D69AC433EF;
        Fri, 24 Mar 2023 20:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679688567;
        bh=OPdAI+HpmRCv5AaetcA52DF1y0uc7HshcbtM+mBNXbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cje68o3ZBaFMtUZW5AWvI71AEkJSPiH6DU/FNEnPECHIUz5kPwPX0uwUu78mEd8FD
         TM03kpHcENCBlkSbdNpG084VL2iMa+rJjj8iWYa+lyqB/p7KLOiTTFOcEEzXu0rYYl
         HYJVOiEEu4mqOSq3X4/JnJP4uGvBV2iB7TQV8lCt8xMJ92uVmWMun8tJAWdMP+s0BK
         ySdgxstEw5n8h+1vocvpJVVGYFCOgsHg+TZRC0cvR+lC2yTYjXMSPA09C/nsAj16yn
         6lbJ05l6PkIurPmZEcLN1hBFHs6834MqlHWAIGE6ZUq4aWifQ7ZApTSFw0OGu/psBr
         FlKqhk2SDWODQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F59B4052D; Fri, 24 Mar 2023 17:09:24 -0300 (-03)
Date:   Fri, 24 Mar 2023 17:09:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Patrice Duroux <patrice.duroux@gmail.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] replace 2&>1 by 2>&1
Message-ID: <ZB4DdJ14nz84CTCl@kernel.org>
References: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
 <20230303193058.21274-1-patrice.duroux@gmail.com>
 <CAP-5=fV5h9AEf3V1taXA++frs=AAPeuPbd=Hb0koVjKfGpQNsw@mail.gmail.com>
 <CAP-5=fUy_mLJ2-z89dc0vro+1aqWFn-CrvqZA1Ji3etPXg+RTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUy_mLJ2-z89dc0vro+1aqWFn-CrvqZA1Ji3etPXg+RTg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Mar 23, 2023 at 11:03:49AM -0700, Ian Rogers escreveu:
> On Mon, Mar 6, 2023 at 1:46 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, Mar 3, 2023 at 11:31 AM Patrice Duroux <patrice.duroux@gmail.com> wrote:
> > >
> > > Signed-off-by: Patrice Duroux <patrice.duroux@gmail.com>
> >
> > Fixes: ade1d0307b2f ("perf offcpu: Update offcpu test for child process")
> > Acked-by: Ian Rogers <irogers@google.com>
> >
> > Thanks,
> > Ian
> 
> Arnaldo, could we pick this up?

Yeah, but next time please write in the subject line that its a patch
for the perf tools :-)

- Arnaldo
 
> Thanks,
> Ian
> 
> > > ---
> > >  tools/perf/tests/shell/record_offcpu.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
> > > index e01973d4e0fb..f062ae9a95e1 100755
> > > --- a/tools/perf/tests/shell/record_offcpu.sh
> > > +++ b/tools/perf/tests/shell/record_offcpu.sh
> > > @@ -65,7 +65,7 @@ test_offcpu_child() {
> > >
> > >    # perf bench sched messaging creates 400 processes
> > >    if ! perf record --off-cpu -e dummy -o ${perfdata} -- \
> > > -    perf bench sched messaging -g 10 > /dev/null 2&>1
> > > +    perf bench sched messaging -g 10 > /dev/null 2>&1
> > >    then
> > >      echo "Child task off-cpu test [Failed record]"
> > >      err=1
> > > --
> > > 2.39.2
> > >

-- 

- Arnaldo
