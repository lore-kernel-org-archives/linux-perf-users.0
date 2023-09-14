Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BDFEEAA7B
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 23:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjINX1Q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 19:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjINX1J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2023 19:27:09 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0470F271B
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 16:27:05 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41513d2cca7so134461cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 16:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694734024; x=1695338824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW0EzSFjr21HAS1xyRMcomxYaM7qO8QFRhUu1mpdGn4=;
        b=JXiZ79OPlZTBrtLkKL4okiz3H34BuZ8BAEsRtxf48IOrL1XLqOfEZJv586ABO+jY+M
         Q4sDV6XCxBzmlAxdGSf3UwZ+IrdcTRdkb/acklhEM3mgDyqglIk4PWaC9Gosm7Z3VD+P
         74AnpYbjAGzKsaX0iAwoDTrseUA5u/WXpOddDqj/pLoYEK/PWwZp8gvA678qt1CQrOTZ
         u/zrkKDHxSRQxftEBSe+r01Vd/AlfzOoU6nQnwo0FYhY9V57wO7VOZkxd/rJ7wJV/Xet
         HwMuNrYNuXbnXHsEgPBDE4mkCwEec36RiR45C1noTEBIVxQAUaK3j5kOI4A6eWSaiHFS
         MXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734024; x=1695338824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW0EzSFjr21HAS1xyRMcomxYaM7qO8QFRhUu1mpdGn4=;
        b=DyK5AfiNgX6Ei9xlBWmmO6SmniA0UP8mIZ3kdP2BN/9kOWiybsD1EsLODbNNfdf84y
         mDxHGGPPyUF1AF4llMyMzLKXQx+/ecDNuh4/o9h3eCWcUi1natf4S9TteRxSF0HvQR0/
         XhG4hsvhpbMGQrTCOQ21qzLRLP7z4JOzJm9xJs6NpMKFW0IaCz8en+5OETQTxDKuF++r
         kM5YDItkWvP2zGU+giHqsl/aJnbBFEl1CjoBpTCubN9mp2I27APXkeGvJ8LsuGQN5Tj+
         DcUl1MZAb6ohSTV2YEO0XL5rM2qEz6KZagEQ/xYrHQXpluqYtOCJhMlGbWWg5BcUgZGg
         SxgA==
X-Gm-Message-State: AOJu0Yx5hAwGiXoSB5IuzdEE/36KzaNifYS1EXcxY5jSbORE2YTzuq1A
        LU3PYidvqsZIRUj9Ln8fv6ONQwyloxxAFQyRA2b+nmuLhlZKDxv+zT26cJYQ
X-Google-Smtp-Source: AGHT+IGomaOkFpXvQ6DCt1NTlJh2nMjw8uP/9HOy5OlWTDNI3/K8CS/USjqV5uLGh7ZH4hraaNQZ5qma3hjsZ8mduuc=
X-Received: by 2002:a05:622a:13c7:b0:410:8ba3:21c7 with SMTP id
 p7-20020a05622a13c700b004108ba321c7mr135118qtk.18.1694734024050; Thu, 14 Sep
 2023 16:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <2fb5c263fce545b0a5b745e6122fa88e@akamai.com>
In-Reply-To: <2fb5c263fce545b0a5b745e6122fa88e@akamai.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 Sep 2023 16:26:52 -0700
Message-ID: <CAP-5=fX-wPy11iVZyc7HRXr_rK3GVwU_7gRtLKFsZH5=i=jWTA@mail.gmail.com>
Subject: Re: Symbol resolution when text in hugepages
To:     "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 13, 2023 at 5:21=E2=80=AFPM Jayaramappa, Srilakshmi
<sjayaram@akamai.com> wrote:
>
> Hi all,
>
> We have an application that has its text section backed by hugepages. In =
our new build environment the text section of the binary is split up into r=
ead and read/execute sections with offsets into the segment. This is breaki=
ng the perf symbol resolution. Previously, everything was in one segment an=
d there was no offset, so perf functioned fine. I know we can dump the symb=
ols from readelf into /tmp/perf-PID.map file. I was wondering if anyone has=
 a cleaner solution? I'd appreciate any pointers you have.

Hi Sri,

Since Linux 5.4 you can use MADV_HUGEPAGE with madvise for file backed
pages. It can still be profitable to use other sources of huge pages
so that you don't wait for the hugepage to be formed, in that case if
there is a file/memfd_create you can embed the information in the
filename. For anonymous pages you can merge them when scanning the
executable in perf_event__synthesize_mmap_events, but it can be
problematic if the program header is on an anonymous page.

Thanks,
Ian

> Thanks
> Sri
