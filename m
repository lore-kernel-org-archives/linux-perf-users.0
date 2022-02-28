Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30DBC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Feb 2022 11:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiB1L6W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiB1L6V (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Feb 2022 06:58:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 563DBE6D;
        Mon, 28 Feb 2022 03:57:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 752C7ED1;
        Mon, 28 Feb 2022 03:57:40 -0800 (PST)
Received: from [10.1.39.130] (e127744.cambridge.arm.com [10.1.39.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A90BD3F73D;
        Mon, 28 Feb 2022 03:57:37 -0800 (PST)
Subject: Re: [PATCH] perf test: Add perf_event_attr tests for the arm_spe
 event
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, James Clark <james.clark@arm.com>
References: <20220126160710.32983-1-german.gomez@arm.com>
 <20220205081013.GA391033@leoy-ThinkPad-X240s>
 <37a1a2f9-2c94-664f-19fb-8337029b8fe5@arm.com>
 <20220207110325.GA73277@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <08166ea7-243b-b662-0913-6edf6abcd458@arm.com>
Date:   Mon, 28 Feb 2022 11:56:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220207110325.GA73277@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 07/02/2022 11:03, Leo Yan wrote:
> [...]
> Thanks for confirmation, German.
>
> You could add my testing tag for this patch:
>
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks Leo
