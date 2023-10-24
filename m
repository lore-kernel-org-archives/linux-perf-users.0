Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7607461
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltbbf6hn"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF0410DA
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 01:52:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so36065715e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698137556; x=1698742356; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrrcjmyOsYhzUAtE3nPjXHtJxGhZGABKJJb1EALYyaI=;
        b=ltbbf6hnqY+myKc90FFxaD7WOjJHYW+Gni44Z7FArvoYwtWOiU6Wdhot2yl7L+3Vfm
         BTk/PU5Kz6E1mqkbWwATwJO6+IboF1aFqhfND3ATpEiqcST6HEGI2J++Kqk9VpDzfAEt
         s/77XbZ3o90D9YwQtMrMT9T2udieNm+iKptK8YJTX6jgcYZdpepkpQNzbTkJzxA6ZiyY
         CpV/3dmawiWYFydRRR6ptPV1XDbI7W8xukcIaLsy0QZUG3fEow++Pct+Yo+Fasd5XpvB
         WiG5sfVEqcjN8zPUNKZflwRmTHMkvtpszFMP7aObO3S0QkaDrBdyErz9RMPlRGPB5vQi
         Hckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137556; x=1698742356;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrrcjmyOsYhzUAtE3nPjXHtJxGhZGABKJJb1EALYyaI=;
        b=IyguX4YLkiP5tXlwbrWN1dFkEw7vO4VHb1WeCVNIlgRx/rSJdlltM+DF4ekOUfnMFm
         wvPXhaFLsr4UjxRi/V14PbUS4V3bWNHAUmcFp9fZ0m9Ri5/BvFnHTCWFSI0KuscQ3IwY
         /G3aftBsOhyB+Q6b/Daxsmz6lvaxkHmdZhG4XGIAcDd1OYYImllH5YxCcpXTIOZD6ItP
         jFdg22OKIQCawFYo8bR1ITtK1G76zIQdNbdnYhAKkaoeXh3qLe1UOMwSl7gNpQWL+Prw
         4xS8Eh8K2QsbQP+lmaCEOYPvO8ENsAImaE3g3I6S10dbX99p2ANOd3DOBZHpAelhp1+8
         AHsg==
X-Gm-Message-State: AOJu0Yz3S63RkvMz/pm9bllNPEgdjLG1KDyvqz8UugJhwAnG4Nqg5G+d
	yCSyymiGJYMBy2c6Kt5RgTI5Yw==
X-Google-Smtp-Source: AGHT+IGJd+Zo8jc5Uk55tbZotCMJAnGI0zkMetklhFZNbBgKiuibrRM/SyCeBJhbt992S+JGVfWR7g==
X-Received: by 2002:adf:f50f:0:b0:327:e073:d5fe with SMTP id q15-20020adff50f000000b00327e073d5femr8271598wro.38.1698137555987;
        Tue, 24 Oct 2023 01:52:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f7-20020adff587000000b0031fb91f23e9sm9449222wro.43.2023.10.24.01.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:52:35 -0700 (PDT)
Date: Tue, 24 Oct 2023 11:52:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: peterz@infradead.org
Cc: linux-perf-users@vger.kernel.org
Subject: [bug report] perf: Disallow mis-matched inherited group reads
Message-ID: <df95d570-0f39-41bb-9072-49eb59fa2d76@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Peter Zijlstra,

The patch 32671e3799ca: "perf: Disallow mis-matched inherited group
reads" from Oct 18, 2023 (linux-next), leads to the following Smatch
static checker warning:

	kernel/events/core.c:13392 inherit_group()
	error: potential NULL/IS_ERR bug 'leader'

kernel/events/core.c
    13363 static int inherit_group(struct perf_event *parent_event,
    13364               struct task_struct *parent,
    13365               struct perf_event_context *parent_ctx,
    13366               struct task_struct *child,
    13367               struct perf_event_context *child_ctx)
    13368 {
    13369         struct perf_event *leader;
    13370         struct perf_event *sub;
    13371         struct perf_event *child_ctr;
    13372 
    13373         leader = inherit_event(parent_event, parent, parent_ctx,
    13374                                  child, NULL, child_ctx);
    13375         if (IS_ERR(leader))
    13376                 return PTR_ERR(leader);
    13377         /*
    13378          * @leader can be NULL here because of is_orphaned_event(). In this
                     ^^^^^^^^^^^^^^^^^^^

    13379          * case inherit_event() will create individual events, similar to what
    13380          * perf_group_detach() would do anyway.
    13381          */
    13382         for_each_sibling_event(sub, parent_event) {
    13383                 child_ctr = inherit_event(sub, parent, parent_ctx,
    13384                                             child, leader, child_ctx);
    13385                 if (IS_ERR(child_ctr))
    13386                         return PTR_ERR(child_ctr);
    13387 
    13388                 if (sub->aux_event == parent_event && child_ctr &&
    13389                     !perf_get_aux_event(child_ctr, leader))
    13390                         return -EINVAL;
    13391         }
--> 13392         leader->group_generation = parent_event->group_generation;
                  ^^^^^^^^^^^^^^^^^^^^^^^^
New unchecked dereference

    13393         return 0;
    13394 }

regards,
dan carpenter
