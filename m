Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E51F582C
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Jul 2025 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511803; cv=none; b=md12qRoXICHY9YiMZhZPSV1GEOxVQ1Hk7zmShIN2MUi0BepRxbUaMbxGTinBxwB5K/sZuwBGaQJsqML8C1f9CknYf+CDpn2K9WSOYGZpBMNbn3ECKMoOIm3pOW+SNiW68DSeVhBacKbhfbBw4srHb7PD7+Rk+VUNC0gT3goIzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511803; c=relaxed/simple;
	bh=siETa+2e1hOdMU82cx4KWvXM2JZUaIlZEqNGoM92INM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODEaX2fMcGLD0rlNAGYyITZZYWpkg+mxcFuM5lYjcZP5BMHnr8kjfJstGM5uIPa3lf0iFWTOL2QiL9+OfeQ6hKxjBebJqGuMLCK1Y2HCA57qfiqNhK15Zm/+U+9OnWLzfwYVjvdh+8SVkHidBpPHGnKWColW/jSjCRKwhUVyplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jU/A2UP7; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jU/A2UP7"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3de210e6076so47215ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jul 2025 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751511801; x=1752116601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN6BFe6om2nPVx4QJftK5Q9oWduRYdtLEf6yX06DzrQ=;
        b=jU/A2UP73fegIvd8e5veGRm/tkhDYhKkn6uscl/EXNdSNL+VXJAq8y3WSACq6/PmDb
         WfKMfP+sKuWhE/a9BlPpmsNmrSn6EjYOfk6k8VpTpJv7uY59bbpfN42WQxoKypFUogf+
         3xKULgTANQ3OkHkNJGSqyl/EumewKXyCIljR1Atdli91JWVs8tq5hshO4YgEE+VL3RUC
         OjcOxlN1kG4nS0PMY/rLyX5wy6AZVrSrTd0C6Gb1P/A4+KxZ72gLDmsEcpI10EiVld3J
         ORY3N5PQmNP+dn7RnpSePCMTXUajDiP1iveRHcS1p6DdFC9svPgDVC2d8a65n9AUcCM0
         ggnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751511801; x=1752116601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN6BFe6om2nPVx4QJftK5Q9oWduRYdtLEf6yX06DzrQ=;
        b=uYYH9QYfuo1OWHmN3auvyBfnI6Umi/xogfDqJtTMCLPYs+rjBNpy9HTpiUG3hMaCA9
         MiqHQ+FbO39ArBZq4JZDGCn8920edbPb6DqaEMD4oCcKWczUlgM/ke1fLJS04bZSw6Ej
         /wg26wio0Pjx5cAHuyC97/y8Y4R6wRVzX21MMOU41OzKPRDnKcEPAyhpqDsZdSCRZ0jd
         XVTCUSz8nqOwM2LQ0lx3UBFDscU4VlX5y0mWjDi5JgHHv8xgJf+IogQywse7slurDS1+
         Y9inVPeUy0n7tG+qYuE103+aTyzXHVt7835vIEW5iRT7VXU8aqAeQ+Fo3X3TH8CDtUCd
         7bBA==
X-Forwarded-Encrypted: i=1; AJvYcCVuomeuLMyjXliW4SHXSGpucnO0zqIpOIa+08Znpl7wSrrYoC5Kzag3vTqAIZqbrUzlXIAO3QXlAgny68nKkCAY@vger.kernel.org
X-Gm-Message-State: AOJu0YzPGBhvjCA0CiwyBj60nwQ7cmrik0KuwhP3VwVi7gKgauKs6n/A
	Drym86vtpwfa3xhXdc4SPMWAbeDGplJhEtBeyUVFJukheRNkf7gsC/pxeYHu3lcE2BkbndEk8kp
	MGPjXtKfl1MFGaD9OmhvjZxOyC7O2E8Mi6V7RYm3D
X-Gm-Gg: ASbGncsFrfOz/Y99JCVDZWK+NP7ezgbFgl2+xDGJJ1B2Igz3zPswRb4+/V0yIDJpJBR
	qKEF60/UgMEfMcECxXV9WMW+Cwz4NwQF48O1+Ybn6lQxUJvB48MIDul+d9uqLjNL6UQkPlw8+3Q
	KEbu2DeV5fDAYPwRlAOijBQfZ6WF02Dg7Ondx95JPLu1C6
X-Google-Smtp-Source: AGHT+IFLzfwbbAe9TXepqAxi+5+4w7o4DGYkqu1IIC17NV3P1HcrgHSuWhS9kEzFIeDPvBnQn6Ua8ovkxxpAU5q+i7M=
X-Received: by 2002:a05:6e02:339e:b0:3dd:a7a1:9ee8 with SMTP id
 e9e14a558f8ab-3e05c82b91dmr2179905ab.24.1751511800459; Wed, 02 Jul 2025
 20:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624190326.2038704-1-irogers@google.com> <aGXo7Hp31qZOTx9S@google.com>
In-Reply-To: <aGXo7Hp31qZOTx9S@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Jul 2025 20:03:08 -0700
X-Gm-Features: Ac12FXyS3_6QZzQsAPBLsuDlhh9SuoLA_S6ft4g5FSEjzHuElk55okBYTQ77q6Y
Message-ID: <CAP-5=fV4mSjxJBSScYu1XFqFMMT0vO+jJDwq57kUB+cEkxQqMQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] perf test: Sanity check file descriptors are
 cleaned up
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 7:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Jun 24, 2025 at 12:03:20PM -0700, Ian Rogers wrote:
> > Some recent patches showed we were leaking file descriptors:
> > https://lore.kernel.org/lkml/20250617223356.2752099-2-irogers@google.co=
m/
> >
> > When a test is forked the file descriptors >3 can be closed and then
> > any file descriptors >3 left after the test are leaks. Add this
> > checking to the forked test code. Prior to that clean up some file
> > descriptor usage so we can assert that only file descriptors are
> > cleaned up. Sometimes the file descriptor being held open is the
> > result of a memory leak, so fix those.
>
> Interesting, I can see a few more tests are failing with this.  But we
> can figure it out later.

That's cool. I was a little disappointed that just the dso kcore leak
was found by this. I was also surprised that the dso kcore memory leak
hadn't shown up with leak sanitizer and reference count checking. Let
me know if there is anything more I need to do to the patch series.

Thanks,
Ian
