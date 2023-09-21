Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1968361
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Sep 2023 00:02:35 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F103CF
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 17:02:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-414ba610766so204511cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695254553; x=1695859353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6HEO0H3o1+RAwm8QmL0zjdZlLfQpbik9NYH5igrRNU=;
        b=nXHPJb2Iwt6N/HapTWoA0frXSIPZV+xRODm159030NlcS/JVxhTCK63WjiqdouBfd1
         TcsX5fXaLlqdnhY09E3QNst/6Sv4prDYQ2B34QgU3yfewoeqSdRoXhdc99/NyKn+4cMr
         Sa2NGnJqYxSHdCxDnWARKEjFrMGqBxUOFOGmLJbfhaaDF+OduFiymH0/0wBi3c/z/3w8
         kjAd5FgREye0e5tiMxMR7ffy/FQG/ASN2H7F91SdFhvNu2U7dVGKqHvnPt0lsVHXHCFd
         zYXRW7d6ch36rKEXCpHCgl/Et32voJbthcoqldLEFHssbK8ysRNIQGLu+99Tsa8FGiGR
         dT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695254553; x=1695859353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6HEO0H3o1+RAwm8QmL0zjdZlLfQpbik9NYH5igrRNU=;
        b=izJq3y9pVZs6yOhlLoSSaN6lSD500D0rJzQDzO0obd7HJGS+4PIDY4gWvgCteTtwzT
         fH1Cu+RSDR8IoT3BaaJuKyidPWHYJMXhrDKpgXcCPc9P8NjlUW8ohR59rzSn6AWhrdFP
         zn/0xSxdQBjzcaO4+/hU7NYqaq+FOwJrOKtr/9y4N+NdAzfy7/+514UD3WskCeHJGODa
         +nXoTjRVVJgqNr3GILntq7yNeVkmCXzofl8VTFtJXSw/1LKq5xC2c9CrQl79nY1oncqO
         iKqV6t8c9r5yZnZ31OwaGe4x4iVcvPZClt1sB48zmzq0samfxt6x0CfjWioGf2kWShyJ
         ak9Q==
X-Gm-Message-State: AOJu0YzP5NnmIVEtl3S6I/p5HXBSqTWZ+GW/cJRqwZaNXOBN2Nt0Tg+S
	qSenHXTorCqqRk0MbXyZD77kEuGOHeoVT4RsU8Q56A==
X-Google-Smtp-Source: AGHT+IHo9IeURtDyIKZfA64YeXX+LJ//CkLpVHvMbOZcIbwvGvXveiQdbvrlElgDIHw/lF09OXtDeiKpU1Cgsv8Gb+s=
X-Received: by 2002:a05:622a:34b:b0:417:5a8c:a104 with SMTP id
 r11-20020a05622a034b00b004175a8ca104mr118640qtw.26.1695254553042; Wed, 20 Sep
 2023 17:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918033623.159213-1-hanchunchao@inspur.com>
In-Reply-To: <20230918033623.159213-1-hanchunchao@inspur.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Sep 2023 17:02:20 -0700
Message-ID: <CAP-5=fWUDgrD-Ehw1hk+L0bYeCVwve+J+=EptgUM4o+GR55YzQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendors events: Remove repeated word in comments
To: Charles Han <hanchunchao@inspur.com>
Cc: john.g.garry@oracle.com, james.clark@arm.com, mike.leach@linaro.org, 
	leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, nick.forrington@arm.com, 
	ilkka@os.amperecomputing.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 8:36=E2=80=AFPM Charles Han <hanchunchao@inspur.com=
> wrote:
>
> Remove the repeated word "of" in comments.
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/arm64/mapfile.csv   | 2 +-
>  tools/perf/pmu-events/arch/nds32/mapfile.csv   | 2 +-
>  tools/perf/pmu-events/arch/powerpc/mapfile.csv | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pm=
u-events/arch/arm64/mapfile.csv
> index 32674ddd2b63..5b58db5032c1 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -4,7 +4,7 @@
>  # where
>  #      MIDR    Processor version
>  #              Variant[23:20] and Revision [3:0] should be zero.
> -#      Version could be used to track version of of JSON file
> +#      Version could be used to track version of JSON file
>  #              but currently unused.
>  #      JSON/file/pathname is the path to JSON file, relative
>  #              to tools/perf/pmu-events/arch/arm64/.
> diff --git a/tools/perf/pmu-events/arch/nds32/mapfile.csv b/tools/perf/pm=
u-events/arch/nds32/mapfile.csv
> index efb395f26883..c76e5fbdac23 100644
> --- a/tools/perf/pmu-events/arch/nds32/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/nds32/mapfile.csv
> @@ -4,7 +4,7 @@
>  # where
>  #      MIDR    Processor version
>  #              Variant[23:20] and Revision [3:0] should be zero.
> -#      Version could be used to track version of of JSON file
> +#      Version could be used to track version of JSON file
>  #              but currently unused.
>  #      JSON/file/pathname is the path to JSON file, relative
>  #              to tools/perf/pmu-events/arch/arm64/.
> diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/=
pmu-events/arch/powerpc/mapfile.csv
> index 4abdfc3f9692..a534ff6db14b 100644
> --- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> @@ -3,7 +3,7 @@
>  #
>  # where
>  #      PVR     Processor version
> -#      Version could be used to track version of of JSON file
> +#      Version could be used to track version of JSON file
>  #              but currently unused.
>  #      JSON/file/pathname is the path to JSON file, relative
>  #              to tools/perf/pmu-events/arch/powerpc/.
> --
> 2.31.1
>
