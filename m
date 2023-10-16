Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A683C29428
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBjzy5K9"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C7E95
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 14:04:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so6585e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697490282; x=1698095082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ2HoL3h5D1fsP53Du9yOoTclZQj1sU4/TX9UV/0uiM=;
        b=EBjzy5K9zEVybireG+puBsS0HVjlviTV8Uo7gpSwlFKT6VMQZKmMHlroae8P4y0EEP
         n2agOrOiz2KH5Iain92YxG9TxmqmLEo5Lt9jmeBB26lwIGtIPfBDk07vInZ81py/zDX5
         6CynVNafVBfZt32SE8WsXavsP2ldzALWxOJnvmePk3uriARGCeXZj4q9VXuT7MyMshS3
         dVcNS1bVL3cMO/0nj1+9xs4f87/ORO+ErQs6plZKMgyKQ+I3DtdOFbUr8eOxWbL9xR55
         Z0k4RltY7GvtpqS+ItR3sSVMRSDO0H0YA6ZL57OM1QCTtIFBT7L50wLxLia1Pd8cbKiS
         cDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490283; x=1698095083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ2HoL3h5D1fsP53Du9yOoTclZQj1sU4/TX9UV/0uiM=;
        b=B1k02Y0hYZKGkXiE2gKuoev1aqOK402bDFNsUdVMsZ33kqlioSzCU8ROADHk3hrAr2
         nhcfFy1BNQt5aTM/tLqgCD5zc4A8DLVE3I+OK0c38s4gIqmVIzbv9dynht34/qIxRSGH
         hrvj6QFj5VzWJYMF7D9T5K2FQK10g8qkBS0ERVFlnQdJ0zXp4M0ykL6T3Q98kJZo0ZFv
         EkHFsT+WQIq7/k/dttI5ZQyQg+vGYwgRfAKUdhcJSeBzm3qeedOst0v7cm3iuGtKEzkg
         tK3B2a7OVnK7SlpUt22RG/Kr9i1nYC+1kqIlcrCeyH6DI0jZfEoxycnWo+tOr71G5k5a
         SAbQ==
X-Gm-Message-State: AOJu0YwDx1okKXOJJGWtyVHGD9wqXrl3ziTGXVQQQcyY5FO0CKPLfdci
	iFtQPXzxGK2OqbgbqJZdN8go2mEE9C0v9u2d2xhzSA==
X-Google-Smtp-Source: AGHT+IEBxQ/b6PbtK2nIbjqx4pGQocOWRqq0DEFmL/qxeQmkxd35BDeJvXUnlduXXhQtlBJccIr9+Xd3OAiFo+k5lzE=
X-Received: by 2002:a05:600c:35c9:b0:400:46db:1bf2 with SMTP id
 r9-20020a05600c35c900b0040046db1bf2mr40379wmq.2.1697490282514; Mon, 16 Oct
 2023 14:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016093309.726436-1-yangjihong1@huawei.com>
In-Reply-To: <20231016093309.726436-1-yangjihong1@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Oct 2023 14:04:30 -0700
Message-ID: <CAP-5=fXwAbaqqYVE_9y6JbkQ8rkU-f38ZB0gbpZdg10HLtyYzQ@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Filter out search events table of software pmu
 in perf_pmu__lookup()
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 2:35=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> For software pmu, the events_table is empty, reducing unnecessary search.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

I'd rather that all PMUs behaved in the same manner without ifs that
will catch people/me out later on. perf_pmu__is_software tells whether
the kernel context is software and therefore whether events can be
grouped with a hardware event. As a test for whether json exists or
not I'd rather stick to values derived from the json.

Thanks,
Ian

> ---
>  tools/perf/util/pmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6428e2648289..59c8394a4efa 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1033,7 +1033,8 @@ struct perf_pmu *perf_pmu__lookup(struct list_head =
*pmus, int dirfd, const char
>                 pmu->id =3D pmu_id(name);
>         pmu->max_precise =3D pmu_max_precise(dirfd, pmu);
>         pmu->alias_name =3D pmu_find_alias_name(pmu, dirfd);
> -       pmu->events_table =3D perf_pmu__find_events_table(pmu);
> +       if (!perf_pmu__is_software(pmu))
> +               pmu->events_table =3D perf_pmu__find_events_table(pmu);
>         pmu_add_sys_aliases(pmu);
>         list_add_tail(&pmu->list, pmus);
>
> --
> 2.34.1
>
