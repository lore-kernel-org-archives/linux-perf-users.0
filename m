Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B0C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 11:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8F260F22
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 11:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhJYLn2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233113AbhJYLnM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 07:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635162049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvF4+nz9sV0ujtBgy5+lWhHsiQG7rLOYAJX/nU6mgaE=;
        b=bRWlAkFRe3hw6PfKTb7mAMoDPHWjHtS3oB1w7yL9+Hr4IoJhPZxQCWSMHAVNj5iB+U5nSR
        3hXwt8lBXePxc/eu4Bitp7SSf8KikCIf7s0uyqVYR/sOxQLfRKN9jaGWw7KAhe2MrtlkAO
        kxwhAoqgW7IajTAsE0k1TxONC9jOBgg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-W-Rv-gUvOhqrwDfX1jFaoQ-1; Mon, 25 Oct 2021 07:40:48 -0400
X-MC-Unique: W-Rv-gUvOhqrwDfX1jFaoQ-1
Received: by mail-wm1-f69.google.com with SMTP id r205-20020a1c44d6000000b0032cb058fe13so1425491wma.7
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Oct 2021 04:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pvF4+nz9sV0ujtBgy5+lWhHsiQG7rLOYAJX/nU6mgaE=;
        b=yUud8u61OJRMUxkkiZUu+f87n01T9XcfVpy/HcDi5Bjw9mH6VSzhN1SvpWH4uZd1Cl
         JdeAdufC2sKs2RGZn5fiHjsMxFevEwmr10PwL5LKC6H/e/LXFoKmWo7kHcjSiEMXPJJ1
         w+VfrprFofo1K55X4NnicEUo2s2cXP70e4D862Ygx9uSCer7DeMN+TjPl2xqS9uqkBCt
         7G0E8x2uTj8xW7IbwDD4BMEuGzzirXN5fRw9vhqPd8OxkYrhOIz2pjzEzXS4BaibvP+g
         slAK/SoS8kutM9y1JhhyoYi/0EL1V2s1KCzRWK2//tG1fVxMJZKz9IEUP8WxX9B3J8CH
         HzZA==
X-Gm-Message-State: AOAM533qN8Fjyq61BjFvB8wNE1EzYWOg2cQWDngRcKa4CQNvWd8lrmm9
        efo5odifrGzA9F7FTrMTMnD6LO1KHNpKp9hLlngFmAJBKHeYzRx7ecAnWEMKx0AuSLWm6ytikpE
        9DRQcPHXhFPlsA8tyxqxb/aimve/qMw==
X-Received: by 2002:a5d:528b:: with SMTP id c11mr22465498wrv.35.1635162047030;
        Mon, 25 Oct 2021 04:40:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhydRGvqbhPwZ1zzJqWcYrqwEZKk7t7seRXfentVvtIFtmJid7cH7YApOVonPRk8Bwtdbnuw==
X-Received: by 2002:a5d:528b:: with SMTP id c11mr22465470wrv.35.1635162046831;
        Mon, 25 Oct 2021 04:40:46 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id u10sm12776698wrm.34.2021.10.25.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:40:46 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:40:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjain@linux.ibm.com, james.clark@arm.com
Subject: Re: [PATCH v2 2/2] perf jevents: Enable warnings through HOSTCFLAGS
Message-ID: <YXaXvGgvs4gr8Cgi@krava>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <1634807805-40093-3-git-send-email-john.garry@huawei.com>
 <YXFhr2YoVp9GPsDM@krava>
 <86aee893-0b6b-bce3-d1aa-3b66365592d1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86aee893-0b6b-bce3-d1aa-3b66365592d1@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Oct 22, 2021 at 10:42:11AM +0100, John Garry wrote:
> On 21/10/2021 13:48, Jiri Olsa wrote:
> > > +HOSTCFLAGS += -Wall
> > > +HOSTCFLAGS += -Wextra
> > > +
> > >   # Enforce a non-executable stack, as we may regress (again) in the future by
> > >   # adding assembler files missing the .GNU-stack linker note.
> > >   LDFLAGS += -Wl,-z,noexecstack
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 7df13e74450c..118bcdc70bb4 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -226,7 +226,7 @@ else
> > >   endif
> > >   export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> > > -export HOSTCC HOSTLD HOSTAR
> > > +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
> > >   include $(srctree)/tools/build/Makefile.include
> > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > > index a055dee6a46a..d5c287f069a2 100644
> > > --- a/tools/perf/pmu-events/Build
> > > +++ b/tools/perf/pmu-events/Build
> > > @@ -1,7 +1,7 @@
> > >   hostprogs := jevents
> > >   jevents-y	+= json.o jsmn.o jevents.o
> > > -HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
> > > +HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include $(HOSTCFLAGS)
> > so the the host cflags are made of:
> > 
> > host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
> > 
> 
> ok, so IIRC, then the rule for building .o from .c in
> tools/build/Makefile.build will pick up HOSTCFLAGS through this variable, so
> we then don't need to explicitly mention it in the per-target rule, so can
> have this as before in pmu-events/Build
> 
> HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
> 
> right?
> 
> (Indeed I guess that we can get rid of -I$(srctree)/tools/include as well)

hm, the -I.. should stay no? I don't see that
it's being added soem other way

jirka


---
diff --git a/tools/build/Build.include b/tools/build/Build.include
index 2cf3b1bde86e..c2a95ab47379 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -99,7 +99,7 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
 ###
 ## HOSTCC C flags
 
-host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
+host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
 
 # output directory for tests below
 TMPOUT = .tmp_$$$$
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0ae2e3d8b832..374f65b52157 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -17,6 +17,7 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
+HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
 include $(srctree)/tools/scripts/Makefile.arch
 
@@ -211,6 +212,7 @@ endif
 ifneq ($(WERROR),0)
   CORE_CFLAGS += -Werror
   CXXFLAGS += -Werror
+  HOSTCFLAGS += -Werror
 endif
 
 ifndef DEBUG
@@ -292,6 +294,9 @@ CXXFLAGS += -ggdb3
 CXXFLAGS += -funwind-tables
 CXXFLAGS += -Wno-strict-aliasing
 
+HOSTCFLAGS += -Wall
+HOSTCFLAGS += -Wextra
+
 # Enforce a non-executable stack, as we may regress (again) in the future by
 # adding assembler files missing the .GNU-stack linker note.
 LDFLAGS += -Wl,-z,noexecstack
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7df13e74450c..118bcdc70bb4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -226,7 +226,7 @@ else
 endif
 
 export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
-export HOSTCC HOSTLD HOSTAR
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
 
 include $(srctree)/tools/build/Makefile.include
 

