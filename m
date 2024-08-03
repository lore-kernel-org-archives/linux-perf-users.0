Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0514F9DB
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Aug 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697909; cv=none; b=MoHNrfHx6dmalQSRoRn6J1eAgrTzCEfHUbAIpP07yZSNYzU6WUEz7/wiWIzYBbRBWw2VZqvH+Di4WW0HzrOVQS7RftYMux0/stfm5JU0WyKYEmCMHk/bcalkeTEFnFXrMOf3Dt5p6YpkU65k+FX3kAkswNQ9ch55aWcV3HCUBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697909; c=relaxed/simple;
	bh=TD5p0UpAlZgZjqGGYGGHskVJVNzetmUKvAuFq0qNFLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQvM3ZoEo+RZ8tNE70U/6Au7q/ZkAFsQXmaGJdtgJCHlA4BCmSzMMyJab+T4qXzJHmo2C82m1Bl3pGTKN4C1rEB+5+WlPSMC3FI9GesYlqm6poJ+7cHYLslwCj9xNk0j6+qMeUHfmXpGqVIH9dFhiQjdatDz4+3YueWrQnNKXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3S3ZJ+I; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3S3ZJ+I"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ed741fe46so10373061e87.0
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Aug 2024 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722697905; x=1723302705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IIRdmIyZahXOLCwdMsyEmaV+E/1pXlkbU2kWHPbdoFE=;
        b=n3S3ZJ+IScHnWz+c5ncTX996I36Rxg99QI26hEZ2w25TxaksTycGq2HpqAecDslFhF
         IH5+WEQvm60dL+d0llfh6aaQRPc/h9HVmrefq1sDV9yBHCxaArRNfz0AD/ZQKpMK9bFR
         YcuSs++erdZgPlsf0st0aIq47S2pKMHa1qQF6s+tXMYGyPzkuDZ1rcErM+B67Wrrya5r
         kvGO9nROOoCpRZRyi5TPt9am+YUO3eL+ysHu0VwjIcbzS1F9umA/D+YmV6BtOkNeH9V0
         OUHt2XEd6ixhdbjBcPI4LGWp9myj8zXIaUXISzW12f2YN2hMmAOknlGs5aSX40tEEKjU
         n+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722697905; x=1723302705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIRdmIyZahXOLCwdMsyEmaV+E/1pXlkbU2kWHPbdoFE=;
        b=Rj8AYLokNAa5v6+SJ952yUOlKT+qGB53epNep06u/nwaYWVB8tAyUdaxGkWk3QgAw1
         Mv4xdrK732sR5zFVedj/70FmatnkTWyADBvB+3hryLf+apnVW1RbAb5mkiiTmL7qSHL3
         VjXqx9Dxq8AhFC49UxrrL5hVX68Pr9vMl792S59tSvUQ5BBgGcAVN1PLXGHfEDkgURwh
         n9oM49pdx3ryqDP6vzE4+lwID2kZy73fSGP15p0ml6KvnDplLhWRLeSsy7f2xIogXIk6
         VY9vngLRTkfZ3HFxMUATlkGYZRQ1soOMn762mNuXKrmerrNDew1BJydeM1de5LtY2D9X
         aVoA==
X-Gm-Message-State: AOJu0Yy6iSNDVe+aZlmo16m9VoRxddcC9h15nYvSFu5QM7u4PJWgTlL4
	I3Y6IXAwJzKzOsQeXoLDI2m1I0sMoqVyNvPs8xm1O4mHV73Dw0wWqFfP6gBpJw==
X-Google-Smtp-Source: AGHT+IErJzElqSBk+MCrcqXa5hP5NyMDUvJDijFMOCBT7gp3eyLUio6Kgsdrt8DW1sGkx9pBBU+SDg==
X-Received: by 2002:a05:6512:1110:b0:52e:f99e:5dd1 with SMTP id 2adb3069b0e04-530bb4d7879mr4049412e87.47.1722697905161;
        Sat, 03 Aug 2024 08:11:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:521e:7b8e:2bc4:adde])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba0787bsm526036e87.7.2024.08.03.08.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 08:11:44 -0700 (PDT)
Date: Sat, 3 Aug 2024 17:11:40 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zq5IrJgjTJOW92gE@google.com>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqlDuIj_nMVXhYou@x1>

On Tue, Jul 30, 2024 at 04:49:12PM -0300, Arnaldo Carvalho de Melo wrote:
>> I'm testing this again, I thought Ian or Namhyung had made comments on
>> previous versions of this patchset, no?

Yes, and I believe they have been addressed.

> Unfortunately it clashed with recent patches in the capstone related
> codebase, IIRC Athira's for powerpc data-type profiling.
> 
> Please take a look at what is in tmp.perf-tools-next at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

I'll have a look and see if I can do a rebase.

/* Steinar */
