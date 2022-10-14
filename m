Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF06C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Oct 2022 20:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJNUWr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiJNUWp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Oct 2022 16:22:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49861D4418
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2022 13:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84755B82415
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2022 20:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1242EC433C1;
        Fri, 14 Oct 2022 20:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665778962;
        bh=exqzR5njiqLWWiXNN2w3BDWQrOSrTJ7Jr0VCCka02Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2+KNT3kBYTq4evrXrKk8gZeXApAQvzfRCfOxN/NYYQgoAsLD4anOCjdbdsaoJkxW
         IPywtFQZccJMBUUidSwEaWw5SS85scKH7QKosyyjtb2AbJQ61mNVnYaiE3/1j59Wqh
         HFG0TiTEFa3aRUx5Q7fU0fWh4Rsw9+y5n56DGPT57jH8FE5rFwQDZ3w5cUbdaIE3Tu
         ySOmogr/NHMZXG1Zj5HpEmdWZqGLB751VSkC2dWbXB8I1EaRfjuSL/9Bf7/pyCBevQ
         gXsGgjetUPjcNjnCnDxi6BxZ5yiJp1tqqZp6YU24l1s2fFZloe7so9W5n4Jdhqw1Ym
         B/qf7zyQX5Skg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8EA0C4062C; Fri, 14 Oct 2022 17:22:39 -0300 (-03)
Date:   Fri, 14 Oct 2022 17:22:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] tools/perf/tests/shell: Update stat+csv_output.sh to
 include sanity check for topology
Message-ID: <Y0nFD7lo6Gdm1bgd@kernel.org>
References: <20221006155149.67205-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006155149.67205-1-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 06, 2022 at 09:21:48PM +0530, Athira Rajeev escreveu:
> Testcase stat+csv_output.sh fails in powerpc:
> 
> 	84: perf stat CSV output linter: FAILED!

Thanks, applied both patches.

- Arnaldo
