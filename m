Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D9CC4320E
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 10:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E862F60EBC
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhHKKp0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 06:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237110AbhHKKpZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Aug 2021 06:45:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E9C060E52;
        Wed, 11 Aug 2021 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628678701;
        bh=DGwBYKZgAkmUXXur2c5GmVWRThYFOxpgNCN2rUtsSr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6sbwDLF1lpnyWBO5A9yI7LyQG29rwwVrg3q81KPe3aDxNdZrnSPEBzo+PEGwIHnE
         Rr4RGfhHxi74OCbzu6GFJVZNMAtaly3TOKyrhLtcmAZVNPqH/DX7VmzQ7Gaoki6zdn
         oGbpJ+s2CVk6fqn3E0Inc/mONS61zFOvXOI60WOkX0/YCnln4Axl0uHKQ1JImMcgK1
         6cCefWZbXr/t2y48wILE8kQaQrfchd1YX7cZj67ApvaBemneCUojwkIUt3yMcrzdQz
         ToaGYSYqyXLE2xDMl/7JRqKTkvE4CTfyP2E6OTOzHqLrbISbpfPCa+hpniOeVPJYRA
         2A7Bq3N6AglrQ==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2] arm64/perf: Replace '0xf' instances with ID_AA64DFR0_PMUVER_IMP_DEF
Date:   Wed, 11 Aug 2021 11:44:54 +0100
Message-Id: <162867613362.1661207.9902910168999427938.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1628652427-24695-2-git-send-email-anshuman.khandual@arm.com>
References: <1628652427-24695-1-git-send-email-anshuman.khandual@arm.com> <1628652427-24695-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 11 Aug 2021 08:57:07 +0530, Anshuman Khandual wrote:
> ID_AA64DFR0_PMUVER_IMP_DEF which indicate implementation defined PMU, never
> actually gets used although there are '0xf' instances scattered all around.
> Just do the macro replacement to improve readability.

Applied to will (for-next/perf), thanks!

[1/1] arm64/perf: Replace '0xf' instances with ID_AA64DFR0_PMUVER_IMP_DEF
      https://git.kernel.org/will/c/fd264b310579

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
