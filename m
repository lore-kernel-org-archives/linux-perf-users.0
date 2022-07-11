Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F4C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Jul 2022 12:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiGKMu1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiGKMu0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Jul 2022 08:50:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1338729CB7;
        Mon, 11 Jul 2022 05:50:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 440301576;
        Mon, 11 Jul 2022 05:50:26 -0700 (PDT)
Received: from [10.1.34.132] (e127744.cambridge.arm.com [10.1.34.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C47243F792;
        Mon, 11 Jul 2022 05:50:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] perf test: Add test for branch stack sampling
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20220705150511.473919-1-german.gomez@arm.com>
 <20220705150511.473919-2-german.gomez@arm.com>
 <CAM9d7chzi9h+w5n_dXwAVwAgh-UyEQveVBh4ZenU60gUTDfrTg@mail.gmail.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <a868cbac-624d-bf6d-fc29-69390532796b@arm.com>
Date:   Mon, 11 Jul 2022 13:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7chzi9h+w5n_dXwAVwAgh-UyEQveVBh4ZenU60gUTDfrTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 08/07/2022 21:31, Namhyung Kim wrote:
> Hello,
>
> On Tue, Jul 5, 2022 at 8:05 AM German Gomez <german.gomez@arm.com> wrote:
>> Add a self test for branch stack sampling, to check that we get the
>> expected branch types, and filters behave as expected.
>>
>> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks a lot Namhyung!

>
> Thanks,
> Namhyung
