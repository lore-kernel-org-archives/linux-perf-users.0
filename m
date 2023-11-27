Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIKrVWm2"
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764AA91
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 05:30:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2858ae35246so1871474a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 05:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701091804; x=1701696604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKlDdBuEZ+8lU90QI08u0X82MNiRvxsgynDVkDlzsLE=;
        b=YIKrVWm2JTzmRYvIV+rA3LDWTWyiXsKmjaNjnb+4vSPoaMhQ49QDxrHsd4bBMFAna3
         04YEz3SDhsQcKXzHRYeE8KdrFKkDi7hycr8iSAKrl2HQq1VZ45zpz/AWYl2l/kpISWQE
         7AzirNKyMy2poyfBYHIgiva5j4+qubT2p36Osfg1XddnKhiKBxsS2IHpQuWLH8ok2hxq
         n4kklFfnQ6j6BX4gN6GzVpcRuAu8KrrEyDPqUNxgct+/t+ss+whbQH/ewmcsnoRi4doU
         bo8Mfrh6cW8TeuRG5ChsOg/oH+7TiuBTMr7x5ooRTf6qUMEKs21Jfv3Hz1piTOBuC5/B
         MXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701091804; x=1701696604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKlDdBuEZ+8lU90QI08u0X82MNiRvxsgynDVkDlzsLE=;
        b=gyJY1T4WWZmYNT3nl+nogKrU7RUVePdWjAwWFZL+KckOKo7eMI/o0X5oU3QRI3LC5R
         pJZSMM+eHkhu+mgAl4pcscxM3EVJn8EIg0CN5av06P4eExGAMxvE52EtXsHaWsdpVphN
         F+mEiTRYMa3aCQ9UeIS0dBRtYv/TUZZRdfz1QpgC6+EuCfN4qBkDGh85FYpE4RChDTH3
         rou/70MfmIaXbvLxOGliF4juUm6+MNvdDyyiv0zSKDk4qWB5gOnslvE7ymohUeMY0CLY
         kJsHexfF6VDJVM5yhHcGFUky9P4LnsZkw7NeCWrdl90Dome8yJzYLAG0V0Qh4cHh2h0S
         8zCw==
X-Gm-Message-State: AOJu0YwT6aH5aq79LI4/bGRGk3XQuR+WdWros+43PqiHsxvsqsl+53+9
	m/FvWHTMXPqAEnEiaXsfzdo6ZQ==
X-Google-Smtp-Source: AGHT+IGM0uNalET3HXy88rOoTMDYsMyN6wjw9RF8DZp4O9yFJrk3P0ME8UMdH+ZJrGCfY1RnxHugLg==
X-Received: by 2002:a17:90b:388e:b0:285:c4f1:4646 with SMTP id mu14-20020a17090b388e00b00285c4f14646mr3143688pjb.46.1701091803680;
        Mon, 27 Nov 2023 05:30:03 -0800 (PST)
Received: from leoy-huanghe.lan (211-75-219-202.hinet-ip.hinet.net. [211.75.219.202])
        by smtp.gmail.com with ESMTPSA id pg4-20020a17090b1e0400b00285a2069a22sm3994317pjb.5.2023.11.27.05.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 05:30:03 -0800 (PST)
Date: Mon, 27 Nov 2023 21:29:57 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Nick Forrington <nick.forrington@arm.com>,
	Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, vmolnaro@redhat.com
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
Message-ID: <20231127132957.GA76706@leoy-huanghe.lan>
References: <20231102162225.50028-1-nick.forrington@arm.com>
 <alpine.LRH.2.20.2311242037260.11297@Diego>
 <20231125030529.GB178091@leoy-huanghe>
 <f0ac7523-edce-4b0b-a142-14c03c912720@arm.com>
 <20231126074030.GA647134@leoy-yangtze.lan>
 <ZWSXr7e5KxM79Z0l@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWSXr7e5KxM79Z0l@kernel.org>

On Mon, Nov 27, 2023 at 10:20:47AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Nov 26, 2023 at 03:41:14PM +0800, Leo Yan escreveu:
> > Maybe the commit log caused a bit confusion, the problem is after
> 
> We'll have the Link pointing to this discussion.

Okay, it's a good tracking.

> > enabling "-moutline-atomics" on aarch64, the overhead is altered into
> > the linked __aarch64_ldadd4_relax() function, test_loop() cannot be
> > sampled anymore, but it's not about stack tracing.
> > 
> > Anyway, the patch is fine for me.
> 
> I'm taking this as an Acked-by: Leo
> 
> But probably this could be even a Tested-by, ok?

Yes, here is my test tag:

Tested-by: Leo Yan <leo.yan@linaro.org>
