Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC256C761A6
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Mar 2023 22:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjC0WSZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Mar 2023 18:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjC0WSX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2023 18:18:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588F72D59
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 15:18:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ew6so42148150edb.7
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679955500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qpaub3I/CyGwEFR/k/WmlBCDNumW/+SJIaNcuoNk9k=;
        b=sLjlJgjeoT0WV0qFn9qz1kIcxyac6pMVMv4H0/t9YS7zXIrH7YfP7jRP4vvtxYuMhv
         ZkjmSM2TjJ2zegpBf5QGdb0Mg2dEBQNtRk9nXqhWfdzK8Cn2PNTlxJjlOr4L+7Qk675Y
         nXesSbqZ55WgkfqcvQkclW2y9t9tEOxFKzyyUPFbBZcRrU7ShBkSWppcY0urgbLMqJbf
         tLMwthWt0GlBeegianqR6puXwKX0gRuaDR6yup4MiyrXZu76w9isj8TE+VUN+DdOSY4A
         IQCaYyBU7XaWxUoZ4cGVm4P8s5+myV0YBVlJc6RiTvo7dF/Tw2pzx5QhD46MOXhuxEcU
         F3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679955500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qpaub3I/CyGwEFR/k/WmlBCDNumW/+SJIaNcuoNk9k=;
        b=Zy+apnwX39NlM2JcTb8p3odGb7SX8yJnxejQFW2V22EYqUErB5E/xu9qnaURHLqPgT
         y8BHFqEUCmLQk19IeOEsyo0MKyhBZOgqWq3FHa8iC7qAdPpGFiy4C+/gVTyoTwsFAdQF
         DYAJx/ps5aPc78rCzsmTceuK2vFVHXCYaqFdDv4chfLx+/pmRmoxoNXpXX2hvFwAHKnF
         XCApCnyYyz9zH1KiCcxpvKhVV3cT4ZhG6f+xdZZDrdrtjXzo9tb2kWEB/dpjkQH89v2k
         vBxD6n5WKVg+3z3JEIj3Yinfh6gahBKaxJILiAJ7nFE+PxBFY+zbF1ecRnyjf9elvMhH
         0Y2Q==
X-Gm-Message-State: AAQBX9e0el3gUDKw5MWcM50Uvjz1UcZgTFcdvfWuN4KyDYrtDhkmbK9c
        oQF3UgoBsiV+9X88DNiG3rvI7o5q8AVQJIHWULxA0Q==
X-Google-Smtp-Source: AKy350ZxmCEdEpv7zB21M0WMADbalXlh1cyjmKEj/2FvVMMOcTkxQAp+v5N9qKKGwJDSfSrEt6L5EOsdS/vzof9S9Yw=
X-Received: by 2002:a17:907:cb86:b0:930:42bd:ef1d with SMTP id
 un6-20020a170907cb8600b0093042bdef1dmr6723296ejc.11.1679955499628; Mon, 27
 Mar 2023 15:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <20230325085416.95191-1-ashimida.1990@gmail.com> <20230327093016.GB4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230327093016.GB4253@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 27 Mar 2023 15:17:43 -0700
Message-ID: <CABCJKueH6ohH27xCPz9a_ndRR26Na_mo=MGF3eqjwV2=gJy+wQ@mail.gmail.com>
Subject: Re: [RFC/RFT,V2] CFI: Add support for gcc CFI in aarch64
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dan Li <ashimida.1990@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Brian Gerst <brgerst@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Changbin Du <changbin.du@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        gcc-patches@gcc.gnu.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Yuntao Wang <ytcoode@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 27, 2023 at 2:30=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sat, Mar 25, 2023 at 01:54:16AM -0700, Dan Li wrote:
>
> > In the compiler part[4], most of the content is the same as Sami's
> > implementation[3], except for some minor differences, mainly including:
> >
> > 1. The function typeid is calculated differently and it is difficult
> > to be consistent.
>
> This means there is an effective ABI break between the compilers, which
> is sad :-( Is there really nothing to be done about this?

I agree, this would be unfortunate, and would also be a compatibility
issue with rustc where there's ongoing work to support
clang-compatible CFI type hashes:

https://github.com/rust-lang/rust/pull/105452

Sami
