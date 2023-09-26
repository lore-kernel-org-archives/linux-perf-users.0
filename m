Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D01104
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 00:39:48 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67348109
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 17:39:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so12732159e87.2
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695688785; x=1696293585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnEgEKAhGM5JWN8y/Tiqur2/djSzZqgbL2OPyciIbQ0=;
        b=hQkZt1rk8MZluX4MVZDRRQvsOTqYR+EuCWTEoIzLB9RG64Ar6RMPhWEwF/LHG2cZZl
         1eBgXRo7sFnZAMOenmld9xZZ+XXH746huXsAA32euUVzzfhtoMde8hMkFW/K8RQM4CCS
         92wQzJkvGXJ1iQJ3jcBS/QHjw8EA3p6842oMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695688785; x=1696293585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnEgEKAhGM5JWN8y/Tiqur2/djSzZqgbL2OPyciIbQ0=;
        b=g1mr/YvtMD8tB6z/eaA+sAaAu6sfsy3PmHoSILZG4PrglJYEON086dFwnIpSQPQGvj
         vT3MZ/qwt3krlLYc3hFAzLUKyrBBvD/leN0swHUCc081I1Lo8VHDkQtvOXEX6gdOHLpQ
         DgHT93c/SrTMeg1RDxJrO8FNjKEIxOw5wYB8lj0ncpqwDwOwDl875BK/ZKeekyJxpZ4Y
         +6WzO1HcR8dyMHOGvQeHJknuSdgcudRZ0+dYr2P/HiRq1nxFu8ii/yJOUpnDnMI/fwiD
         bZxtjdn44n95NTOm2snrJDhrqENe7FMzeYqFoU51gVoe9art7pxdPl5hga3saMI5Z5XU
         P8kQ==
X-Gm-Message-State: AOJu0YxqhLs2rDNay0VnhmVXNT9xvG6+f9fRItqlSCZFeyCTaaq1+SG/
	UhN9T34OPmA5nnFJt0Gh92a43T6LACvpXAWLbho85bwi
X-Google-Smtp-Source: AGHT+IGobJNSQuD7ai3jxY6QBAutW+n6PCXzBPWkOq3usJh6l1qqveXLz/rZTOSGzyphsOYC2dXnMA==
X-Received: by 2002:a19:6710:0:b0:500:9a15:9054 with SMTP id b16-20020a196710000000b005009a159054mr6236969lfc.20.1695688785697;
        Mon, 25 Sep 2023 17:39:45 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id q19-20020a056402041300b005330e1e7da0sm6023391edv.92.2023.09.25.17.39.45
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 17:39:45 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4063c2ed5ebso2325e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 17:39:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3b90:b0:405:35bf:7362 with SMTP id
 n16-20020a05600c3b9000b0040535bf7362mr54102wms.0.1695688785170; Mon, 25 Sep
 2023 17:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906160505.2431857-1-dianders@chromium.org> <20230906090246.v13.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
In-Reply-To: <20230906090246.v13.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Sep 2023 17:39:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBw1-9=LPUydewyOg8oL2WMG+ZCQ=PBpe0CiCs-ToWSg@mail.gmail.com>
Message-ID: <CAD=FV=UBw1-9=LPUydewyOg8oL2WMG+ZCQ=PBpe0CiCs-ToWSg@mail.gmail.com>
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

Mark,

On Wed, Sep 6, 2023 at 9:06=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> +void arch_send_wakeup_ipi(unsigned int cpu)
> +{
> +       /*
> +        * We use a scheduler IPI to wake the CPU as this avoids the need=
 for a
> +        * dedicated IPI and we can safely handle spurious scheduler IPIs=
.
> +        */
> +       arch_smp_send_reschedule(cpu);

I was backporting this to our ChromeOS kernels and our build test bot
noticed that arch_smp_send_reschedule() didn't exist in older kernels.
That's fine--I can always adjust this patch when backporting or
cherry-pick extra patches, but it made me wonder. Is there a reason
you chose to use arch_smp_send_reschedule() directly here instead of
smp_send_reschedule()? I guess the only difference is that you're
bypassing the tracing. Is that on purpose? Should we add a comment
about it, or change this to smp_send_reschedule()?

Thanks!

-Doug
