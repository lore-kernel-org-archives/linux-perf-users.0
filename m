Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD80AC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 10:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1AB61175
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 10:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbhKIKo2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 05:44:28 -0500
Received: from foss.arm.com ([217.140.110.172]:60004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242487AbhKIKoU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 05:44:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0DFEED1;
        Tue,  9 Nov 2021 02:41:34 -0800 (PST)
Received: from [10.57.46.99] (unknown [10.57.46.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D451B3F7F5;
        Tue,  9 Nov 2021 02:41:31 -0800 (PST)
Subject: Re: [PATCH 2/3] perf arm-spe: Save context ID in record
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211102180739.18049-1-german.gomez@arm.com>
 <20211102180739.18049-3-german.gomez@arm.com>
 <20211106134725.GI477387@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <55338d60-bb75-48b8-66bb-87d74a6752b3@arm.com>
Date:   Tue, 9 Nov 2021 10:41:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211106134725.GI477387@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 06/11/2021 13:47, Leo Yan wrote:
> On Tue, Nov 02, 2021 at 06:07:38PM +0000, German Gomez wrote:
>> This patch is to save context ID in record, this will be used to set TID
>> for samples.
>>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> ---
>>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
>>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>> index 32fe41835..1b58859d2 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>> @@ -151,6 +151,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>>  	u64 payload, ip;
>>  
>>  	memset(&decoder->record, 0x0, sizeof(decoder->record));
>> +	decoder->record.context_id = -1;
> Since 'context_id' is type u64, here it's good to assign '(u64)-1'.

Ack.

Thanks,
German

>
>>  	while (1) {
>>  		err = arm_spe_get_next_packet(decoder);
>> @@ -180,6 +181,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>>  		case ARM_SPE_COUNTER:
>>  			break;
>>  		case ARM_SPE_CONTEXT:
>> +			decoder->record.context_id = payload;
>>  			break;
>>  		case ARM_SPE_OP_TYPE:
>>  			if (idx == SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC) {
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> index 59bdb7309..46a8556a9 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> @@ -38,6 +38,7 @@ struct arm_spe_record {
>>  	u64 timestamp;
>>  	u64 virt_addr;
>>  	u64 phys_addr;
>> +	u64 context_id;
>>  };
>>  
>>  struct arm_spe_insn;
>> -- 
>> 2.25.1
>>
