Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDDEC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 16:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA3861C12
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 16:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhKQQae (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:30:34 -0500
Received: from foss.arm.com ([217.140.110.172]:60120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhKQQab (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 11:30:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 624F41FB;
        Wed, 17 Nov 2021 08:27:32 -0800 (PST)
Received: from [10.57.44.211] (unknown [10.57.44.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95A273F5A1;
        Wed, 17 Nov 2021 08:27:29 -0800 (PST)
Subject: Re: [PATCH 1/1] perf arm-spe: Inject SPE samples in perf-inject
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211105104130.28186-1-german.gomez@arm.com>
 <20211105104130.28186-2-german.gomez@arm.com>
 <5163f41f-2337-6557-ca91-fb2c66738872@arm.com> <YZUf5zu4aOfoIhFl@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <aa79a8eb-e7fa-ad81-f4a3-a843b63020b2@arm.com>
Date:   Wed, 17 Nov 2021 16:27:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZUf5zu4aOfoIhFl@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On 17/11/2021 15:29, Arnaldo Carvalho de Melo wrote:
> [...]
> Next time please expand this explanations a bit more: why should we
> inject such samples? Is this enabling some new mode of operation, fixing
> something, what is an example of output before this patch and after it?
I will keep this in mind, thanks. In this case the support was missing
and I included the context in the cover letter but not the commit msg.

Thanks,
German
>
> - Arnaldo
>
> [...]
