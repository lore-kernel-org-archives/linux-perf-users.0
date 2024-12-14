Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4BD1865E3;
	Sat, 14 Dec 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734179712; cv=none; b=r0z/IMdk16DoUYyKnks1WfTivjnE0hNYtJQsyhUF82I65Hwn3K4Mw3r/5Jnn5fjb2Zlyvc+udYXlFEys7/QpcDI3cB9X2X8XnwzhtpSZRWdknuYoS950bxpmVGD46yDY2YO8OaWMsWCtebPvINejYYTZGua2arp3xnXq29U2jLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734179712; c=relaxed/simple;
	bh=DHbsgIChekq1/+MQtnp5Gpc7MNurovM1v0ce07kwQO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNIBqqH0De8tkT1unnnO9qAsPUOPYgunWW46E+4ZPCfUUIempTQDJTEzH/etrQPbIT7zhUQP1mWmUuT51RW9GXdHu8fvKUCGYrgi/g837Z1ggvt16oVZU5Yp6OrwTXSUZqTydbOMYYeZW9nWwthg2V8+rZ9YJM8ByI6d+GHoSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByG2+Cm3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByG2+Cm3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so2292203a91.2;
        Sat, 14 Dec 2024 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734179710; x=1734784510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1SMsEGruFdAyL91QMcYYqfUU9gU2qxB8M/r5v8wsDw=;
        b=ByG2+Cm39KqQdMjgXCtHsZhhe2og2to4TmE+KEEKeY3EQ+skTmy/GhzYkhJXKoU5P4
         2vJL4tMYFbRlIysKtRP+MV+mpoUfBGgPj30qKKtubSOLFEJVQpn1TqDtODps9ssDz0dC
         oUMtJPAQe1+RUMnJK20uPaW/AvuV0CeRV5vci1AF4y/ESyRkRhO36C5qxMYu/28Ck7wY
         pHyj4bwGzM3XC9mOkV4XsvkjnidZkeeb3HLiO3q6426aW9JzP2rIwCEV74gjNlIlQovk
         Kn6VaPPPEeHf6/szE1ldXxEFAXWIr2VcTneFvI8kQVI8ZUZSYWoqSgqjatrhS0xjb8br
         3dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734179710; x=1734784510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1SMsEGruFdAyL91QMcYYqfUU9gU2qxB8M/r5v8wsDw=;
        b=k7W1qKojF8G73oGuKSmQT6RjKJ5WogSf8P2FGzo91pmKt1ftFfcXKHUmTH5PlwVm0g
         ySqPOUbAi3bMTdkrFqeTnG5oAZdZnH5ppRBhRF1rmtlAJn8CCHx8kWkoPyGvVHYYtQ7N
         qiT/ySfNLorHgKY0/W4PBpxhShoxcEFSswwUFWn/L+TdR3rdPNTV1Y20T2BkIhzv7gDs
         39qIkBm8gVBYkh87Kn3f1UHRtDGcwbMebaal14MpUH5RNsxxNNXAfV2oCvccDfxZKF+l
         QdifvrARMgjY3foZYzYiaZQzDz/T/TRmQlV7q3u95spH/ca7kA1KGmMk0zYxMrd1vzHG
         P+vg==
X-Forwarded-Encrypted: i=1; AJvYcCVt6hh+MMGMnUMUtYQM8hoCGQc84Uwe7DoD6asKtSj38Ygj6MZq6i2ARmzD6FdC07YV4ZwcyDZvCLO42I8=@vger.kernel.org, AJvYcCWO+u6YQ3/lie5atH5p3iXtOOmjqQCkvK9kzfSuLRq+WZtV6hARZM8U1Ogy2DK+2zzHzviG9AWPTeZhGA+l0HOdfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXoTTJR412yKIVl4+CCiylHNc9J1kg8MS5RHJU5E23wvDPJao
	2jMP7TkV9romfvJnU6ATSK5wsRYeu5gvRYVyol9qaOtk+TJwrKii
X-Gm-Gg: ASbGnct5dw+Uj0wetl1eF67F35mcVQQVYhYxQifMl818Of5sXsSefK/EC7lKC0mEcG/
	Zub+70Yta2ND3BxKP9n9R4ZjKx+I4tX0x3/vbzBTb6n6Q5dryR6Jtlt1W/nGqw50oJOpkdzh5qK
	7IqcqCnZOVIVmnwneMnQtaOta92V84sVdGWDRtrJFHKuuaG9d9IpWOVjn31FxJezsgDrUeSRc8r
	fuolHes5zVvoMk3Wj6Akbh4Ns8H7/oYdchWgjgMWjZKoK55sg6yZ5JXGT3XoPnKGtx335vNdXGz
	az9qotgd
X-Google-Smtp-Source: AGHT+IG8L1YaGH/Cgmw7Opw3u4PDbnmIOIuuXVXMVqH9T8gGG3dklZxuxNY+sYBFxEQpVE+ObpgmSw==
X-Received: by 2002:a17:90b:5490:b0:2ee:cddd:2454 with SMTP id 98e67ed59e1d1-2f28fc672edmr9885088a91.15.1734179710538;
        Sat, 14 Dec 2024 04:35:10 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434ae9sm1500804a91.33.2024.12.14.04.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 04:35:10 -0800 (PST)
Date: Sat, 14 Dec 2024 20:35:05 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 6/8] perf maps: Avoid UB passing NULL to bsearch
Message-ID: <Z117eag/AP9w9In6@visitorckw-System-Product-Name>
References: <20241213210425.526512-1-irogers@google.com>
 <20241213210425.526512-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213210425.526512-7-irogers@google.com>

On Fri, Dec 13, 2024 at 01:04:23PM -0800, Ian Rogers wrote:
> If maps_by_address is NULL it is UB to pass it to bsearch, and will
> trigger ubsan, even if the nr_maps is 0.
> 
> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei
