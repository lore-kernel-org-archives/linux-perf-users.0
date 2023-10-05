Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F97FA
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277646AE
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Oct 2023 22:02:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690bd59322dso462635b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Oct 2023 22:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696482153; x=1697086953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucXGMM2wsWZRQUIgE61EwUCtxRL/wptAnVm0ckROPSc=;
        b=ilGUVVPMNVRihI1mo/6ruKBUbwln/rSq/Df/XWUUaV6Vd46W0jpRcFGF+r/ApXL9ZH
         IQjUCZs9eE90/1iQ+O29EhiBFZmY+rkGudQliaEtYrB/DfcHDQc6shL6uXQWii0OA1AZ
         M1nC+v/gT4WOtqMTTQzYUR/BExrIl5qaWNSm8gcBZanO6AQPQURkHxx+APu43Ivo738e
         HBsJlHQkmQk7OvPoxx9xPPyeaP/Xg9G0HBRjsULvdkBOJ1/D0WG9I8siBj29QkwkK5wK
         pAvtYXPonX8yYWoizVfHRRma4ePoxVnRyYagX71Iyh7tqWTsSCAhaU+BwLZooWdX3aTL
         VkZA==
X-Gm-Message-State: AOJu0Yx7hh2ztwvWEHrTpX+FFkVhQZDxvvl36L34ENZ2Lp/3P1H1aB13
	YRKybEWAoBtYwk28OOO7PoVyRukdSsPF3J0v3iA=
X-Google-Smtp-Source: AGHT+IFcEDolgIB6QYHPmh5ef7Xci5FyI7BIz/Zahu5T5nGT9LDu5s5Q7rezmdB93yE13CCofmJWcfrMGf1+iG0cHcE=
X-Received: by 2002:a17:90a:a38b:b0:274:99e7:217e with SMTP id
 x11-20020a17090aa38b00b0027499e7217emr4008307pjp.16.1696482153357; Wed, 04
 Oct 2023 22:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929041133.95355-1-atrajeev@linux.vnet.ibm.com> <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 4 Oct 2023 22:02:20 -0700
Message-ID: <CAM9d7cj26Dpit3igZjybsbnotBiv_F8mEu62Aor+9bBhwVh55g@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf tests test_arm_coresight: Fix the shellcheck
 warning in latest test_arm_coresight.sh
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 9:11=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Running shellcheck on tests/shell/test_arm_coresight.sh
> throws below warnings:
>
>         In tests/shell/test_arm_coresight.sh line 15:
>         cs_etm_path=3D$(find  /sys/bus/event_source/devices/cs_etm/ -name=
 cpu* -print -quit)
>                   ^--^ SC2061: Quote the parameter to -name so the shell =
won't interpret it.
>
>         In tests/shell/test_arm_coresight.sh line 20:
>                 if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" =
=3D "0xA13" ] ; then
>                                      ^-- SC2166: Prefer [ p ] && [ q ] as=
 [ p -a q ] is not well defined
>
> This warning is observed after commit:
> "commit bb350847965d ("perf test: Update cs_etm testcase for Arm ETE")"
>
> Fixed this issue by using quoting 'cpu*' for SC2061 and
> using "&&" in line number 20 for SC2166 warning
>
> Fixes: bb350847965d ("perf test: Update cs_etm testcase for Arm ETE")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

You'd better add Coresight folks on this.
Maybe this file was missing in the MAINTAINERS file.

Thanks,
Namhyung


> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/te=
sts/shell/test_arm_coresight.sh
> index fe78c4626e45..f2115dfa24a5 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -12,12 +12,12 @@
>  glb_err=3D0
>
>  cs_etm_dev_name() {
> -       cs_etm_path=3D$(find  /sys/bus/event_source/devices/cs_etm/ -name=
 cpu* -print -quit)
> +       cs_etm_path=3D$(find  /sys/bus/event_source/devices/cs_etm/ -name=
 'cpu*' -print -quit)
>         trcdevarch=3D$(cat ${cs_etm_path}/mgmt/trcdevarch)
>         archhver=3D$((($trcdevarch >> 12) & 0xf))
>         archpart=3D$(($trcdevarch & 0xfff))
>
> -       if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" =3D "0xA13=
" ] ; then
> +       if [ $archhver -eq 5 ] && [ "$(printf "0x%X\n" $archpart)" =3D "0=
xA13" ] ; then
>                 echo "ete"
>         else
>                 echo "etm"
> --
> 2.31.1
>
