Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32945C49EA2
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 17:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C9E61107
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 17:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhFVRpJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232301AbhFVRpH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 13:45:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FEBD60720;
        Tue, 22 Jun 2021 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624383771;
        bh=AdNNC8o9THyCPkVQW5qscu3FI9w1HH+6jr1PCtqb1Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BuUaok2S0pfxbCbyv4kUBId+/dPCEvf8XmanC4CYP9caxpRBxb7U7CZWgF+9tHVIc
         /CBf5C1EAcICRWycYEE006yhknN5fpaQCIK5NCbwpBjbjJ86IrM7aM2ns/jtWT+s4v
         k9b7Y6coVds0foRMwQzZ+Byo6XaELtC9i8okUwT+UQf3+sn20sspTchLQ1JV+vk6Jm
         0uzVB2bBnhMjdhVaX2qu7vWTa3NkKaUHRQb6DQ5J+HACxg/CTQ6PfTDYW21NPSNQPM
         AjLqY8atsh1QaGc8uXbKMGTGzZtLi2UMLZr48cTarxfngM8ZHOrcRXB9rS+sGnwJ2o
         ezkC1+mRKY5Iw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EF15640B1A; Tue, 22 Jun 2021 14:42:47 -0300 (-03)
Date:   Tue, 22 Jun 2021 14:42:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: perf tool: About tests debug level
Message-ID: <YNIhF2ncHTE8uEoo@kernel.org>
References: <ecd941b3-2fd5-61d8-93a1-76a3a3ee4138@huawei.com>
 <CAP-5=fUxQZ+rxLEn6jeRNVMf48BaPNdaUdoMs8LY4P-GROiOnw@mail.gmail.com>
 <cd501541-deb5-f2f5-e086-cca44b40c87d@huawei.com>
 <CAP-5=fU05k62d57pbWquqv3Z1RFzWMOB1d3OFEcEax5btEWEzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU05k62d57pbWquqv3Z1RFzWMOB1d3OFEcEax5btEWEzg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 22, 2021 at 09:00:31AM -0700, Ian Rogers escreveu:
> On Tue, Jun 22, 2021 at 4:58 AM John Garry <john.garry@huawei.com> wrote:
> >
> > On 22/06/2021 06:04, Ian Rogers wrote:
> > >> ---- end ----
> > >> Parse and process metrics: FAILED!
> > >>
> > >> Note that the "FAILED" messages from the test code come from pr_debug().
> > >>
> > >> In a way, I feel that pr_debug()/err from the test is more important
> > >> than pr_debug() from the core code (when running a test).
> > >>
> > >> Any opinion on this or how to improve (if anyone agrees with me)? Or am
> > >> I missing something? Or is it not so important?
> > > Hi John,
> > >
> >
> > Hi Ian,
> >
> > > I think the issue is that in the parsing you don't know it's broken
> > > until something goes wrong. Putting everything on pr_err would cause
> > > spam in the not broken case.
> >
> > Right, I would not suggest using pr_err everywhere.
> >
> > > Improving the parsing error handling is a
> > > big task with lex and yacc to some extent getting in the way. Perhaps
> > > a middle way is to have a parameter to the parser that logs more, and
> > > recursively call this in the parser when parsing fails. I guess there
> > > is also a danger of a performance hit.
> >
> > So I am thinking that for running a test, -v means different levels logs
> > for test code and for core (non-test code). For example, -v prints
> > pr_warn() and higher for test logs, but nothing for core logs. And then
> > -vv for running a test gives pr_debug and above for test logs, and
> > pr_warn and above for core logs. Or something like that.
> >
> > Maybe that is not a good idea. But I'm just saying that it's hard to
> > debug currently at -v for tests.
> >
> > Thanks,
> > John
> 
> I think this sounds good. It'd be nice also to have verbose output in
> the shell tests following the same convention. There's currently no
> verbose logging in shell tests but I propose it here:
> https://lore.kernel.org/lkml/20210621215648.2991319-1-irogers@google.com/
> By their nature some of the shell tests launch perf, perhaps there can
> be some convention on passing the verbose flag through in those cases.

Hey, there is even a v2 for that one, lemme process it :-)

- Arnaldo
