Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2502C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Feb 2022 13:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbiBQNTg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:19:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiBQNTg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Feb 2022 08:19:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE912AE714;
        Thu, 17 Feb 2022 05:19:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F27B61BC4;
        Thu, 17 Feb 2022 13:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237E3C340E9;
        Thu, 17 Feb 2022 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645103960;
        bh=4EyEkWFqrHHaf+rJiEPSN1RBWYPrrcSmy23C9np2YRk=;
        h=From:To:Cc:Subject:Date:From;
        b=WHelvKVDfsFke/qLmJjKQGeO8J1BcsSAKCuZxV0PTASlG9ZPvNcNPNOXjkVnBCaDI
         HJOO/HpMbDQK0/hYuhTnR8ZR+xtJWLQo3ckgjpWVivqMuW0j2U+7ALXRBYx3eX/Hoq
         PicImU5n68NVmWZ/GTb6ueBRq+h/VS6sGM6gKr85nuD7ASr8Yh+Abmfo6VoUVK40/8
         5P+fKQ7W0ndWpVAhe4+ajU5gEjkhg8CcjKGLiYI9Tha5e2+TbQ+ag5/kxvtvQPxyNc
         kPns+u0TTRpyjfQ8/bdTZJJEQFO2F1b//Nj0v+bz1JsS/lwbROfvyeYqGog0r5+Ep9
         Rb74O5dcuCiKg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCHv2 0/3] perf/bpf: Replace deprecated code
Date:   Thu, 17 Feb 2022 14:19:13 +0100
Message-Id: <20220217131916.50615-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

hi,
the original patchset [1] removed the whole perf functionality
with the hope nobody's using that. But it turned out there's
actually bpf script using prologue functionality, so there
might be users of this.

This patchset gets rid of and adds workaround (and keeps the
current functionality) for following deprecated libbpf
functions/struct:

  bpf_program__set_priv
  bpf_program__priv
  bpf_map__set_priv
  bpf_map__priv
  bpf_program__set_prep
  bpf_program__nth_fd
  struct bpf_prog_prep_result

Basically it implements workarounds suggested by Andrii in [2].

I tested with script from examples/bpf that are working for me:

  examples/bpf/hello.c
  examples/bpf/5sec.c

The rest seem to fail for various reasons even without this
change..  they seem unmaintained for some time now, but I might
have wrong setup.

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/depre

thanks,
jirka


[1] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#t
[2] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#md3ccab9fe70a4583e94603b1a562e369bd67b17d
---
Jiri Olsa (3):
      perf tools: Remove bpf_program__set_priv/bpf_program__priv usage
      perf tools: Remove bpf_map__set_priv/bpf_map__priv usage
      perf tools: Rework prologue generation code

 tools/perf/util/bpf-loader.c | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 230 insertions(+), 37 deletions(-)
