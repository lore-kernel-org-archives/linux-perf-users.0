Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D7421A0A
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676954; cv=pass; b=FF1/mdA6BAFnOD8huKt2FP+kAm0LZEOqWP/KVZb/P1oq6n1yEIlnhISoBT3MvdXdk1QE/RwfHlG56HVM1kKjJII8KJDvdl9ssFuYlDf37HVCI8S9FI7iRArHB7x9F1BneSJUxNESitZGOwTyz576rKK9aU2p0oGh7KBM3kFsn4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676954; c=relaxed/simple;
	bh=KJEqwM0YTwTR/NzeRqhW3D8vaVZiQ6K23yhYxo9cwRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixWXOotv5bFiGi0+I0/jXoGSKLMjPa6i1/HkT0fkCln5LXwf56+uI9p41sHP5SS0yCQzocJVND7WeidzY+TLIPM215NtaBdX8fYn2nHXnBQ/ORoO4Ied4nYmb+rmx0hQH2hgcZGgSwVmfHww5Vrtq6+KgTIpIdCghugyBf0jXQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dnpTGt9U; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnpTGt9U"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba180a022dso145ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 05:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778676953; cv=none;
        d=google.com; s=arc-20240605;
        b=ScryJ1dqR8OSfiAlqqVyfxerOOGV/h3yZAkZDgp7cqKado9uo5STG94I2S6j8doIZZ
         2GfE/u9k6OgMMjrSlCnKeYUPLKzR1oIxMdq8Coqjjdj3v2eFJHYJniaVNeIMRUnXFQAJ
         dz5gucSmZ7ZfWUYp1L4weygT9mqru5aLUqjn/l7m1jISjwOXWMepzk2iAaPWNL42ZqS0
         9hQ3WgULxk8pnJnePdEq2lhw2+8jLiupB08RzLGnHt9dA7QyF6ifrvE8ppTSUKx2Sots
         du+opAQqua8aSjF1tz1tpT7EdZL1bt53CNMSgccAj82BJK8FL3KPc4sZLXbOBuO/YfZK
         bPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p4chqvdfqdlpd51Jc1ZDdzdbFEZgBpj4aJvQtdp2bJY=;
        fh=NsRARg2OdtwNUbqoOUcO3wrUqmCPGCjs0Qtff+aIwis=;
        b=jIi2H/nOHCisRA9bRkAOPSwsIUazuy5MEDMw2kaQhi0KjQyyUIHnPMQpZU7xxFmXBy
         6DyyDJgIyI/zlaji84bU6mC5UADGIumwmJ0zB2ezG6BnwAszTFRoTfqHr4O9TW6EaBrp
         Nw9I2geEUMOW6sY4bOhQlgBeB7vxjwvaXQri58WrI06THkUAiLbPQ1p28rUdGKwY+LCD
         Xsc3hRFgDCb1wOcfXw3hUJVoDy1TzXTVG1v6gEF7l0kx/p1g4ck879u1L0QTqZnSQEd0
         lUXXF+59tho4/Tii7Ur6jJ6sFu3kPqIapwEYiGOda46gWGKGfF3JePnyeh/6PAvr0Xsg
         qEXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778676953; x=1779281753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4chqvdfqdlpd51Jc1ZDdzdbFEZgBpj4aJvQtdp2bJY=;
        b=dnpTGt9UrNNdzTTbTL31CS1Hv4fjqO2wSqVUaDAD2/soeUO18bgncIFCaMCLDxVhp0
         Opi6NMH4PO2Rbuc0x/1kh0554N47A8HyHwBD8DvhZGtSbZUrsuzxXjXypgD5C1esm7MJ
         NtqX62fuap5zdehMlFqvV1ArmuR3c26/ESWECLXxAX79XM8gP8kplLeLNogi4ZTrAfTf
         2WtXZKwwLnFQsDQrbipchCpSd0YxNVHfgGhF301vnGiySNdGk1R//Y2PAcGlPkEZcnCn
         ps5CUY2B1xc7ocPi+e/j4lC3Zi1FSFuwARL3MRa/iRBzx7wTi143CkG5XHR/e58P88md
         L0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676953; x=1779281753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4chqvdfqdlpd51Jc1ZDdzdbFEZgBpj4aJvQtdp2bJY=;
        b=IBoL++0h+Rfb6q7zu9fZ0mT+9lZ9j30GFskhw4dehdfln1HF+2NwaegHuchESLF258
         rhBJMeP+4utvoV2aFfIbnWD88PsveARRac4VR/kbGztGwW1N8elvd+URBScPHiOOBsNn
         M2p+KY9WgGCHGdygR3aqjy69ww7Wv1kuhyFepbcF0APNz2uW519JXafbPyjCD60j47XH
         eb9r5NNEAcnxRjkk1FunWedygdJhztFu8NO3O+gnrvyMtMgvJpcIMp9yzqlNiaJlGkVV
         6xEJtHh9sV838verdRkedmeYAopx/EYdeOYWYrCMCD5wY1mKdnl5P18fdCmNGwovoQ/d
         SM2w==
X-Forwarded-Encrypted: i=1; AFNElJ9gTOZ6EgjBlxyiUD70ctm1+AuMBvEtXwGwOaIwRSUaQelazMiSRYnjqe6DQWh6De5UvkcFjEzKOmejiXqDE34J@vger.kernel.org
X-Gm-Message-State: AOJu0YzO0d401CdO4GIax6rYF6I8RSFDePWbE331nuGjDGVs0kg3u3jX
	NFshvUsFZ19oqsKC5MCwKJg6E+m8A+lct1tug7sEfMImyIF5vyPZOcLpUeANGMM3VVZf2i7P03s
	Ew51QXv/siHuOavufTUgyWXijZ/DQMh9y/h29gAkg
X-Gm-Gg: Acq92OEU59QSbHQW8Q7hgN3jzg+ElW5T4iTxUyOJDjD7dYn7q+nEN/FXj3n2tKncGY9
	IIr09Kmpznlcwlg8OSAKJkMIyIoj1oejTx5L6eavJ5R73ntXp4Ymt9ADuH/5L+ef10bHPMoXRu4
	Dzz/EX2woQuU20MU2KZ5f0jlbsxk5RbWgJwBlWFXleRuHenrj+UWREtiCyCFBCshxZA30/USlEY
	MmqhDnSGUB9fyzWqqunPibK01enC10FvI6L+l4wchQrxsikJpZCTJ1mLt4zF4sEHfeU4pHTKKY4
	DnKxSyYUkCQzZ7pM1NTUlR0R+A1POQ==
X-Received: by 2002:a17:903:1a8b:b0:2bd:3c1b:3073 with SMTP id
 d9443c01a7336-2bd3c1b31c2mr972875ad.16.1778676952003; Wed, 13 May 2026
 05:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-james-spe-discard-warning-v1-1-985c02756ee4@linaro.org> <20260513102024.GE34802@e132581.arm.com>
In-Reply-To: <20260513102024.GE34802@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 05:55:40 -0700
X-Gm-Features: AVHnY4InNk-bInjoavdvMv1aeYxqzotXH5pd7IbLWmqSVKfM-woL6gSaSwwZyiA
Message-ID: <CAP-5=fUoebOVhWvTbgkyY6erZJjbLRbRVk6oauVKjtHGGgMyaQ@mail.gmail.com>
Subject: Re: [PATCH] perf arm-spe: Don't warn about the discard bit if it
 doesn't exist
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 3:20=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Fri, Apr 10, 2026 at 12:05:12PM +0100, James Clark wrote:
> > Opening an SPE event shows a warning that doesn't concern the user:
> >
> >   $ perf record -e arm_spe
> >   Unknown/empty format name: discard
> >
> > Perf only wants to know if the discard bit is set for configuring the
> > event, not in response to anything the user has done. Fix it by adding
> > another helper that returns if a config bit exists without warning.
> >
> > We should probably keep the warning in evsel__get_config_val() to avoid
> > having every caller having to do it, and most format bits should never
> > be missing.
> >
> > Add a test for the new helper. Rename the parent test function to be
> > more generic rather than adding a new one as it requires a lot of
> > boilerplate.
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
>
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
