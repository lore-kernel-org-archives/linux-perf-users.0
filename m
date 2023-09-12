Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC6BEE3F0C
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 19:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjILTgy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbjILTgx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 15:36:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862B21B2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 12:36:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F15C433C9;
        Tue, 12 Sep 2023 19:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694547409;
        bh=SvlumMTdQZh6G5IlMqBFuVWCG4j/pbQtNHmOMRfenUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/GARk51udRfyyi6T1TBkuQvcisgm+pwQW9wF9Wyyf87P1Vq1bOBpWxVRL/CMzvvx
         IsOYPpi+tl7Ehb02HTRT2pit8d52oruRKK3mscTPSnY5wMqetzHFfhqkQEJeKSZXja
         8XSGPjUy3P9CJVwrj6RnqIHFU00+8ruDcLwMAt+C4QduvU9Mg5rnmmDqV309XQoQpc
         n6OMWMM7x/Ff8PH9byMkQfYgEd55P0yfchWqvp545j+XjkEUwYrHtGLjaJNpRrKIG9
         1n73DFcnlt9SzVtoe2W5VXR4X4yDOSHYCp1YKMvMkgek9XW9sLx+rt1HUo4IEwlzPu
         AkxavjgFkdIKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E0C2403F4; Tue, 12 Sep 2023 16:36:46 -0300 (-03)
Date:   Tue, 12 Sep 2023 16:36:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V3] tools/perf: Add includes for detected configs in
 Makefile.perf
Message-ID: <ZQC9zp14T92/fwCN@kernel.org>
References: <20230912063807.74250-1-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fU644=VvHf1JcQ1LN7tb_wAkrnrE+n4xCVyWae=UxTFyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU644=VvHf1JcQ1LN7tb_wAkrnrE+n4xCVyWae=UxTFyg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 12, 2023 at 07:00:00AM -0700, Ian Rogers escreveu:
> On Mon, Sep 11, 2023 at 11:38 PM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
> >
> > Makefile.perf uses "CONFIG_*" checks in the code. Example the config
> > for libtraceevent is used to set PYTHON_EXT_SRCS
> >
> >         ifeq ($(CONFIG_LIBTRACEEVENT),y)
> >           PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
> >         else
> >           PYTHON_EXT_SRCS := $(shell grep -v '^\#\|util/trace-event.c' util/python-ext-sources)
> >         endif
> >
> > But this is not picking the value for CONFIG_LIBTRACEEVENT that is
> > set using the settings in Makefile.config. Include the file
> > ".config-detected" so that make will use the system detected
> > configuration in the CONFIG checks. This will fix isues that
> > could arise when other "CONFIG_*" checks are added to Makefile.perf
> > in future as well.
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> > Changelog:
> > v2 -> v3:
> > Added -include since in some cases make clean or make
> > will fail when config is not included and if config-detected
> > file is not present.
> >
> > v1 -> v2:
> > Added $(OUTPUT) prefix to config-detected as pointed
> > out by Ian
> >
> >  tools/perf/Makefile.perf | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 37af6df7b978..f6fdc2d5a92f 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -351,6 +351,9 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> >
> >  python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
> >
> > +# Use the detected configuration
> > +-include $(OUTPUT).config-detected
> > +
> >  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> >    PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
> >  else
> > --
> > 2.31.1
> >

-- 

- Arnaldo
