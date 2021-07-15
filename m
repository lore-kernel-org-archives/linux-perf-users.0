Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1DFC1B08C
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F645613D3
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhGOQg0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhGOQg0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:36:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9107AC06175F;
        Thu, 15 Jul 2021 09:33:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso4038325wmj.4;
        Thu, 15 Jul 2021 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FpstuIIN0DB2WHE/Hcl2SOa1IWvxixa590FX0bfpwfE=;
        b=BdAJ+gTPLbBFZP4N6+1Ryck8w3TjNik+tH0tKPVpaqDJsxVu9skZDfKZSW3DX7RPkg
         kaPuZIt4iRW7kD1YMBBI9KsMmxC6Zl/FQTuOKIU8x0LD8FB389rDMrxZfyN9/yalKn/f
         6q6FkTiApz7DT7lawHd2XvSUdK8Enz5bpxrZDpHlTKI3Su7BZ/X4mquHetv8I8w2h2Sz
         dRpRY4bS/Moer7MkzRBZ1t7lbEKHdHWyszxIxbhOMo3ILBAZki0v/+QLM6dEvK0eI1fK
         Ws/62NdmmHEaJWJILTaqFZVNkwPP5fBFbCX6OADcVaInZkepGTN6leKHXR+CTneaRGYG
         jZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FpstuIIN0DB2WHE/Hcl2SOa1IWvxixa590FX0bfpwfE=;
        b=rVMWMjmXhjpdMNiSFgUpIuqJuz/eYbe049VcvGRaLXfowc4GpQZhdvTeJRvgGxS8t5
         geS0DVbUfEZRGYoRRYnPsmKVVHX/oQCZs3DKGJ7rc05T8WVUr2CtAsGz6IUOxiP2XVTM
         90mCnbbIBja6MmBpKED/X9miKjcgTAfna52tr8i9JmjExZHpsWaL6USO0wRHJIeuCFtM
         j8WykoXcgOfTH1qn2pHQj9ULFRqP5kU0UwxL8pft70kRw4pb+obdC1rUQMC+DlUoqN+N
         eeZKbHl4nt4mXWl8EqvCFIojSuVvyvCrDUSxqpHmOgNZmkmAn67u5yozZjcYL5CFfBCU
         3eww==
X-Gm-Message-State: AOAM533DZhuG8IandGnI7dwcqRmQ+kcypyDyfl7euLDLszI7KftOilw+
        DRm8S5QpkRkHBP2txMyWZaI=
X-Google-Smtp-Source: ABdhPJzzdtcC8TEKqc1Q7jxIw+KmSvRm7a3pW8MnUe6GpYEUjoG6ijbJMOhsf2PUW5SS3UrGRcmfWA==
X-Received: by 2002:a05:600c:5107:: with SMTP id o7mr5600699wms.184.1626366810818;
        Thu, 15 Jul 2021 09:33:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id i12sm7069635wrp.57.2021.07.15.09.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:33:30 -0700 (PDT)
Message-ID: <959c58526c5388eb891fd8a5927b5abc08c46a58.camel@gmail.com>
Subject: Re: [RFC PATCH 02/10] perf tests: add test for workqueue
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Date:   Thu, 15 Jul 2021 18:33:29 +0200
In-Reply-To: <YO7+g3wvtvJ+Zm5o@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
         <333e2e3986d32cf8894105f149abb543a84ec91c.1626177381.git.rickyman7@gmail.com>
         <YO7+g3wvtvJ+Zm5o@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Wed, 2021-07-14 at 12:10 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 13, 2021 at 02:11:13PM +0200, Riccardo Mancini escreveu:
> > It will have subtests testing threadpool and workqueue separately.
> > This patch only introduces the first subtest, checking that the
> > threadpool is correctly created and destructed.
> > This test will be expanded when new functions are added in next
> > patches.
> > 
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
<SNIP>
> > +
> > +
> > +static int __test__threadpool(void *_args)
> > +{
> > +       struct threadpool_test_args_t *args = _args;
> > +       struct threadpool_struct *pool;
> > +       int ret;
> > +
> > +       ret = __threadpool__prepare(&pool, args->pool_size);
> 
> Turn the last three lines into one;

ok

> 
>         int ret = __threadpool__prepare(&pool, args->pool_size);
> 
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = __threadpool__teardown(pool);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return 0;
> 
> Humm, will you add something here in the following csets? Otherwise turn
> these 5 lines into one:
> 
>         return __threadpool__teardown(pool);

ok, it was just copy-paste from above.

Thanks,
Riccardo

> 
> > +}
> > +
> > +static const struct threadpool_test_args_t threadpool_test_args[] = {
> > +       {
> > +               .pool_size = 1
> > +       },
> > +       {
> > +               .pool_size = 2
> > +       },
> > +       {
> > +               .pool_size = 4
> > +       },
> > +       {
> > +               .pool_size = 8
> > +       },
> > +       {
> > +               .pool_size = 16
> > +       }
> > +};
> > +
> > +struct test_case {
> > +       const char *desc;
> > +       int (*func)(void *args);
> > +       void *args;
> > +       int n_args;
> > +       int arg_size;
> > +};
> > +
> > +static struct test_case workqueue_testcase_table[] = {
> > +       {
> > +               .desc = "Threadpool",
> > +               .func = __test__threadpool,
> > +               .args = (void *) threadpool_test_args,
> > +               .n_args = (int)ARRAY_SIZE(threadpool_test_args),
> > +               .arg_size = sizeof(struct threadpool_test_args_t)
> > +       }
> > +};
> > +
> > +
> > +int test__workqueue(struct test *test __maybe_unused, int i)
> > +{
> > +       int j, ret = 0;
> > +       struct test_case *tc;
> > +
> > +       if (i < 0 || i >= (int)ARRAY_SIZE(workqueue_testcase_table))
> > +               return -1;
> > +
> > +       tc = &workqueue_testcase_table[i];
> > +
> > +       for (j = 0; j < tc->n_args; j++) {
> > +               ret = tc->func(tc->args + (j*tc->arg_size));
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +
> > +int test__workqueue_subtest_get_nr(void)
> > +{
> > +       return (int)ARRAY_SIZE(workqueue_testcase_table);
> > +}
> > +
> > +const char *test__workqueue_subtest_get_desc(int i)
> > +{
> > +       if (i < 0 || i >= (int)ARRAY_SIZE(workqueue_testcase_table))
> > +               return NULL;
> > +       return workqueue_testcase_table[i].desc;
> > +}
> > -- 
> > 2.31.1
> > 
> 


