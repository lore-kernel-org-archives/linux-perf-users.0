Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3DEEE3F29
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 21:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjILVBk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 17:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjILVBk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 17:01:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBD6199
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 14:01:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20C8C433C7;
        Tue, 12 Sep 2023 21:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694552496;
        bh=IqmP/sSoVCIfMVPR3GUsXSF5sm6uKotcSjGYHUSipl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCpE/67ITfR+E/xq7TblVY4eOBJ4T24g/jSgPQZ5kGcwJh8JBWi/QGvtbPAceBsKW
         bnE11pMmi5QOJQWLdghWfo3g3W/wkXSiz4vUZhZldSxrPBjk7SKOQRIHAKoG/uG7ba
         UoLbQkNpkBMIM3LnK5bgfxpjgyZJhbu7jiKjgEsKNMyFD5yHNLnfPBJdnpNLQn6azm
         OMPQLcbsHaqfow/q4NVIhbrEz+Pu8lEMLmk+5daD1OW2juHyCQNtWhiFI3Yc4OCfu5
         n8ljZ9APnkCL3jWZpI2Mu9Q4IOEAHeBKZq4y1wjDwo283pUG7svqu1IvDfxoEtBDiM
         J7BHFYdce/wgQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54680403F4; Tue, 12 Sep 2023 18:01:33 -0300 (-03)
Date:   Tue, 12 Sep 2023 18:01:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     vmolnaro@redhat.com
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        mpetlan@redhat.com
Subject: Re: [PATCH 2/2] perf test stat+shadow_stat.sh: Add threshold for
 rounding errors
Message-ID: <ZQDRrcZFAvHpqDLn@kernel.org>
References: <20230912121926.12111-1-vmolnaro@redhat.com>
 <20230912121926.12111-2-vmolnaro@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912121926.12111-2-vmolnaro@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 12, 2023 at 02:19:26PM +0200, vmolnaro@redhat.com escreveu:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> The test was failing in specific scenarios due to imperfection of FP
> arithmetics. The `bc` command wasn't correctly rounding the result
> of division causing the failure.
> 
> Replace the `bc` with `awk` which should work with more decimal
> places and add a threshold to catch any possible rounding errors.
> The acceptable rounding error is set to 0.01 when the test
> passes with a warning message.
> ---
>  tools/perf/tests/shell/stat+shadow_stat.sh | 30 +++++++++++++++++-----
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
> index 0e9cba84e75..73c990fe5ee 100755
> --- a/tools/perf/tests/shell/stat+shadow_stat.sh
> +++ b/tools/perf/tests/shell/stat+shadow_stat.sh
> @@ -4,6 +4,8 @@
>  
>  set -e
>  
> +TRESHOLD=0.015

You got it right on the patch description, I fixed it here as:

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index 626d669158d2d089..a7e4a8f2ad186458 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -4,7 +4,7 @@

 set -e

-TRESHOLD=0.015
+THRESHOLD=0.015

 # skip if system-wide mode is forbidden
 perf stat -a true > /dev/null 2>&1 || exit 2
@@ -38,7 +38,7 @@ test_global_aggr()
                res=`echo $num $cyc | awk '{printf "%.2f", $1 / $2}'`
                if [ "$ipc" != "$res" ]; then
                        # check the difference from the real result for FP imperfections
-                       diff=`echo $ipc $res $TRESHOLD | \
+                       diff=`echo $ipc $res $THRESHOLD | \
                        awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`

                        if [ $diff -eq 1 ]; then
@@ -80,7 +80,7 @@ test_no_aggr()
                res=`echo $num $cyc | awk '{printf "%.2f", $1 / $2}'`
                if [ "$ipc" != "$res" ]; then
                        # check difference from the real result for FP imperfections
-                       diff=`echo $ipc $res $TRESHOLD | \
+                       diff=`echo $ipc $res $THRESHOLD | \
                        awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`

                        if [ $diff -eq 1 ]; then
⬢[acme@toolbox perf-tools-next]$
