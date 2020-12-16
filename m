Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C1C4361B
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Dec 2020 14:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395872335A
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Dec 2020 14:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgLPN74 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgLPN74 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Dec 2020 08:59:56 -0500
Date:   Wed, 16 Dec 2020 10:59:29 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608127155;
        bh=Y07yZLNYZu6pc5dhJagZ/igm7UpnDoJzpTI0/uaZtKY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=SiglF3VLg2kgPaeZmZ/RHSsSpv+JKb0KM/q02xTLcrDdTl1EynOET9t879yxioo3b
         Pp4ZwXTwY9NulDSLbItBCFkFsZJyR6FftFJk50j7DtBU5RAttxHxTzkqj/11RNnwx4
         Ma3J+6tuu6kbLfwbI6nMskd+YhWQdaebkv9v0DKai30Suv8YDgUn/vfW0ho6Hdt+Wf
         bBWqumoBj6TzeB+R5MTpHb3y8Rj2jt9rn4vI0XoftzqhhlIXB81LoPMwr18x7vD/z1
         yQb0o2iFbOfjQQFITAlGB9BUHwUqEDAkkqmdZ2iYSX18uRGw/XejyQgU1QY7rl3EGE
         TlSWoqVPuBmAQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf probe can't remove probes
Message-ID: <20201216135929.GA294100@kernel.org>
References: <20201125172755.GA53351@kernel.org>
 <20201126092125.402257a8776637d6bd2e090c@kernel.org>
 <20201126172603.GD53384@kernel.org>
 <20201216091640.402d51e22dff04fff8ba6d79@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216091640.402d51e22dff04fff8ba6d79@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Dec 16, 2020 at 09:16:40AM +0900, Masami Hiramatsu escreveu:
> On Thu, 26 Nov 2020 14:26:03 -0300
 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Thu, Nov 26, 2020 at 09:21:25AM +0900, Masami Hiramatsu escreveu:
> > > On Wed, 25 Nov 2020 14:27:55 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > As you can see, "-D" is showing definition. Not delete. (*)
> > > Delete is "-d" or "--del".

> > Yeah, I was in a hurry and looked at just the first line right after the
> > command, didn't want to forget reporting it so sent the "bug" report,
> > d0h, sorry about the noise, using -d or --del works.

> > But having both -d and -D, in retrospect, wasn't such a good idea :-\
> 
> Sorry for confusing :(
 
> Hmm, would we better to remove -D and keep only --definition?
> But it is already there, I think we should keep this option
> for backward compatibility.

Nah, since we have it there, lets take this just as a lesson and in the
future use single letter options just for core functionality, leaving
things like --definition to be just a long option.

We can't change it now :-)

- Arnaldo
