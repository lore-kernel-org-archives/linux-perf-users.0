Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869772D0C99
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273879; cv=none; b=KsEbjV4kUwr+rxVG/jFH/nCXs2+ivLjYr8cdCkH99izWFt0N77V4gNRBqcVFmCLznJ2jlQ7pyYjmDOWW/0Y99VPiX9xfJBdgZvq45M2SukEaKptXP6i8/VZLhrK7QoRwwUYJV8J3NsDAof1tDt+MH3P1uFZHNZFks7wmUw8Bh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273879; c=relaxed/simple;
	bh=I2oehnwu1ZtZ2nSZQReIFluTy9eO0ldlfcJOha47UgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJkFaIi5tGz98HubOmID0sKJmj39IAvd+qixky5RZ1KzzVs4qZxsdY5Vk4e4WPGyqyYV5fugT+gm61E0KYXUncsrP3Y6ATANsnPzL+gYNZVISjs3yrM1eONoahhbnNRVgmdh22RT+jcQRMRRewaD9pYft9BuIZ6JsQ3pVPZ0zFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMSepwig; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMSepwig"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781206cce18so435964b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 16:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759273878; x=1759878678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoQEcly9HBRRvRyEJZ3tin9hqwMJQKfC7mBPShQ6syA=;
        b=KMSepwigWU3Ka6NJzv5k9sNnllmbwfzq721FH1PhCMMkszmqa+bbP3zpTabBkKUsCf
         CG174baV40c5TSLWwcLmB/zCpM14W8rPqsgElEu7otmcP5GO6lPVnA691amXVo5u01HD
         taytt3Luf9siDUbl5u6XiEn0U4PLH1MVIrJVnChtEFnYZLdClzl5fosqe13Al3mApHam
         gmjo4Zz4ViYPzCAiT6SQYlyjXa8P/s/hMEOwOpXfZNWR/r5SoWhiyUtdKLsdEbXFiAER
         uw3FfVQFLbLfXQLU0e9PWoxWmuDFpO8leLYwfKzOfAvkhgJ6mlcmPfkx0/Og4iiZQwLN
         yf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759273878; x=1759878678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoQEcly9HBRRvRyEJZ3tin9hqwMJQKfC7mBPShQ6syA=;
        b=WXEjs3dJHsik0oD0KlqST/Sspe/rv3R76u9V3+6Ddq2VLE8zOjuE7YVOGfctbHhce2
         P/3ELnbYmFjkfyxsLY6rJuMlSiDzZa3nDtonJX1/m1iNu64tOfyHIPTQJktiAo7Jjvx9
         +QM6s42Z18mf6cE2prsJceDy7Y0KfDjkHPO+1EIN25CAyZSbAdmSvKzL70VvMh2fF2/s
         VzO7TL6foVTRPx4uadpugYM+nGCeK1AUBhDAb8d61GIISIwhtwc8bx31okKgLthSQBKr
         TsCRVfvCIhyNK5+7otlsMdIDiFHqqVArAA8IMdw9ww7ILrX6awLGpPedFyEzdrNM3v97
         Xb6w==
X-Forwarded-Encrypted: i=1; AJvYcCVE9Pw54059o7BzCbXik/MUU7hbavseqDmG2uI47NHNQHWPSLG1lpcjlJftC2ICzYEDwz5JkWqkRttewll1f+1d@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vf1pRV5jmpNb69Z84xDyb5a55XXsY3q4gF9s+7CApqMAAu6s
	eyNuNu5/Upn3nlEwPmKiyEuw5xm9Bu4gL+xPtsAd4DUwmhnBi4LT19rh
X-Gm-Gg: ASbGncthmNfpe9Ie1xZbyhH+my+kQUrpURPOGMQPLZ7jjmb2WJAmwpzTH6xNamewXeH
	NadLBFf7Z8QF6GnwMGnh06fyubv2VyjcSUfkxDOS01/M6rbrCWNlN8JCDTAO2X3MwDYs9KrVug1
	ZquXzxVr0uPZVdedYAO6gq/mQC6IeGYGhmmTnz3Zice1ByR0AGNDlesoM6kAGN7n5q5rR2GU/gg
	amWropxb1m5bhUEY0V8+MFOjStRqTqab3Lqd7InUVQ5EeYDZmmMth0hlfJQPqHYbWbBHgpOtWWu
	VnZ3JcWybiFAXYt6SuqtefB2U++V7aEO+14XV8vhnweqkAu/wCknYUCVJLUeJg0q1CjMWC1bTcM
	ufGobddxe37j7DWp4tkZWcyJfPYF5
X-Google-Smtp-Source: AGHT+IF+nweCrMiUJcE3jpyOpnOZrJlJow1aPBjVGke+YDbBefAorJadxVH1HjNckfU28LnGL5Fy+g==
X-Received: by 2002:a05:6a20:4326:b0:278:bc13:d83e with SMTP id adf61e73a8af0-3218dae950bmr1904270637.11.1759273877643;
        Tue, 30 Sep 2025 16:11:17 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::55b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b274dasm15009804b3a.63.2025.09.30.16.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:11:17 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: irogers@google.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	collin.funk1@gmail.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	ravi.bangoria@amd.com
Subject: Re: [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
Date: Tue, 30 Sep 2025 16:10:57 -0700
Message-ID: <20250930231100.197258-1-collin.funk1@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903184248.695267-1-irogers@google.com>
References: <20250903184248.695267-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ian Rogers <irogers@google.com> wrote:

> The 'import perf' test needs to set up a path to the python module as
> well as to know the python command to invoke. These are hard coded at
> build time to be build a directory and the python used in the build,
> which is less than desirable. Avoid the hard coded values by reusing
> the existing shell script python setup and determine a potential built
> python module via the path of the perf executable.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/python-use.sh | 36 ++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100755 tools/perf/tests/shell/python-use.sh

Aside from avoiding hard coded build directories, this also looks much cleaner to me.

Reviewed-by Collin Funk <collin.funk1@gmail.com>

Collin
