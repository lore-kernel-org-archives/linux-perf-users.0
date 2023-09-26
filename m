Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D73B288
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 22:54:30 +0000 (UTC)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E7121
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 15:54:29 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79f9f5135f8so293573239f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695768869; x=1696373669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUr8O7tqNP6/AHlaieQGuvAZ3nJ/0R3GgdQO01zbXBk=;
        b=jfiXq5z/PvcZkgBY4QULnYSwuXCnRNTCSfheVDV3Y/GO43S91dW6z9hdeXDU/WS055
         nToQoJOS6XFaQuKlZknZd8SwVgcWn8ZcAs1l8FP0+Ee4t4GQrnpA5ykI9gEZAWoWCxvZ
         yCWTZpsXoIaCxd4YwgGS5Em5XLdeSv99t8B6j9Jp8YsyeLLYB9qQlFU7vsx1qqH+9DOm
         B+Q2MBZU+UaM3d3cOon43gYPogBg7K8b+vrow+1AD+dOtWtW/suSv8ppU+/sDO5obRfI
         EhqCFh2/j8X+yfRCU2JgUOYCJFPOCtx7sjVnfKgG5fxczHuclYzH1VtHeEzopdHT4nnY
         9RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695768869; x=1696373669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUr8O7tqNP6/AHlaieQGuvAZ3nJ/0R3GgdQO01zbXBk=;
        b=Tpqm6Pcsp1jKaZoal5HcZoQF7SFNlE34FEg/zjAm82vXZ2T6VGgz4UEPvOOlLB8D9R
         s0SbY0qUXlYDPZ/24dwfTEuGOA9rjykFjDk0a3j7V8o/SK2mMD8nhjn1h00CAs4TjHGg
         q1rRRuED3YTxl4H9wbt4k2CMoF+9ZeNXERer12sYNZJb+gPIq4IsJM5c16FjRJhSRgVx
         QHMlS/Xi9SalgDZxIZ8z6Wqesc0fQqhZuFrDxWqXlpiaK2+wU5YALWCSS1m/559kirPC
         4QGoA4E75F/irvnWUHY31cwQPQY0vyu2N0bgiMa+8BnZpinKjJVXPejMxI2eY755FDow
         Ee8A==
X-Gm-Message-State: AOJu0YyyzMr4e+N3tiBLZp+GtS3KEyltLn5rl3/+kSQtonCDxvYsYg0E
	C+L9cq9L3/5F46BoZjWRzbaIKNEIFs0WhYbSfHXTQiBP93g=
X-Google-Smtp-Source: AGHT+IFWXl2VL6ZaJHy41IG81P0mLxVgjAIOff/KflVudAC9I5A0SglcOGv7AdopKOcxFdncPyssYsngMKkKpbjGd9k=
X-Received: by 2002:a05:6602:181a:b0:790:fcc2:6e9c with SMTP id
 t26-20020a056602181a00b00790fcc26e9cmr269117ioh.12.1695768868834; Tue, 26 Sep
 2023 15:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919150419.23193-1-vmolnaro@redhat.com> <alpine.LRH.2.20.2309201256480.3810@Diego>
In-Reply-To: <alpine.LRH.2.20.2309201256480.3810@Diego>
From: Namhyung Kim <namhyung@gmail.com>
Date: Tue, 26 Sep 2023 15:54:17 -0700
Message-ID: <CAM9d7cievN+Jry0EwLB0FrTr3hjTmXMoCwsv8fZbRn0TTW1nMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf test stat+shadow_stat.sh: Add threshold for
 rounding errors
To: Michael Petlan <mpetlan@redhat.com>
Cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	acme@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 5:39=E2=80=AFAM Michael Petlan <mpetlan@redhat.com>=
 wrote:
>
> On Tue, 19 Sep 2023, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> >
> > The test was failing in specific scenarios due to imperfection of FP
> > arithmetics. The `bc` command wasn't correctly rounding the result of
> > division causing the failure.
> >
> > Replace the `bc` with `awk` which should work with more decimal places
> > and add a threshold to catch any possible rounding errors.  The
> > acceptable rounding error is set to 0.01 when the test passes with a
> > warning message.
> >
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>
> Acked-by: Michael Petlan <mpetlan@redhat.com>

Applied both to perf-tools-next, thanks!
