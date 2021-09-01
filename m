Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E3BC432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 16:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6714B6108E
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 16:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhIAQuw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhIAQuv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 12:50:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A132260525;
        Wed,  1 Sep 2021 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630514994;
        bh=qfbWT7+qcpIOR2ilM3lTfkuFQnLJW5YbueLjEBSnZyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oR3FDJQStaL1ofpT2swCRp2pWYRhoVGq3++Hbqjrbole3eG6IIu6rrAoWSLL6CmSr
         Z2sGMTQjhKVdidwUSA0dFIlekvqxO26VE45ToS0LQV2x6eMCqklNwRgwzMh8pMmwqn
         YNZ/3OOMrAIFpxgOAo9D9a3xyRTepCk2AvHjG/lWW/X39mlcH7v2Vqa/UplBi0LfZC
         BSOD//t5YdnM5ze3j2ANGQHKzxvYjzsEKEdVN5U4RNkijseE2YxoiZA5RP8VSl2JX+
         WsaSHT287Z2F4RrCG69LIaeH+IEGgAMVaU8oN2DdKXdvN4xr1WQ+ULND4hjF1l2ZQI
         qp6kcQ4CknSOA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 666A34007E; Wed,  1 Sep 2021 13:49:51 -0300 (-03)
Date:   Wed, 1 Sep 2021 13:49:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic
 number
Message-ID: <YS+vL2SYCCVLAXVp@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s>
 <YS+iOrcPTzQfmbqU@kernel.org>
 <YS+lTXyuC+9VTrxd@kernel.org>
 <YS+neCZler56Hs2D@kernel.org>
 <YS+pgZMpFmnRlMuT@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS+pgZMpFmnRlMuT@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 01, 2021 at 01:25:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Sep 01, 2021 at 01:16:56PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Sep 01, 2021 at 01:07:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, Sep 01, 2021 at 12:54:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Applies cleanly to my tree, test building it now, holler if there is
> > > > something that prevents it from being merged.

> > > I´m now trying to fix this up, I applied it using 'b4', so no patch
> > > should have gone missing...

> > So its probably related to:

> > ⬢[acme@toolbox perf]$ rpm -qa | grep opencsd
> > opencsd-1.0.0-1.fc34.x86_64
> > opencsd-devel-1.0.0-1.fc34.x86_64
> > ⬢[acme@toolbox perf]$

> > In which case the usual mechanism is to test if we have what is needed
> > via tools/build/feature/test-_____.c, lemme check...

> There is a test and it fails, of course:

> ⬢[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-libopencsd.make.output
> test-libopencsd.c:9:2: error: #error "OpenCSD >= 1.1.1 is required"
>     9 | #error "OpenCSD >= 1.1.1 is required"
>       |  ^~~~~
> ⬢[acme@toolbox perf]$

> But the fact that I ask for CORESIGHT=1 should have the build fail then,
> i.e. if one explicitely asks for a feature and it can't be built, fail
> the whole build.

So after uninstalling the libopencsd that comes with fedora 34 and
cloning the upstream OpenCSD git repo, building it and installing in
/usr/local/ it seems to work as expected:

⬢[acme@toolbox perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;
⬢[acme@toolbox perf]$ make O=/tmp/build/perf VF=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin |& grep -i opencsd
...                    libopencsd: [ on  ]
⬢[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-libopencsd.make.output
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$ ldd ~/bin/perf | grep opencsd
	libopencsd_c_api.so.1 => not found
⬢[acme@toolbox perf]$ export LD_LIBRARY_PATH=/usr/local/lib
⬢[acme@toolbox perf]$ ldd ~/bin/perf | grep opencsd
	libopencsd_c_api.so.1 => /usr/local/lib/libopencsd_c_api.so.1 (0x00007f839e8b2000)
	libopencsd.so.1 => /usr/local/lib/libopencsd.so.1 (0x00007f839da3c000)
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$ ldd /tmp/build/perf/feature/test-libopencsd.bin
	linux-vdso.so.1 (0x00007ffd669b3000)
	libopencsd_c_api.so.1 => /usr/local/lib/libopencsd_c_api.so.1 (0x00007fe608b8c000)
	libopencsd.so.1 => /usr/local/lib/libopencsd.so.1 (0x00007fe608af5000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fe60891e000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007fe6086ff000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fe6085bb000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fe6085a0000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fe608ba2000)
⬢[acme@toolbox perf]$ ls -la /usr/local/lib/libopencsd*
-rw-r--r--. 1 root root 1641364 Sep  1 13:41 /usr/local/lib/libopencsd.a
-rw-r--r--. 1 root root  168022 Sep  1 13:41 /usr/local/lib/libopencsd_c_api.a
lrwxrwxrwx. 1 root root      21 Sep  1 13:41 /usr/local/lib/libopencsd_c_api.so -> libopencsd_c_api.so.1
lrwxrwxrwx. 1 root root      25 Sep  1 13:41 /usr/local/lib/libopencsd_c_api.so.1 -> libopencsd_c_api.so.1.1.1
-rw-r--r--. 1 root root  104968 Sep  1 13:41 /usr/local/lib/libopencsd_c_api.so.1.1.1
lrwxrwxrwx. 1 root root      15 Sep  1 13:41 /usr/local/lib/libopencsd.so -> libopencsd.so.1
lrwxrwxrwx. 1 root root      19 Sep  1 13:41 /usr/local/lib/libopencsd.so.1 -> libopencsd.so.1.1.1
-rw-r--r--. 1 root root  762432 Sep  1 13:41 /usr/local/lib/libopencsd.so.1.1.1
⬢[acme@toolbox perf]$

This doesn't explain that 'make -C tools/perf build-test' error, perhaps
it is reusing the feature dump (feature detection), done without
CORESIGHT=1, when building with CORESIGHT=1 :-\

Anyway, please consider making the build fail when CORESIGHT=1 is passed
explicitely and that tools/build/feature-libopencsd.c feature test fails
instead of silently building the tool _without_ the explicitely asked
for feature.

Thanks,

- Arnaldo
