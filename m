Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8C4404
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC29B
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 19:04:24 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-27d4372322aso1968998a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 19:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697508264; x=1698113064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+GF7dCDjHk8m5WS8HzK25lhtAgTi6Fyhpd2LEXBsic=;
        b=r1XKf1BX7TteugCRppH9MkzKNLz5Szu3zBwBL+magkOLegw3AwXc5ZfI0qONHLJmUU
         08HPGPkK24D7GwpvMz9XV7j92dfkEzEQGHZUKcWUTE2A1b/bxTG1MQXML8+WvKFE8HgD
         OwGiS63sRwSbmHKOXhrx2/EJua3PY0vX1FHA5J1pOMx6NOeV0nMD/ciKDuVgVRXmX4uG
         yt3U4XzglMDftkdnDFtJkzQ1NMmX3bMNDIZGWmqbo84ksM4Kru2FA7YfKnxNG9T7aSL0
         iOmqZAim/LYmKDLZCMi+Ob4Yt1UX+6x/B+E81DCG3ckq6V7FMuIQ9q0k6pBADblJOuaC
         BD0w==
X-Gm-Message-State: AOJu0YxMpWdJrNbFkx6MoCtcf4/ER7mPAofL08ftpkBq5AIEIDylK0qH
	h/Cdy2OqzPmU5ogM40qqdaYwibH4uVEMSD3B/Kk=
X-Google-Smtp-Source: AGHT+IFrYuYxrCcB1JXBA8JEqzHU7hCBkSpTeW7cvEzxyZwI8/33nx+B/IyphfEiNQF5w2vmkvQ/kEG3UnUP0AIV0PA=
X-Received: by 2002:a17:90a:fa11:b0:27d:3fa4:9d9a with SMTP id
 cm17-20020a17090afa1100b0027d3fa49d9amr799520pjb.29.1697508264166; Mon, 16
 Oct 2023 19:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013073021.99794-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20231013073021.99794-1-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 16 Oct 2023 19:04:12 -0700
Message-ID: <CAM9d7ch9Ap+NkdQwTD+BCXNuL6GXRJYJ3vFmH3hFS3F2avT0Jw@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] Fix for shellcheck issues with latest scripts in tests/shell
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Fri, Oct 13, 2023 at 12:31=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> shellcheck was run on perf tool shell scripts as a pre-requisite
> to include a build option for shellcheck discussed here:
> https://www.spinics.net/lists/linux-perf-users/msg25553.html
>
> And fixes were added for the coding/formatting issues in
> two patchsets:
> https://lore.kernel.org/linux-perf-users/20230613164145.50488-1-atrajeev@=
linux.vnet.ibm.com/
> https://lore.kernel.org/linux-perf-users/20230709182800.53002-1-atrajeev@=
linux.vnet.ibm.com/
>
> Three additional issues were observed and fixes are part of:
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>
> With recent commits in perf, other three issues are observed.
> shellcheck version: 0.6.0
> The changes are with recent commits ( which is mentioned in each patch)
> for lock_contention, record_sideband and stat_all_metricgroups test.
> Patch series fixes these testcases and patches are on top of:
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>
> The version 1 patchset had fix patch for test_arm_coresight.sh.
> Dropping that in V2 based on discussion here:
> https://lore.kernel.org/linux-perf-users/F265857D-0D37-4878-908C-D20732F2=
12F9@linux.vnet.ibm.com/T/#u
>
> Athira Rajeev (3):
>   tools/perf/tests Ignore the shellcheck SC2046 warning in
>     lock_contention
>   tools/perf/tests: Fix shellcheck warning in record_sideband.sh test
>   tools/perf/tests/shell: Fix shellcheck warning SC2112 with
>     stat_all_metricgroups

For the series,
Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
