Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC314EB64DA
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFMUeV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjFMUeV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 16:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B0DC
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 13:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60EAF63AB9
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 20:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F759C433C8;
        Tue, 13 Jun 2023 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686688458;
        bh=jwNp4h9PPEmYXaB0IJltuMdZjveh3KTKFfP9o02XV4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wk7pTSUE9YZG6Qzyiy/LXXi9unpTZEKB6P6Wl2VeX5UcV5Rpe1MwPOzgzajVVoqD4
         DmzILRapqXpUeg++De+d8OTR5Gx93TZ40ZRsrOhFjxAL3uF8inM3Cl83BIEF9BNG44
         qWb37EZ5sSVUZLPAjaCICNi3yo9aezcsQw3aIbF0wr2pmusjqFkkzWDE9TER23bi8p
         6HtPjLPKmK84T8a8TcBwDY0JaSVAnaakRjJvAdX+W79M3STSQZvdUMfEE78po1siCE
         Er0OxeMmAMT86IXmkQTJDYq/m1Il3eA0JuGoRNIKG9DMCiakp8OmeOvaZsQpEFG34S
         FMWe7X/aqsGuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A42240692; Tue, 13 Jun 2023 17:34:16 -0300 (-03)
Date:   Tue, 13 Jun 2023 17:34:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        ravi.bangoria@amd.com, john.g.garry@oracle.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH 00/17] tool/perf/test: Fix shellcheck coding/formatting
 issues of test shell scripts
Message-ID: <ZIjSxwyna2ExW8JQ@kernel.org>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 13, 2023 at 10:11:28PM +0530, Athira Rajeev escreveu:
> Patchset covers a set of fixes for coding/formatting issues observed while
> running shellcheck tool on the perf test shell scripts. Shellcheck is a static
> analysis tool that can find semantic/syntax bugs in the shell scripts.

Thanks, applied the series.

- Arnaldo
 
> Patches 1-14 fixes the issues found with shellcheck. Patch 15, 16
> and patch 17 address a fix in task_analyzer test.
> 
> This cleanup is a pre-requisite to include a build option for shellcheck
> discussed here: https://www.spinics.net/lists/linux-perf-users/msg25553.html
> Also this is first set of patches. There will be one more set which will
> include build option for shellcheck as discussed in the mail thread.
> 
> Abhirup Deb (2):
>   tools/perf/tests: fix test_arm_spe.sh signal case issues
>   perf/tests/shell: fix shellscript errors for lock_contention.sh
> 
> Aboorva Devarajan (1):
>   tools/perf/tests: Fix shellcheck issues in test_task_analyzer.sh file
> 
> Aditya Gupta (3):
>   perf tests task_analyzer: fix bad substitution ${$1}
>   perf tests task_analyzer: print command on failure
>   perf tests task_analyzer: skip tests if no libtraceevent support
> 
> Akanksha J N (1):
>   tools/perf/tests: Fix shellcheck warnings for
>     trace+probe_vfs_getname.sh
> 
> Anushree Mathur (1):
>   perf/tests/shell : Shellcheck fixes for perf test
>     "test_arm_coresight.sh"
> 
> Barnali Guha Thakurata (1):
>   tools/perf/tests/shell/stat_all_metrics: Fix shellcheck warning SC2076
>     in stat_all_metrics.sh
> 
> Disha Goel (1):
>   tools/perf/tests: fix shellcheck warning for stat+json_output
> 
> Geetika (1):
>   tools/perf/tests: Fix all POSIX sh warnings in perf shell test
>     test_brstack.sh
> 
> Korrapati Likhitha (1):
>   tools/perf/tests: Fix shellcheck warnings for stat+csv_output
> 
> Samir Mulani (1):
>   tools/perf/tests: fixed shellcheck warnings for perf shell scripts
> 
> Shirisha G (1):
>   tools/perf/tests: fix shellcheck warnings for daemon.sh
> 
> Sourabh Jain (1):
>   perf: get rid of unused import
> 
> Spoorthy S (2):
>   shellcheck : fixing signal names and adding double quotes for
>     expression in test_arm_callgraph_fp
>   tools/perf/tests: Fix all POSIX sh warnings in stat+shadow_stat.sh
> 
>  .../scripts/python/arm-cs-trace-disasm.py     |   1 -
>  tools/perf/tests/shell/buildid.sh             |  12 +-
>  tools/perf/tests/shell/daemon.sh              | 113 ++++++++++++------
>  tools/perf/tests/shell/lock_contention.sh     |  70 +++++------
>  .../shell/record+probe_libc_inet_pton.sh      |   6 +-
>  .../shell/record+script_probe_vfs_getname.sh  |   4 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |   4 +-
>  tools/perf/tests/shell/stat+json_output.sh    |   2 +-
>  tools/perf/tests/shell/stat+shadow_stat.sh    |   4 +-
>  tools/perf/tests/shell/stat_all_metrics.sh    |   6 +-
>  .../perf/tests/shell/test_arm_callgraph_fp.sh |   6 +-
>  tools/perf/tests/shell/test_arm_coresight.sh  |   6 +-
>  tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
>  tools/perf/tests/shell/test_brstack.sh        |  12 +-
>  tools/perf/tests/shell/test_task_analyzer.sh  |  98 ++++++++-------
>  .../tests/shell/trace+probe_vfs_getname.sh    |   6 +-
>  16 files changed, 203 insertions(+), 149 deletions(-)
> 
> -- 
> 2.39.1
> 

-- 

- Arnaldo
