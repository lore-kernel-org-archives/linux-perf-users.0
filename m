Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E2ACD37B4
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Sep 2023 09:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjIQJWh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 17 Sep 2023 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjIQJWJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 17 Sep 2023 05:22:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC76C188
        for <linux-perf-users@vger.kernel.org>; Sun, 17 Sep 2023 02:22:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235F3C433C7;
        Sun, 17 Sep 2023 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694942523;
        bh=/j4DWIsQgtSFEy5JH+6kgx9JVQPPEwKacezaH14fxjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+DAL0AY2EA5aqVORmPxjz7DYGAZACn/9pSe/lHG2uQBukVs5eVTUxe/3ZLHfJKFX
         15ioFzCDgghCVUx3CS3VowHiRqEs2NODXiN+8o22mzEYT41/19zAXNuhoiNGQwNV1T
         FtVfai2PDf+tnT+Rer9TFX7TMRaI4UnVl/XrhDMZUeniABbWzFJr39CGFAGy/GtYLs
         nNSi0tl63I56huAawdabSzM4KL7bw8wXl9pJSXIvhXtcN6pWPjRYwn/ZF7/Ugr6BBt
         zOW8Qj1iM+pow6K8OmXBkAd8LHCeZLGpUwWQZN4/jftj5zGpmbj3TDXnVKvy4mG3n5
         TKZzruGch+Hbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AA31C403F4; Sun, 17 Sep 2023 11:22:00 +0200 (CEST)
Date:   Sun, 17 Sep 2023 11:22:00 +0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Manu Bretelle <chantra@meta.com>
Cc:     Mykola Lysenko <mykolal@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
Message-ID: <ZQbFOHecUI+baoz8@kernel.org>
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com>
 <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
 <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
 <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
 <146e00be-98c8-873d-081f-252647b71b12@amd.com>
 <ZK7JMjN9LXTFEOvT@kernel.org>
 <CAADnVQLpfmJ7yg-QtwfOFATJb=JcSDDxo11JG32KOQ6K=sNp4Q@mail.gmail.com>
 <ZLBlUXDxRqzNRup3@kernel.org>
 <87FAA9FD-C64E-4199-9F77-8671FF19EEE1@fb.com>
 <SA1PR15MB46099ABDC08009096019B5B4CBF7A@SA1PR15MB4609.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR15MB46099ABDC08009096019B5B4CBF7A@SA1PR15MB4609.namprd15.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 14, 2023 at 09:43:41PM +0000, Manu Bretelle escreveu:
> Hi Arnaldo,
 
> Checking back here to see if there is anything you need help in order
> to add perf support to BPF CI. Were you able to make progress and are
> hitting some issues along the way?

I'm travelling now, but I saw that Ian replied.

No progress on my part, but I would start with a simple:

Build perf from the same kernel source tree used in the
current CI tests, then run 'perf test'. It would test more than just the
BPF part, but would be a good start.

A second step would be just disabling the tests that are failing and
that are not BPF specific, using the --skip arg to 'perf test':

[root@quaco test]# perf test -h skip

 Usage: perf test [<options>] [{list <test-name-fragment>|[<test-name-fragments>|<test-numbers>]}]

    -s, --skip <tests>    tests to skip

[root@quaco test]#

So something like:

-----------------
make -C tools/perf
perf test --skip list,of,tests,failing,that,are,not,BPF,specific
-----------------

The perf build dependencies should be similar to the ones needed to
build libbpf or close to it, so the above would be a great first stab at
it.

- Arnaldo
 
> 
> Thanks,
> 
> Manu
> 
> From: Mykola Lysenko <mykolal@meta.com>
> Date: Friday, July 14, 2023 at 11:15 AM
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mykola Lysenko <mykolal@meta.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Manu Bretelle <chantra@meta.com>, Daniel Müller <deso@posteo.net>, Mykola Lysenko <mykolal@meta.com>
> Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
> Hey Arnaldo,
> 
> > On Jul 13, 2023, at 1:57 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> >
> > |-------------------------------------------------------------------!
> >
> > Em Wed, Jul 12, 2023 at 11:20:27AM -0700, Alexei Starovoitov escreveu:
> >> On Wed, Jul 12, 2023 at 8:39 AM Arnaldo Carvalho de Melo
> >> <acme@kernel.org> wrote:
> >>>
> >>> Right, perhaps the libbpf CI could try building perf, preferably with
> >>> BUILD_BPF_SKEL=1, to enable these tools:
> >>
> >>
> >> That would be great.
> >> perf experts probably should do pull-req to bpf CI to enable that.
> >> See slides:
> >> http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-bpf-ci.pdf
> >>
> >> "How to contribute?
> >> Depending on what part of CI you are changing, you can create a pull request to
> >> https://github.com/kernel-patches/vmtest/
> >> https://github.com/libbpf/ci
> >> "
> >
> > Sure, I still recall Quentin's talk about CI, etc in Dublin, will come
> > up with something and submit.
> 
> Thanks for looking at this!
> 
> If you will have any questions on how CI works, do not hesitate to join BPF office hours and we will do our best to answer.
> 
> Mykola
> 
> >
> > - Arnaldo
> 

-- 

- Arnaldo
