Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F42C9E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6949F;
	Sun,  8 Oct 2023 22:22:04 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-27751ac0653so2455902a91.3;
        Sun, 08 Oct 2023 22:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696828921; x=1697433721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wRMA6PdEYAejXUpWE7rJpLSvGQxKHe3y2Xu2hibcMI=;
        b=QheQefglbCA3yqHcrXn9ZvFEj7TWj8v2+iyTT80Q66ZiXRe17SUck5di5Z73FTX0eM
         mUT6Bt/VzeIUH+20R5gxoo1d7QFUEs2QLdQFce7+0wKqsnh4CZEMEegduLs4i5JDm9nr
         0Ukb/2qIZM1oLWucQddzJS/w79Zl+IsMC9FQcHhtywtuBev+PSCY4EdvtrmmOq7hdGof
         Mk3AdlPUk4t+Lu1xZ/MMackmtzu2N4NEfJhoYZtwqw/MNP3Aa8ChALA5TXW7wr2v2sJq
         grtea6RN7VX5c62WVMnLFOcxmRbNw1Q53OMvsmWxA1rgNE3virJmXw+xloKPw4+WgCsJ
         k8/w==
X-Gm-Message-State: AOJu0YybXfNKHdVyQ52Kls42JzJ4jIJcvffLrP07/A2NKMi857t9XZ1r
	impUNOTmPs3G2sgPsZbsBJO5GJe6ie0Unm6jsXQ=
X-Google-Smtp-Source: AGHT+IHny9G0BkYZhdEZRUkV5fXGLMjI0ADOVu2CKmR60BomZXSEfg9+mgWGqdU34gmaBTkwRD5RPGhpEuhj2gGHRz4=
X-Received: by 2002:a17:90a:73c6:b0:26d:287f:a545 with SMTP id
 n6-20020a17090a73c600b0026d287fa545mr10816633pjk.29.1696828920719; Sun, 08
 Oct 2023 22:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230930072719.1267784-1-visitorckw@gmail.com> <CAM9d7ciJZsCaVo6m_VtJ=QKNGAtBkAncidQjHzwexd3H8+3Usw@mail.gmail.com>
In-Reply-To: <CAM9d7ciJZsCaVo6m_VtJ=QKNGAtBkAncidQjHzwexd3H8+3Usw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 8 Oct 2023 22:21:49 -0700
Message-ID: <CAM9d7cjx04RFjE6x+09mh7SjVWRiB46czYGWenVzf=LaKCrqSA@mail.gmail.com>
Subject: Re: [PATCH] perf hisi-ptt: Fix memory leak in lseek failure handling
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: yangyicong@hisilicon.com, jonathan.cameron@huawei.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 9:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Sat, Sep 30, 2023 at 12:27=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.=
com> wrote:
> >
> > In the previous code, there was a memory leak issue where the previousl=
y
> > allocated memory was not freed upon a failed lseek operation. This patc=
h
> > addresses the problem by releasing the old memory before returning -err=
no
> > in case of a lseek failure. This ensures that memory is properly manage=
d
> > and avoids potential memory leaks.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!
