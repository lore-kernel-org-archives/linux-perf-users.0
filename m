Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5E8C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C507761269
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhKKH2a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 02:28:30 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38886 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhKKH2a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 02:28:30 -0500
Received: by mail-lj1-f176.google.com with SMTP id e9so10181758ljl.5;
        Wed, 10 Nov 2021 23:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4w43pXJEj6sPijE7G4/gLGRPchckrBkkpJmn6UFaT3c=;
        b=GypT5sO/ey57sjf1cm41YbN72pdtBygF7BnGkLwe9D9kl9L53NOdli9JLojhdDCWcd
         pkxhNWIMwdwWhKw+YPi9u6lWVL9ZtOzjF5ZGPJiv538ZVvyPyfeS1Jbw3RsvWjLe5XHN
         zChbC5n1Pm1zMLjXum9NqxA4q5ikA+fKGHrza64M0prOd5ezW3zccPjElULcorVY+Llf
         EnfRpgnf8E5woVjqlKvwWP53UId1BRrlY9WtJN7DnWU9jNoSYaLnu5d6fM5Cmfp4vjq2
         J56VDwcR65khmS3p3oZ5g47vAwZ2liJLA8qJWu4bpkNYkQbz+cC43puvIp+i10XoDlW6
         khhw==
X-Gm-Message-State: AOAM531r1C/qrgJUGyvB9akbW+txGu00yHJyXaNnwDLKnjIHXlEEZ/VQ
        FuX838WqkWY9QzO3gKOqIKisf0eQKwo36BoTmWM=
X-Google-Smtp-Source: ABdhPJzPMVBGPuLftQNA/tOSHotYrLQMXnnafr/sQy0BbFisj6KBKPam+pROMfHCZgG4F2oQ0rUbnpbFCzuKmnVw4TQ=
X-Received: by 2002:a2e:82ce:: with SMTP id n14mr5210040ljh.90.1636615540222;
 Wed, 10 Nov 2021 23:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20211109115020.31623-1-german.gomez@arm.com> <20211109115020.31623-4-german.gomez@arm.com>
In-Reply-To: <20211109115020.31623-4-german.gomez@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 10 Nov 2021 23:25:28 -0800
Message-ID: <CAM9d7cgB_kemcZLL2FK6pHOEx_TkJ72YNFW03OR_Zyhn0yrmPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf arm-spe: Save context ID in record
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Tue, Nov 9, 2021 at 3:50 AM German Gomez <german.gomez@arm.com> wrote:
>
> This patch is to save context ID in record, this will be used to set TID
> for samples.
>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 32fe41835..3fc528c92 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -151,6 +151,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>         u64 payload, ip;
>
>         memset(&decoder->record, 0x0, sizeof(decoder->record));
> +       decoder->record.context_id = (u64)-1;
>
>         while (1) {
>                 err = arm_spe_get_next_packet(decoder);
> @@ -180,6 +181,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>                 case ARM_SPE_COUNTER:
>                         break;
>                 case ARM_SPE_CONTEXT:
> +                       decoder->record.context_id = payload;
>                         break;
>                 case ARM_SPE_OP_TYPE:
>                         if (idx == SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC) {
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 59bdb7309..46a8556a9 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -38,6 +38,7 @@ struct arm_spe_record {
>         u64 timestamp;
>         u64 virt_addr;
>         u64 phys_addr;
> +       u64 context_id;
>  };
>
>  struct arm_spe_insn;
> --
> 2.25.1
>
