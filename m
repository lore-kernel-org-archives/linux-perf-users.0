Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E8C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 21:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbiEQVRM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiEQVRL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 17:17:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C233EB3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 14:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65466B81C5E
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6A6C385B8;
        Tue, 17 May 2022 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652822226;
        bh=zUaU6xab8UhL+tNHApsBPJeMtDxA7d/J5bMjZqlD9X0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6r3Ou8bovH3VbJUYZtkmd6KwJz4KSL7atpUXni6sYrbAxizvtt6F3zO4C+o6/b5s
         C7NLNhXPd8Qsd9Cy1VMItEglyeHLvO7S/fDAVVuyNoKRGA8SKQC/d+VCpEDXXZZ78O
         gE/JRJqfv89sW/AVRR6TPBKMFoPQsZ9b+qwFxW1xoo4G5717jitkd0tCPa221x/hWV
         85Z+kjb1btI2kM3xT4mwwR3GdE6gKFl3KebFLHypZR8zkc5TskbH8OpyDCKbvVkh4S
         pKp3MO3Cy72/jMXjJdCsg2/d5f5mNgdFJqj8jW10SlFiDkmToR3+5xufV8yrSUMgm/
         ag7h3K6f3GJfA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C9333400B1; Tue, 17 May 2022 18:17:02 -0300 (-03)
Date:   Tue, 17 May 2022 18:17:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Avi Kivity <avi@scylladb.com>
Cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Infinite recursion in `perf record`
Message-ID: <YoQQzm3b1kGkEeVQ@kernel.org>
References: <f0add43b-3de5-20c5-22c4-70aff4af959f@scylladb.com>
 <YoO2wrQ41W1lO88T@kernel.org>
 <9f21cc03-f411-828d-7817-5d9570d43ba1@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f21cc03-f411-828d-7817-5d9570d43ba1@scylladb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, May 17, 2022 at 05:59:17PM +0300, Avi Kivity escreveu:
> 
> On 17/05/2022 17.52, Arnaldo Carvalho de Melo wrote:
> > Em Mon, May 16, 2022 at 06:22:35PM +0300, Avi Kivity escreveu:
> > > In bpf-event.c we have:
> > > 
> > > 
> > > struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > > {
> > >         struct btf *btf;
> > > #pragma GCC diagnostic push
> > > #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > >         int err = btf__get_from_id(id, &btf);
> > > #pragma GCC diagnostic pop
> > > 
> > >         return err ? ERR_PTR(err) : btf;
> > > }
> > > 
> > > and in btf.c we have:
> > > int btf__get_from_id(__u32 id, struct btf **btf)
> > > {
> > >          struct btf *res;
> > >          int err;
> > > 
> > >          *btf = NULL;
> > >          res = btf__load_from_kernel_by_id(id);
> > >          err = libbpf_get_error(res);
> > > 
> > >          if (err)
> > >                  return libbpf_err(err);
> > > 
> > >          *btf = res;
> > >          return 0;
> > > }
> > > 
> > > Obviously, if the first weak symbol isn't overridden we get into an infinite
> > > recursion, which is what I see immediately on running perf record:
> > So the intent was to be able to dynamicly link with older and newer
> > libbpf versions, as btf__get_from_id() is being deprecated and
> > btf__load_from_kernel_by_id() isn't available in older libbpf versions.
> > 
> > This is all only when linking with the system's libbpf, not with the one
> > in tools/lib/bpf/, when perf does a static link.
> > 
> > So I think (will check) that your build is using LIBBPF_DYNAMIC=1, and
> > while there is a test build for that in 'make -C tools/perf build-test'.
> > 
> >           make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
> > 
> > It will cover testing just with the libbpf-devel installed on the
> > tester's machine/container.
> > 
> > I couldn't find the perf build log, the link you provided:
> > 
> > https://kojipkgs.fedoraproject.org//packages/kernel/5.17.6/300.fc36/data/logs/x86_64/build.log
> 
> 
> This link should work:

> https://kojipkgs.fedoraproject.org//packages/kernel-tools/5.17.6/300.fc36/data/logs/x86_64/build.log

Thanks, I'll check.
 
> > is for the kernel, not tools/perf.
> > 
> > I agree with Ian I should have done this using ifdef, a
> > tools/build/feature check that tries to build a test app linking against
> > libbpf-devel with btf__load_from_kernel_by_id(), if it is there, then
> > use it directly, if not, implement it in terms of btf__get_from_id().
> > 
> > I'll try to use my unbroken fingers to do that 8-)
 
> Thanks, I hope it doesn't cause more damage.

Hopefully not :-)

- Arnaldo
