Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C96C636D7
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Feb 2023 03:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjBWD6W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Feb 2023 22:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjBWD6V (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Feb 2023 22:58:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C4610253
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2023 19:58:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id iv11-20020a05600c548b00b003dc52fed235so6952612wmb.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2023 19:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IxsGBXV15vlKxvjhvdM60Z0zaiMtg1YCb2+rbW/W2ro=;
        b=f62pn7qnbDZPQPC27XciIzjpEUO9N1R8bF4LgHcNulv5+2GQNhIhYRglneCR0HRN+D
         UyWBjuyBG66Y3NmxrSrAgpKVv6WL+hzFIo5B9COZ5TIQPVhATe8RaTz7kNZVJUDFNwPY
         bGM/X0mRtNdfRRTF+xI5/dkRUuqIMLlwXO5wWgZTPQUkTkuUgpMkkmulBxIFNT3VoRx6
         e3tSdmTDUg7WhUcEnAt+F1yHhDjJz7V96LkfkOjbmxgZL4HdlSHhGfaYzIHhJtNHGJq3
         4zQ3zVUHqLJkR9TY1F3wewEOcbZTgn9W7e75rb+YhFP/ZEch5Od8yGskheTAw/m37okN
         nWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxsGBXV15vlKxvjhvdM60Z0zaiMtg1YCb2+rbW/W2ro=;
        b=GTNlKnBvND5wxaItzb/Ib2wi+rs9h+Ed5CZAgccMG/V2lst9ceu6Vakz3eRyftHb/w
         1K99mKNMqTtYlkjGilYThp4PPSJjR5Y2doJRQMO5IA1ug0kwoMPnOS2rJSjDWx6c2Mlf
         wy4rDPkMM+7qmHVVOBJHjX8etAhjRwz1VuPuZf25kdJZTHqvU9LGiAr5WZFpCFT0BbrW
         wQ3dlzPJ2JfZPQHXN/cdAILnONhbDjPcpGU2J92qBY4YrxFsAIOJFddb2q+pP9Yfi6rw
         9eTl+97ZCgcb18VLVjWJz/3HGUXB9abV4rCHgHD35ZNuTfiaDxj9qKeRm7zGYxvwk9Q5
         qBPw==
X-Gm-Message-State: AO0yUKVA9YnTHld7/rgJryB1eK+Tur0fsOxnJWVqIaXcapfcVfou04Os
        1Na1443bIjvYy4DdYGHOB5jguyR0vLu5/HPgM9WK5g==
X-Google-Smtp-Source: AK7set81Io+7cYMCH8vgLkj3wEespo3eo98ecXfzfsqmr2KHVd8D8Oi4GQsLqaZX1HE9YoYR0AXH41YD+LNq4uhCDz0=
X-Received: by 2002:a05:600c:1c95:b0:3db:1d5e:699 with SMTP id
 k21-20020a05600c1c9500b003db1d5e0699mr1152414wms.195.1677124698785; Wed, 22
 Feb 2023 19:58:18 -0800 (PST)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
In-Reply-To: <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Feb 2023 19:58:06 -0800
Message-ID: <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2023
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The Linux Foundation was selected as a GSoC organization for 2023!
https://summerofcode.withgoogle.com/programs/2023/organizations/the-linux-foundation

This means we're looking for contributors until March 19th:
https://developers.google.com/open-source/gsoc/timeline

Some project ideas are listed here:
https://wiki.linuxfoundation.org/gsoc/2023-gsoc-perf

Please help to share!

Thanks,
Ian

(Resend in plain text because of LKML's HTML filters)
