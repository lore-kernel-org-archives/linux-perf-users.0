Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89A1111
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jx5OGt22"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28cc07d8876so2168238a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jan 2024 17:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704849261; x=1705454061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0QW46Gis+61G/am4G3OnlXBRgJBpR8nOsCNrDI0sD8=;
        b=Jx5OGt229aC2z8kbAMoVpUDoEj4N94X3CzTdWjehz7YMabPnJBWEvvEVu2tTO9IpLf
         Bo9XPdHtd/7kTx9A1sR/0T6Ifh+gcbQxy61g7+c0xlTufDZleKwyd1UJhM2IVHXabdvf
         Ipe4KcDJPDhp5uk9UoCu/GbItzGWhO4IfgJ5GwvEuVys5rSiRdwlVdKSMCNCOvUN8elR
         stTNlPIlGMUNqPASvkndEQeWnbm9WcAgFa/OexWmD+BFgi/cpcursjHp0152vGMh9PYH
         upw5ei6PbSxh89RpesvP0YpJ+5NHkWMrGODpNUjuyhFGlOpWE0PAZVdOQHxn1gRpT5NW
         O7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704849261; x=1705454061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0QW46Gis+61G/am4G3OnlXBRgJBpR8nOsCNrDI0sD8=;
        b=Xm1iUWBsLYSlXS0EropQorhodpyVoeWPGq1r02+31SCiO3hB6WMIjIAyjKc6+GDYAh
         W3NDTmytf52nbOiVS1hOBopLJj0aMLTKC1ZC9dYMi1u19cn/UPvriRz0hPzaHqGFB74S
         5dODrB8BTnmOr4rE5/YVauz0S6E2PjZvmStkeRTzG5z6pPIIIEfbK9tuExFF9y5DwuvC
         Ke5ao/XyMWxq/j6oK7ERBiagQwOmHEqu0cY7djj0FXf6wdY1SQirjk3mIhxNrGmlgL56
         rtlA3ED7GvcI+Id07iEIrHfd+O/TLjYQKKgdG9wWc3dqGJAnEf74Ylw4gg9pRnCIJbyK
         kebg==
X-Gm-Message-State: AOJu0YzEeV+5Xy/BLkrBEEnuK/Da0NCCg7L7T/x9lB5BhAqjKJghSitk
	oM/79AFCLIH6ifsoSHWaVoLkqe9gopjJsg==
X-Google-Smtp-Source: AGHT+IHFZW5QjM5bsJ4IwgGYllbjTit0iYgpIyphSzLzLhYj8lH6rkx9T2tEfel77gaAg/WPdDTpAQ==
X-Received: by 2002:a17:90a:31c8:b0:28c:3042:f8cb with SMTP id j8-20020a17090a31c800b0028c3042f8cbmr119341pjf.21.1704849261353;
        Tue, 09 Jan 2024 17:14:21 -0800 (PST)
Received: from debian-dev (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id js16-20020a17090b149000b0028c2de909e4sm136337pjb.50.2024.01.09.17.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 17:14:20 -0800 (PST)
Date: Wed, 10 Jan 2024 09:14:13 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: acme@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	john.g.garry@oracle.com, james.clark@arm.com, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, alisaidi@amazon.com,
	vsethi@nvidia.com, rwiley@nvidia.com, ywan@nvidia.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com
Subject: Re: [PATCH v1 3/3] perf arm-spe: Add Neoverse-V2 to neoverse list
Message-ID: <20240110011413.GA44@debian-dev>
References: <20240109192310.16234-1-bwicaksono@nvidia.com>
 <20240109192310.16234-4-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109192310.16234-4-bwicaksono@nvidia.com>

On Tue, Jan 09, 2024 at 01:23:10PM -0600, Besar Wicaksono wrote:
> Add Neoverse-V2 MIDR to neoverse_spe range list.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

This patch series looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
