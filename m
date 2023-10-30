Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81891199CD
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+y6/MXJ"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E8C6;
	Mon, 30 Oct 2023 11:59:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso4832555b3a.3;
        Mon, 30 Oct 2023 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698692354; x=1699297154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvLzHKNfqfJIPeesP1sm7xBmzodfUNiDMZFz9MwUuZ4=;
        b=D+y6/MXJrt4XM+wWJ+c953PmYbnT/Av1NGEQCfnHHtv+E2Xk9aSejgrr/WOglDHFjF
         CCyBqArQN/sNXUDI0FXEaPTo+OjU0i3+3zgpZsi2vbIOb4EQaiJQs214eAS4bYEuOtlj
         RsJEKbk/bPseW4Cuz+luBCt5o6FfWM7KM7Y9FHa/QjRlTHmi7Lx+g5UHeLcVeR7yIX51
         YUSHEEQPByM+N7gnaq6ELKP0FbtipGt4seo6ZjJ99Mw4XEtATH94AJ4Thb1HD06Mwc5n
         E523X4iLDsJKF262yOcc32E0Bw3JRX+tuOVWKxz/OtkICI8gWB5U1FJwiW56P3FV0H6n
         cnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692354; x=1699297154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvLzHKNfqfJIPeesP1sm7xBmzodfUNiDMZFz9MwUuZ4=;
        b=qShs+M1DvWE3n6+zjRCbXhT3aytpXa10+WnM0k9RRJ79lbO3vNqmN/f8HAywSsVOKb
         STtYSMxg3QoLIhbESo1f+SGYNB+X0ki/70/b/AwheqK+8DiNfI8BTlsdckmylMe81aFy
         Nwzgi6jfPCxAZ7/wybHTru5B/hOizvm3+cLyS010epjJZpH2vUu75gISnI8Gw1dFCU2E
         69Bd9069yQVz78JDNOwP2r78vYViVJ+c0CGh7td0OpKUALPgLRvTrr0OmwLacO9hhKmd
         Io7adgt6xnKagbPkf5QDJqKmpieUbvnTXDivmB9HhhJfrxP+WKUh8xshA2dvLMgaoah3
         b6kA==
X-Gm-Message-State: AOJu0YyOgo1ydoVDGo5zK7hJ61J9PffaDViNjCyaVNmYkHcC+9S9KCYo
	5SCFpsj6pO4deWma8jjmUs0=
X-Google-Smtp-Source: AGHT+IENhuBqrVCfJcJVLnd2q2Kv4zWWdzJY1J/GkKavpS0MENz533hVt/e3Tr9o0Hizsv9S8PMWUQ==
X-Received: by 2002:a05:6a00:1356:b0:6c0:4006:4195 with SMTP id k22-20020a056a00135600b006c040064195mr13066707pfu.0.1698692354573;
        Mon, 30 Oct 2023 11:59:14 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:b306:b3a5:37ab:d58f])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b006be484e5b9bsm6191396pfo.58.2023.10.30.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:59:14 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/1] perf python: Fix binding linkage due to rename and move of evsel__increase_rlimit()
Date: Mon, 30 Oct 2023 11:59:02 -0700
Message-ID: <169869215961.2773399.6773127902679002347.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <ZTu8Kgb2KqifMBZ3@kernel.org>
References: <20231023033144.1011896-1-yangjihong1@huawei.com> <ZTrCS5Z3PZAmfPdV@kernel.org> <CAM9d7cjhSSV+18ZCHLdTFpMM+MmpoDkYSGjUa5JKZp02Kx9XRw@mail.gmail.com> <ZTu8Kgb2KqifMBZ3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 27 Oct 2023 10:33:30 -0300, Arnaldo Carvalho de Melo wrote:
> The changes in ("perf evsel: Rename evsel__increase_rlimit to
> rlimit__increase_nofile") ended up breaking the python binding that now
> references the rlimit__increase_nofile function, add the util/rlimit.o
> to the tools/perf/util/python-ext-sources to cure that.
> 
> This was detected by the 'perf test python' regression test:
> 
> [...]

Applied to perf-tools-next, thanks!
