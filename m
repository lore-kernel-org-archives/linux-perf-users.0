Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35272C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4BD61374
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 16:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTQgb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJTQgb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 12:36:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A0CC06161C;
        Wed, 20 Oct 2021 09:34:16 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id o12so3544081qtq.7;
        Wed, 20 Oct 2021 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=g0oIpasJUwiZArD8DikauE4FXsqD3MlkEjrf0K6eLn4=;
        b=lhyELlFUPc4TlP6E7DoYx5iUdBf4V4Xy0LCpOB7CaD8VDZcSfzouU1TdzcPQ9Vyu04
         cICDL7teiMgIs0NgHlaq2qP0d4GzEcNHyQ/aKmwKgYCcXbptTP4GBjUyEQadrIC23/Pe
         cj3J1PVvOLb44M8BYHwbz6mCSGtAcyXty0/KvHg0HA8CCd6Jsa2Y8jOXYl7WWVf96typ
         HPNYwS9Cdll/9mCn/LQCbk0HPPVjUT8F1ttvhBNSAK7e34ANCtvzlgXscFN0dkW4M8Yr
         tCZgn+bDpRgDLJBtny5S1X59/5kQU0bsTPFbWB1xBV2aZ5y16XMxSdLfPeZl8xS1nl2c
         h4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=g0oIpasJUwiZArD8DikauE4FXsqD3MlkEjrf0K6eLn4=;
        b=7+1KzPj1mWmyfMYqmqNUer6nlyfmUcF5S30ZVtCs7USb6VFdfQaWnvppuJL7MoSec5
         qgXBjFpWd0rd0NZsseG9ZEsA2i7RmHF1BuzGqycpZ8c3KLSU36JPsw3Pqfloq7rIALNQ
         1INjy/9hZasZoAO3Rf3JizfGhwVZMrgcHdHMQrrltAtwkNATpye5qc/68RF/XSNfdyuU
         IsaMsDcRz+6uNvTRjCw24+9qA7SZ4tTOoydQCZLeRZVkuPGCXyXKAWHpMCkh+9ZYdp9S
         pwKT9Pldyn0Eo/U98XUJO1k9IZJsZl6pZuZVgnHkRxsw66VveI/mOYoaRvP3yRgDNZlF
         eqIg==
X-Gm-Message-State: AOAM5339mgFZDtjU12TJV8bH097uZ5pnjrLZDKNafeWDfmkc7J0rcsR/
        deFHieKxO8QrqeurBfNaSEbzW4jk3+NS6g==
X-Google-Smtp-Source: ABdhPJzvxc11RJlS0z5B0+As3NfzUiau0BP85PP4NiflGqwBp+LFUptKCxvXUjalZflM8FWT048MwA==
X-Received: by 2002:ac8:6619:: with SMTP id c25mr175994qtp.91.1634747655554;
        Wed, 20 Oct 2021 09:34:15 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c7sm1177672qke.78.2021.10.20.09.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 09:34:14 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:34:09 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 0/2] perf jevents: Enable build warnings
User-Agent: K-9 Mail for Android
In-Reply-To: <744e6d05-eaec-49d9-1e3d-2f96d4e01e1a@huawei.com>
References: <1634316507-227751-1-git-send-email-john.garry@huawei.com> <YXAoOgRVfkzr5vcS@kernel.org> <744e6d05-eaec-49d9-1e3d-2f96d4e01e1a@huawei.com>
Message-ID: <16E39CDA-56B0-4A88-AD66-E2197E4E1C3B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On October 20, 2021 11:41:01 AM GMT-03:00, John Garry <john=2Egarry@huawei=
=2Ecom> wrote:
>On 20/10/2021 15:31, Arnaldo Carvalho de Melo wrote:
>> Em Sat, Oct 16, 2021 at 12:48:25AM +0800, John Garry escreveu:
>>> Currently jevents builds without any complier warning flags enabled=2E=
 So
>>> use newly-defined HOSTCFLAGS, which comes from EXTRA_WARNINGS=2E I am =
not
>>> 100% confident that this is the best way, but sending out for review=
=2E
>>>
>>> Baseline is be8ecc57f180 (HEAD, acme/perf/core) perf srcline: Use
>>> long-running addr2line per DSO
>>=20
>> Thanks, applied=2E
>>=20
>
>Hi Arnaldo,
>
>I was going to send a v2, with changes according to James Clark's review=
=20
>  - that was to add -Wall & -Werror, but they caused a problem on your=20
>perf/core branch as they triggered the warn fixed in commit b94729919db2=
=2E
>
>I suppose the best thing now is to send a patch on top once perf/core=20
>contains that commit=2E Let me know otherwise=2E


Tests are running, if something fails, then I'll have to fix it and will n=
ot make my perf/core public, so I can replace what I have with a v2, otherw=
ise you please send a patch on top after l make it public=2E

- Arnaldo
>
>Thanks
