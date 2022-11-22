Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91571C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Nov 2022 17:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiKVRnA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiKVRmr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Nov 2022 12:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CED7990D
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Nov 2022 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669138903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bow/C20qLn6NFQLpGU1BpWtTQeMCHYjLQwwJDhvDbQc=;
        b=i5VvaWE+UK3drx7xoUiFhGk2TQp7yObR398rs0T9uXeEvljB4rE8o7JV/7+Q3Xqns3U2gt
        pfp42QWTMEAjELV1iD6VCgT0zjqIbjs01FfYtGe2lClCDcKZKGFTsS25kIVQYndASkbq1B
        PeCuUrDh1xRjkshYOJlZN7GqLkDPy94=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-120-2LCHkXezOpSzQRwAtERWDA-1; Tue, 22 Nov 2022 12:41:41 -0500
X-MC-Unique: 2LCHkXezOpSzQRwAtERWDA-1
Received: by mail-vk1-f199.google.com with SMTP id n20-20020a1fa414000000b003bc585c7d50so5149131vke.16
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Nov 2022 09:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bow/C20qLn6NFQLpGU1BpWtTQeMCHYjLQwwJDhvDbQc=;
        b=bHUXrQz+wx5OCP4AuY8uCA6j6nfUNcsW0IJwpDVs2VtkQnNLbHPmGbSZD4V3t8VCpZ
         V4vRGs5rqjmtssVE7TU4kwBQw2bE9BgXWeR65cN+7BYvUM1lZzFClADzaeE4c0cBI/4f
         PDzd/DbuNNCryX6sHIXEmmSbu+yKaWA66CXjrXd8XV5VNlnNxhVc3WseNDXmUkVRV3M4
         8lcfJJ10oDXvOM/iz96evGafTHpTBhbtxWQFcJCZR730HJ1seFAv3hCPt9vBfzUnQrXw
         peiXOUA+Gkjgwp7UMrJjOoJtLU4yP2t2SMCB+KcMrBqamIB82z7mN4q0r0S/75ATXo9b
         +6Ew==
X-Gm-Message-State: ANoB5pntgEEt5khvGxQtVuoeCVJq7trOy8nIgYK30JZiS+NlO/XNRkFs
        P2l6xyE+mappuVR/Skjkxxv016EMSO7uMFVaOgEJQYQixLkT5w26NBxjJH7rf9wq4+Dsx6JjWhK
        0ZB/tb0qQipRPW1Sz4txjivOGtgbCTHxDr5btvQk9bO5WpQ==
X-Received: by 2002:a05:6102:2833:b0:3b0:6c8e:5be with SMTP id ba19-20020a056102283300b003b06c8e05bemr827068vsb.18.1669138900593;
        Tue, 22 Nov 2022 09:41:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6qMgG0J1stGdQzpB7ukTzlBC3hK4FISN4sJApOlglYde2GDiyHmqKXPuAB86jQbQbQkfwaeICrVj4kvA8s7zk=
X-Received: by 2002:a05:6102:2833:b0:3b0:6c8e:5be with SMTP id
 ba19-20020a056102283300b003b06c8e05bemr827056vsb.18.1669138900381; Tue, 22
 Nov 2022 09:41:40 -0800 (PST)
MIME-Version: 1.0
References: <CAE4VaGDR+p-KDK6WNnzp5go4r_3Q-OtjR_J2_NpgFcwL8O8KiA@mail.gmail.com>
 <0ecb09b3-5a72-6bac-0236-8807bbacf702@amd.com>
In-Reply-To: <0ecb09b3-5a72-6bac-0236-8807bbacf702@amd.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Tue, 22 Nov 2022 18:41:29 +0100
Message-ID: <CAE4VaGDk3os+P6-+XojA8=cmBiFJj1UrU1cQNXL-qPji6X07ew@mail.gmail.com>
Subject: Re: AMD -missing perf stat metricgroup "pipeline"
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-perf-users@vger.kernel.org, ravi.bangoria@amd.com,
        ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

(forgot to send the message in plain text mode - resending)

Hi Sandipan,

> For determining if a workload is backend-bound, the recommended
> method on Zen 4 is to use the pipeline utilization metrics. We are
> the process of providing similar metrics and metric groups through
> the perf JSON event files for Zen 4 and they will be out very soon.


This is great news - I'm looking forward to having it released! :-)

> The PPR for Genoa processors is available here:
> https://www.amd.com/system/files/TechDocs/55901_0.25.zip

Thanks for sharing this it!

I could confirm that my workload is heavily backend bound - to 86%.
See [1]. That is exactly what I was looking for. It will be awesome
once it will become easily accessible via the pipeline metricgroup.

Thanks a lot!
Jirka

[1]
perf stat -e r100431EA0,r1004360A0,r4300C1,r430076  ./harmonic_series 0 1e9
Time elapsed: 2.44143 s
AVX512:
Sum 23.3799
Difference Sum - Formula -1.91847e-13
Time elapsed: 2.44154 s

Performance counter stats for './harmonic_series 0 1e9':

   46,731,488,713      r100431EA0
           22,145      r1004360A0
    5,015,015,425      r4300C1
    9,021,144,392      r430076

      2.442290274 seconds time elapsed

      2.437987000 seconds user
      0.000000000 seconds sys

Total Dispatch Slots: Up to 6 instructions can be dispatched in one
cycle. 6 * Event[430076]

Retiring: Fraction of dispatch slots used by ops that retired:
Event[4300C1] / Total
Dispatch Slots
5/(9*6)*100 = 9%

Backend Bound: Fraction of dispatch slots that remained unused
because of backend stalls. Event[100431EA0] / Total Dispatch Slots
46.7/(9*6)*100 = 86%


On Tue, Nov 22, 2022 at 5:48 AM Sandipan Das <sandipan.das@amd.com> wrote:
>
> Hi,
>
> On 11/21/2022 7:33 PM, Jirka Hladky wrote:
> >
> > I'm testing AVX-512 packed double performance on the AMD Zen4
> > platform, and I need help identifying the backend-bound workloads. On
> > Intel systems, I use the metricgroup pipeline:
> >
> > perf stat -M pipeline binary
> >
> > which gives me exactly what I need.
> >
> > What plans are to add a similar metric group for the AMD systems?
> >
>
> For determining if a workload is backend-bound, the recommended
> method on Zen 4 is to use the pipeline utilization metrics. We are
> the process of providing similar metrics and metric groups through
> the perf JSON event files for Zen 4 and they will be out very soon.
>
> The Processor Programming Reference (PPR) for Zen 4 based parts
> has a table titled "Guidance for Pipeline Utilization Statistics"
> which has the formulae for different Level 1 and 2 pipeline
> utilization metrics.
>
> The PPR for Genoa processors is available here:
> https://www.amd.com/system/files/TechDocs/55901_0.25.zip
>
> In this specific document, the table is in page 235 under section
> 2.1.15 titled "Performance Monitor Counters".
>
> It may not be convenient to find out if a workload is backend-bound
> without the use of a metric but one can still do it by programming
> the raw events that make up that metric.
>
> E.g. the formula for determining backend boundedness is:
> Event[100431EA0] / 6 * Event[430076]
>
> Running perf with the raw events give the counts which can then be
> used to calculate the metric.
>
> E.g.
>
> $ perf stat -e r100431EA0,r430076 ./test
>
>  Performance counter stats for './test':
>
>            750,372      r100431EA0:u
>      7,500,728,022      r430076:u
>
>        2.894204814 seconds time elapsed
>
>        2.894060000 seconds user
>        0.000000000 seconds sys
>
> The backend boundedness is then 750372 / (6 * 7500728022)
> which is roughly 0.001667%.
>
> - Sandipan
>


-- 
-Jirka

