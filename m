Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E90C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 17:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382744AbiEMRF3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382737AbiEMRF2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 13:05:28 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43315A2ED
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 10:05:26 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id y74so9021131vsy.7
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M20/Mcaj+7CKKvMSlepJXfPmEm2rLWCFBP/Lq2j/vwI=;
        b=mrL3OYeL4uxYEIpzuHvbQ8/i8o/17RBvCEFupArWRVgPUb0v2h2sd3MAZ89u6YbOfb
         SYHF27u+q7Vjcoynsn636fdp8UBpxMy2P4WWYTLQQTper1egJVXoBGgeFL+Lzjpg+3ry
         VQKlRShU9mGvhL3iLVRBTKnyBbYqonZbNL0QuFz9ovT8N3IE+Mi6SDEG1yFF/Z3BuZzH
         AHqcPSOlauyvDhFQzQdh7UEAs/lGfk0/odQ4A6jMqf8TikGKSz8Ysvu8+gvl9oozFsZw
         wxKoOINaxLmxVIUv1Wm7vsmzc2M9NaJrO7IMcsXC30MYgeQTcr0oU3JF9Vrj1GcqYSQv
         c3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M20/Mcaj+7CKKvMSlepJXfPmEm2rLWCFBP/Lq2j/vwI=;
        b=M3KT0hP4dZ8zvTlmMWLnyJbjFCTcVEAbTBLsgU/IhTYPGoEmCuOcp3HlQJNHylbROi
         tDBorKtbb5sYF/Vkgn3Q1RtnaYeq9Lny0t/sASQ96apY087MNe4WHH2vi9wsfCyyqWXl
         cdri/wnXlkH/ZPQ+v1yd6VKsaL20eIFyrC76B/0AtdHTcvwuiClWN+BRnnemSHZvw/wE
         gPdjRBzDnXYSxnGZ4zH+ACOcsaSflp1d3KlJzzorYVwwKNiVJQC6k8SOqAON9UYPTTr1
         JCsr92ldTLZ8kXcHHXvYquVfVh490SYNobjKayonXtIZClq+6dMFGlNnRfMqcUPSNMDf
         ZIng==
X-Gm-Message-State: AOAM532B6rTQy6dwxXe85M87jWgZoOFsTGjnvmhz5zjoc88fdSiKnJzR
        009igXhXItGQvZwE8EKzI6qmnVsPgKaS3CbN59wsMQ==
X-Google-Smtp-Source: ABdhPJyuZbLaFtq2n9NyLPjiVytNIDz6eQbCT21SLSfAoOglW4hIWTknPeKi7juMY+f7jD3wwPwXLjo91U6F/WzP/hg=
X-Received: by 2002:a67:af01:0:b0:32d:3d57:cff with SMTP id
 v1-20020a67af01000000b0032d3d570cffmr2925978vsl.8.1652461525912; Fri, 13 May
 2022 10:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com> <20220513040519.1499333-3-irogers@google.com>
 <cd8f8fca-a1e0-e4de-92e4-536dcb2c1f7c@huawei.com>
In-Reply-To: <cd8f8fca-a1e0-e4de-92e4-536dcb2c1f7c@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 10:05:13 -0700
Message-ID: <CAP-5=fUahv8WVMXWXseCN8hC0qJL4fKBhA+eR9hnydgK-WDHQA@mail.gmail.com>
Subject: Re: [PATCH 2/7] perf test: Use skip in vmlinux kallsyms
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 13, 2022 at 10:01 AM John Garry <john.garry@huawei.com> wrote:
>
> On 13/05/2022 05:05, Ian Rogers wrote:
> > Currently failures in reading vmlinux or kallsyms result in a test
> > failure. However, the failure is typically permission related.
>
> If the user requires root priviledges then should we just mention this
> would be a problem for this test?

Tbh, it wasn't clear to me and so I didn't add a reason for skipping.

Thanks,
Ian

> > Prefer to
> > flag these failures as skip.
> >
> > Signed-off-by: Ian Rogers<irogers@google.com>
>
> Thanks,
> John
