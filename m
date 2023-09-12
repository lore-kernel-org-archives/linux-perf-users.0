Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB2CA0FE9
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 20:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjILU6F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 16:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjILU6E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 16:58:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34709199
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 13:58:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970DBC433C8;
        Tue, 12 Sep 2023 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694552280;
        bh=M/UsozducGLUnB+9eH/J1CTsaAgt+i/dfguT+iaaZpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2/YlPJSBkJQFYLjIOkoGy9KYKvn5/NIkwQVUfnKMoNS07JCgqw5xA+y4ln0cQvDb
         Pl1jY5jfrDPDGTb644TN/Jsl1imQRmGCEDp2V0qmPQMqe7K+9LDmQn6l2oEvn1q0sN
         fOlDH+/oSybecLC78g8Tf22xmpPY0qFzPWDpr1TGxE3jHwRtKd5APX3bXP46aXSAfx
         U+B7FFyXRSxQ4g9bJG4NwWzay9VS/S9z97YpR8bJ5rEfSaFgyTmsgXKT7OpRL9BvlD
         WKtMmOExkPdWYyRtq3Rdj+QQ5KzbjYuRTu5fijxKFz9db5fKLs+tZ3qxbTLmV0632o
         Ho6bZri+HNdeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0830F403F4; Tue, 12 Sep 2023 17:57:57 -0300 (-03)
Date:   Tue, 12 Sep 2023 17:57:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     vmolnaro@redhat.com
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        mpetlan@redhat.com
Subject: Re: [PATCH 1/2] perf test lock_contention.sh: Skip test if the
 number of CPUs is low
Message-ID: <ZQDQ1Qqg+zm59OTO@kernel.org>
References: <20230912121926.12111-1-vmolnaro@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912121926.12111-1-vmolnaro@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 12, 2023 at 02:19:25PM +0200, vmolnaro@redhat.com escreveu:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Machines with less then 4 CPUs weren't consistently triggering lock
> events required for the test.
> 
> Skip the test on those machines. The limit of 4 CPUs is set as it
> generates around 100 lock events for a test.

Better, but still some issues, fixing manually.

⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20230912121926.12111-1-vmolnaro@redhat.com
Grabbing thread from lore.kernel.org/all/20230912121926.12111-1-vmolnaro%40redhat.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 4 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH 1/2] perf test lock_contention.sh: Skip test if the number of CPUs is low
    + Acked-by: Michael Petlan <mpetlan@redhat.com> (✓ DKIM/redhat.com)
    + Link: https://lore.kernel.org/r/20230912121926.12111-1-vmolnaro@redhat.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH 2/2] perf test stat+shadow_stat.sh: Add threshold for rounding errors
    + Acked-by: Michael Petlan <mpetlan@redhat.com> (✓ DKIM/redhat.com)
    + Link: https://lore.kernel.org/r/20230912121926.12111-2-vmolnaro@redhat.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✓ Signed: DKIM/redhat.com
---
Total patches: 2
---
 Link: https://lore.kernel.org/r/20230912121926.12111-1-vmolnaro@redhat.com
 Base: not specified
       git am ./20230912_vmolnaro_perf_test_lock_contention_sh_skip_test_if_the_number_of_cpus_is_low.mbx
⬢[acme@toolbox perf-tools-next]$ git diff
⬢[acme@toolbox perf-tools-next]$        git am ./20230912_vmolnaro_perf_test_lock_contention_sh_skip_test_if_the_number_of_cpus_is_low.mbx
Applying: perf test lock_contention.sh: Skip test if the number of CPUs is low
.git/rebase-apply/patch:13: trailing whitespace.
	fi 
warning: 1 line adds whitespace errors.
Applying: perf test stat+shadow_stat.sh: Add threshold for rounding errors
⬢[acme@toolbox perf-tools-next]$ 


> ---
>  tools/perf/tests/shell/lock_contention.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> index f2cc187b618..1d3598ff6a0 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -31,6 +31,12 @@ check() {
>  		echo "[Skip] No lock contention tracepoints"
>  		err=2
>  		exit
> +	fi 
> +
> +	if [ `nproc` -lt 4 ]; then
> +		echo "[Skip] Low number of CPUs (`nproc`), lock event cannot be triggered certainly"
> +		err=2
> +		exit
>  	fi
>  }
>  
> -- 
> 2.41.0
> 

-- 

- Arnaldo
