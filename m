Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BCAC61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Mar 2023 11:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCFLqO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Mar 2023 06:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCFLqN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Mar 2023 06:46:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851D29145;
        Mon,  6 Mar 2023 03:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:From:Date:Sender:Reply-To:To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VEO5rZX9aUxlm52Tvt9jQZD1KJto3XAZL4lzHbryAVo=; b=L0m35GrCZ5+wjT6kNwQn654CCj
        +Hu+BPxnPriRk1x/JnGx15F9T3XiRKSh0mnUepYB0sxjqeFXmKEYihcm33W9fiyMzLws2mBX6niIv
        V1cU7iW9k/bBPM1gy5EK0SnhYP9wyJqWWQ8aTiJllrl7R9+r2N5QHbzQXSFws1rVB1lDjQVPwWwPm
        H8Y0fO+yYU1eZc0iZthtypPg6lEx6oOLiZdAamjjJafYDi6FMH9SjKfR7+FW4/UOvctI0IS1qaJX4
        G3tE/zL4WgYPrgxUypvbVrd17p+nupLFbSYMz71bJuL/m6XCaWkHwpDMIrz3/Xl4l2nIcS6lUn/Vn
        gswM5UIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pZ9I2-00GelC-2t;
        Mon, 06 Mar 2023 11:46:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7277F300137;
        Mon,  6 Mar 2023 12:46:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6345723B586C3; Mon,  6 Mar 2023 12:46:02 +0100 (CET)
Date:   Mon, 6 Mar 2023 12:46:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH] perf/core: introduced stub APIs for exported APIs
Message-ID: <20230306114602.GD1267364@hirez.programming.kicks-ass.net>
References: <20230305053934.9948-1-bhardwajmanish18@gmail.com>
 <20230305092759.10754-1-bhardwajmanish18@gmail.com>
 <CAPLwjC7=SS2v2qU==mAUrS=SH1Fmg0bXQx4Swnqh8ndSCvULEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPLwjC7=SS2v2qU==mAUrS=SH1Fmg0bXQx4Swnqh8ndSCvULEw@mail.gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Mar 05, 2023 at 03:24:27PM +0530, manish bhardwaj wrote:
> Can you guys, please let me know how and where I can track this patch in
> patchwork?

What's a patchwork, also top posting, srsly?
