Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC0749D
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Sep 2023 03:54:26 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C610A
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 20:54:24 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-79f8e4108c3so417386439f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 20:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695873264; x=1696478064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ffh5AuBADYvsfT7a3KQemhZt061Q+/YJzr1xF3hsJY=;
        b=aY1hXLRkR7K+UVuoLnjiLQZKebU766FQvsMWnq4FJsM8iXF6/de+BXhiq+GmLhCV56
         Hv4gk51kwy4A8IwRciMxCQ0Hfyysxa2gUmLkI8PccMWzO/M6ADD797rLujOvI/X/XWjy
         kdcWClCET2eP0bWqb6ndxkIaAj1bKvaRnWQeqtQY/oKY2rVs38sJLZQ5kM6zSEcBTjcZ
         Q687IinAdY2AsobzEAXvggh88NLlQhO1nvJOLwwV9FCEM3abifnSUF0FxIzXmnwFIZSg
         Kr28FFlAvFtzwrEcfq7dGLxJ+ifLSmKGtwvcJV+Xb7hTjDNpniyo5/YbvH4jap0Lhj5I
         oyOA==
X-Gm-Message-State: AOJu0YzWaBrCgu1PgIiVXl/t01GE4twd/qtDGGiPtX00khI3SJlp0bwI
	KbjELHiJgrkrqZmmJr2PG9Q+fDVGLHGEaDvunGkB66MVee0=
X-Google-Smtp-Source: AGHT+IHejStbeE558odE76K+o5Iv15QNsvtUJIfzQ0Z7pMMjVunz5I/JAr4eiOxxtAhfmjJ1B52foGpUDGi3P1LgrkU=
X-Received: by 2002:a5e:8804:0:b0:791:1e87:b47e with SMTP id
 l4-20020a5e8804000000b007911e87b47emr49195ioj.15.1695873263829; Wed, 27 Sep
 2023 20:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907171540.36736-1-atrajeev@linux.vnet.ibm.com>
 <e5e806c3-da4a-8672-9c8e-6c341c6bd27d@linux.ibm.com> <11B32809-962E-4632-95FD-EAF07EE04D1D@linux.vnet.ibm.com>
In-Reply-To: <11B32809-962E-4632-95FD-EAF07EE04D1D@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 27 Sep 2023 20:54:12 -0700
Message-ID: <CAM9d7cgtBCHZWt1h8jZj1k1VuJUvGXjmXuXBmE-4sZXW_inzPA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix for shellcheck issues with version "0.6"
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: kajoljain <kjain@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, root <root@ltcden13-lp4.aus.stglabs.ibm.com>, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 9:29=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 25-Sep-2023, at 1:34 PM, kajoljain <kjain@linux.ibm.com> wrote:
> >
> >
> >
> > On 9/7/23 22:45, Athira Rajeev wrote:
> >> From: root <root@ltcden13-lp4.aus.stglabs.ibm.com>
> >>
> >> shellcheck was run on perf tool shell scripts s a pre-requisite
> >> to include a build option for shellcheck discussed here:
> >> https://www.spinics.net/lists/linux-perf-users/msg25553.html
> >>
> >> And fixes were added for the coding/formatting issues in
> >> two patchsets:
> >> https://lore.kernel.org/linux-perf-users/20230613164145.50488-1-atraje=
ev@linux.vnet.ibm.com/
> >> https://lore.kernel.org/linux-perf-users/20230709182800.53002-1-atraje=
ev@linux.vnet.ibm.com/
> >>
> >> Three additional issues are observed with shellcheck "0.6" and
> >> this patchset covers those. With this patchset,
> >>
> >> # for F in $(find tests/shell/ -perm -o=3Dx -name '*.sh'); do shellche=
ck -S warning $F; done
> >> # echo $?
> >> 0
> >>
> >
> > Patchset looks good to me.
> >
> > Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
> >
> > Thanks,
> > Kajol Jain
> >
>
> Hi Namhyunbg,
>
> Can you please check for this patchset also

Sure, it's applied to perf-tools-next, thanks!
