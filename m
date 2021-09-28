Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6591DC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CDE61360
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbhI1Vpj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232003AbhI1Vpi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 17:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632865438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iiF8exoYlueRS0KnTsyCUS9qWOqre2hhhD+QduQ5KmQ=;
        b=h/M2YgpIXSdfeRk3QGzzxo9XKllMTEDaRMgk4tV6guALUud22Y5eqEn1HPsVs4K+rGkmqI
        8PkpAJWiKQmNUjV6sNZmkMOyJ5PZjL7UFPDpGZ+fONM2wxx+RrdiAB/VUt+gV9JJufrk1J
        RDw5PJKb6nxZkTka1etHqUPv33e8ja4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-z-ssChagNvaN2LuvMeC9HA-1; Tue, 28 Sep 2021 17:43:57 -0400
X-MC-Unique: z-ssChagNvaN2LuvMeC9HA-1
Received: by mail-ed1-f69.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so145721edi.12
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 14:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iiF8exoYlueRS0KnTsyCUS9qWOqre2hhhD+QduQ5KmQ=;
        b=n++krQKu8VGoJMhgLHRloozjWQz/FPGkCCiyCEbec1aklyTl4NswnitloyBG0PNHci
         7x/9D8ygvcQgexkN90SbXQVYdFvKlhpD/N/V10hhUSre963CzqvA0T3byxmfviTZCYRr
         zhVNQ4YCxa63h73uB8HWEfAYucAm4hStx8ZMzr7jw0Vbvq3/U8AFG3QBWjwrO22qHfxq
         C3Xn3Mv3rhrtqnOCUjfSiPG7z6BRYOnqoPfldd4aLuavB6v4uOJeHAOR1Qf1DMnzIJy1
         2LA3WrVIZzFo0kE140Sf94uOH+bHmF350CuLlC105nlJAypF9GckaI/2estRna70zXme
         KuFA==
X-Gm-Message-State: AOAM531CK9J7E/MTXYnRriv8y1SLVuQidVKWs11vNnvkKQPGhF/XWPZL
        L2X15Tv1kqx9hSclZKJAfrkMK+JaI5T8HqVWMaZMXQ2Gc4ZOZW4auaKL/o7Dg3MLYJq90KpRZlx
        r02ZG39q1yg0jKs7C3xtg4E0U/z695A==
X-Received: by 2002:a17:906:a150:: with SMTP id bu16mr9687736ejb.108.1632865436028;
        Tue, 28 Sep 2021 14:43:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzffHysBBgASP2F8Ab/DD86WSd96VYno2KuTylK/C/SLn2gn1hgJ37l2kHvRSFMtXbL2vmRZQ==
X-Received: by 2002:a17:906:a150:: with SMTP id bu16mr9687714ejb.108.1632865435859;
        Tue, 28 Sep 2021 14:43:55 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id m7sm171987ejc.83.2021.09.28.14.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:43:55 -0700 (PDT)
Date:   Tue, 28 Sep 2021 23:43:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jinshan Xiong <jinshan.xiong@gmail.com>
Cc:     arnaldo.melo@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/lib/perf: make the static libperf complete
Message-ID: <YVOMmYcX4E6PsHu3@krava>
References: <CABoqRjsUPhJk6A7QOh_9z6zHLyqX=ZZG7gkcEZeui1uO4m7Bbg@mail.gmail.com>
 <20210927223101.3155964-1-jinshan.xiong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927223101.3155964-1-jinshan.xiong@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 27, 2021 at 03:30:26PM -0700, Jinshan Xiong wrote:
> This patch makes libperf.a complete. Initially it misses the symbols
> fdarray_* that makes it unusable after being installed by:
>    $ make install DESTDIR=<install_dir>
> 
> Check missing symbols:
>    $ nm tools/lib/perf/libperf.a | grep fdarray_
>                     U fdarray__add
>    0000000000002b3e t fdarray__available_entries
>                     U fdarray__exit
>                     U fdarray__filter
>                     U fdarray__grow
>                     U fdarray__init
>                     U fdarray__poll

right, libperf.a should be complete.. but how about we use libperf.a
as source for libapi.a and include it directly in there.. and remove
libapi.a from perf 

we will have complete libperf.a without new -ext.a file and perf
compiles properly.. should be also ok for future perf dynamic linking
with libperf.so

I did just quick build test.. I might have missed something

jirka


---
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 08fe6e3c4089..e1150408e095 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -109,7 +109,7 @@ else
 endif
 
 LIBAPI = $(API_PATH)libapi.a
-export LIBAPI
+LIBAPI_IN = $(API_PATH)libapi-in.o
 
 $(LIBAPI): FORCE
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
@@ -121,8 +121,8 @@ $(LIBAPI)-clean:
 $(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
-$(LIBPERF_A): $(LIBPERF_IN)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
+$(LIBPERF_A): $(LIBPERF_IN) $(LIBAPI)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN) $(LIBAPI_IN)
 
 $(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
 	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e04313c4d840..a500fd6fe5ea 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -321,9 +321,6 @@ LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
 DYNAMIC_LIST_LDFLAGS               = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
 LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = $(if $(findstring -static,$(LDFLAGS)),,$(DYNAMIC_LIST_LDFLAGS))
 
-LIBAPI = $(API_PATH)libapi.a
-export LIBAPI
-
 LIBBPF = $(BPF_PATH)libbpf.a
 
 LIBSUBCMD = $(SUBCMD_PATH)libsubcmd.a
@@ -340,7 +337,7 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
 
 PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
-PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBTRACEEVENT) $(LIBAPI)
+PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBTRACEEVENT)
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
 
@@ -379,7 +376,7 @@ endif
 
 export PERL_PATH
 
-PERFLIBS = $(LIBAPI) $(LIBSUBCMD) $(LIBPERF)
+PERFLIBS = $(LIBSUBCMD) $(LIBPERF)
 ifndef NO_LIBBPF
   ifndef LIBBPF_DYNAMIC
     PERFLIBS += $(LIBBPF)
@@ -820,13 +817,6 @@ $(LIBTRACEEVENT)-clean:
 install-traceevent-plugins: libtraceevent_plugins
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) install_plugins
 
-$(LIBAPI): FORCE
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
-
-$(LIBAPI)-clean:
-	$(call QUIET_CLEAN, libapi)
-	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
-
 $(LIBBPF): FORCE
 	$(Q)$(MAKE) -C $(BPF_DIR) O=$(OUTPUT) $(OUTPUT)libbpf.a FEATURES_DUMP=$(FEATURE_DUMP_EXPORT)
 
@@ -1078,7 +1068,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 483f05004e68..c470a67d2b77 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -51,7 +51,6 @@ src_perf  = getenv('srctree') + '/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 libtraceevent = getenv('LIBTRACEEVENT')
-libapikfs = getenv('LIBAPI')
 libperf = getenv('LIBPERF')
 
 ext_sources = [f.strip() for f in open('util/python-ext-sources')
@@ -71,7 +70,7 @@ perf = Extension('perf',
 		  include_dirs = ['util/include'],
 		  libraries = extra_libraries,
 		  extra_compile_args = cflags,
-		  extra_objects = [libtraceevent, libapikfs, libperf],
+		  extra_objects = [libtraceevent, libperf],
                  )
 
 setup(name='perf',

