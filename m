Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1D3C54EBD
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Jan 2023 19:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjAITlA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbjAITkq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 14:40:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C677D0E
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Jan 2023 11:40:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so7876591wms.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2023 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o93RGUSe+ygfsACOiKR79noLA/HJS4wxmrTmGVyWD9c=;
        b=K2ZY16K/q8V/OQ5/nhKP+F6QxZmA66JgfLoNOjIGiMgj8eYnIYc367mu5hGa3JQ/kQ
         WyOo86YWyfRnZCI8MWqaYLlyaRrM3VIf84LROoz3XJgCP/fEqoG/f/DueUpWspCfDWFu
         ECICRkkdsXYvb7kj6cUTG9xJ5ma0+M/QFT0ZUaOlqrQ1CaIf8SSbLBT8hllbtr8XXWZw
         m2n9tXVgqIU0oABhnhTtNJOOnmQeyPuxZTk/kPfq5P2LDbRQXEsl60m+1oUx0UosfzJ+
         6HD6YaqDifw27U9PB9anWyzHK3RobDD3VWbPfmAUzsOYnXSNUISSgfIPi0SjDmsG+z4h
         9tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o93RGUSe+ygfsACOiKR79noLA/HJS4wxmrTmGVyWD9c=;
        b=k9POn3MfB6qF0nPqCdI6yJe8xxVxX6QbmvT+Nawluf7ZAWJ83KPyXSPyGZ9bcWh4VE
         Zcqj73b9eOXaCv+bBDXdK8zoQ0VsMIG6iWkS9aZ054K9uFfSzSj4jJ9my5bvJfiwHJeN
         R68U7dE5OyLqqgpfY4AYRdyYxtqH8zBf0+4lb4gQYGQoHpO5J+O0rl0vUdWK4eJqZTbk
         waSaSIohJNsHCz2n38CjqpwpKcasVUn8L16NInAoOZcr6suGC6Rh74tIFM/YqPwR8GTp
         wu2rG6I2tDENLIpY12Zh9LZJuBMKv262o4uydyKLsNIOE1S9tKqYeOeBR9gfK3XNRztv
         ZCnQ==
X-Gm-Message-State: AFqh2krltCswm+YSk/PFmzDIGFi91PB+ax+h1H3MfcSoNZ+1aTujCuGC
        NqF9ZyosjTeVjQi/uZpSBfivWaR42GN8xVsFygjmEQ==
X-Google-Smtp-Source: AMrXdXusViWQjcqDzOLejRAyUcdIr65857dE+IhEjEhRmFv45VYDSd1fgiojh1X8rnq2Hd+ZaNwTff7nOt0hEyF8UeQ=
X-Received: by 2002:a05:600c:5d5:b0:3cf:6a4c:af8b with SMTP id
 p21-20020a05600c05d500b003cf6a4caf8bmr4873036wmd.115.1673293242667; Mon, 09
 Jan 2023 11:40:42 -0800 (PST)
MIME-Version: 1.0
References: <Y7xXz+TSpiCbQGjw@kernel.org>
In-Reply-To: <Y7xXz+TSpiCbQGjw@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Jan 2023 11:40:30 -0800
Message-ID: <CAP-5=fVr9nuKH=su5rxWer=o3KML4bk5oEzfUp_gtJBWoF0rgw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tools: Don't install libtraceevent plugins as
 its not anymore in the kernel sources
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 9, 2023 at 10:07 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> While doing 'make -C tools/perf build-test' one can notice error
> messages while trying to install libtraceevent plugins, stop doing that
> as libtraceevent isn't anymore a homie.
>
> These are the warnings dealt with:
>
>    make_install_prefix_slash_O: make install prefix=/tmp/krava/
>     failed to find: /tmp/krava/etc/bash_completion.d/perf
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_cfg80211.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_scsi.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_xen.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_function.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_sched_switch.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_mac80211.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_kvm.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_kmem.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_hrtimer.so
>     failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_jbd2.so
>
> Fixes: 4171925aa9f3f7bf ("tools lib traceevent: Remove libtraceevent")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Link: http://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config |  8 --------
>  tools/perf/tests/make      | 12 ------------
>  2 files changed, 20 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index c2504c39bdcb8992..156440ea019143f8 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1314,14 +1314,6 @@ tip_instdir_SQ = $(subst ','\'',$(tip_instdir))
>
>  export perfexec_instdir_SQ
>
> -# If we install to $(HOME) we keep the traceevent default:
> -# $(HOME)/.traceevent/plugins
> -# Otherwise we install plugins into the global $(libdir).
> -ifdef DESTDIR
> -plugindir=$(libdir)/traceevent/plugins
> -plugindir_SQ= $(subst ','\'',$(plugindir))
> -endif
> -
>  print_var = $(eval $(print_var_code)) $(info $(MSG))
>  define print_var_code
>      MSG = $(shell printf '...%40s: %s' $(1) $($(1)))
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 05e818a8bbad11a4..009d6efb673ce828 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -222,19 +222,7 @@ installed_files_bin := bin/perf
>  installed_files_bin += etc/bash_completion.d/perf
>  installed_files_bin += libexec/perf-core/perf-archive
>
> -installed_files_plugins := $(lib)/traceevent/plugins/plugin_cfg80211.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_scsi.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_xen.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_function.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_sched_switch.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_mac80211.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_kvm.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_kmem.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_hrtimer.so
> -installed_files_plugins += $(lib)/traceevent/plugins/plugin_jbd2.so
> -
>  installed_files_all := $(installed_files_bin)
> -installed_files_all += $(installed_files_plugins)
>
>  test_make_install       := $(call test_dest_files,$(installed_files_all))
>  test_make_install_O     := $(call test_dest_files,$(installed_files_all))
> --
> 2.39.0
>
