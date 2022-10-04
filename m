Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E5CC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 13:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJDNis (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJDNir (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2022 09:38:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F94DB67
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Oct 2022 06:38:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1J4Vbbz4xGs;
        Wed,  5 Oct 2022 00:38:44 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     jolsa@kernel.org, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        acme@kernel.org, mpe@ellerman.id.au
Cc:     kjain@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, disgoel@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, linux-perf-users@vger.kernel.org
In-Reply-To: <20220921145255.20972-1-atrajeev@linux.vnet.ibm.com>
References: <20220921145255.20972-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: (subset) [PATCH V2 1/3] powerpc/perf: Fix branch_filter support for multiple filters in powerpc
Message-Id: <166488994565.779920.440863414238574866.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:25:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 21 Sep 2022 20:22:53 +0530, Athira Rajeev wrote:
> For PERF_SAMPLE_BRANCH_STACK sample type, different branch_sample_type
> ie branch filters are supported. The branch filters are requested via
> event attribute "branch_sample_type". Multiple branch filters can be
> passed in event attribute.
> 
> Example:
> perf record -b -o- -B --branch-filter any,ind_call true
> 
> [...]

Patch 3 applied to powerpc/next.

[3/3] tools/testing/selftests/powerpc: Update the bhrb filter sampling test to test for multiple branch filters
      https://git.kernel.org/powerpc/c/18213532de7156af689cb0511d2f95bcbe3c98a0

cheers
