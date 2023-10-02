Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F31A5BE
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 16:48:28 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB8B3
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 09:48:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso743747266b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Oct 2023 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265304; x=1696870104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tGIS2d4IoBhPIJormO2ARUKb4WPqFJw4stm8Ff0wEc=;
        b=kW7Y8sfD4fGa6l95GeAvpt1zDa7CZyv6NyX1vSf1/2n3/DKWsBRMch6bEzCZ9z5QUI
         A45wvcWWbJ47eiVvEoXyvGDGAMoeY71E+5Rei5fXVlL+//r10U6R7Mjg3HHLuKGVSEwX
         52wTh8RGDSRXZgkuEiLoH+QZXLYbLKDjOralM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265304; x=1696870104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tGIS2d4IoBhPIJormO2ARUKb4WPqFJw4stm8Ff0wEc=;
        b=uW/DuMBNJ9YYPJ8La+oplFpdqZJ7KYD0q16kHehagGvfbo+qdLDDy/ZhZ0CZx8aqu+
         WxkfiUmjSl1UAmA3zAiyPN5XLS+mlGiXXDUMz7Y8rd+vk+4MZCii6uXUoqOSORzYQuu6
         pYB6G4Cz35bCUSgCxFpsDUeidzz0asSgeFvIWrPo/XLSHHfbIb2q/LAanv/DDOfTVDC3
         sQOA24mZL8IXPxnzBZYjI0Dc17haIzUG8vg5iN/7Y4bxbmM3gRlr2hJBMIHDNf20kFqv
         COJzTntURgRC7ohq5W6G6y3UkAyOPWc456fjxKY0VzdTqJrALjAuuE53S+djTzHcz21O
         8akg==
X-Gm-Message-State: AOJu0Yz79I1OlAjatQOYZrVyUI0bOfyGhcM1iOdV7tz2pOlcnwgf8fPR
	z0i4euoTYYUzAk5u8Cms+/Tp20NK/4f3Ona/jD0T4D3L
X-Google-Smtp-Source: AGHT+IEksvOQFTquaYp0cw2zfix+vUZMery65HMd0nRx/Vn1jFMP91llPxFwR411ldpGKetMmtfBIg==
X-Received: by 2002:a17:906:5391:b0:9ae:5513:e475 with SMTP id g17-20020a170906539100b009ae5513e475mr218314ejo.9.1696265304414;
        Mon, 02 Oct 2023 09:48:24 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906230900b00993004239a4sm17144621eja.215.2023.10.02.09.48.23
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 09:48:23 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso292a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Oct 2023 09:48:23 -0700 (PDT)
X-Received: by 2002:a50:96d1:0:b0:522:4741:d992 with SMTP id
 z17-20020a5096d1000000b005224741d992mr2415eda.4.1696265303058; Mon, 02 Oct
 2023 09:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906160505.2431857-1-dianders@chromium.org>
 <20230906090246.v13.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid> <CAD=FV=UBw1-9=LPUydewyOg8oL2WMG+ZCQ=PBpe0CiCs-ToWSg@mail.gmail.com>
In-Reply-To: <CAD=FV=UBw1-9=LPUydewyOg8oL2WMG+ZCQ=PBpe0CiCs-ToWSg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 2 Oct 2023 09:48:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCcwc71hSMQVQN4AYi7XhKpOwbOZnt8b9iGUgqmvzuKw@mail.gmail.com>
Message-ID: <CAD=FV=WCcwc71hSMQVQN4AYi7XhKpOwbOZnt8b9iGUgqmvzuKw@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] arm64: smp: Remove dedicated wakeup IPI
To: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>, 
	Chen-Yu Tsai <wens@csie.org>, Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
	Peter Zijlstra <peterz@infradead.org>, Masayoshi Mizuma <msys.mizuma@gmail.com>, 
	Stephane Eranian <eranian@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	kgdb-bugreport@lists.sourceforge.net, Stephen Boyd <swboyd@chromium.org>, 
	linux-perf-users@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	ito-yuichi@fujitsu.com, Chen-Yu Tsai <wenst@chromium.org>, jpoimboe@kernel.org, 
	keescook@chromium.org, linux-kernel@vger.kernel.org, philmd@linaro.org, 
	samitolvanen@google.com, scott@os.amperecomputing.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, Sep 25, 2023 at 5:39=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Mark,
>
> On Wed, Sep 6, 2023 at 9:06=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> >
> > +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> > +void arch_send_wakeup_ipi(unsigned int cpu)
> > +{
> > +       /*
> > +        * We use a scheduler IPI to wake the CPU as this avoids the ne=
ed for a
> > +        * dedicated IPI and we can safely handle spurious scheduler IP=
Is.
> > +        */
> > +       arch_smp_send_reschedule(cpu);
>
> I was backporting this to our ChromeOS kernels and our build test bot
> noticed that arch_smp_send_reschedule() didn't exist in older kernels.
> That's fine--I can always adjust this patch when backporting or
> cherry-pick extra patches, but it made me wonder. Is there a reason
> you chose to use arch_smp_send_reschedule() directly here instead of
> smp_send_reschedule()? I guess the only difference is that you're
> bypassing the tracing. Is that on purpose? Should we add a comment
> about it, or change this to smp_send_reschedule()?

FWIW, I posted a patch changing this to smp_send_reschedule(). Please
yell if this is incorrect.

https://lore.kernel.org/r/20231002094526.2.I2e6d22fc42ccbf6b26465a28a10e36e=
05ccf3075@changeid
