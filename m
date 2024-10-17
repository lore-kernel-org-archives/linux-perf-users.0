Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B301DF74C
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183464; cv=none; b=gC0dd3q85Wwo6DjmIQSHefJtZhv4uWvYkxfA5YYrGxUwcFODqryBE3eecds8Oi96A/NO5VNQKJBTRhgjL0pDlmH4XFYN26Urd9NKf8X9/OZ7t4UDebqkqXNp4k6IWnZ0Q91L8/BDGvXim61ob+mvvAGjAx2SsCYWTi6TaT8HfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183464; c=relaxed/simple;
	bh=qYmzlCRl1PVunQMKxtFza9iHD1OMsbq9k8HKpjfRrfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuuAAtWm3e5y1kWcIaW4ZK3HSICtajKgQFzCl1wFPioMFsKI+pkO/xT/J5ejrx2nOsKYtke2ZcctlXWr5pXeyzR+EADS8C55UiZHfcUa0r/BkKfkQQGPMeWbDYmhyiG7pIZg8aibMOk+OyWJKpEk36E961oC7bFjob6hdQeYocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZumqqNE; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZumqqNE"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so3615ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729183462; x=1729788262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYmzlCRl1PVunQMKxtFza9iHD1OMsbq9k8HKpjfRrfg=;
        b=fZumqqNE3MJ276zfoVOCYIRwCXkqQrtFN9s0dugHg9KGudwfc+U6vGOd08q78sPGir
         M2ohdVaUwqboCoNMNmKYVZGNWW/GI1JEsUA96rZMCxckSZ09ljQN6CVetas+cnp08d2E
         T1zsp0cEOR8F1gOvJLnzmnNHUJa60ITR7aUvnqyqKnwQZ2QD19VfXmZDb08R9r10Wplg
         1tMf0Rm5Db0EQRt2+pTgDXTgsmpaBo7Hbp8M9CWsXkrmVAjkWdrxqVn7DMp8d2NZ2CZ/
         WAQC6gXs/yOnTXKJObvfMJXjiocxh514M/rYTw595pt62ylt4vX9jopmUGS2AdTT6wkp
         BkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729183462; x=1729788262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYmzlCRl1PVunQMKxtFza9iHD1OMsbq9k8HKpjfRrfg=;
        b=vgKTtxaR/YYMX6AAys0H3XCnp8J5BHpPi1l1t2pF9bKDMYHW/MujXE2IjBah+Nk9r5
         ROnrQKK7yNvuqBiHXIEF7idAsxNqzLh9Osd5LyP4JxWferJ+AfSZWieQnFBDD5Z9d38l
         QrK8aK4lGSFp/8xfB86+2K/XFHIQ4s9WHybC7i9hTHV7BuNvM6oL0osuZ3L+GY5I1HBC
         IkCMJlK/iViGhVAG7++xIP15WHPMIBpdOZQc6MmO7NcULqo1zNdlBCNkYf57b8bEYTcS
         cvZL9S7alrlHJWJeh09GTFJrz2/vX4tTboadJZMayqAxmx8fuf62/8IE/OWbnw9oyvJN
         1hOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgr+gvwryMAOrtQrPKCvQUJVMSYEyeBkEx13TqKJftJ5TtsTXJ58b6xckY2AzB8u4zcyEsBypTKf6AIkzeqAe3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+uSvqhPv036KjA7vg2PnnEiehG5U9OpDQ8KEGLvIAzVr6TJ/j
	aoGB2LgO2c0eYJF1rD9ON0Q9i2Y1zWTVMc81gS+H8RywKDVBnsdhOmzWJ4y+IKU6vq/fDD85IGy
	7dMd6wSzUi9c2tq613HuNuqPox3EZBboHVJIk
X-Google-Smtp-Source: AGHT+IF2iP9+1oOcV8IGw97zuOm8z5d7mrOyrhGfJCa16rIeNXkwZW72QrTI3RPHM646dPWp51d/P/WO7EK51xoHgto=
X-Received: by 2002:a05:6e02:144f:b0:3a0:aa15:3491 with SMTP id
 e9e14a558f8ab-3a3ea04c540mr4795615ab.23.1729183461837; Thu, 17 Oct 2024
 09:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com> <172918316032.639809.5792146702013848062.b4-ty@kernel.org>
In-Reply-To: <172918316032.639809.5792146702013848062.b4-ty@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Oct 2024 09:44:08 -0700
Message-ID: <CAP-5=fWMkF-z5t6-Oz8e8YRuW0rsMg7JXj4vSHqLZFe0y3=sUA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] CSV/JSON metric thresholds, fix printf modifiers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Weilin Wang <weilin.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:39=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, 16 Oct 2024 10:53:42 -0700, Ian Rogers wrote:
>
> > Metric thresholds are being computed for CSV and JSON output but not
> > displayed. Rename the color that encodes the threshold as enum values
> > and use to generate string constants in a CSV column or json
> > dictionary value.
> >
> > Add printf attribute to functions in color.h that could support
> > it. Fix bad printf format strings that this detected.
> >
> > [...]
>
> Applied to perf-tools-next, thanks!

Sorry for the trouble, could we switch to the v4 series due to issues
on hypervisors with not counted events in CSV output missing a column:
https://lore.kernel.org/lkml/20241016215139.212939-1-irogers@google.com/
The patch set drops the CSV output metric threshold support.

Thanks,
Ian
