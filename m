Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687AEC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 20:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B8560F23
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 20:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbhIVVAL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237592AbhIVVAL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 17:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632344319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WOUQ1umT9EVazlsaxah7aOEpG+BSYoIBiyUBV41kXfo=;
        b=RzRcFFOSKqvlGIOBPpkTNq1SDnhfx7K8Mu0fiDxEyNe3cE2nolpiA423uabbCtuhllswfu
        e3Ln0aRmNz/uV9RMAJjVIaS/uLwKPmMpdJNdGhHuOZnsqq3vrIZO73wn8aoakc/z8UAUnK
        7YXrMORxnAUKaDd1dNmvpGAhx3bRrX0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-Stzt9JQVNy6Kgu5MTZrkVQ-1; Wed, 22 Sep 2021 16:58:38 -0400
X-MC-Unique: Stzt9JQVNy6Kgu5MTZrkVQ-1
Received: by mail-wr1-f71.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so3320032wrf.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 13:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WOUQ1umT9EVazlsaxah7aOEpG+BSYoIBiyUBV41kXfo=;
        b=1LZfbsQATMow+ekCcZZlYuta2EngELhudBBovQhe9vy/SRB8NqA1yWwqpjfC9+18ab
         rq3IeaeXweEwm45aWJqC6sSyYmBYfPx3CBGB+O09ToW+JRN6ROIA+VVoqJtQfB9ge7NK
         lSfaQ80SuHAtrVzBmnY4v5kxp4kmjsVhAmHrA5qHK1X/W6Sm7+h5/CxPDXDmGuH2Uqho
         a2zsxQune4ofZOgyiVvVhQrXlXnrctpBrB7wOV3Nuj5f3spfoTk416qyJDiYYVPExK9b
         4NPFinhidJQDLu9+ZjIes6SzmFtYhlnpSlwGSrkAZTDmCyYu5eg2GHASrkLcKebOMs2K
         QVVQ==
X-Gm-Message-State: AOAM531XXKtUzqOnbP9vw4vyGqWAssjoWX/C73UBgUheJtMhO0Vk48b2
        jt/mcS9NLDZxLeFsnoL4Is5bjB4NoAAbRgdhU9ZL9ek3kOkHiZaXVnKxF7095v9JClHkELAzD2S
        AoXsL7mB4fYhLFF/+kpp/9tVcsCfomg==
X-Received: by 2002:a1c:403:: with SMTP id 3mr995694wme.161.1632344317359;
        Wed, 22 Sep 2021 13:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfe21pwgdBihcn0HQ0laMXCh8q0TyvBnWeQZwWGFzNVHBjJ9vABjhZqodTrXXNQFkfbmE13Q==
X-Received: by 2002:a1c:403:: with SMTP id 3mr995681wme.161.1632344317199;
        Wed, 22 Sep 2021 13:58:37 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id h18sm3250118wrb.33.2021.09.22.13.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:58:36 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:58:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v8 5/8] perf metric: Add utilities to work on ids map.
Message-ID: <YUuY+WhB3Y3VQm2w@krava>
References: <20210918063513.2356923-1-irogers@google.com>
 <20210918063513.2356923-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918063513.2356923-6-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SNIP

> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index adf16bb7571a..34b51ca5e87f 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -59,8 +59,48 @@ static bool key_equal(const void *key1, const void *key2,
>  	return !strcmp((const char *)key1, (const char *)key2);
>  }
>  
> -/* Caller must make sure id is allocated */
> -int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
> +struct hashmap *ids__new(void)
> +{
> +	return hashmap__new(key_hash, key_equal, NULL);
> +}
> +
> +void ids__free(struct hashmap *ids)
> +{
> +	struct hashmap_entry *cur;
> +	size_t bkt;
> +
> +	if (ids == NULL)
> +		return;
> +
> +#ifdef PARSER_DEBUG
> +	fprintf(stderr, "freeing ids: ");
> +	ids__print(ids);
> +	fprintf(stderr, "\n");
> +#endif

hum, is this intended or forgotten debug leftover?

jirka

> +
> +	hashmap__for_each_entry(ids, cur, bkt) {
> +		free((char *)cur->key);
> +		free(cur->value);
> +	}
> +
> +	hashmap__free(ids);
> +}
> +
> +void ids__print(struct hashmap *ids)

SNIP

