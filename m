Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C81CC001B0
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 20:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGMU57 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGMU56 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 16:57:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA8E271F
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 13:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8538E61B6C
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 20:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF91DC433C8;
        Thu, 13 Jul 2023 20:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689281876;
        bh=+R5y01qvCjh+BoWaqyDvokXbp1fi20idqBjQDMdK6B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUOLciB+nPHAKoMotWfi1ShU5AdDTcEs9B9+EsDtKvF5evkljj6hcXLqzcRC+v8V+
         mALuKx7xq827bU6yhqrk7wHYSJHwNgFpuDrngCRZ8iuXvE/+5DwmXOIdoOyEMf0BEg
         0/5GU1Fl4GCiKXht1PGEDv7As2XE4JdbnI2K/aUSmzHGWAXatbLO6CCbF7e3DTj1L7
         B6D2W3RzaPSiXNhc+btQJBBP+hjFmIax5VSg0h+lTR0ZOK5k3A4dRxqcfX9Hk2z8yo
         FbUJ8IUWqCJ99cGFIETBME0RiJJ47Yil3xYKhu3LqUg65pC/C+2Yv3htPV0mJzg5+c
         PJ0tJugsZhaTg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0922D40516; Thu, 13 Jul 2023 17:57:53 -0300 (-03)
Date:   Thu, 13 Jul 2023 17:57:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Manu Bretelle <chantra@meta.com>,
        Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>,
        Mykola Lysenko <mykolal@meta.com>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
Message-ID: <ZLBlUXDxRqzNRup3@kernel.org>
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com>
 <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
 <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
 <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
 <146e00be-98c8-873d-081f-252647b71b12@amd.com>
 <ZK7JMjN9LXTFEOvT@kernel.org>
 <CAADnVQLpfmJ7yg-QtwfOFATJb=JcSDDxo11JG32KOQ6K=sNp4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLpfmJ7yg-QtwfOFATJb=JcSDDxo11JG32KOQ6K=sNp4Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 12, 2023 at 11:20:27AM -0700, Alexei Starovoitov escreveu:
> On Wed, Jul 12, 2023 at 8:39 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Right, perhaps the libbpf CI could try building perf, preferably with
> > BUILD_BPF_SKEL=1, to enable these tools:
> 
> 
> That would be great.
> perf experts probably should do pull-req to bpf CI to enable that.
> See slides:
> http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-bpf-ci.pdf
> 
> "How to contribute?
> Depending on what part of CI you are changing, you can create a pull request to
> https://github.com/kernel-patches/vmtest/
> https://github.com/libbpf/ci
> "

Sure, I still recall Quentin's talk about CI, etc in Dublin, will come
up with something and submit.

- Arnaldo
