Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEDFC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 09:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiGRJJn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 05:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiGRJJm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 05:09:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35521BC1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 02:09:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tk8so8668297ejc.7
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mdf5q/qVt50lKlbFg9riuF5UqJk6aS++kMHubLi94hU=;
        b=MyxoSBCz0+4WmzKije06wMMGwlLZnAyOl7DaKvuVIq+B8RQDKReiWmBYgLWrS/REsl
         r9JB5KFrkHjbbD5Y9e0fKF0myB7/l7z0daobfSOEjZkRqILEa4cJj4vH8ILfqblaZHzh
         IK7u3wmNUUziPzBJ/15x85nDjmwc7fqqKdXhL7WqVncz9FyWfrfrmzrMEOJhoZ+CLNWR
         aJOTamW5Ch1XOP3R6aa9FafC7UN7Mvl7sFRvB/fzmxtYAQ1xRfGvokf0+dPOGTIuPbUB
         f4grt/7hizM1GYX6XUscwQaKRqKBXQDaBKq0CFN3UrlZpC8dFhpWViORoUkC88Osv5Hc
         T8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mdf5q/qVt50lKlbFg9riuF5UqJk6aS++kMHubLi94hU=;
        b=sLdzj/S+QPHvw2Ksx5ZmtZPK1lgzcqnawkgiKKJJgjxRCVKdAkQHMVOPCstbe5IlqL
         ExF27lhkjPXK0D6VdoNnW3/uWVaIDCWy8bKgB0yHNm2Kx2VO5HCmmQ9O0MgnaseXjLUr
         pHOVh1QG+hb9KZ5Sl+j0LW9IjaHBKKO6nVlaPM2ndwFvfsfs0KjhsuS/+5DhHdEZnm0Y
         4OyHGolyWW+72XXmKu/1zMkg8SeHBy9mz9Wvm+KnJkQCDRyyhxtw1eJT8lwo32gkh/2o
         eFTpmDFa0Yg4AUO/xKNrMarnFLqtEM4FS5cx2FLce3wcK+Bj0DEWOx9JhREWk3d3/hbi
         rJFg==
X-Gm-Message-State: AJIora+BEdVhx3vCJB4cwGC9AaZ82eDZEgA9lbDnxnZ29HaIGhlyiusb
        d6R6MPCS4TKV6Lkx18upkB1W1JwXnhKnk/RlLxofeQ==
X-Google-Smtp-Source: AGRyM1uJqUvLGFX0HYNi7EiX1iff2QTsdFUBsk5ZFgYQlM7pHNjwdtj5TFwxgatScxITOJKZKA/rEeMAD3KXPgHUpfc=
X-Received: by 2002:a17:907:1ddd:b0:72b:49ff:d39e with SMTP id
 og29-20020a1709071ddd00b0072b49ffd39emr25082012ejc.500.1658135379803; Mon, 18
 Jul 2022 02:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220712021527.109921-1-lihuafei1@huawei.com> <20220712021527.109921-5-lihuafei1@huawei.com>
In-Reply-To: <20220712021527.109921-5-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:09:18 +0200
Message-ID: <CACRpkdaF4UXuiH_4StWZLwhrC8H7Le9rbnRtHYaRLrJ+fQT2_g@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: stacktrace: Make stack walk callback consistent
 with generic code
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 12, 2022 at 4:19 AM Li Huafei <lihuafei1@huawei.com> wrote:

> In order to use generic arch_stack_walk() code, make stack walk callback
> consistent with it.
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
