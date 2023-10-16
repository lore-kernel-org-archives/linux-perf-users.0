Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B320B0F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rt+U9cfJ"
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72221E3
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 03:39:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32daeed7771so1057420f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 03:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697452778; x=1698057578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIaK3sm66TImARHDtodwxW2o8aXauaz7AMVXRhEFaCs=;
        b=rt+U9cfJf5hXAKiMwGngW28UXxe0Om5Yevn7YJOqJz8Fye5DXk0EHZT9jlGWD+u9RH
         rgeI8afG+ckDi8Jl0M9Os1SxVpQOPMW6S6EfDBoha6e8vCIlOyu+kbMuWvrckOt2emIH
         lTlZt7YX6d5hKQBwHZptDp4ylnGAZ9eenxMk3hWBZERF/UU4m/+tQ2lWmOL20dJWOsIx
         D1AsyFutb3RwbN6Ng67oOYSva/e1CyplxPU3zHjVLmLLrvUMpgT/JrKXl9XWtqrpcdfW
         xYsDDz+u9ApB7sptdIYPfuq76M5xrtrQilDjehT8UmuXxoVZKk95BhKmy/X0kY+e08mg
         jLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452778; x=1698057578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIaK3sm66TImARHDtodwxW2o8aXauaz7AMVXRhEFaCs=;
        b=o4+YrdiOpXiYVWC0euxMSFOAdbdarnuh+/aVHxxDE8C/0+q2Ot0Yeyk9fBWNwPb3Bq
         I+SpA44sQ+ohNXtTgcaO2EsLjOkLt/5w6wqSVviCtAt3cYc1GtYS75friqG61HaODLDX
         MDLfVwnQx1uBcHRW7gyaJ4adjzTzNdYCfVC7IYZLx6C1Q37Pmcg8A4W4uk5OcFASvhy3
         Wj8Ro+NNYfryQGlj9AVrK24rEHf+NivoCi5GuC/5R7Jh3th2kCPu2UMiYJrwq6+NUwt5
         Or1MNuspSWErVY05Mb4ESEwrq53f0h5IZpDH63arRjWstbLxYx2ZaKb1Tq06XJAD03RX
         8flw==
X-Gm-Message-State: AOJu0YwmkZkXHUdKZR5VaNlPW1nszGZzhXundjnwhVjeME/80UmkIa+8
	CFmP/jCfSbAAVnlgz2NRUzjPuA==
X-Google-Smtp-Source: AGHT+IFveYcznE7UFu1xi5ZfIZ/xSlQ/9xS59UksXA4meHvxl/9Pc9EfDN0Oj/U3lSI4A04Yn/sylg==
X-Received: by 2002:a05:6000:1c17:b0:32d:a910:6c2a with SMTP id ba23-20020a0560001c1700b0032da9106c2amr4912494wrb.30.1697452777799;
        Mon, 16 Oct 2023 03:39:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e14-20020adffd0e000000b00315af025098sm27104942wrr.46.2023.10.16.03.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:39:37 -0700 (PDT)
Date: Mon, 16 Oct 2023 13:39:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Message-ID: <f13b0b1a-e5f8-48db-9a09-1ef88cc6c6eb@kadam.mountain>
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
 <ZSjyJuqk3z0RyKP2@gmail.com>
 <0c973a20-e10c-4989-b7d9-86cb0f522718@kadam.mountain>
 <ZSkInflBriOL9V3M@gmail.com>
 <CAFULd4b7F=MNMduRn99FFcAc7Of7RsL+vyXVzsiBZZ9hz0+HnA@mail.gmail.com>
 <ZSpZRM4ZEnNy98Rz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSpZRM4ZEnNy98Rz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The surprising thing is the Clang doesn't detect the bug either.  It's
strange.  (I found this bug with Smatch).

Also I notice that my Fixes tag wasn't correct either.  That patch did
have a missing error code bug, but "ret" was set to zero.  :/

regards,
dan carpenter

