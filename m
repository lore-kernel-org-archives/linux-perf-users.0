Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC4DC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500056137E
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhKQO2H (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:28:07 -0500
Received: from foss.arm.com ([217.140.110.172]:57770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232926AbhKQO2G (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 09:28:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 321691FB;
        Wed, 17 Nov 2021 06:25:08 -0800 (PST)
Received: from [10.57.44.211] (unknown [10.57.44.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 363233F70D;
        Wed, 17 Nov 2021 06:25:04 -0800 (PST)
Subject: Re: [PATCH 1/1] perf arm-spe: report all SPE records as "all" events
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211117142002.226339-1-german.gomez@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <97f15436-a018-5915-b818-8f0c2d60a136@arm.com>
Date:   Wed, 17 Nov 2021 14:25:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211117142002.226339-1-german.gomez@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Forgot to remove the internal change-id tag :)

I will resend, sorry

On 17/11/2021 14:20, German Gomez wrote:
> From: James Clark <james.clark@arm.com>
>
> Currently perf-report and perf-inject are dropping a large number of SPE
> records because they don't contain any of the existing events, but the
> contextual information of the records is still useful to keep.
>
> The synthesized event "all" is generated for every SPE record that is
> processed, regardless of whether the record contains interesting events
> or not. The event can be filtered with the flag "--itrace=o".
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> Change-Id: Ie8169d61df6dc90e5abec7a29c1a5a8510790a1f
>
> [...]
