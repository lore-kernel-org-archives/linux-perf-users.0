Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA180C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Dec 2021 02:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350901AbhLXCEC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 21:04:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36236 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhLXCEC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 21:04:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B143B82004
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Dec 2021 02:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7396AC36AE9;
        Fri, 24 Dec 2021 02:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640311439;
        bh=wftTPT18IiQ1tylWBMHbgZSJ5k23Isv0k6mWuASkwaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuZKIfMexQA2gVisqETia5F3V6I5iC7x1TlUYYSEOM6ZrROpXXM3mmmGLw9sPzo3c
         h720Fl2nT8CzH3eUDblIdE/Ck7FCpuEAqPDgxvT/Iv/o4BrJVgaY7LDErVSjUMsvmn
         48A4JxkIsV5chLFskWlYQ2esau6zp2G8E5GhOWWY/S8cgY+NO+yJiwGwNEuZNEFD8M
         rc2X3lX8iexu3X902LzsV91YYgwdZmxEkSf6UPeoFDmk4n74S5v1tqKSTZ6exeC0nX
         nAGk4+q9xBF9AHKWT2SQPaSKe5hK35uih0U1PshCYfJ/tdpRtbnq9s/z4hyh269MLl
         spqYfYOVp9k8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1C6140B92; Thu, 23 Dec 2021 23:03:56 -0300 (-03)
Date:   Thu, 23 Dec 2021 23:03:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kevin Grigorenko <kevin.grigorenko@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: Fix perf-record manual typo
Message-ID: <YcUqjPeawdnH2JeV@kernel.org>
References: <OFF9778928.59F62D85-ON002587B3.00757F55-882587B3.00766874@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFF9778928.59F62D85-ON002587B3.00757F55-882587B3.00766874@ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Dec 22, 2021 at 02:33:20PM -0700, Kevin Grigorenko escreveu:
> From: Kevin Grigorenko <kevin.grigorenko@us.ibm.com>
> Date: Wed, 22 Dec 2021 13:21:44 -0800
> Subject: [PATCH] perf: Fix perf-record manual typo
> 
> Signed-off-by: Kevin Grigorenko <kevin.grigorenko@us.ibm.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt 
> b/tools/perf/Documentation/perf-record.txt
> index 3cf7bac67239..52f98d53a97e 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -258,7 +258,7 @@ OPTIONS
>         Call Frame Information) or "lbr" (Hardware Last Branch Record
>         facility).
>  
> -       In some systems, where binaries are build with gcc
> +       In some systems, where binaries are built with gcc
>         --fomit-frame-pointer, using the "fp" method will produce bogus
>         call graphs, using "dwarf", if available (perf tools linked to
>         the libunwind or libdw library) should be used instead.

Can you please check this works with what is in acme/perf/core?

⬢[acme@toolbox perf]$ git checkout perf/core
Switched to branch 'perf/core'
⬢[acme@toolbox perf]$ am
Applying: perf: Fix perf-record manual typo
error: git diff header lacks filename information when removing 1 leading pathname component (line 6)
Patch failed at 0001 perf: Fix perf-record manual typo
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf]$ git am --abort
⬢[acme@toolbox perf]$ git diff
⬢[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
patching file tools/perf/Documentation/perf-record.txt
Hunk #1 FAILED at 258.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/Documentation/perf-record.txt.rej
⬢[acme@toolbox perf]$
