Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EACECAAA1
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Sep 2022 12:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiIFMnQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Sep 2022 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiIFMnQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Sep 2022 08:43:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD7C2E6AE;
        Tue,  6 Sep 2022 05:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45E2CCE173B;
        Tue,  6 Sep 2022 12:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC27C433D6;
        Tue,  6 Sep 2022 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662468191;
        bh=K1By8u+CDbblwN0y0TTXazWMEbqs/OvrwXrnQXuktpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DO363IeC6gTuoRQBOOEynysmtFUPQYOjwurjDT+zeYYU/AjYgyJYzHTro2BbznpqA
         BIvxeX4Y0C+wA8/8UTQL1T04BNYEK62pLwY0sVYUNPSgPVxlCmbX9FOLItd8Z4kPX6
         diOhocnouB+ju3ljWiMZ9sct4jLkgca1UhxdVOM4Xo5kMtLIxuYdhA4jcTV2dAmiGd
         mSY/5tT9W6i+VW+crHwmyJ4yM3RAvJ8sK1XnzyirYjst1Zk69m6tIEYl0OMeX+Q5+J
         NFBFf0vHbIEaNyUu3QjMh/IrpHe9sjRdnupKLLFqNKuKur3s2UrHVAMxCG3P7YP+M7
         352ZljpjJ3DKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE919404A1; Tue,  6 Sep 2022 09:43:08 -0300 (-03)
Date:   Tue, 6 Sep 2022 09:43:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] perf: Clean up and fix potential mem leak
Message-ID: <YxdAXFowH/JbPV78@kernel.org>
References: <20220906032906.21395-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906032906.21395-1-shangxiaojing@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 06, 2022 at 11:29:03AM +0800, Shang XiaoJing escreveu:
> Some clean up in perf.c and builtin-c2c.c.
> 
> changes from v2:
> - clear omissible free label in c2c_he_zalloc.

Thanks, applied [12]/3 to perf/core for Linux v6.1.

- Arnaldo

 
> Shang XiaoJing (3):
>   perf clean: Add same_cmd_with_prefix helper
>   perf c2c: Add helpers to get counts of loads or stores
>   perf c2c: Prevent potential memory leak in c2c_he_zalloc
> 
>  tools/perf/builtin-c2c.c | 77 +++++++++++++++++++---------------------
>  tools/perf/perf.c        | 12 +++++--
>  2 files changed, 46 insertions(+), 43 deletions(-)
> 
> -- 
> 2.17.1

-- 

- Arnaldo
