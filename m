Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5064FC25B4E
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 06:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjAXGfi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 01:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjAXGff (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 01:35:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02FB3E08D
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 22:34:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g73-20020a25db4c000000b00802b0159bccso10635731ybf.22
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 22:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9CQf7qwf816ywxYe0MGvN2DXuLUyDOCX6uxlx6OMLsg=;
        b=E/aDkM7K/lA4FaRlkpePHCMT3UVODvM17F6GurRPNTGwzR4OIm/m3KHjNuJWMKh8Du
         shSVKsu9+W4MoZRyUeStedTnW1kfbIwvd15RkKq28atlPKIhjdpYnvGoaDsvUS5yL0+5
         WM0WNKkEab2aKJpq07OjmYwyxbkFWrmTRvfkMmW9qztdWsDFxsxIVPOIOgZnjPyk9bVE
         Gjee1xhFG2B18924+GoEvcEEh1mcGkiW1eiaZZNDqwlNxpKKxtqofR6tpSfzTjfzPt92
         QHNfUKeKHmiH2OkS72MKotSYJydW6zVrQF07xDsX/nn7fEQ+QB/D9IT4iQZJZUyfVIcb
         mo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CQf7qwf816ywxYe0MGvN2DXuLUyDOCX6uxlx6OMLsg=;
        b=2mZjE2UDRe87EkxOOXMFiU2KpikH0NkcI4yiCfacVcTbgOcS0JhCgzr3xMupo235je
         Km6Ywu6xFZY93haeKNvLey30j0a8dq2QTt2FtYG8GwpEZGjupNBSJH2O0MRv8W3h7D5m
         C7Nmm81tC0Caam0Q8Y1Q/IIyO2fF90vzYsQuW0L+esUM1wE9vU+oxAzM117NpPZgBtsK
         9zkGUgesre+63oN0wKfIWUDiYig4v8rjNSN20IOIKROTyGuLMU7hfCQ/hOxgJJlxzTKd
         Nz3zAreZzWkADIm0jLq4voLqbC7O/O4mKk3QTUAjp573J8qe07f4cH0Orxiox7tHrf+M
         S0/A==
X-Gm-Message-State: AFqh2kpH98ObU3+zSWeRH7WhbYUw//aa50lgCz4HTewo+snXKlobsDwc
        LaRmFg6qjGZXbOhK4wY23fNuKgsHGZ2K
X-Google-Smtp-Source: AMrXdXtzoentlV7UmGLWsQR0SkxQ5u2HBNb4nnRJgT9cvccOfzAGu8MysRvoSaTaE2B0Dti7zL52DJHCOUj3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a25:d4d3:0:b0:7d1:f411:4f5a with SMTP id
 m202-20020a25d4d3000000b007d1f4114f5amr3000373ybf.599.1674542096878; Mon, 23
 Jan 2023 22:34:56 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:33:20 -0800
In-Reply-To: <20230124063320.668917-1-irogers@google.com>
Message-Id: <20230124063320.668917-12-irogers@google.com>
Mime-Version: 1.0
References: <20230124063320.668917-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3 11/11] perf jevents: Add model list option
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This allows the set of generated jevents events and metrics be limited
to a subset of the model names. Appropriate if trying to minimize the
binary size where only a set of models are possible. On ARM64 the
--model selects the implementor rather than model.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build      | 3 ++-
 tools/perf/pmu-events/jevents.py | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 15b9e8fdbffa..a14de24ecb69 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -10,6 +10,7 @@ JEVENTS_PY	=  pmu-events/jevents.py
 ifeq ($(JEVENTS_ARCH),)
 JEVENTS_ARCH=$(SRCARCH)
 endif
+JEVENTS_MODEL ?= all
 
 #
 # Locate/process JSON files in pmu-events/arch/
@@ -23,5 +24,5 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
 else
 $(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY) pmu-events/metric.py
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
 endif
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 627ee817f57f..764720858950 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -888,12 +888,19 @@ def main() -> None:
           action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
     """Replicate the directory/file walking behavior of C's file tree walk."""
     for item in os.scandir(path):
+      if (len(parents) == 0 and item.is_dir() and _args.model != 'all' and
+          'test' not in item.name and item.name not in _args.model.split(',')):
+        continue
       action(parents, item)
       if item.is_dir():
         ftw(item.path, parents + [item.name], action)
 
   ap = argparse.ArgumentParser()
   ap.add_argument('arch', help='Architecture name like x86')
+  ap.add_argument('model', help='''Select a model such as skylake to
+reduce the code size.  Normally set to "all". For architectures like
+ARM64 with an implementor/model, this selects the implementor.''',
+                  default='all')
   ap.add_argument(
       'starting_dir',
       type=dir_path,
-- 
2.39.0.246.g2a6d74b583-goog

