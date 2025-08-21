Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA75257821;
	Thu, 21 Aug 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815962; cv=none; b=gDNt5480CpJxBP7mE843U7xqZoDnEMKr744upaLf+JjN9pvEkzJfC1ceGsp6tu9Fga2bTRUMWet/WRe9Krwygx+oWO8FZcwK8J8Km390O+ABaVsl7b29zI0+M1BhEcesFwGdfRmYwkJezlelE41zz2UEGwQ9HblQdmGnY2IB6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815962; c=relaxed/simple;
	bh=DWNvCgvUku97kCEz2S2L2RN/nWTSZ8kkimEeJ71ZdUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ruYdpKlPa7l/Kfur2+hkSvcByQyBVVV8/bWQLF2uFS+PaoVyMIxP/v9towb1AeTiuE538Cx5lECHH0hi+hYUQ5DBfdLKko8GPEL3aKfD4cMo1WAG7Jf5UMGdmVcT2jsvGElUxRFs/pAz1MJ74uzmBgqCE2oBJEEYqmW01aXmJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzCCOzR8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzCCOzR8"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso2058359b3a.1;
        Thu, 21 Aug 2025 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755815960; x=1756420760; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl41pdMQfgSxT89vUYvDPz6ja4RDAegG3CblVy+ZTCc=;
        b=LzCCOzR86m2lkhWUhBjBu/ZGrWnAaWOVOOYqq7INVwoAw8XXFsw6JV0c2weclKRza4
         L2YZjzCBlGQHajJW8c36Q7fnbAmieQ2X5h9Lq79USjVz3tEu0dl9qtYT0PvpVnSLYJiu
         qaQoiR2tbO3fYEMMdCvEM9TXADDxWfgNbB16SDOur1ui0/P7s0oD79NST2aqD29c+haQ
         YmWlttsiWDW2vy2E1RoctXH/2sMQDLTAFt+HIQBHACzWsiJH5q5qozAhNNDQebk8dED3
         EJqx7yN5SBTBTaCWTKtVq46B7SxGk6oscAE97PDCZZPm6ZnXKYRJ/jaOCYi8+hZ1s+Lz
         1FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755815960; x=1756420760;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl41pdMQfgSxT89vUYvDPz6ja4RDAegG3CblVy+ZTCc=;
        b=eM0d72hY3k4ULi/bwhxaSOJ4JRiYs30iEYJXsTIILtAMZCk48wZ7f0jvbPU+nfyGAF
         DzfP2nWyGKv5x5CQnIYojTGbajgUzYkvPrPHOnlB2bgtfUR4kROOQUPDMg1KgA+IMnDu
         kK0+UweYFF4/6+PgyE5gPLb4ixEUjrbSAkoFmYjq44XfZSMWyPXcnB51pstf/q2Y9SU2
         ITs1YuC43wry6j9Y0bvfK12+bpkGKGZ7ceLilenjsCXOljSwwfw4MBri8+kNPGRDiPdq
         4aJ9/smIDE4KH6OWa3H4KxT1DoXV3cXhEaAv0bApvL6TYuUlw6DEEEWSi2HwNuj8ituy
         qr9A==
X-Forwarded-Encrypted: i=1; AJvYcCVerrIM/Q+JVvHOAMH3VCPvcG595YsJylRmLDp/M/nf3aoHwrT4nuPZ4MWfh6faDzAJaph9JevPGyZi+ao=@vger.kernel.org, AJvYcCVsV2wP5/jiwa3TVlvd3ZJJTxC68n/BcIECEV/n/dVGrry07NGGk5JepyeHVFIoS2oOBqmyWiNKK2fVG1uylIrVFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3xtEvZwc75mtNOxIw1B0muAHyqb6aXXcyyiYedLCXB5cFuCD
	LTqjD4Cek8cJimnIy2cjHfTIsi3WgETwKxzWxjnwGzwH24x3jPyiYL1CkBk+Xx1pZ3k=
X-Gm-Gg: ASbGncskeEU/bM9+2Un6cveQNDtZi0bckNZQ5I+0xJsvEk/KpT6nLckg3HBkPcR+pdT
	SL6k+UWERnhQE73tx0sMFfxrCCWBAxZCt81A88Ui/b3Hx0fUmpbT+8UPZAPlj7VKWumGY/xkEJA
	t52RcDJzdpGNsset4vjY+vEl5mAJ+xNTrmMkX6/qM2cJSEe+DYAwvIerbwqTdBcJx+C+ebEM4lS
	V2hVpgy8EfZbRjQRs2aQPDj6I88yfoVMb5VMPTxcCGTsMTN/k0wXs7E7ODKK3ERJ3vnWlxarzR+
	1ZKeVyTyrJhHHiOEDcJMoldbwnyrSQs9fUK4jAeZ7DkwZ1FyI//wmAAPSFdor+ZtLFhnpuxSArB
	KxBK2ld3Z3EoqeA==
X-Google-Smtp-Source: AGHT+IG0xQxtAXB2xWgcjuktQKwSapMNEBe8+quB0DRKQ4otngjOB7zVW45vZxbnXfVrlR4QRZypxg==
X-Received: by 2002:a05:6a20:3942:b0:243:15b9:7798 with SMTP id adf61e73a8af0-24340eb7997mr1079642637.60.1755815960267;
        Thu, 21 Aug 2025 15:39:20 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::e9a2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d5513fcsm9003912b3a.111.2025.08.21.15.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:39:19 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Namhyung Kim
 <namhyung@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Adrian Hunter <adrian.hunter@intel.com>,  Kan Liang
 <kan.liang@linux.intel.com>,  Chun-Tse Shao <ctshao@google.com>,  Blake
 Jones <blakejones@google.com>,  James Clark <james.clark@linaro.org>,  Jan
 Polensky <japo@linux.ibm.com>,  Howard Chu <howardchu95@gmail.com>,
  Thomas Gleixner <tglx@linutronix.de>,  Nam Cao <namcao@linutronix.de>,
  Li Huafei <lihuafei1@huawei.com>,  "Steinar H. Gunderson"
 <sesse@google.com>,  Athira Rajeev <atrajeev@linux.ibm.com>,
  linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] perf disasm: Avoid undefined behavior in
 incrementing NULL
In-Reply-To: <20250821163820.1132977-2-irogers@google.com>
References: <20250821163820.1132977-1-irogers@google.com>
	<20250821163820.1132977-2-irogers@google.com>
Date: Thu, 21 Aug 2025 15:39:18 -0700
Message-ID: <87h5y09u5l.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Rogers <irogers@google.com> writes:

> Incrementing NULL is undefined behavior and triggers ubsan during the
> perf annotate test. Split a compound statement over two lines to avoid
> this.
>
> Fixes: 98f69a573c66 ("perf annotate: Split out util/disasm.c")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/disasm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index b1e4919d016f..e257bd918c89 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -390,13 +390,16 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>  	 * skip over possible up to 2 operands to get to address, e.g.:
>  	 * tbnz	 w0, #26, ffff0000083cd190 <security_file_permission+0xd0>
>  	 */
> -	if (c++ != NULL) {
> +	if (c != NULL) {
> +		c++;
>  		ops->target.addr = strtoull(c, NULL, 16);
>  		if (!ops->target.addr) {
>  			c = strchr(c, ',');
>  			c = validate_comma(c, ops);
> -			if (c++ != NULL)
> +			if (c != NULL) {
> +				c++;
>  				ops->target.addr = strtoull(c, NULL, 16);
> +			}
>  		}
>  	} else {
>  		ops->target.addr = strtoull(ops->raw, NULL, 16);

It is undefined behavior, but works correctly with GCC and Clang. In
Gnulib, we allow it and suggest using -fno-sanitize=pointer-overflow
instead [1].

But I can understand that is not every projects preference. Therefore,
this change looks good to me.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Collin

[1] https://www.gnu.org/software/gnulib/manual/html_node/Unsupported-Platforms.html
