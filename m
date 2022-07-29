Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E049C19F29
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 13:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiG2NLM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiG2NKr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3F222A2;
        Fri, 29 Jul 2022 06:10:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSYs1F4vz4x1c;
        Fri, 29 Jul 2022 23:10:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        mpe@ellerman.id.au, acme@kernel.org
Cc:     kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        irogers@google.com, linuxppc-dev@lists.ozlabs.org,
        rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.vnet.ibm.com
In-Reply-To: <20220520084630.15181-1-atrajeev@linux.vnet.ibm.com>
References: <20220520084630.15181-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/2] powerpc/perf: Add support for caps under sysfs in powerpc
Message-Id: <165909971373.253830.11662171769797597633.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:01:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 20 May 2022 14:16:29 +0530, Athira Rajeev wrote:
> Add caps support under "/sys/bus/event_source/devices/<pmu>/"
> for powerpc. This directory can be used to expose some of the
> specific features that powerpc PMU supports to the user.
> Example: pmu_name. The name of PMU registered will depend on
> platform, say power9 or power10 or it could be Generic Compat
> PMU.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/perf: Add support for caps under sysfs in powerpc
      https://git.kernel.org/powerpc/c/6320e693d98c7430653866b7ca6679338134cb79
[2/2] docs: ABI: sysfs-bus-event_source-devices: Document sysfs caps entry for PMU
      https://git.kernel.org/powerpc/c/999d7c47a0f737157608b9b0d2d37bdd1afec58c

cheers
