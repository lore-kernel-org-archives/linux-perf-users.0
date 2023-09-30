Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35F8C16
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Sep 2023 05:53:01 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303D6B3;
	Fri, 29 Sep 2023 22:52:58 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-79fb78e297bso410726439f.0;
        Fri, 29 Sep 2023 22:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696053178; x=1696657978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgL4mgIUCB3+3iorD5Xfn3R15O+SpyDpvRSN+ix3xsI=;
        b=lZGL/YLTgPABwJvNRwg+U3AoU2Fk2YO14fQei2dUiW1Z/QMzt4WevQa2QoOOA6j7Ol
         5gM2Hc4rRpIlHcaoSGbS1L9IDfrPgjUde+ZlMoW2/eWAxfl5pYp3GzLvk7+55MatYH34
         vX2IRkRu4AyoAVC1dag2Qa15EgDspmQODU/Vaq56QAvO5IB15t7g28gvEqCPU7cBVuX5
         /VX+Lz/yidGJUr+ZMBhg7EBNfdh4gpFnvy+WWjSpxo5A4JtzlvQ8ijsfPr0hJxBhjrvn
         eCJuBsCTlCp3T5gqIgZ9VB3yPFYrcSFWAcTyo9JK0L757JOGNNIvxmwMUYac63zJdNEw
         HUwg==
X-Gm-Message-State: AOJu0Yw7I1fh3DbBTHgkW4IiMWIKJ83zE5w7PA8zlV0+B8RTBzT7vcxi
	U9+Jl0w9bL22aHhQ8fhfvTUQgcVJA6M4HSxM/aw=
X-Google-Smtp-Source: AGHT+IEWGh0PEJQMYm7c1DxqOI+Qgx/21NB+oD5KIoFL78pxtoMhWJQolIFXxa2+/NSxrZB5zyzJtqoRQ7ea00LyWg8=
X-Received: by 2002:a5e:dc44:0:b0:78b:d0a9:34fb with SMTP id
 s4-20020a5edc44000000b0078bd0a934fbmr6395308iop.20.1696053178067; Fri, 29 Sep
 2023 22:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1695794391-34817-1-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1695794391-34817-1-git-send-email-renyu.zj@linux.alibaba.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 29 Sep 2023 22:52:46 -0700
Message-ID: <CAM9d7chjTuypUywbxfo9fKsJaDrJYE1YuLWdXX9AkFi58JBnew@mail.gmail.com>
Subject: Re: [PATCH v11 0/7] Add metrics for Arm CMN
To: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: John Garry <john.g.garry@oracle.com>, Ian Rogers <irogers@google.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, Zhuo Song <zhuo.song@linux.alibaba.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 11:00=E2=80=AFPM Jing Zhang <renyu.zj@linux.alibaba=
.com> wrote:
>
> Changes since v10:
> - Fixed conflict.
> - Add tags.
> -Link: https://lore.kernel.org/all/1695621444-56530-1-git-send-email-reny=
u.zj@linux.alibaba.com/
>
> Jing Zhang (7):
>   perf pmu: "Compat" supports regular expression matching identifiers
>   perf metric: "Compat" supports regular expression matching identifiers
>   perf jevents: Support EventidCode and NodeType
>   perf test: Make matching_pmu effective
>   perf test: Add pmu-event test for "Compat" and new event_field.
>   perf jevents: Add support for Arm CMN PMU aliasing
>   perf vendor events: Add JSON metrics for Arm CMN

Applied to perf-tools-next, thanks!
