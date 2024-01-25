Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F75D566A
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jan 2024 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158466; cv=none; b=O5i7Re7MtiGWb0rCKgi4cgSANLCFLgKldlCIYkkFOcE2PaUBkf29mS67wpxd46zJ1AlY2xvXVa/g3qvWI6wmOyeI9elQNo6/TfrZ68n7b/rddL7vVivr1lY1/09+pimiqbypn9XXFurTLHPH+ZLU6/MrFYey/lK7aBaCkFCITQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158466; c=relaxed/simple;
	bh=RY0YpxLJVnkyOM+U4EyavUoYESYenKBNJ/vaR1IY6cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbWyLqNhH4uIf5xlPTUL1W3eqZMi4qZ0cPLTCxshJKkwwzokb421DLBQO2okq07Hw1zUu9se740a2u20CDdR7GcaVaI4k/vd29SNP5ON367lMGEkt1YvQTlYPmGSRodXt5ikJB3UJLt/5f9P0sT2i2wOlCCn5yV9afA7w93rnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYBslUBh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYBslUBh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d72d240c69so54785ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 20:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706158465; x=1706763265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY0YpxLJVnkyOM+U4EyavUoYESYenKBNJ/vaR1IY6cM=;
        b=KYBslUBhHYnRbtEOssPRg1sIKHjI8Lo0tAolcbPFTk7Zz1yslplDzC1rXa2wBilOhm
         zxPgKBBm3R/ZuM872QgdRU1RFvMN8AC0BH21pnHLDRn8oKpzTwlXu11WzJNNw9GqZBCn
         eObwDyj14Va/2mzeQSBxazZBdQZgafH8Yw77xqr+Re/D6HKTvl4z8hvwqJNlb+c1Ucm6
         Ip4//zYBB9FEXFvO1tWKYyTZyKd5jkzrKm1KxJdKoozrHoH6iXFKQazF2VPu4S3eit1C
         XGe+H1zWts/U7p8MSSq3+TesHQvyOsEaeQGabkGicLmlCrRIIWPiM+3nUEZKbR9a+Bh3
         3D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706158465; x=1706763265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY0YpxLJVnkyOM+U4EyavUoYESYenKBNJ/vaR1IY6cM=;
        b=a34REYVlHgD9LGMY2lcjPYcEhpo9mKDVluBoQu13Rik1V8JNberYHMprOJdaxIRaBj
         ESTQ17EcIMgaY8O9BkAuyROmLHmxL/yqFYjsZnjfXNbkzeoiJlBsNZ3/9aqUgirqnDQG
         8ESrVmt+Q50QG9hRtt4X/WXjC2ahmnAAMcbIUh7gfLeAGdFXf0f1WVc1PNntXvfs96mH
         3N7E6hz26J6EVjKzm6teCINpEyiIqc7IgroFGswC7OJlKxun9C9W/PSeajV5A+UMGXXi
         V2HV5F1soL0Q2UtLVa3mJXAO2Xf5S6r9IOb+7oFXdwtfIsuI8udREDv/SQlvHaC8FDxp
         KNHg==
X-Gm-Message-State: AOJu0Yz3S/rvCvZdOkLMQJWE+iRyPXPPi3vc0huEvlKAtWF3/PMV/qvo
	4459nHPzFou+PERYzzlpL+S2ALG7S6wYEAZqO/efkvQKVtXsuf7vcfMrtmooh4lILCgcAB2a86c
	sCTac2K4ZXwQOHqpfyxEPFr1QD2IvM5rggt+Y
X-Google-Smtp-Source: AGHT+IGmwUyV7ad6tGGpwYKy06i1bLqX3aP6rnMCqtrP6eCDM/dw9PI9hnQa4rcswaKttl2+4JOZaCJ4y/v8gXKio/0=
X-Received: by 2002:a17:903:22c8:b0:1d7:37f5:5619 with SMTP id
 y8-20020a17090322c800b001d737f55619mr104642plg.25.1706158464470; Wed, 24 Jan
 2024 20:54:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-8-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-8-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 20:54:12 -0800
Message-ID: <CAP-5=fXDWbp90cQ62tjEahy68DF+YGiWWhXxjMLNfLq_Ce98-A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/18] perf pmu-events: Add event counter data for Icelakex
To: weilin.wang@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Yang Jihong <yangjihong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:03=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> The added new fields are required in this new grouping method. Currently,
> the format of added fields are temporary for experiments.

It'd be nice in the commit message to state which fields are added.
I'm somewhat confused about the meaning of TakenAlone on an event.

Thanks,
Ian
