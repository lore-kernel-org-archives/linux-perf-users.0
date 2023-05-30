Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27740C77B7A
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 May 2023 06:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjE3Gy6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 May 2023 02:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjE3Gyv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 May 2023 02:54:51 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1621E5
        for <linux-perf-users@vger.kernel.org>; Mon, 29 May 2023 23:54:49 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso374821cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 May 2023 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685429689; x=1688021689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoU/9v3bmYe5em3pZ8Qm6c8p1nDaciuv1tADFddxFDM=;
        b=VgSGtYt8W1Zn1mWK6alB2rA8GfNplLqkPko2JeDNGlDw/kQ2EhQxziA+Ed4UJVS2Sm
         BySebuU8gxZ1aZO2XJgXoasR/NUf47cz5ibFtJNJ//72Z4wyV2RxK0afTSThMlrIckES
         oc7jyOrY6+PJDD19LXHUpun3h8pIfVYAEljSmnDwOiYgcANxFQbyLaN2OrLeju9NHc1r
         +oS07EwqQJHAhoLZXzl47XbM3A4YzdyOL3hX4n0FlzdNOj5ztbiBSsdI0hzTCQABJnO6
         TzEF5Hic7mVbB+Or8HAHwCrglukaFk22x0CQdX4sXQpRsQzkJnwXjE2i1rLfue05N0Bq
         1wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685429689; x=1688021689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoU/9v3bmYe5em3pZ8Qm6c8p1nDaciuv1tADFddxFDM=;
        b=WKZgU72yi3ZQXIC2XG22cHoveVxwF3A7UHh4D61dkuZ/o9VkuAatwSQ3tGPTVZMzjl
         PP2Vx62QfWPXks5F6djRL8jfap9Hhd52PkOq3DogqR3ViApQz1Jn6R8arFjNTFQ5F0zC
         okIV5ZTG+LNm/gsd5R+PwsxAF80dUv9uiBcRtY2oHQCwp1Xi65WQd2wcdpn/gxI7omaP
         4Xw2b5nUiXr2DGKx+h4AHDqBeXoDcQNvZS7x6jnOQF+4+f8Btk2cfX8lzo5ltYK8M+ES
         B3KtVgA+mLJRLUjL7W1T+rThWTqlzmVzCdvgxFrhQZqgTXfbQOd1QJjhH1DpsCXLfxng
         7sjQ==
X-Gm-Message-State: AC+VfDwtjjEQv8ooPn9vsz+TY+yjls7WxqFpmdN6Hoz8uRMEY+T3N7KK
        o4mlFxuQIN+NqNEAlfYL0OZuCzCHak6d1Pl7N+kymg==
X-Google-Smtp-Source: ACHHUZ7Bqqw3I8bqs/tZq64LmP9ot1bwhIvJaNEHAr866PaE/BvwE6qtfdTos3qHAMNbXlWJUuTI5Ld4xvYI99Zs4Rs=
X-Received: by 2002:a05:622a:1aa3:b0:3f6:97b4:1a4b with SMTP id
 s35-20020a05622a1aa300b003f697b41a4bmr61520qtc.21.1685429688703; Mon, 29 May
 2023 23:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com> <ZHWCPXKo2fFJmtlT@tassilo>
In-Reply-To: <ZHWCPXKo2fFJmtlT@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 May 2023 23:54:37 -0700
Message-ID: <CAP-5=fXXykcwjXjd+W=8Eez79JhmuKhf1Z-1R_8+AD4XdY4a8A@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Address some perf memory/data size issues
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 29, 2023 at 9:57=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
>
> FWIW I think the whole patchkit could be replaced with a one liner
> that disables THP for the BSS segment. I suspect that would be roughly
> equivalent for memory consumption because 4K pages that are never
> touched would never be allocated.
>
> -Andi

So, it is worth reading some of the comments on the code to see why a
wider clean up is worth it:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/path.c?h=3Dperf-tools#n7
"It's obviously not thread-safe. Sue me."
(a comment stemming back to the git origins of the code base)

BSS won't count toward file size, which the patches were primarily
going after - but checking the size numbers I have miscalculated from
reading size's output that I'm not familiar with. The numbers are
still improved, but I just see a 37kb saving, with 5kb more in
.rodata. Something but not much. .data.rel.ro is larger, which imo is
good, but those pages will still be dirtied so a mute point wrt file
size and memory overhead.

For huge pages I thought it was correct that things are aligned by max
page size which I thought on x86-64 was 2MB, so I tried:
EXTRA_LDFLAGS=3D"-z max-page-size=3D4096"
but it made no difference to anything, and with:
EXTRA_CFLAGS=3D"-Wl,-z,max-page-size=3D4096"
EXTRA_CXXFLAGS=3D"-Wl,-z,max-page-size=3D4096"
file size just got worse.

Thanks,
Ian
