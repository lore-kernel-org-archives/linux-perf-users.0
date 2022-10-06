Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37CBC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 15:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiJFPHj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiJFPHb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 11:07:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127AB2DBD
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 08:07:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 10so2036312pli.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Oct 2022 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=XtvtZz1yUgqHiAj7O8HtuSAPvSYvhkK7EoWWsgh0ZUE=;
        b=zdVppy7U8tcJQ88OlDFFKdVJQzkbfHRxI85A7ctKKxwBvnxVy9mg/m4HcggmyZHIXk
         s1I9tV16Q69fNBCaOlYvpWtgc+kjeclkInb7qXf0PyY0DQVckXA/b9gdlJ7GrKVUMmdS
         oyhehdBQXoTNt900f2O28IPX3vsJ4VFayrGR3SV1MNqnNK8Yiq3dV7K6DrcDZrJI/I9G
         35dbQdFi63TP4lYUVqhhOkMkrAEfj0uxJXV47n/Sj5zb/GFsCgDgZIFDuggDGzgmT0j4
         Vw2XkdmFuU0j/0bBAzw98P5WnzmqcHCW2TrdGLXzwHJBmDP3v0x2rxvneHvOyEdnGsb5
         cOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XtvtZz1yUgqHiAj7O8HtuSAPvSYvhkK7EoWWsgh0ZUE=;
        b=QEsbZlzjiGN78xJQFOrLMFWUmfAJpoVSsJHQAAGBttzs/KUOdmvCVbX5eV9a8jqikw
         KU7HoCcVC/j/8TMhGsHeCRbRip91UdHyPxtmhkU9sODQqGfKEUvtxWU9YuJ0ZAn296Ha
         ZBvDnBHgmAxVYC/4T7B4UsraHh38ayjwkWqTo8RaBHBntgTtmZQ2UDhzhrapBE77ZPfG
         SXAs7FL3S9uAWoyub4FJHAEuxuBbYb+5Rhn/+4oyIkTA5OmX6wUpNAAgVBMjPb4K1IpA
         IXZKD4CxFHh/yxNNONfDjnXzm6myFrwcG/cZsO20cd/JcwqKjW2qOuOpULOb/1aNbD5t
         IOkA==
X-Gm-Message-State: ACrzQf3kKVuB+x5udlkJiHjxoMi3E8Vlb4cjgyAWaurHFt7zzY64+HCg
        qYg69+xLnE+5zvHul0AqA1AufA==
X-Google-Smtp-Source: AMsMyM4cGPquTdWykAA37Ii+6eWhxh4UPQR99MKboJwCMPEQFFUpIRob/M46Z6EP+9RYn4vxahqYtQ==
X-Received: by 2002:a17:90b:4acf:b0:202:65e3:da5a with SMTP id mh15-20020a17090b4acf00b0020265e3da5amr10929521pjb.174.1665068847275;
        Thu, 06 Oct 2022 08:07:27 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net. [211.75.219.202])
        by smtp.gmail.com with ESMTPSA id ik8-20020a170902ab0800b001730a1af0fbsm3366287plb.23.2022.10.06.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:07:26 -0700 (PDT)
Date:   Thu, 6 Oct 2022 23:07:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     carsten.haitzler@foss.arm.com, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Yz7vJ9Wy0zCTwp1t@leoy-yangtze.lan>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org>
 <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
 <Yz7klV3h+JJ+ilAp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yz7klV3h+JJ+ilAp@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 06, 2022 at 11:22:13AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > @@ -1006,7 +1014,10 @@ install-tests: all install-gtk
> >                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
> >                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> >                 $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > -               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> > +               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> > +               $(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> > +       $(Q)$(MAKE) -C tests/shell/coresight install-tests
> > 
> > It's deliberately to not add '-m 644' when install coresight test
> > shell scripts under the folder tests/shell/coresight/ so that we can
> > keep the executable permission for these scripts.  On the other flip,
> > we set 644 mode for the scripts under tests/shell/lib/ so these
> > scripts will not be executed directly by perf test framework.
> > 
> > @Carsten, if have chance could you confirm for above change?
> 
> If you need for some .sh, coresight test's to have x set while all of
> the others don't have, and you have a good reason for that, ok, we just
> add a comment.

Simply to say, all lib scripts are not needed for execute permission.
Yes, it's good to add a comment for the installation steps.

> > >   DESCEND plugins
> > >   GEN     /tmp/build/perf/python/perf.so
> > >   INSTALL trace_plugins
> > >   INSTALL binaries
> > >   INSTALL tests
> > > install: cannot stat 'tests/shell/coresight/*.sh': No such file or directory
> > > make[2]: *** [Makefile.perf:1007: install-tests] Error 1
> > > make[2]: *** Waiting for unfinished jobs....
> > > 
> > > I'll add it back when the first .sh gets added to tests/shell/coresight/
> > 
> > Sorry for introducing extra efforts for you and thanks!
> 
> This also has to go, I'll check and fix this loop that doesn't follow
> the existing output style, happens with ´make install', etc too:
> 
> ⬢[acme@toolbox perf]$ make -C tools/perf clean
> make: Entering directory '/var/home/acme/git/perf/tools/perf'
>   CLEAN   x86
>   CLEAN   libtraceevent
>   CLEAN   libapi
>   CLEAN   libbpf
>   CLEAN   libsubcmd
>   CLEAN   libperf
>   CLEAN   fixdep
>   CLEAN   feature-detect
>   CLEAN   python
>   CLEAN   bpf-skel
> make -C asm_pure_loop clean >/dev/null        <-------------------
> make -C memcpy_thread clean >/dev/null        <-------------------
> make -C thread_loop clean >/dev/null          <-------------------
> make -C unroll_loop_thread clean >/dev/null   <-------------------

Ouch, if we can update the file tests/shell/coresight/Makefile as below:

$(CLEANDIRS):
        $(call QUIET_CLEAN, test-$(@:clean-%=%)) $(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null

Then we can get output as:

  # make clean
  CLEAN   arm64
  CLEAN   libtraceevent
  CLEAN   libapi
  CLEAN   libbpf
  CLEAN   libsubcmd
  CLEAN   libperf
  CLEAN   fixdep
  CLEAN   feature-detect
  CLEAN   python
  CLEAN   bpf-skel
  CLEAN   test-asm_pure_loop
  CLEAN   test-memcpy_thread
  CLEAN   test-thread_loop
  CLEAN   test-unroll_loop_thread
  CLEAN   core-objs
  CLEAN   core-progs
  CLEAN   core-gen
  CLEAN   Documentation

Sorry for inconvenience.

Thanks,
Leo
