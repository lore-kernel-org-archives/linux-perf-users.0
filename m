Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A855C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Nov 2021 01:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbhKYBMN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:12:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345427AbhKYBKM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Nov 2021 20:10:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B29560EB5;
        Thu, 25 Nov 2021 01:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637802422;
        bh=cSUCk7AT90ZPuLfC+MzDMxzjrF3CntV1HeNTtvnw5w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6eIP8GPfJiz0g+2FjdpD+/yWeczhh0KSzRYSM/hRdYFdQGULZcPPNlNNXv6hF2mS
         qORnE06ARDeMmWe0SKgiIhex9kN+RceSEvsK0+Z+JMe/xfxdDCplh4WNVWHk/H+S5v
         VhXB9xWL4dXPLjYog5vckrGARDoa9Q2FbL7oFJCTfTVDrlDJzIStCwQyLdC7ZVDL1V
         BEr7WNbaLOm8wH1blLhNrtAlH8oAVnFZ/SWyofsE8F5ejDGnyAbrI40PhaEyby9SdF
         VbJI/jb81J1YyPRYGTervZtjLqh3L7Ie7RemmaVhKUBX/GCYVRt+ElLrH+FZRIKV+e
         H8RHufepIX6tw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A1E4240002; Wed, 24 Nov 2021 22:06:58 -0300 (-03)
Date:   Wed, 24 Nov 2021 22:06:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] tools/perf: Fix perf test 7 Simple expression parser on
 s390
Message-ID: <YZ7hsokbiFQRhNMB@kernel.org>
References: <20211124090343.9436-1-tmricht@linux.ibm.com>
 <CAP-5=fXdOQUNDTXvt7GHRvu_7jyTPp_53f8_5DzDCXWCpWLtEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXdOQUNDTXvt7GHRvu_7jyTPp_53f8_5DzDCXWCpWLtEQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Nov 24, 2021 at 07:41:40AM -0800, Ian Rogers escreveu:
> On Wed, Nov 24, 2021 at 1:04 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > Fix this by adding s390 architecture to support CPU die list.

> > Output after:
> >  # ./perf test -Fv 7
> >   7: Simple expression parser                                        :
> >   --- start ---
> >   division by zero
> >   syntax error
> >   ---- end ----
> >   Simple expression parser: Ok
> >  #
> > Cc: Ian Rogers <irogers@google.com>
> > Fixes: fdf1e29b6118 ("perf expr: Add metric literals for topology.")

> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

