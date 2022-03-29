Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D01C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Mar 2022 12:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiC2MdJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbiC2MdE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Mar 2022 08:33:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C70E5EDCD
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 05:31:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h4so24551350wrc.13
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y9RUNc9u4NDcWzkzWpNKYsTxGVbukHkl4DrmNzDmOrM=;
        b=hlBOatvIQkfNLpHHQsqkeaqrF/vl5iO2zvTCN65flMcbf741w5RUPcJZpqNmzIqriI
         SsPAeScVhnDBFnt1AGXNEH5ugBtcSohfRpJyNFkpHSfeRBpSULLaclDOH/bzjt5ou+Q0
         Qzmx25AMCN8bjeowkUU/mfrMZ6Scb8XW4lzm6SaK7QXadh7pb3Hm0lCm8Aa3Ezwy6Pjo
         n2I2lYJ1wr+JC0NXQpfnrLRDDnw5Rl9KRh6Y0+OcJ307B79ikNOaPLv2/CzZVFTEi8Ru
         IxiEf2TNJbt1f5oeUpPMPF9gy9uVwsVGxDG4jq1mRd11aXNsUS9tfOa7vus37KGgrP8L
         ZMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y9RUNc9u4NDcWzkzWpNKYsTxGVbukHkl4DrmNzDmOrM=;
        b=YDrU7c8I1opSvYd6C1lNXftd0lQxnfi4WBwH9Qk2pHHZBvPdQCUwOSnEEGiQ9Lwa2Z
         OusnJy4wU/wW6Tm5l/GcyFFn2hF0IfY3HRTnG0mstOZO+zgMfKukhvAaURxshtnPGYJm
         kNpckCyo24GukiDzjxDA7Iu4VrrD9QnvbQjnLDFhz0QjygYM+RWVHud2kHbEK/9BVF4D
         HVsxqSXNS8KXO9cK18LO3Uu50QJH94f67PUkPCljLM0R+zJGaFgNYGRwuQExsNi9H9a6
         JykNpaVXlNNtgDVBovhsYNNrWm3QmjU2D4PgmsQgFdTz5RqxCG3GsJ+8yJg4RbAAScxV
         dTbQ==
X-Gm-Message-State: AOAM5335VSQnzH4hUqgA3u2apWzAuaUD2pNU2VquEEr6S0vEy+473tb3
        N9DAUqTe7ohNaVXbr3XGd/E0vg==
X-Google-Smtp-Source: ABdhPJy72PAhTXZFXupmbBsCmVeopApvYCfXr8IgWNONOJ/JYSPSNiev16r0QIGal9vCCZsc/AI4yA==
X-Received: by 2002:adf:e346:0:b0:205:97d0:50db with SMTP id n6-20020adfe346000000b0020597d050dbmr28982595wrj.257.1648557079428;
        Tue, 29 Mar 2022 05:31:19 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id m2-20020a1c2602000000b0038ca9ffac53sm2136981wmm.11.2022.03.29.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 05:31:18 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:31:14 +0200
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        He Kuang <hekuang@huawei.com>
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <YkL8EpWaeZ1US8t2@google.com>
References: <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
 <YjHfGrZovk3N/H0f@google.com>
 <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
 <YjhUjotmo+kYvoNP@google.com>
 <ffa56520-09b5-9c5d-7733-6767d2f8e350@intel.com>
 <YjiuoEUL6jH32cBi@google.com>
 <Yjm5stBpRC0g4G8s@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjm5stBpRC0g4G8s@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 22, 2022 at 12:57:38PM +0100, Steinar H. Gunderson wrote:
> and this is evidently fatal. So for whatever reason, the sample address
> is attributed to some symbol, and that symbol is assumed to have a
> single range (is this even necessarily true?), we refuse the event,
> and then we fail the entire report. (It doesn't happen with --stdio,
> though!)

I think I traced this. The basic issue is this routine, which compares
two symbols (to see if they should be combined for the sake of perf
report):

  int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
  {
          if (!sym_l || !sym_r)
                  return cmp_null(sym_l, sym_r);

          if (sym_l == sym_r)
                  return 0;

          if (sym_l->inlined || sym_r->inlined) {
                  int ret = strcmp(sym_l->name, sym_r->name);

                  if (ret)
                          return ret;
                  if ((sym_l->start <= sym_r->end) && (sym_l->end >= sym_r->start))
                          return 0;
          }

          if (sym_l->start != sym_r->start)
                  return (int64_t)(sym_r->start - sym_l->start);

          return (int64_t)(sym_r->end - sym_l->end);
  }

The problem is that part comparing sym_l->start and sym_r->end. I'm not
entirely sure what the logic here is, but it seems to me that the
intention is that if sym_l is a subset of sym_r, it collapses them.
However, it seems to assume that [start,end] is inclusive, whereas it is
generally [start,end) in later code. This means that if you have e.g.
a symbol [0x1000,0x1010) which is then inlined as the very first thing
in the adjacent function [0x1010,0x1030) (say, sym_r is the inlined
symbol [0x1010,0x1020)), _sort__sym_cmp will indeed collapse them.
This causes the ERANGE problem later, as you can have 0x1005 being
mapped to a hist_entry correpsonding to the symbol [0x1010,0x1030).
It seems this logic was indeed added to fix ERANGE problems in 2019
(see 7346195e8), but it is seemingly incomplete.

If I change <= to < and >= to >, it stops erroring out; however, I'm
still not sure whether this is actually right. Doesn't the collapsing
then depend on what order the entries happen to be added in, ie.,
whether the larger symbol comes first or last?

/* Steinar */
