Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E379CC
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Sep 2023 04:10:31 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB510A
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 21:10:29 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-79fa7e33573so352617939f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 21:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695874229; x=1696479029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nTr0xSMdGypbVrs4EW20udCUdK2YivXh4qdc8d6M9U=;
        b=PyE215eWqQraZ8O2E44pPO0WM31PBdqr8rOg5sYlBdulRu/knoerMMnzoULn1J/xnt
         fGg2+xsM0/jvdxXvHvrmUpY9dZD7riW+wVycbL7E9YCDDP3Ko9ky/K9xMDRrL6NaKr1B
         jMNN2pszzlyn9RxdR52M6SgU50XdtDaU6oFzZUxutSxj9hplgiZyJySdZlEfq5YrH6PW
         hIjvQttbKQbK57OMGvBsALYQt6BhSUhNvQCyAYX7w2s4cvSYKrCceHag1ISNh77Sf9Zd
         tDyFfVAFbda9wC4vhHc29sbD4IlUZXbOPwJrK7qSKpSwg2R/ycbjChU91DobPwiC+SUf
         9ujw==
X-Gm-Message-State: AOJu0YzKthRfOk76H/lPWb/zXqdKSzXTR5VoPYs8P04bSJ1Q7w5V4kVe
	f4YdsqUEmdVbf41vOgkI8GgcUloRRfDGupkSIaM=
X-Google-Smtp-Source: AGHT+IFsRqBJIodlhK7Kvm6rRuROj+ebVCuSEo1GY5wdtvHC27GlzJqOZ98CdBdecfIfrM8MfbMllIo/W530inoNOkg=
X-Received: by 2002:a6b:a0a:0:b0:79f:b2c5:e8b with SMTP id z10-20020a6b0a0a000000b0079fb2c50e8bmr113511ioi.20.1695874229108;
 Wed, 27 Sep 2023 21:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920192847.975897-1-adityag@linux.ibm.com>
 <20230920192847.975897-2-adityag@linux.ibm.com> <CAM9d7cihonpzY7pW1o9V1q5Ja2SAD+frcjVESBw=073LpuokLA@mail.gmail.com>
 <cvjy23kygfwv6hl4kw6k5ob7hezmxmsx7owjso5hqmuno2oz4a@3fcbymhjkklo>
In-Reply-To: <cvjy23kygfwv6hl4kw6k5ob7hezmxmsx7owjso5hqmuno2oz4a@3fcbymhjkklo>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 27 Sep 2023 21:10:18 -0700
Message-ID: <CAM9d7ch5ea6vRaRSXSB3NE=O3vuMMcFF06BsM5XvZCy6wX62KQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf check: introduce check subcommand
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, 
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 3:18=E2=80=AFAM Aditya Gupta <adityag@linux.ibm.com=
> wrote:
> Also namhyung, I moved the definition of the 'supported_features' array t=
o
> builtin-check.c, and is also accessed in builtin-version.c does that seem=
 good
> to you ?

Yeah, I liked that part :)

Thanks,
Namhyung
