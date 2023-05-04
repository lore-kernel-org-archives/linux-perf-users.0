Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553CEC77B75
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 03:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjEDDMm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 May 2023 23:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDDMl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 May 2023 23:12:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE31BD7
        for <linux-perf-users@vger.kernel.org>; Wed,  3 May 2023 20:12:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so12937752a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 May 2023 20:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683169959; x=1685761959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5ozZPD1eRitxmLVpmwZ2WhYcThQgSne38lv/tIUIxw=;
        b=U8Uyt/OsdK07vvow0LLQjDsWPcNH6iCYv4nIEvDdkJiZYq0mNvleDhgTdc5KWtTAV2
         K+SYV+Pvzx1WPqIYEjHHP+rBIp/YVrxkjzd/nHvkZYoC+9uQ85cGRQzLOR8nSrX+bQcP
         eF7gPCxCiH+2HORzYhhmbVWhAnpMSKv4nlYdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683169959; x=1685761959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5ozZPD1eRitxmLVpmwZ2WhYcThQgSne38lv/tIUIxw=;
        b=gcpU5U+uMuYX/bmKOrJ/QZ3daztcyMOm/x9MM7uB1qV9YYDERnUcm/Kto89B6iVRei
         aYLy6KukAdV6jxa+MXVsIStLyhWWu9nx6iVqUTfzNQyeLoKvVOoYunkGvKC0I3XQ/xoe
         XRy/g4nT67sM5ZjqsUBQ9Vr+ysYJv+/sWgYyUsRCwZVWeNGGhUoNYrmKgBDtNbPfIE7k
         LIifLnMK+EfICy15rfqAzfMeX2fiT9REk1bYljrOf1M+ysC+GgNcM8N358lR4Uzn3fV3
         WAfZ5z29RJDyVR6E0Jy52+C+qghKVAO7iKa4OOXJBPPAQzQLUNMXAvVAZJjxgG760L1+
         6ifw==
X-Gm-Message-State: AC+VfDweWes3PwNn7NJjxsQyWDgpD7E/vDKaeqTYlqkJhC6nMiBxmnXT
        Ex1Xw9HCoT3VxHOTjN7/ZqiS1fM6K4HT/34qGDNKM380
X-Google-Smtp-Source: ACHHUZ5DKG/lH0Lhj8jS76TPD2A2lEVzI+cWfM2b62cScgd9ZqMagaapFO9c0uWDldNcf3mjybyXMA==
X-Received: by 2002:a17:907:3e8f:b0:959:c6cb:8546 with SMTP id hs15-20020a1709073e8f00b00959c6cb8546mr4128316ejc.28.1683169959104;
        Wed, 03 May 2023 20:12:39 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ib2-20020a1709072c6200b00965b04646cdsm79649ejc.58.2023.05.03.20.12.36
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 20:12:37 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so12937556a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 May 2023 20:12:36 -0700 (PDT)
X-Received: by 2002:a17:906:6a07:b0:94f:6316:ce8d with SMTP id
 qw7-20020a1709066a0700b0094f6316ce8dmr3770779ejc.34.1683169956655; Wed, 03
 May 2023 20:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230503211801.897735-1-acme@kernel.org> <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
In-Reply-To: <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 20:12:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
Message-ID: <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.4
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 3, 2023 at 8:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I did consider it, but the end result doesn't even build, so I unpulled a=
gain..
>
> I get some libbpf error, and I'm just not interested in trying to
> debug it. This has clearly not been tested well enough to be merged.

Side note: its' not even about testing.

The error message makes it clear that this is garbage and should never
be merged even if it were to compile.

There is not a way in hell that it is correct that a 'perf' tool build
should ever even look at the vmlinux binary to build.

The fact that it does shows that something is seriously wrong in
perf-tool land, and I will not be touching any pulls until that
fundamental mistake is entirely gone.

The vmlinux image that is present in my tree (ie
/home/torvalds/v2.6/linux/vmlinux) is a test build with an insane
config. And the fact that the perf tool even looks at it is seriously
broken.

Whatever you are doing - stop it right now.

               Linus
