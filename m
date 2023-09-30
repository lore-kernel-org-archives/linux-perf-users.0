Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F31FA8
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Sep 2023 05:53:38 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F11AB
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 22:53:37 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-79faba5fe12so426015839f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 22:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696053217; x=1696658017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lMNDZtXrJLrGqzemt2EkDxCOgpyINxs4NaojVztYD0=;
        b=CX8nziArfp687OaOIzwUtXKtpLA2wwPihuleiGrUGRyHkG7Q8LG5B0PpZmuPb0Lqj6
         eC4/jjmrHu68TY5dCMxk/PhdexwWleN3w8orNEwcBQ6ZuvRuKl0C30wlXRmra6vIHy8+
         ER6riETFpEi9bb5PGWV7wZJrAN04kpDjA+azx/p09XH7EpBKM/hhuWvVzv3U2TqnC6bk
         RDMEFOldKbOpQPDY+yOw4v9+hB4cQn43avxeXRvYIEe+4VMU6ViUvdYTcY1d+6fYqxC7
         6xt5f980wAzMO96QAFkU7xu8zHH+eWF098i0ypQMCvJfnyFLySsE1iFCjN8QmSzpYJTM
         ugVA==
X-Gm-Message-State: AOJu0YwvmKgF3z++j7gGj8R8KKTnZwkBrqAS+1kN8GkKtq6Lxz7sSbF4
	hpTiKT/ibOzCzEflHTAofa4QVPau8oNzwuX1Y0OaXXbH
X-Google-Smtp-Source: AGHT+IF3Cs2412FLTzw0lokrxjiBgnhFrJBSlhCmbiSTkFbdV+fqJW3d/Xlis7jFMnTSCdE2T8GYxHHQlKW6AOYmSWo=
X-Received: by 2002:a05:6602:2251:b0:794:c9a2:5fe3 with SMTP id
 o17-20020a056602225100b00794c9a25fe3mr6959471ioo.4.1696053216970; Fri, 29 Sep
 2023 22:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927181703.80936-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230927181703.80936-1-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 29 Sep 2023 22:53:25 -0700
Message-ID: <CAM9d7ciNutXBM1LHMfkjLPKiT=8b0TMfiTRkn9w4=Tw53ACUNw@mail.gmail.com>
Subject: Re: [PATCH V3] perf test: Fix parse-events tests to skip parametrized events
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com, Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 11:17=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Testcase "Parsing of all PMU events from sysfs" parse events for
> all PMUs, and not just cpu. In case of powerpc, the PowerVM
> environment supports events from hv_24x7 and hv_gpci PMU which
> is of example format like below:
>
> - hv_24x7/CPM_ADJUNCT_INST,domain=3D?,core=3D?/
> - hv_gpci/event,partition_id=3D?/
>
> The value for "?" needs to be filled in depending on system
> configuration. It is better to skip these parametrized events
> in this test as it is done in:
> 'commit b50d691e50e6 ("perf test: Fix "all PMU test" to skip
> parametrized events")' which handled a simialr instance with
> "all PMU test".
>
> Fix parse-events test to skip parametrized events since
> it needs proper setup of the parameters.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Tested-by: Ian Rogers <irogers@google.com>
> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>

Applied to perf-tools-next, thanks!
