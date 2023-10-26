Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F862381DF
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnQ+nJYO"
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8AC91;
	Thu, 26 Oct 2023 10:11:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso976571a12.1;
        Thu, 26 Oct 2023 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698340283; x=1698945083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+b3te2DwYywqjIiY8hga8wTzUv9c0ds1pzLWR2VOXk=;
        b=AnQ+nJYORiJExIflszqTA1NzEglFdQJk35FRbDQuvsjIXjNwiuKVSQMTK3d45EfoRc
         CbBWDDnIYPQQP8qgp/CnIN2y3JGgJ9zo1LP9OrbWtooACCy0+sv9nsB3ZdWkaPGVYLP6
         PAdBVm964g6tH3uwdLytbexFWP7k47wc4rGDbVM30frXGo0+5alTFIlDpZmD4qVC0aUE
         9orPSs6aiIh4uLsPU5DG/pVIT3g+nVfdSkj5851LvEPSjtZcMGO/UcA85qQM64CEgKT8
         OrJ7kIy65uA+dxA2bCWR62yvcZt8UlLs++k1ttuXCcF0G/GtgK71oqeJwOpOsIFXYXn6
         tBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340283; x=1698945083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+b3te2DwYywqjIiY8hga8wTzUv9c0ds1pzLWR2VOXk=;
        b=G0fxHuwHN/mcLMjNU29KrDcUqLpuTHYPrtPxpAh5eSRATwqe09ShsqUlaxHFs5nZm7
         fm6v2awmj3vSHRBFOBYynPdGswPA9fblXUL56U0U7AQYxzQ/JFe3i6BnROkwnpli2K8A
         PAomkbNahg3PZE0qm3JDY3aMMRbnh5ne8HdKFbetmL10iyq7Ne97bzUZ+22eVZQ6Ks1G
         q/Gb/DUrI0fLQqIv2EOKOjw7uiDm/sNUVJNMkac0QJ2typgVPce5GU1B9LrMtBD8g7I3
         Up3tIfZHWOXPoRm6wk+VWfxbt0L5Ixqox1dGVJhA5rsAVQaWN8HyI7hrVbMkGtZrirpn
         YqSg==
X-Gm-Message-State: AOJu0Ywi5izA4lWgpNcl0sRxIXPfrValSnGDnPME54cyQjklIff5N56e
	EMjEZdrVlJN7BEQ8SboPK3Q=
X-Google-Smtp-Source: AGHT+IGOa1aDHT8kOWahmwESzieWcOLzCIdMI5G67cB15BLitvpWEbWKva5Clh2UegJ3+gv+SP1GxA==
X-Received: by 2002:a05:6a20:3d82:b0:16b:9886:7eda with SMTP id s2-20020a056a203d8200b0016b98867edamr501084pzi.35.1698340283370;
        Thu, 26 Oct 2023 10:11:23 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ec51:cb82:a169:2ada])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b00688965c5227sm11356315pfh.120.2023.10.26.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:11:23 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf report: Fix hierarchy mode on pipe input
Date: Thu, 26 Oct 2023 10:11:11 -0700
Message-ID: <169833996388.1181734.3051920334476183711.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231025003121.2811738-1-namhyung@kernel.org>
References: <20231025003121.2811738-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 24 Oct 2023 17:31:21 -0700, Namhyung Kim wrote:
> The hierarchy mode needs to setup output formats for each evsel.
> Normally setup_sorting() handles this at the beginning, but it cannot
> do that if data comes from a pipe since there's no evsel info before
> reading the data.  And then perf report cannot process the samples
> in hierarchy mode and think as if there's no sample.
> 
> Let's check the condition and setup the output formats after reading
> data so that it can find evsels.
> 
> [...]

Applied to perf-tools-next, thanks!
