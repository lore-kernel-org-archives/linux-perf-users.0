Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A06AC4708F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 18:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724B9613D1
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 18:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhFASXD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 14:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234586AbhFASXC (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EC3E613D1;
        Tue,  1 Jun 2021 18:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622571680;
        bh=VpUmjGOvJByu/T88DngjYnAK6QQZStRS/EuB63qLZi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6WQfx/T/KGSXEN8vuQbRjwDr8oLoYJjrjqWX9y70WHOyylymrYkLd8DGfMX2t1Z8
         KrZxxMtA0eJdf3o4JZ8UhNzKh9qgRhYgjluXGPHE4UlNSLz14orudAUz0zpKiGnKOT
         wnzbiN3Nxv5zKxV0Ibyyb5qwomuImhkLMdwdQ9+oUAO3NE8QvLe3iO60rpe/VINY96
         fkaQ6/eFXd5jIDHn2mE8NWVpFXb8VLTaXx7Gi5vGwGyMLQN3ZrVUQhgXwhFN9Qs4Lv
         mL71RJi7i3A2oLGcVPOba/ZLyfw6zU3wgBfa2FseEZdpn6GgKL+omRojFbLF4tS8nj
         uIV2ZcniGafgw==
From:   Will Deacon <will@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: perf: Convert snprintf to sysfs_emit
Date:   Tue,  1 Jun 2021 19:21:01 +0100
Message-Id: <162255350340.566186.10036396302405143953.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1621497585-30887-1-git-send-email-tiantao6@hisilicon.com>
References: <1621497585-30887-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 20 May 2021 15:59:45 +0800, Tian Tao wrote:
> Use sysfs_emit instead of snprintf to avoid buf overrun,because in
> sysfs_emit it strictly checks whether buf is null or buf whether
> pagesize aligned, otherwise it returns an error.

Applied to will (for-next/perf), thanks!

[1/1] arm64: perf: Convert snprintf to sysfs_emit
      https://git.kernel.org/will/c/a5740e955540

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
