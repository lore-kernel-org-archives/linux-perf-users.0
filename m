Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47809C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Feb 2022 19:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiBUTrJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:47:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiBUTrJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 14:47:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642A12251A
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 11:46:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id h15so14560762edv.7
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 11:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x5n0KIksilMeR6DzbdweTTc3DXgOS0W8l/4lRaacIPc=;
        b=G+r8G1FUSwrCdALE+kx8hoJ2nwYntJ83swgzKr6XNLcFbSNBXlvXoA8qaX3/1AGEU0
         txQXh1Lk6a1I8MoqOC5FdgdVkPlsULGDSwITw7AiTWvnV3j50cJSW/lngKhUJPOoZ63D
         K8meMmIOsMAteFqry5T7jmssxA+LhnBN/kuQo8F2VlA6NMDot+ZLSHE3amd+DNYzTto6
         /rvreUruhwER/7dd5FytCJkb3oyDVgdTzkw3eHIRTjOYY14/6fZxyKf8F4NuhThpyN0/
         mwHyCUSB9OF3XcMCntfD16FgAoAxPeaKEqUWboCGVWE3J5t8YD/zjiFqybRwMFjuX723
         pFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x5n0KIksilMeR6DzbdweTTc3DXgOS0W8l/4lRaacIPc=;
        b=uSSCnrvc5SNgzWlVoZ8DFLg3s4nmgkOcZ7sB3HSfURgoydEKKGbPcFJB8n/YCdAkgz
         KINTwZpCOTBJp8fQ2SRUUGLKqp6lHYkz/qqmDQ+FbBBI7+WqxO+xyBrwIZJyOPv9GIYZ
         GaY0UK+gE0K9DyEV1eobVOLhdaPx6rI6CmH5QlfwgSnK9uzmhEEtFBCd+BrAGi5fvV2d
         dP3v75W2nNeb80r6PHb7yHeLafUa/p+lcoZD31YZ5jwraQD7gv5UvA/WkVRzWLCuTpI8
         nTnhr6OPCbZPRNWpkmD0FlRSK8XchTYqiiMf8VkK3qy1X88aVmXZlEiNoUdquJ+iGFwn
         gLyA==
X-Gm-Message-State: AOAM532mEK+k13iSrHt7CS5X4eA5nL8pdBG8RFCAWxBwFu+VNppxKg6a
        y5fvHTEQQTO70sB1qCjvRUzpGOtXB4w9ew==
X-Google-Smtp-Source: ABdhPJzhpxLOKfgvzh2kCQph9iwqs0uAI963J7ZLuU1A1Tq5zSCWqOjjH4JdijFCcB/9YKQOviPUiQ==
X-Received: by 2002:a05:6402:849:b0:412:8cf5:73db with SMTP id b9-20020a056402084900b004128cf573dbmr22668575edz.237.1645472803932;
        Mon, 21 Feb 2022 11:46:43 -0800 (PST)
Received: from krava ([2a00:102a:500a:4c07:3c4e:83d8:8cd9:974f])
        by smtp.gmail.com with ESMTPSA id fd21sm5458546ejc.44.2022.02.21.11.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:46:43 -0800 (PST)
Date:   Mon, 21 Feb 2022 20:46:40 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     acme@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] libperf: Rename arguments of perf_thread_map APIs
Message-ID: <YhPsIJBdsN9AiE0O@krava>
References: <20220221102612.43879-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221102612.43879-1-tz.stoyanov@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 21, 2022 at 12:26:12PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> The "int thread" input arguments of some perf_thead_map APIs are index
> of the thread in the thread map. In order to avoid confusion and to
> make the APIs consistent with perf_cpu_map APIs, those arguments are
> renamed to "int idx".
> 
> Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  6 +++---
>  tools/lib/perf/include/perf/threadmap.h  |  6 +++---
>  tools/lib/perf/threadmap.c               | 12 ++++++------
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 32c5051c24eb..a21f733b95b1 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -63,10 +63,10 @@ SYNOPSIS
>  
>    struct perf_thread_map *perf_thread_map__new_dummy(void);
>  
> -  void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
> -  char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> +  void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> +  char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
>    int perf_thread_map__nr(struct perf_thread_map *threads);
> -  pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
> +  pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);
>  
>    struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
>    void perf_thread_map__put(struct perf_thread_map *map);
> diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
> index a7c50de8d010..58f7fbdce446 100644
> --- a/tools/lib/perf/include/perf/threadmap.h
> +++ b/tools/lib/perf/include/perf/threadmap.h
> @@ -9,10 +9,10 @@ struct perf_thread_map;
>  
>  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
>  
> -LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
> -LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> +LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> +LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
>  LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
> -LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
> +LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);

does this argument name change break abi? do we care at this point? ;-)
not sure if we already started to treat libperf properly in this regard

jirka
